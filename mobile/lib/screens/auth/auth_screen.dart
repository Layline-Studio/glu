import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:url_launcher/url_launcher.dart';

import '../../config/app_config.dart';
import '../../l10n/l10n.dart';
import '../../models/auth_transaction.dart';
import '../../providers/auth_provider.dart';
import '../../providers/auth_transaction_provider.dart';
import '../../providers/deep_link_provider.dart';
import '../../theme/app_colors.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({
    super.key,
    required this.config,
  });

  final AppConfig config;

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  String? _statusMessage;
  bool _magicLinkSent = false;
  String? _sentEmail;
  ProviderSubscription<DeepLinkState>? _deepLinkSubscription;

  late final AnimationController _animationController;
  late final Animation<double> _logoAnimation;
  late final Animation<double> _titleAnimation;
  late final Animation<double> _buttonsAnimation;
  late final Animation<double> _dividerAnimation;
  late final Animation<double> _emailAnimation;
  late final Animation<double> _footerAnimation;

  bool get _authEnabled => widget.config.hasSupabase;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    );
    _titleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.1, 0.45, curve: Curves.easeOutCubic),
    );
    _buttonsAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.25, 0.6, curve: Curves.easeOutCubic),
    );
    _dividerAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.35, 0.7, curve: Curves.easeOutCubic),
    );
    _emailAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.45, 0.8, curve: Curves.easeOutCubic),
    );
    _footerAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOutCubic),
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _checkPendingAuth();
      _listenForDeepLinkAuth();
    });
  }

  @override
  void dispose() {
    _deepLinkSubscription?.close();
    _animationController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _listenForDeepLinkAuth() {
    _deepLinkSubscription?.close();
    _deepLinkSubscription = ref.listenManual(deepLinkProvider, (previous, next) {
      if (next.hasPendingAuth && !(previous?.hasPendingAuth ?? false)) {
        _handleDeepLinkAuth();
      }
    });
  }

  Future<void> _checkPendingAuth() async {
    final deepLinkState = ref.read(deepLinkProvider);
    if (deepLinkState.hasPendingAuth) {
      await _handleDeepLinkAuth();
    }
  }

  Future<void> _handleDeepLinkAuth() async {
    await ref.read(authControllerProvider).handleDeepLinkAuth();
  }

  Future<void> _runAuthAction(Future<void> Function() action) async {
    if (_isLoading || !_authEnabled) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _statusMessage = null;
    });

    try {
      await action();
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage =
            'Sign-in failed. Please try again or use another sign-in method.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _buildRedirectUrl(String state) {
    final configured = Uri.parse(widget.config.authRedirectUrl);
    final isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android);
    final base = isMobile ? Uri.parse('glu://login-callback') : configured;
    final params = Map<String, String>.from(base.queryParameters)
      ..['state'] = state;
    return base.replace(queryParameters: params).toString();
  }

  Future<void> _sendMagicLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      setState(() {
        _errorMessage = 'Enter a valid email address to continue.';
      });
      return;
    }

    await _runAuthAction(() async {
      final txState = await ref
          .read(authTransactionProvider.notifier)
          .createTransaction(AuthMethod.magicLink);
      await supabase.Supabase.instance.client.auth.signInWithOtp(
        email: email,
        emailRedirectTo: _buildRedirectUrl(txState),
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _statusMessage = 'Check your email for the sign-in link.';
        _magicLinkSent = true;
        _sentEmail = email;
      });
    });
  }

  Future<void> _signInWithOAuth(supabase.OAuthProvider provider) async {
    if (provider == supabase.OAuthProvider.apple &&
        defaultTargetPlatform == TargetPlatform.iOS &&
        !kIsWeb) {
      await _signInWithAppleNative();
      return;
    }

    if (provider == supabase.OAuthProvider.google &&
        !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android) &&
        widget.config.googleWebClientId.isNotEmpty) {
      await _signInWithGoogleNative();
      return;
    }

    await _runAuthAction(() async {
      final txState = await ref
          .read(authTransactionProvider.notifier)
          .createTransaction(AuthMethod.oauthWeb);
      await supabase.Supabase.instance.client.auth.signInWithOAuth(
        provider,
        redirectTo: _buildRedirectUrl(txState),
      );
    });
  }

  Future<void> _signInWithAppleNative() async {
    await _runAuthAction(() async {
      final rawNonce =
          supabase.Supabase.instance.client.auth.generateRawNonce();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final idToken = credential.identityToken;
      if (idToken == null) {
        throw const supabase.AuthException('No Apple ID token received.');
      }

      await supabase.Supabase.instance.client.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
    });
  }

  Future<void> _signInWithGoogleNative() async {
    await _runAuthAction(() async {
      final googleSignIn = GoogleSignIn.instance;
      final platformClientId =
          defaultTargetPlatform == TargetPlatform.iOS &&
                  widget.config.googleIosClientId.isNotEmpty
              ? widget.config.googleIosClientId
              : null;

      await googleSignIn.initialize(
        serverClientId: widget.config.googleWebClientId,
        clientId: platformClientId,
      );

      GoogleSignInAccount? googleUser;
      try {
        googleUser = await googleSignIn.attemptLightweightAuthentication();
      } catch (_) {
        googleUser = null;
      }

      googleUser ??= await googleSignIn.authenticate();
      final authorization = await googleUser.authorizationClient
              .authorizationForScopes(['email', 'profile']) ??
          await googleUser.authorizationClient.authorizeScopes(
            ['email', 'profile'],
          );

      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw const supabase.AuthException('No Google ID token received.');
      }

      await supabase.Supabase.instance.client.auth.signInWithIdToken(
        provider: supabase.OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      return;
    }
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.authCouldNotOpenLink)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final deepLinkState = ref.watch(deepLinkProvider);
    final isProcessingDeepLink = deepLinkState.isProcessing;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, -0.72),
            radius: 1.08,
            colors: [
              colors.heroEnd.withValues(alpha: 0.75),
              colors.heroStart.withValues(alpha: 0.75),
              colors.canvas,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Gap(48),
                        _FadeSlideIn(
                          animation: _logoAnimation,
                          child: Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A9786DA),
                                  blurRadius: 34,
                                  offset: Offset(0, 14),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(26),
                              child: Image.asset('assets/icons/app_icon.png'),
                            ),
                          ),
                        ),
                        const Gap(24),
                        _FadeSlideIn(
                          animation: _titleAnimation,
                          child: Column(
                            children: [
                              Text(
                                context.l10n.authWelcomeTitle,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                context.l10n.authSubtitle,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Gap(36),
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: _magicLinkSent
                                ? _FadeSlideIn(
                                    animation: _buttonsAnimation,
                                    child: _MagicLinkSentCard(
                                      email: _sentEmail ?? '',
                                      isLoading: _isLoading,
                                      onResend: _sendMagicLink,
                                      onChangeEmail: () {
                                        setState(() {
                                          _magicLinkSent = false;
                                          _statusMessage = null;
                                        });
                                      },
                                    ),
                                  )
                                : Column(
                                    children: [
                                      _FadeSlideIn(
                                        animation: _buttonsAnimation,
                                        child: Column(
                                          children: [
                                            _OAuthButton(
                                              onPressed: _isLoading || !_authEnabled
                                                  ? null
                                                  : () => _signInWithOAuth(
                                                        supabase.OAuthProvider.google,
                                                      ),
                                              icon: SvgPicture.asset(
                                                'assets/icons/google.svg',
                                                width: 22,
                                                height: 22,
                                              ),
                                              label: context.l10n.authContinueWithGoogle,
                                            ),
                                            const Gap(12),
                                            _OAuthButton(
                                              onPressed: _isLoading || !_authEnabled
                                                  ? null
                                                  : () => _signInWithOAuth(
                                                        supabase.OAuthProvider.apple,
                                                      ),
                                              icon: SvgPicture.asset(
                                                'assets/icons/apple.svg',
                                                width: 22,
                                                height: 22,
                                              ),
                                              label: context.l10n.authContinueWithApple,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Gap(16),
                                      _FadeSlideIn(
                                        animation: _dividerAnimation,
                                        child: const _OrDivider(),
                                      ),
                                      const Gap(16),
                                      _FadeSlideIn(
                                        animation: _emailAnimation,
                                        child: Column(
                                          children: [
                                            _InputCard(
                                              child: SizedBox(
                                                height: 56,
                                                child: Center(
                                                  child: TextField(
                                                    controller: _emailController,
                                                    keyboardType:
                                                        TextInputType.emailAddress,
                                                    textInputAction:
                                                        TextInputAction.send,
                                                    textAlignVertical:
                                                        TextAlignVertical.center,
                                                    onSubmitted: (_) => _sendMagicLink(),
                                                    onChanged: (_) {
                                                      if (_errorMessage != null ||
                                                          _statusMessage != null) {
                                                        setState(() {
                                                          _errorMessage = null;
                                                          _statusMessage = null;
                                                        });
                                                      } else {
                                                        setState(() {});
                                                      }
                                                    },
                                                    decoration: InputDecoration(
                                                      isCollapsed: true,
                                                      filled: false,
                                                      hintText: context.l10n.authEmailHint,
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      disabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      focusedErrorBorder:
                                                          InputBorder.none,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      hintStyle: theme
                                                          .textTheme.bodyLarge
                                                          ?.copyWith(
                                                        color: colors.textSecondary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Gap(12),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 56,
                                              child: FilledButton.icon(
                                                onPressed: _isLoading ||
                                                        !_authEnabled ||
                                                        !_emailController.text
                                                            .contains('@')
                                                    ? null
                                                    : _sendMagicLink,
                                                icon: _isLoading
                                                    ? const SizedBox(
                                                        width: 18,
                                                        height: 18,
                                                        child:
                                                            CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                          color: Colors.white70,
                                                        ),
                                                      )
                                                    : const Icon(
                                                        Icons.mail_outline_rounded,
                                                        size: 20,
                                                      ),
                                                label: Text(
                                                  _isLoading
                                                      ? 'Sending...'
                                                      : 'Send secure sign-in link',
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              'A one-tap sign-in link will arrive in your inbox.',
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        if (!_authEnabled) ...[
                          const Gap(20),
                          const _StatusBanner(
                            message:
                                'Authentication is not available yet because Supabase is not configured.',
                            type: _StatusType.error,
                          ),
                        ],
                        if (_errorMessage != null || deepLinkState.error != null) ...[
                          const Gap(20),
                          _StatusBanner(
                            message: deepLinkState.error ?? _errorMessage!,
                            type: _StatusType.error,
                            onDismiss: deepLinkState.error != null
                                ? () =>
                                    ref.read(deepLinkProvider.notifier).clearError()
                                : null,
                          ),
                        ],
                        if (_statusMessage != null) ...[
                          const Gap(20),
                          _StatusBanner(
                            message: _statusMessage!,
                            type: _StatusType.loading,
                          ),
                        ],
                        if (isProcessingDeepLink) ...[
                          const Gap(20),
                          const _StatusBanner(
                            message: 'Signing you in...',
                            type: _StatusType.loading,
                          ),
                        ],
                        const Gap(48),
                      ],
                    ),
                  ),
                ),
              ),
              _FadeSlideIn(
                animation: _footerAnimation,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'By continuing, you agree to our\n',
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () =>
                                    _launchUrl('https://myglu.health/terms'),
                                child: Text(
                                  'Terms of Service',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colors.textSecondary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: colors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: ' and '),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () =>
                                    _launchUrl('https://myglu.health/privacy'),
                                child: Text(
                                  'Privacy Policy',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colors.textSecondary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: colors.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                            const TextSpan(text: '.'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const Gap(8),
                      const _TrustSignalRow(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FadeSlideIn extends StatelessWidget {
  const _FadeSlideIn({
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}

class _OAuthButton extends StatelessWidget {
  const _OAuthButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        clipBehavior: Clip.antiAlias,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: colors.lineSubtle),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0C1118),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  const Gap(12),
                  Text(
                    label,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum _StatusType { error, loading }

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({
    required this.message,
    required this.type,
    this.onDismiss,
  });

  final String message;
  final _StatusType type;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final isError = type == _StatusType.error;
    final foregroundColor =
        isError ? const Color(0xFF9E4F4F) : colors.textPrimary;
    final backgroundColor =
        isError ? colors.accentPeach.withValues(alpha: 0.35) : colors.softSurface;

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isError ? colors.accentPeach : colors.lineSubtle,
            ),
          ),
          child: Row(
            children: [
              if (isError)
                Icon(Icons.info_outline_rounded, size: 18, color: foregroundColor)
              else
                SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: foregroundColor,
                  ),
                ),
              const Gap(12),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: foregroundColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onDismiss != null) ...[
                const Gap(8),
                GestureDetector(
                  onTap: onDismiss,
                  child: Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: foregroundColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      children: [
        Expanded(child: Divider(color: colors.lineSubtle)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                ),
          ),
        ),
        Expanded(child: Divider(color: colors.lineSubtle)),
      ],
    );
  }
}

class _MagicLinkSentCard extends StatelessWidget {
  const _MagicLinkSentCard({
    required this.email,
    required this.onResend,
    required this.onChangeEmail,
    required this.isLoading,
  });

  final String email;
  final VoidCallback onResend;
  final VoidCallback onChangeEmail;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x120C1118),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: colors.accentMint,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              color: colors.textPrimary,
              size: 28,
            ),
          ),
          const Gap(20),
          Text(
            'Check your inbox',
            style: theme.textTheme.titleLarge,
          ),
          const Gap(8),
          Text(
            'We sent a sign-in link to',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const Gap(4),
          Text(
            email,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(24),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              TextButton(
                onPressed: isLoading ? null : onResend,
                child: Text(
                  isLoading
                      ? context.l10n.authSending
                      : context.l10n.authResendLink,
                ),
              ),
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.textSecondary,
                  shape: BoxShape.circle,
                ),
              ),
              TextButton(
                onPressed: onChangeEmail,
                child: Text(context.l10n.authUseDifferentEmail),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InputCard extends StatelessWidget {
  const _InputCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colors.lineSubtle, width: 1.25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F0C1118),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _TrustSignalRow extends StatelessWidget {
  const _TrustSignalRow();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    Widget item(IconData icon, String label) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.textSecondary),
          const Gap(6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        item(Icons.lock_outline_rounded, 'Private'),
        item(Icons.verified_user_outlined, 'Encrypted'),
        item(Icons.favorite_border_rounded, 'Wellness first'),
      ],
    );
  }
}
