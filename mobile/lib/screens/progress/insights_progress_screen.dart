import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../l10n/l10n.dart';
import '../../providers/generate_insights_service_provider.dart';
import '../../services/generate_insights_service.dart';
import '../../theme/app_colors.dart';

final _insightsHistoryProvider =
    FutureProvider<List<InsightHistoryEntry>>((ref) async {
  return ref.read(generateInsightsServiceProvider).loadInsightHistory();
});

class InsightsProgressScreen extends ConsumerWidget {
  const InsightsProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final state = ref.watch(_insightsHistoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: state.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (entries) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 28),
              children: [
                Row(
                  children: [
                    InkResponse(
                      onTap: () => Navigator.of(context).pop(),
                      radius: 20,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 18,
                        color: colors.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      context.l10n.insightsProgressTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
                const SizedBox(height: 18),
                if (entries.isEmpty)
                  _EmptyInsightsState(colors: colors)
                else
                  ...[
                    for (final entry in entries) ...[
                      _InsightHistoryCard(entry: entry),
                      const SizedBox(height: 12),
                    ],
                  ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EmptyInsightsState extends StatelessWidget {
  const _EmptyInsightsState({
    required this.colors,
  });

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Text(
        context.l10n.insightsProgressEmptyState,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: colors.textSecondary,
        ),
      ),
    );
  }
}

class _InsightHistoryCard extends StatelessWidget {
  const _InsightHistoryCard({
    required this.entry,
  });

  final InsightHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateLabel = DateFormat('MMM d, yyyy', locale).format(
      entry.createdAt.toLocal(),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
              children: [
              Text(
                dateLabel,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                entry.summary,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.textSecondary,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
