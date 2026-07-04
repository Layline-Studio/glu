import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/app_profile.dart';
import '../models/goals.dart';
import '../l10n/app_locale.dart';
import 'revenuecat_service.dart';

class ProfileService {
  static const _onboardingSettingKeys = <String>{
    'medication_status',
    'medication_method',
    'medication_name',
    'current_dose_mg',
    'device_type',
    'medication_frequency',
    'medication_frequency_days_between_doses',
    'primary_goal',
    'gender',
    'age',
    'height',
    'weight',
    'medication_started_at',
    'medication_start_weight',
    'onboarding_benefits_seen_at',
    'notifications_prompted_at',
    'notifications_permission_status',
    'onboarding_review_prompted_at',
    'daily_routine',
    'symptom_concerns',
    'preferred_name',
    'onboarding_setup_summary_seen_at',
    'onboarding_started_at',
    'onboarding_completed_at',
  };
  static const _showcaseSettingKeys = <String>{
    'showcase_reminders_seen',
    'showcase_log_seen',
    'showcase_water_seen',
    'showcase_progress_seen',
  };

  const ProfileService({
    required RevenueCatService revenueCatService,
  }) : _revenueCatService = revenueCatService;

  final RevenueCatService _revenueCatService;
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  SupabaseClient get _client => Supabase.instance.client;

  Future<AppProfile> bootstrapProfile() async {
    final timezone = await _resolveTimezone();
    final platform = await _resolvePlatform();
    final preferredLocale = _resolvePreferredLocale();
    await _syncRevenueCatIdentity();
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existingProfile = await _fetchProfile(user.id);
    if (existingProfile == null) {
      try {
        final inserted = await _client
            .from('profiles')
            .insert({
              'id': user.id,
              'subscription_tier':
                  _revenueCatService.activeEntitlementIdentifier,
              if (platform != null) 'platform': platform,
              'timezone': timezone,
              'settings': {
                'app_locale': preferredLocale,
              },
              'goals': AppGoals.empty.toJson(),
            })
            .select()
            .single();
        await _trackAccountCreated();
        return AppProfile.fromJson(Map<String, dynamic>.from(inserted));
      } on PostgrestException catch (error) {
        if (_isProfilesUserForeignKeyError(error)) {
          await _client.auth.signOut();
          throw const StaleAuthSessionException();
        }
        rethrow;
      }
    }

    final shouldUpdateTimezone = (existingProfile.timezone == null ||
            existingProfile.timezone!.isEmpty) &&
        timezone != null &&
        timezone.isNotEmpty;
    final shouldUpdatePlatform = (existingProfile.platform == null ||
            existingProfile.platform!.isEmpty) &&
        platform != null &&
        platform.isNotEmpty;
    final shouldUpdateLocale =
        existingProfile.appLocale == null && preferredLocale.isNotEmpty;
    final shouldUpdateTier = existingProfile.subscriptionTier !=
        _revenueCatService.activeEntitlementIdentifier;

    if (!shouldUpdateTimezone &&
        !shouldUpdatePlatform &&
        !shouldUpdateTier &&
        !shouldUpdateLocale) {
      return existingProfile;
    }

    final updatedSettings = shouldUpdateLocale
        ? {
            ...existingProfile.settings,
            'app_locale': preferredLocale,
          }
        : null;

    final updated = await _client
        .from('profiles')
        .update({
          'subscription_tier': _revenueCatService.activeEntitlementIdentifier,
          if (shouldUpdateTimezone) 'timezone': timezone,
          if (shouldUpdatePlatform) 'platform': platform,
          if (updatedSettings != null) 'settings': updatedSettings,
        })
        .eq('id', user.id)
        .select()
        .single();
    return AppProfile.fromJson(Map<String, dynamic>.from(updated));
  }

  Future<AppProfile> updateSettings(Map<String, dynamic> patch) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existingProfile = await _fetchProfile(user.id);
    if (existingProfile == null) {
      throw Exception('Profile not found.');
    }

    final updatedSettings = Map<String, dynamic>.from(existingProfile.settings)
      ..addAll(patch);

