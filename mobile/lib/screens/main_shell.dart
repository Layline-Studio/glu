import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import '../config/app_config.dart';
import '../models/app_profile.dart';
import '../l10n/l10n.dart';
import '../providers/profile_provider.dart';
import '../providers/profile_service_provider.dart';
import '../services/notification_router_service.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'log/log_screen.dart';
import 'progress/progress_screen.dart';
import 'settings_screen.dart';

const _progressTabIndex = 2;
const shellSettingsTabIndex = 3;
const _lastVisitedTabIndexKey = 'main_shell_last_visited_tab_index';

final shellTabRequestProvider = NotifierProvider<_ShellTabNotifier, int?>(
  _ShellTabNotifier.new,
);

class _ShellTabNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void request(int index) => state = index;
  void clear() => state = null;
}

class MainShell extends ConsumerStatefulWidget {
  const MainShell({
    super.key,
    required this.config,
    required this.supabaseReady,
  });

  final AppConfig config;
  final bool supabaseReady;

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

// Ordered showcase chain. Each entry fires only after all previous ones are seen.
// requiredTab: the tab that must be active to trigger (-1 = any tab).
typedef _ShowcaseEntry = ({String seenKey, int requiredTab});

class _MainShellState extends ConsumerState<MainShell> {
  int _index = 0;
  bool _initialTabLoaded = false;

  static const _chain = <_ShowcaseEntry>[
    (seenKey: 'showcase_reminders_seen', requiredTab: 0),
    (seenKey: 'showcase_log_seen',       requiredTab: -1),
    (seenKey: 'showcase_water_seen',     requiredTab: 1),
    (seenKey: 'showcase_progress_seen',  requiredTab: -1),
  ];

  final GlobalKey _logShowcaseKey = GlobalKey();
  final GlobalKey _waterShowcaseKey = GlobalKey();
  final GlobalKey _progressShowcaseKey = GlobalKey();

  // Tracks which showcases have been triggered this session to avoid re-firing.
  final _started = <String>{};

  final _notificationRouter = NotificationRouterService();

