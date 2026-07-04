import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/app_config.dart';
import 'l10n/l10n.dart';
import 'providers/app_locale_provider.dart';
import 'providers/analytics_provider.dart';
import 'providers/revenuecat_provider.dart';
import 'screens/app_root_screen.dart';
import 'services/auth_sync_service.dart';
import 'services/fcm_token_service.dart';
import 'services/reminder_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final config = AppConfig.fromEnvironment;
  runApp(
    ProviderScope(
      child: GluBootstrapApp(
        config: config,
      ),
    ),
  );
}

class GluBootstrapApp extends ConsumerStatefulWidget {
  const GluBootstrapApp({super.key, required this.config});

  final AppConfig config;

  @override
  ConsumerState<GluBootstrapApp> createState() => _GluBootstrapAppState();
}

class _GluBootstrapAppState extends ConsumerState<GluBootstrapApp> {
  late final Future<_BootstrapState> _bootstrapFuture = _bootstrap();

  Future<_BootstrapState> _bootstrap() async {
    await Firebase.initializeApp();
    await reminderServiceSingleton.initialize();
    await analyticsServiceSingleton.configure(widget.config);
    final revenueCatService = revenueCatServiceSingleton;
    var supabaseReady = false;

    if (widget.config.hasSupabase) {
      await Supabase.initialize(
        url: widget.config.supabaseUrl,
        anonKey: widget.config.supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          detectSessionInUri: false,
        ),
      );
      supabaseReady = true;
    }

    await revenueCatService.configure(widget.config);

    if (supabaseReady) {
      final authSyncService = AuthSyncService(
        supabaseClient: Supabase.instance.client,
        revenueCatService: revenueCatService,
        fcmTokenService: FcmTokenService(),
      );
      await authSyncService.start();
    }

    return _BootstrapState(
      analytics: FirebaseAnalytics.instance,
      supabaseReady: supabaseReady,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appLocale = ref.watch(
      appLocaleControllerProvider,
    );
    return MaterialApp(
      locale: appLocale,
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: FutureBuilder<_BootstrapState>(
        future: _bootstrapFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return _BootstrapErrorScreen(error: snapshot.error);
          }

          if (!snapshot.hasData) {
            return const _BootstrapLoadingScreen();
          }

          final state = snapshot.data!;
          return AppRootScreen(
            config: widget.config,
            supabaseReady: state.supabaseReady,
          );
        },
      ),
    );
  }
}

class _BootstrapState {
  const _BootstrapState({
    required this.analytics,
    required this.supabaseReady,
  });

  final FirebaseAnalytics analytics;
  final bool supabaseReady;
}

class _BootstrapLoadingScreen extends StatelessWidget {
  const _BootstrapLoadingScreen();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.startupWakingUp),
          ],
        ),
      ),
    );
  }
}

class _BootstrapErrorScreen extends StatelessWidget {
  const _BootstrapErrorScreen({required this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F4),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text(
                l10n.startupFailed,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              SelectableText(
                '$error',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
