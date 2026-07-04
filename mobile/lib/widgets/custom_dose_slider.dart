import 'package:flutter/material.dart';

import '../models/medication_catalog.dart';
import '../theme/app_colors.dart';

class CustomDoseSlider extends StatelessWidget {
  const CustomDoseSlider({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.step,
    required this.onChanged,
  });

  final double value;
  final double min;
  final double max;
  final double step;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final clamped = value.clamp(min, max);
    final divisions = ((max - min) / step).round();
    final display = MedicationCatalog.formatDoseLabel(
      MedicationCatalog.coerceDoseValue(clamped) ?? clamped.toString(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            display,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textPrimary,
            ),
          ),
        ),
        Row(
          children: [
            _DoseStepButton(
              icon: Icons.remove_rounded,
              onTap: () {
                final next = (clamped - step).clamp(min, max).toDouble();
                final normalized =
                    MedicationCatalog.coerceDoseValue(next) ?? next.toString();
                onChanged(normalized);
              },
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 16),
                  activeTrackColor: colors.heroEnd,
                  inactiveTrackColor: colors.lineSubtle,
                  thumbColor: colors.heroEnd,
                  overlayColor: colors.heroEnd.withValues(alpha: 0.16),
                ),
                child: Slider(
                  value: clamped,
                  min: min,
                  max: max,
                  divisions: divisions > 0 ? divisions : null,
                  label: display,
                  onChanged: (next) {
                    final normalized = MedicationCatalog.coerceDoseValue(next) ??
                        next.toString();
                    onChanged(normalized);
                  },
                ),
              ),
            ),
            _DoseStepButton(
              icon: Icons.add_rounded,
              onTap: () {
                final next = (clamped + step).clamp(min, max).toDouble();
                final normalized =
                    MedicationCatalog.coerceDoseValue(next) ?? next.toString();
                onChanged(normalized);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _DoseStepButton extends StatelessWidget {
  const _DoseStepButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: colors.softSurface,
            shape: BoxShape.circle,
            border: Border.all(color: colors.lineSubtle),
          ),
          child: Icon(
            icon,
            color: colors.textPrimary,
          ),
        ),
      ),
    );
  }
}