  @override
  void initState() {
    super.initState();
    ShowcaseView.register();
    unawaited(_restoreLastVisitedTabIndex());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual(shellTabRequestProvider, (_, next) {
        if (next != null) {
          _handleTabTap(next);
          ref.read(shellTabRequestProvider.notifier).clear();
        }
      });
      unawaited(_notificationRouter.start(ref));
    });
  }

  Future<void> _restoreLastVisitedTabIndex() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedIndex = prefs.getInt(_lastVisitedTabIndexKey);
      if (!mounted) {
        return;
      }
      setState(() {
        _index = _normalizeTabIndex(storedIndex ?? 0);
        _initialTabLoaded = true;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _initialTabLoaded = true;
      });
    }
  }

  int _normalizeTabIndex(int index) {
    if (index < 0 || index > 3) {
      return 0;
    }
    return index;
  }

  Future<void> _persistLastVisitedTabIndex(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_lastVisitedTabIndexKey, index);
    } catch (_) {
      // Best effort only.
    }
  }

  void _maybeStartNextShowcase(AppProfile? profile) {
    if (profile == null) return;
    final settings = profile.settings;

    // If all showcase keys are unseen (e.g. after a reset), clear session state.
    final allUnseen = _chain.every(
      (e) => (settings[e.seenKey] as bool?) != true,
    );
    if (allUnseen) _started.clear();

    for (final entry in _chain) {
      final seen = (settings[entry.seenKey] as bool?) ?? false;
      if (seen) continue; // already done, check next in chain

      // This is the next showcase to show. Only fire if on the right tab.
      if (entry.requiredTab >= 0 && _index != entry.requiredTab) return;

      // Don't re-fire if already triggered this session.
      if (_started.contains(entry.seenKey)) return;

      final key = _showcaseKey(entry.seenKey);
      if (key == null) return; // child screen manages its own trigger

      _started.add(entry.seenKey);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ShowcaseView.get().startShowCase([key]);
      });
      return;
    }
  }

  GlobalKey? _showcaseKey(String seenKey) => switch (seenKey) {
        'showcase_log_seen' => _logShowcaseKey,
        'showcase_progress_seen' => _progressShowcaseKey,
        _ => null,
      };

  bool _seen(AppProfile? profile, String key) =>
      (profile?.settings[key] as bool?) ?? false;

  Future<void> _markShellShowcaseSeen(String key) async {
    try {
      await ref.read(profileServiceProvider).updateSettings({key: true});
      ref.invalidate(profileBootstrapProvider);
    } catch (_) {}
  }

  Future<void> _handleTabTap(int nextIndex) async {
    if (nextIndex == _index) {
      return;
    }

    HapticFeedback.selectionClick();

    if (!mounted) {
      return;
    }
    if (nextIndex == _progressTabIndex) {
      ref.read(progressAnimationTriggerProvider.notifier).increment();
    }
    // Allow re-triggering tab-specific showcases when re-entering their tab.
    _started.removeWhere((key) {
      final entry = _chain.where((e) => e.seenKey == key).firstOrNull;
      return entry?.requiredTab == nextIndex;
    });
    setState(() => _index = nextIndex);
    unawaited(_persistLastVisitedTabIndex(nextIndex));
  }

  @override
  void dispose() {
    unawaited(_notificationRouter.dispose());
    ShowcaseView.get().unregister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(profileBootstrapProvider).asData?.value;
    _maybeStartNextShowcase(profile);

    if (!_initialTabLoaded) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(
            config: widget.config,
            supabaseReady: widget.supabaseReady,
            isActive: _index == 0,
          ),
          LogScreen(
            waterShowcaseKey: _waterShowcaseKey,
            showWaterShowcase: _seen(profile, 'showcase_water_seen') == false,
            onWaterShowcaseInteracted: () =>
                _markShellShowcaseSeen('showcase_water_seen'),
            isActive: _index == 1,
          ),
          const ProgressScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: _PremiumNavBar(
        currentIndex: _index,
        onTap: _handleTabTap,
        logShowcaseKey: _logShowcaseKey,
        progressShowcaseKey: _progressShowcaseKey,
        showLogShowcase: _seen(profile, 'showcase_log_seen') == false,
        showProgressShowcase: _seen(profile, 'showcase_progress_seen') == false,
        onLogShowcaseInteracted: () =>
            _markShellShowcaseSeen('showcase_log_seen'),
        onProgressShowcaseInteracted: () =>
            _markShellShowcaseSeen('showcase_progress_seen'),
      ),
    );
  }
}

// ── Nav bar ───────────────────────────────────────────────────────────────────

