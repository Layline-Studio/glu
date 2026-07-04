import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../theme/app_colors.dart';

class SuccessOverlayIconSpec {
  const SuccessOverlayIconSpec({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;
}

class LogSuccessOverlay extends StatelessWidget {
  const LogSuccessOverlay({
    super.key,
    required this.title,
    this.subtitle,
    required this.icons,
    required this.rippleColor,
    this.badgeColor,
  });

  final String title;
  final String? subtitle;
  final List<SuccessOverlayIconSpec> icons;
  final Color rippleColor;
  final Color? badgeColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return ColoredBox(
      color: colors.surface,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 108,
                  height: 108,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: rippleColor.withValues(alpha: 0.16),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.72, 0.72),
                      end: const Offset(1.08, 1.08),
                      duration: 520.ms,
                      curve: Curves.easeOutCubic,
                    )
                    .fade(begin: 0.34, end: 0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    icons.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        icons[index].icon,
                        color: icons[index].color,
                        size: 14 + ((index + 1) % 2) * 7,
                      )
                          .animate(delay: Duration(milliseconds: 70 * index))
                          .moveY(begin: 18, end: -24, duration: 540.ms)
                          .fadeIn(duration: 180.ms)
                          .fadeOut(delay: 220.ms, duration: 260.ms),
                    ),
                  ),
                ),
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: badgeColor ?? colors.softSurface,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.lineSubtle),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    color: colors.textPrimary,
                    size: 32,
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.76, 0.76),
                      end: const Offset(1, 1),
                      duration: 320.ms,
                      curve: Curves.easeOutBack,
                    )
                    .fadeIn(duration: 200.ms),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: subtitle == null
                  ? theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    )
                  : theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colors.textPrimary,
                    ),
            )
                .animate()
                .moveY(begin: 8, end: 0, duration: 220.ms)
                .fadeIn(duration: 180.ms),
            if (subtitle != null) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.textSecondary,
                ),
              ).animate().fadeIn(duration: 180.ms, delay: 40.ms),
            ],
          ],
        ),
      ),
    );
  }
}
