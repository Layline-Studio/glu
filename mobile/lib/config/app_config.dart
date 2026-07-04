class AppConfig {
  const AppConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.authRedirectUrl,
    required this.revenueCatApiKey,
    required this.googleWebClientId,
    required this.googleIosClientId,
    required this.revenueCatIosKey,
    required this.revenueCatAndroidKey,
    required this.posthogApiKey,
    required this.posthogHost,
  });

  final String supabaseUrl;
  final String supabaseAnonKey;
  final String authRedirectUrl;
  final String revenueCatApiKey;
  final String googleWebClientId;
  final String googleIosClientId;
  final String revenueCatIosKey;
  final String revenueCatAndroidKey;
  final String posthogApiKey;
  final String posthogHost;

  static const AppConfig fromEnvironment = AppConfig(
    supabaseUrl: String.fromEnvironment('SUPABASE_URL'),
    supabaseAnonKey: String.fromEnvironment('SUPABASE_ANON_KEY'),
    authRedirectUrl: String.fromEnvironment(
      'AUTH_REDIRECT_URL',
      defaultValue: 'glu://login-callback',
    ),
    revenueCatApiKey: String.fromEnvironment('REVENUECAT_API_KEY'),
    googleWebClientId: String.fromEnvironment('GOOGLE_WEB_CLIENT_ID'),
    googleIosClientId: String.fromEnvironment('GOOGLE_IOS_CLIENT_ID'),
    revenueCatIosKey: String.fromEnvironment('REVENUECAT_IOS_KEY'),
    revenueCatAndroidKey: String.fromEnvironment('REVENUECAT_ANDROID_KEY'),
    posthogApiKey: String.fromEnvironment('POSTHOG_API_KEY'),
    posthogHost: String.fromEnvironment(
      'POSTHOG_HOST',
      defaultValue: 'https://us.i.posthog.com',
    ),
  );

  bool get hasSupabase =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;

  bool get hasGoogleSignIn =>
      googleWebClientId.isNotEmpty || googleIosClientId.isNotEmpty;

  bool get hasRevenueCat =>
      revenueCatApiKey.isNotEmpty ||
      revenueCatIosKey.isNotEmpty ||
      revenueCatAndroidKey.isNotEmpty;

  bool get hasPosthog => posthogApiKey.isNotEmpty;
}