class _PremiumNavBar extends StatelessWidget {
  const _PremiumNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.logShowcaseKey,
    required this.progressShowcaseKey,
    required this.showLogShowcase,
    required this.showProgressShowcase,
    required this.onLogShowcaseInteracted,
    required this.onProgressShowcaseInteracted,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final GlobalKey logShowcaseKey;
  final GlobalKey progressShowcaseKey;
  final bool showLogShowcase;
  final bool showProgressShowcase;
  final VoidCallback onLogShowcaseInteracted;
  final VoidCallback onProgressShowcaseInteracted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final l10n = context.l10n;
    final items = [
      _NavItem(label: l10n.mainShellHome, icon: Icons.home_rounded),
      _NavItem(label: l10n.mainShellLog, icon: Icons.edit_note_rounded),
      _NavItem(label: l10n.mainShellProgress, icon: Icons.show_chart_rounded),
      _NavItem(label: l10n.mainShellSettings, icon: Icons.tune_rounded),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: colors.lineSubtle),
            boxShadow: const [
              BoxShadow(
                color: Color(0x16000000),
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: i == 1 && showLogShowcase
                      ? Showcase(
                          key: logShowcaseKey,
                          title: l10n.mainShellLogShowcaseTitle,
                          description: l10n.mainShellLogShowcaseDescription,
                          tooltipBackgroundColor: colors.surface,
                          tooltipBorderRadius: BorderRadius.circular(24),
                          tooltipPadding:
                              const EdgeInsets.fromLTRB(18, 18, 18, 18),
                          titlePadding: const EdgeInsets.only(bottom: 8),
                          titleAlignment: Alignment.centerLeft,
                          descriptionAlignment: Alignment.centerLeft,
                          titleTextAlign: TextAlign.left,
                          descriptionTextAlign: TextAlign.left,
                          titleTextStyle:
                              theme.textTheme.titleSmall?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w700,
                            height: 1.1,
                          ),
                          descTextStyle: theme.textTheme.bodySmall?.copyWith(
                            color: colors.textPrimary.withValues(alpha: 0.72),
                            height: 1.35,
                          ),
                          overlayOpacity: 0.58,
                          disableMovingAnimation: true,
                          disableScaleAnimation: true,
                          showArrow: true,
                          toolTipMargin: 10,
                          targetPadding: const EdgeInsets.all(4),
                          targetBorderRadius: BorderRadius.circular(999),
                          onBarrierClick: onLogShowcaseInteracted,
                          onToolTipClick: onLogShowcaseInteracted,
                          onTargetClick: onLogShowcaseInteracted,
                          disposeOnTap: true,
                          child: _NavBarItem(
                            item: items[i],
                            isActive: i == currentIndex,
                            onTap: () => onTap(i),
                          ),
                        )
                      : i == 2 && showProgressShowcase
                          ? Showcase(
                              key: progressShowcaseKey,
                              title: l10n.mainShellProgressShowcaseTitle,
                              description:
                                  l10n.mainShellProgressShowcaseDescription,
                              tooltipBackgroundColor: colors.surface,
                              tooltipBorderRadius: BorderRadius.circular(24),
                              tooltipPadding:
                                  const EdgeInsets.fromLTRB(18, 18, 18, 18),
                              titlePadding: const EdgeInsets.only(bottom: 8),
                              titleAlignment: Alignment.centerLeft,
                              descriptionAlignment: Alignment.centerLeft,
                              titleTextAlign: TextAlign.left,
                              descriptionTextAlign: TextAlign.left,
                              titleTextStyle:
                                  theme.textTheme.titleSmall?.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.w700,
                                height: 1.1,
                              ),
                              descTextStyle: theme.textTheme.bodySmall?.copyWith(
                                color: colors.textPrimary.withValues(alpha: 0.72),
                                height: 1.35,
                              ),
                              overlayOpacity: 0.58,
                              disableMovingAnimation: true,
                              disableScaleAnimation: true,
                              showArrow: true,
                              toolTipMargin: 10,
                              targetPadding: const EdgeInsets.all(4),
                              targetBorderRadius: BorderRadius.circular(999),
                              onBarrierClick: onProgressShowcaseInteracted,
                              onToolTipClick: onProgressShowcaseInteracted,
                              onTargetClick: onProgressShowcaseInteracted,
                              disposeOnTap: true,
                              child: _NavBarItem(
                                item: items[i],
                                isActive: i == currentIndex,
                                onTap: () => onTap(i),
                              ),
                            )
                          : _NavBarItem(
                              item: items[i],
                              isActive: i == currentIndex,
                              onTap: () => onTap(i),
                            ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final iconColor = isActive
        ? colors.textPrimary
        : colors.textSecondary.withValues(alpha: 0.55);
    final labelColor = isActive
        ? colors.textPrimary
        : colors.textSecondary.withValues(alpha: 0.55);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedScale(
              scale: isActive ? 1.12 : 1.0,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutBack,
              child: Icon(item.icon, size: 22, color: iconColor),
            ),
            const SizedBox(height: 3),
            Text(
              item.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: labelColor,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            // Sliding indicator pill
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: isActive ? 18 : 0,
              height: 3,
              decoration: BoxDecoration(
                color: colors.textPrimary,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
