import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/analytics_provider.dart';
import '../providers/subscription_provider.dart';
import '../screens/payment/payment_screen.dart';
import '../screens/settings/manage_subscription_screen.dart';
import '../theme/app_colors.dart';

Future<void> openProAccessScreen(
  BuildContext context,
  WidgetRef ref, {
  String source = 'unknown',
}) async {
  final status = await ref.read(subscriptionProvider.future).catchError(
        (_) => SubscriptionStatus.free,
      );
  if (!context.mounted) {
    return;
  }
  ref.read(analyticsServiceProvider).capture(
    eventName: 'paywall_open_requested',
    properties: {
      'source': source,
      'subscription_status': status.name,
    },
  );
  await Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => status == SubscriptionStatus.pro
          ? const ManageSubscriptionScreen()
          : PaymentScreen(source: source),
    ),
  );
}

class ProGate extends ConsumerWidget {
  const ProGate({
    super.key,
    required this.child,
    this.title = 'Glu Pro',
    this.description = 'Upgrade to unlock this feature.',
    this.ctaLabel = 'Upgrade to Pro',
    this.icon = Icons.workspace_premium_outlined,
    this.lockedBuilder,
    this.loadingBuilder,
  });

  final Widget child;
  final String title;
  final String description;
  final String ctaLabel;
  final IconData icon;
  final Widget Function(BuildContext context, VoidCallback openAccess)?
      lockedBuilder;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(subscriptionProvider);
    void openAccess() {
      unawaited(openProAccessScreen(context, ref, source: 'pro_gate'));
    }

    return status.when(
      data: (value) {
        if (value == SubscriptionStatus.pro) {
          return child;
        }
        return lockedBuilder?.call(context, openAccess) ??
            _DefaultProLockedState(
              title: title,
              description: description,
              ctaLabel: ctaLabel,
              icon: icon,
              onTap: openAccess,
            );
      },
      loading: () => loadingBuilder?.call(context) ?? const SizedBox.shrink(),
      error: (error, stackTrace) =>
          lockedBuilder?.call(context, openAccess) ??
          _DefaultProLockedState(
            title: title,
            description: description,
            ctaLabel: ctaLabel,
            icon: icon,
            onTap: openAccess,
          ),
    );
  }
}

class _DefaultProLockedState extends StatelessWidget {
  const _DefaultProLockedState({
    required this.title,
    required this.description,
    required this.ctaLabel,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final String ctaLabel;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: colors.accentButter,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: colors.textPrimary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: theme.textTheme.titleMedium),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          FilledButton(
            onPressed: onTap,
            child: Text(ctaLabel),
          ),
        ],
      ),
    );
  }
}
