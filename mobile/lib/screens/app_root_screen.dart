import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/app_config.dart';
import '../models/app_profile.dart';
import '../l10n/l10n.dart';
import '../l10n/app_locale.dart';
import '../models/app_version_status.dart';
import '../models/goals.dart';
import '../models/reminders.dart';
import '../providers/app_locale_provider.dart';
import '../providers/app_version_provider.dart';
import '../providers/analytics_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/deep_link_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/revenuecat_provider.dart';
import '../providers/subscription_provider.dart';
import '../providers/reminder_service_provider.dart';
import 'main_shell.dart';
import 'auth/auth_screen.dart';
import 'onboarding/onboarding_screen.dart';

class AppRootScreen extends ConsumerStatefulWidget {
  const AppRootScreen({
    super.key,
    required this.config,
    required this.supabaseReady,
  });

  final AppConfig config;
  final bool supabaseReady;

  @override
  ConsumerState<AppRootScreen> createState() => _AppRootScreenState();
}

class _AppRootScreenState extends ConsumerState<AppRootScreen>
    with WidgetsBindingObserver {
  String? _shownVersionPromptSignature;
  String? _trackedAnalyticsUserId;
  bool _versionDialogOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !widget.supabaseReady) {
        return;
      }
      ref.read(deepLinkProvider.notifier).init();
      unawaited(_refreshEntitlementsOnResume());
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed || !widget.supabaseReady) {
      return;
    }
    unawaited(_refreshEntitlementsOnResume());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Session?>>(authSessionProvider, (_, next) {
      next.whenData((session) {
        if (session == null) {
          _trackedAnalyticsUserId = null;
          ref.read(analyticsServiceProvider).reset();
          ref.read(reminderServiceProvider).cancelAll();
          return;
        }

        final userId = session.user.id;
        _trackedAnalyticsUserId = userId;
        ref.read(analyticsServiceProvider).identify(
          userId: userId,
          userPropertiesSetOnce: {
            'first_seen_auth_at': DateTime.now().toUtc().toIso8601String(),
          },
        );
      });
    });
    ref.listen<AsyncValue<AppProfile?>>(profileBootstrapProvider, (_, next) {
      next.whenData((profile) {
        ref.read(reminderServiceProvider).syncProfileReminders(profile);
        if (profile == null) {
          return;
        }

        final analytics = ref.read(analyticsServiceProvider);
        final userId =
            profile.id.isNotEmpty ? profile.id : _trackedAnalyticsUserId;
        if (userId != null && userId.isNotEmpty) {
          analytics.identify(userId: userId);
        }
        ref.read(appLocaleControllerProvider.notifier).setLocale(
          resolveAppLocale(
          WidgetsBinding.instance.platformDispatcher.locale,
          profile.appLocale,
          ),
        );
        analytics.setUserProperties(
          userProperties: {
            'subscription_tier': profile.subscriptionTier ?? 'free',
            'timezone': profile.timezone ?? 'unknown',
            'has_completed_onboarding': profile.hasCompletedOnboarding,
            'notifications_permission_status':
                profile.settings['notifications_permission_status'],
            'measurement_unit': profile.settings['measurement_unit'],
          },
          userPropertiesSetOnce: {
            'profile_created_at': profile.createdAt.toUtc().toIso8601String(),
          },
        );
        unawaited(_trackRetentionEvents(profile));
      });
    });

    ref.listen<AsyncValue<AppVersionStatus>>(appVersionStatusProvider, (
      _,
      next,
    ) {
      if (!widget.supabaseReady) {
        return;
      }
      next.whenData(_handleVersionStatus);
    });

    final authState = ref.watch(authSessionProvider);
    return authState.when(
      data: (session) {
        if (session == null) {
          return AuthScreen(config: widget.config);
        }

        final profileState = ref.watch(profileBootstrapProvider);
        return profileState.when(
          data: (profile) {
            if (profile == null || !profile.hasCompletedOnboarding) {
              return OnboardingScreen(
                profile: profile ??
                    AppProfile(
                      id: '',
                      subscriptionTier: null,
                      platform: null,
                      createdAt: DateTime.fromMillisecondsSinceEpoch(0),
                      updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
                      timezone: null,
                      settings: {},
                      reminders: AppReminders.empty,
                      goals: AppGoals.empty,
                    ),
              );
            }

            return MainShell(
              config: widget.config,
              supabaseReady: widget.supabaseReady,
            );
          },
          loading: () => const _RouteLoadingScreen(),
          error: (error, _) => _RouteErrorScreen(error: error),
        );
      },
      loading: () => const _RouteLoadingScreen(),
      error: (error, _) => _RouteErrorScreen(error: error),
    );
  }

  Future<void> _refreshEntitlementsOnResume() async {
    try {
      await ref.read(revenueCatServiceProvider).refresh();
    } catch (_) {
      // Best effort only. The next provider read will still fall back safely.
    }
    if (!mounted) {
      return;
    }
    ref.invalidate(subscriptionProvider);
    ref.invalidate(profileBootstrapProvider);
  }

  Future<void> _handleVersionStatus(AppVersionStatus status) async {
    if (!mounted || !status.shouldPrompt || _versionDialogOpen) {
      return;
    }
    if (_shownVersionPromptSignature == status.signature) {
      return;
    }

    _versionDialogOpen = true;
    _shownVersionPromptSignature = status.signature;

    await showDialog<void>(
      context: context,
      barrierDismissible: !status.isRequired,
      builder: (context) => PopScope(
        canPop: !status.isRequired,
        child: AlertDialog(
          title: Text(_dialogTitle(status)),
          content: Text(_dialogBody(status)),
          actions: [
            if (!status.isRequired &&
                status.storeUrl != null &&
                status.storeUrl!.isNotEmpty)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.l10n.commonLater),
              ),
            TextButton(
              onPressed: () async {
                if (status.storeUrl != null && status.storeUrl!.isNotEmpty) {
                  await launchUrl(
                    Uri.parse(status.storeUrl!),
                    mode: LaunchMode.externalApplication,
                  );
                }
                if (context.mounted &&
                    (!status.isRequired ||
                        status.storeUrl == null ||
                        status.storeUrl!.isEmpty)) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(_primaryActionLabel(status)),
            ),
          ],
        ),
      ),
    );

    _versionDialogOpen = false;
  }

  Future<void> _trackRetentionEvents(AppProfile profile) async {
    try {
      final userId = profile.id.trim();
      if (userId.isEmpty) {
        return;
      }

      final age = DateTime.now().toUtc().difference(profile.createdAt.toUtc());
      final prefs = await SharedPreferences.getInstance();
      final buckets = <(String key, String eventName, int days)>[
        (
          'retention_day_1_tracked_at_$userId',
          'retention_day_1',
          1,
        ),
        (
          'retention_day_7_tracked_at_$userId',
          'retention_day_7',
          7,
        ),
      ];

      for (final bucket in buckets) {
        final (key, eventName, days) = bucket;
        if (prefs.getString(key) != null) {
          continue;
        }
        final lowerBound = Duration(days: days);
        final upperBound = Duration(days: days + 1);
        if (age < lowerBound || age >= upperBound) {
          continue;
        }

        await FirebaseAnalytics.instance.logEvent(
          name: eventName,
          parameters: {
            'days_since_signup': days,
          },
        );
        await prefs.setString(key, DateTime.now().toUtc().toIso8601String());
      }
    } catch (_) {
      // Best effort only. App routing should not depend on analytics.
    }
  }

  String _dialogTitle(AppVersionStatus status) {
    switch (status.kind) {
      case AppUpdatePromptKind.required:
        return 'Update required';
      case AppUpdatePromptKind.optional:
        return 'Update available';
      case AppUpdatePromptKind.missingConfig:
        return 'Check for updates';
      case AppUpdatePromptKind.none:
        return '';
    }
  }

  String _dialogBody(AppVersionStatus status) {
    switch (status.kind) {
      case AppUpdatePromptKind.required:
        final minimumVersion = status.minimumVersion;
        if (minimumVersion != null && minimumVersion.isNotEmpty) {
          return 'Version $minimumVersion or newer is required to continue.';
        }
        return 'Please update the app to continue.';
      case AppUpdatePromptKind.optional:
        final latestVersion = status.latestVersion;
        if (latestVersion != null && latestVersion.isNotEmpty) {
          return 'Version $latestVersion is available. Update now to stay current.';
        }
        return 'A newer version of the app is available.';
      case AppUpdatePromptKind.missingConfig:
        return 'A new version may be available. Please check the store for updates.';
      case AppUpdatePromptKind.none:
        return '';
    }
  }

  String _primaryActionLabel(AppVersionStatus status) {
    if (status.storeUrl != null && status.storeUrl!.isNotEmpty) {
      return 'Update';
    }
    return status.isRequired ? 'OK' : 'Dismiss';
  }
}

class _RouteLoadingScreen extends StatelessWidget {
  const _RouteLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _RouteErrorScreen extends StatelessWidget {
  const _RouteErrorScreen({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            '$error',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