    final updated = await _client
        .from('profiles')
        .update({'settings': updatedSettings})
        .eq('id', user.id)
        .select()
        .single();
    return AppProfile.fromJson(Map<String, dynamic>.from(updated));
  }

  Future<AppProfile> updateGoals(AppGoals goals) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existingProfile = await _fetchProfile(user.id);
    if (existingProfile == null) {
      throw Exception('Profile not found.');
    }

    final updated = await _client
        .from('profiles')
        .update({'goals': goals.toJson()})
        .eq('id', user.id)
        .select()
        .single();
    return AppProfile.fromJson(Map<String, dynamic>.from(updated));
  }

  Future<AppProfile> resetOnboarding() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existingProfile = await _fetchProfile(user.id);
    if (existingProfile == null) {
      throw Exception('Profile not found.');
    }

    final updatedSettings = Map<String, dynamic>.from(existingProfile.settings);
    for (final key in _onboardingSettingKeys) {
      updatedSettings.remove(key);
    }

    final updatedGoals = existingProfile.goals.copyWith(
      weight: existingProfile.goals.weight.copyWith(
        enabled: true,
        history: const [],
      ),
    );

    final updated = await _client
        .from('profiles')
        .update({
          'settings': updatedSettings,
          'goals': updatedGoals.toJson(),
        })
        .eq('id', user.id)
        .select()
        .single();
    return AppProfile.fromJson(Map<String, dynamic>.from(updated));
  }

  Future<AppProfile> resetShowcases() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final existingProfile = await _fetchProfile(user.id);
    if (existingProfile == null) {
      throw Exception('Profile not found.');
    }

    final updatedSettings = Map<String, dynamic>.from(existingProfile.settings);
    for (final key in _showcaseSettingKeys) {
      updatedSettings.remove(key);
    }

    final updated = await _client
        .from('profiles')
        .update({'settings': updatedSettings})
        .eq('id', user.id)
        .select()
        .single();
    return AppProfile.fromJson(Map<String, dynamic>.from(updated));
  }

  Future<void> deleteAccount() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    try {
      await _client.auth.refreshSession();
    } catch (_) {
      // Best-effort refresh before this critical operation.
    }

    final response = await _client.functions.invoke('delete-account');
    final data = response.data;
    final error = response.data is Map<String, dynamic>
        ? (response.data as Map<String, dynamic>)['error']
        : null;
    if (response.status >= 400 || error != null) {
      throw Exception(error ?? 'Account deletion failed.');
    }
    if (data is Map<String, dynamic> &&
        data['success'] != true &&
        data['error'] != null) {
      throw Exception(data['error']);
    }
  }

  Future<void> _trackAccountCreated() async {
    try {
      await FirebaseAnalytics.instance.logSignUp(
        signUpMethod: 'supabase',
        parameters: {
          'source': 'profile_bootstrap',
        },
      );
    } catch (_) {
      // Analytics must never block profile creation.
    }
  }

  Future<void> _syncRevenueCatIdentity() async {
    final session = _client.auth.currentSession;
    final userId = session?.user.id;
    if (userId == null || !_revenueCatService.isConfigured) {
      return;
    }
    if (_revenueCatService.currentAppUserId != userId) {
      await _revenueCatService.logIn(userId);
      return;
    }
    await _revenueCatService.refresh();
  }

  Future<String?> _resolveTimezone() async {
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      return timezone.identifier.isEmpty ? null : timezone.identifier;
    } catch (_) {
      return null;
    }
  }

  String _resolvePreferredLocale() {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return resolveAppLocale(locale, null).languageCode;
  }

  Future<String?> _resolvePlatform() async {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        try {
          final info = await _deviceInfo.iosInfo;
          final version = info.systemVersion.trim();
          return version.isEmpty ? 'ios' : 'ios $version';
        } catch (_) {
          return 'ios';
        }
      case TargetPlatform.android:
        try {
          final info = await _deviceInfo.androidInfo;
          final version = info.version.release.trim();
          return version.isEmpty ? 'android' : 'android $version';
        } catch (_) {
          return 'android';
        }
      default:
        return null;
    }
  }

  Future<AppProfile?> _fetchProfile(String userId) async {
    final response =
        await _client.from('profiles').select().eq('id', userId).maybeSingle();
    if (response == null) {
      return null;
    }
    return AppProfile.fromJson(Map<String, dynamic>.from(response));
  }

  bool _isProfilesUserForeignKeyError(PostgrestException error) {
    return error.code == '23503' &&
        error.message.toLowerCase().contains('profiles_id_fkey');
  }
}

class StaleAuthSessionException implements Exception {
  const StaleAuthSessionException();

  @override
  String toString() {
    return 'Your local session is stale after the database reset. Please sign in again.';
  }
}
