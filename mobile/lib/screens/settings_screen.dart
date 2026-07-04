import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/app_profile.dart';
import '../l10n/app_locale.dart';
import '../l10n/l10n.dart';
import '../providers/app_locale_provider.dart';
import '../providers/profile_provider.dart';
import '../providers/profile_service_provider.dart';
import '../providers/reminder_service_provider.dart';
import '../providers/record_service_provider.dart';
import '../providers/subscription_provider.dart';
import '../widgets/pro_gate.dart';
import 'home_screen.dart';
import 'goals_screen.dart';
import 'progress/progress_screen.dart';
import 'settings/dose_reminder_screen.dart';
import 'settings/feedback_sheet.dart';
import 'settings/supplement_reminder_screen.dart';
import '../theme/app_colors.dart';

final _authIdentitiesProvider = FutureProvider<List<UserIdentity>>((ref) async {
  return Supabase.instance.client.auth.getUserIdentities();
});

final _packageInfoProvider = FutureProvider<PackageInfo>((ref) async {
  return PackageInfo.fromPlatform();
});

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  static const _primaryGoalKey = 'primary_goal';
  static const _measurementUnitKey = 'measurement_unit';
  static const _preferredNameKey = 'preferred_name';
  static const _ageKey = 'age';
  static const _genderKey = 'gender';
  static const _heightKey = 'height';
  static const _dailyRemindersKey = 'daily_reminders';
  static const _appLocaleKey = 'app_locale';
  static const _debugSubscriptionOverrideField = 'debug_subscription_override';
  static const _debugInsightCardModeKey = 'debug_insight_card_mode';
  String? _expandedField;
  String? _savingField;
  bool _accountActionInFlight = false;
  bool _isResettingOnboarding = false;
  bool _isResettingShowcases = false;
  bool _isResettingUserData = false;

  Future<void> _updateSettings(String field, Map<String, dynamic> patch) async {
    if (_savingField != null) return;

    setState(() {
      _savingField = field;
    });

    try {
      await ref.read(profileServiceProvider).updateSettings(patch);
      ref.invalidate(profileBootstrapProvider);
      ref.invalidate(subscriptionProvider);
      if (mounted) {
        setState(() {
          _expandedField = null;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _savingField = null;
        });
      }
    }
  }

  void _toggleField(String field) {
    setState(() {
      _expandedField = _expandedField == field ? null : field;
    });
  }

  Future<void> _unlinkIdentity(UserIdentity identity) async {
    if (_accountActionInFlight) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          context.l10n.settingsDisconnectProviderTitle(
            _providerDisplayName(identity.provider),
          ),
        ),
        content: Text(
          context.l10n.settingsDisconnectProviderBody(
            _providerDisplayName(identity.provider),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.settingsDisconnect),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _accountActionInFlight = true);
    try {
      await Supabase.instance.client.auth.unlinkIdentity(identity);
      ref.invalidate(_authIdentitiesProvider);
    } finally {
      if (mounted) {
        setState(() => _accountActionInFlight = false);
      }
    }
  }

  Future<void> _deleteAccount() async {
    if (_accountActionInFlight) return;
    final controller = TextEditingController();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final isConfirmed =
                controller.text.trim().toUpperCase() == 'DELETE';
            return AlertDialog(
              title: Text(context.l10n.settingsDeleteAccountTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.settingsDeleteAccountBody,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: context.l10n.settingsDeleteAccountConfirmHint,
                    ),
                    onChanged: (_) => setDialogState(() {}),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(context.l10n.commonCancel),
                ),
                FilledButton(
                  onPressed: !isConfirmed
                      ? null
                      : () {
                          Navigator.of(dialogContext).pop();
                          _performDeleteAccount();
                        },
                  child: Text(context.l10n.commonDelete),
                ),
              ],
            );
          },
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
    });
  }

  Future<void> _performDeleteAccount() async {
    if (_accountActionInFlight) return;
    setState(() => _accountActionInFlight = true);
    try {
      await ref.read(profileServiceProvider).deleteAccount();
      await Supabase.instance.client.auth.signOut(scope: SignOutScope.local);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.settingsDeleteAccountError),
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _accountActionInFlight = false);
      }
    }
  }

  Future<void> _resetOnboarding() async {
    if (_isResettingOnboarding) return;

    setState(() => _isResettingOnboarding = true);
    try {
      await ref.read(profileServiceProvider).resetOnboarding();
      ref.invalidate(profileBootstrapProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.settingsRestartAppToSeeOnboarding)));
    } finally {
      if (mounted) {
        setState(() => _isResettingOnboarding = false);
      }
    }
  }

  Future<void> _resetShowcases() async {
    if (_isResettingShowcases) return;

    setState(() => _isResettingShowcases = true);
    try {
      await ref.read(profileServiceProvider).resetShowcases();
      ref.invalidate(profileBootstrapProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.settingsShowcasesReset)));
    } finally {
      if (mounted) {
        setState(() => _isResettingShowcases = false);
      }
    }
  }

  Future<void> _resetUserData() async {
    if (_isResettingUserData) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.settingsResetUserDataTitle),
        content: Text(
          context.l10n.settingsResetUserDataBody,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.settingsResetUserData),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    setState(() => _isResettingUserData = true);
    try {
      await ref.read(recordServiceProvider).resetUserData();
      ref.invalidate(homeStatsProvider);
      ref.invalidate(progressOverviewProvider);
      ref.invalidate(profileBootstrapProvider);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.settingsUserDataReset)));
    } finally {
      if (mounted) {
        setState(() => _isResettingUserData = false);
      }
    }
  }

  Future<void> _updateDailyReminders(bool enabled) async {
    if (_savingField != null) return;

    AppProfile? updatedProfile;
    setState(() {
      _savingField = _dailyRemindersKey;
    });

    try {
      updatedProfile = await ref
          .read(reminderServiceProvider)
          .updateDailyReminders(enabled: enabled);
      ref.invalidate(profileBootstrapProvider);
    } finally {
      if (mounted) {
        setState(() {
          _savingField = null;
        });
      }
    }

    unawaited(_syncDailyRemindersAfterSave(updatedProfile));
  }

  Future<void> _showHealthGoalPicker(String? currentGoal) async {
    if (_savingField != null) return;

    final selected = await showDialog<String?>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(context.l10n.settingsHealthGoalDialogTitle),
        children: [
          for (final option in _primaryGoalOptions(context))
            SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop(option.value),
              child: Text(option.label),
            ),
        ],
      ),
    );
    if (!mounted || selected == null || selected == currentGoal) {
      return;
    }

    await _updateSettings(_primaryGoalKey, {_primaryGoalKey: selected});
  }

  Future<void> _showGenderPicker(String? currentGender) async {
    if (_savingField != null) return;

    final selected = await showDialog<String?>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(context.l10n.settingsGender),
        children: [
          for (final option in _genderOptions(context))
            SimpleDialogOption(
              onPressed: () => Navigator.of(dialogContext).pop(option.value),
              child: Text(option.label),
            ),
        ],
      ),
    );
    if (!mounted || selected == null || selected == currentGender) {
      return;
    }

    await _updateSettings(_genderKey, {_genderKey: selected});
  }

  Future<void> _syncDailyRemindersAfterSave(AppProfile profile) async {
    try {
      await ref
          .read(reminderServiceProvider)
          .syncDailyReminders(profile)
          .timeout(const Duration(seconds: 10));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            context.l10n.settingsDailyRemindersCouldNotBeScheduledRightNow,
          ),
        ),
      );
    }
  }

  Future<void> _showSubscriptionOverridePicker(String? currentOverride) async {
    if (_savingField != null) return;

    final selected = await showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.settingsSubscriptionOverrideTitle),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop('auto'),
            child: Text(context.l10n.settingsSubscriptionOverrideAuto),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop('free'),
            child: Text(context.l10n.settingsSubscriptionOverrideForceFree),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop('pro'),
            child: Text(context.l10n.settingsSubscriptionOverrideForcePro),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (selected == null) return;
    if (selected == currentOverride) return;

    await _updateSettings(_debugSubscriptionOverrideField, {
      debugSubscriptionOverrideKey: selected,
    });
  }

  Future<void> _showInsightCardModePicker(String? currentMode) async {
    if (_savingField != null) return;

    final selected = await showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.settingsTodayInsightCardTitle),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop('auto'),
            child: Text(context.l10n.settingsTodayInsightCardAuto),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop('on'),
            child: Text(context.l10n.settingsTodayInsightCardOn),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop('off'),
            child: Text(context.l10n.settingsTodayInsightCardOff),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (selected == null) return;
    if (selected == currentMode) return;

    await _updateSettings(_debugInsightCardModeKey, {
      _debugInsightCardModeKey: selected,
    });
  }

  Future<void> _showLanguagePicker(String? currentLocale) async {
    if (_savingField != null) return;

    final selected = await showDialog<String?>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.settingsLanguageDialogTitle),
        children: [
          for (final locale in supportedAppLocales)
            SimpleDialogOption(
              onPressed: () =>
                  Navigator.of(context).pop(locale.languageCode.toLowerCase()),
              child: Text(languageNameForLocale(locale)),
            ),
        ],
      ),
    );
    if (!mounted) return;
    if (selected == null) return;
    if (selected == currentLocale) return;

    await _updateSettings(_appLocaleKey, {
      _appLocaleKey: selected,
    });
    ref.read(appLocaleControllerProvider.notifier).setLocale(Locale(selected));
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final profileState = ref.watch(profileBootstrapProvider);
    final isPro = ref.watch(isProProvider);
    final identitiesState = ref.watch(_authIdentitiesProvider);
    final packageInfoState = ref.watch(_packageInfoProvider);

    return Scaffold(
      backgroundColor: colors.canvas,
      body: Stack(
        children: [
          SafeArea(
            child: profileState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('$error')),
              data: (profile) {
                final settings = profile?.settings ?? const <String, dynamic>{};
                final dailyRemindersEnabled = profile
                        ?.reminders.daily.enabled ??
                    ((settings['daily_reminders_enabled'] as bool?) ?? false);
                final measurementUnit =
                    (settings[_measurementUnitKey] as String?) ?? 'kg';
                final userEmail =
                    Supabase.instance.client.auth.currentUser?.email ?? '';
                final footerAccountActions = _footerAccountActions(
                  context,
                  identitiesState.asData?.value ?? const <UserIdentity>[],
                );

                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  children: [
                    Center(
                      child: Text(
                        context.l10n.settingsTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _ProfileSummaryHeader(
                      name: _preferredNameSummary(settings),
                      email: Supabase.instance.client.auth.currentUser?.email ??
                          'Not available',
                      editing: _expandedField == _preferredNameKey,
                      saving: _savingField == _preferredNameKey,
                      onEdit: () => _toggleField(_preferredNameKey),
                      onSaveName: (value) => _updateSettings(
                        _preferredNameKey,
                        {_preferredNameKey: value.trim()},
                      ),
                      onSignOut: () async {
                        await Supabase.instance.client.auth.signOut();
                      },
                    ),
                    const SizedBox(height: 18),
                    _SectionLabel(label: context.l10n.settingsPreferences),
                    const SizedBox(height: 8),
                    _SettingsCard(
                      child: Column(
                        children: [
                          _NavigationSettingRow(
                            icon: Icons.favorite_rounded,
                            label: context.l10n.settingsHealthGoal,
                            value: _healthGoalSummary(context, settings),
                            showDivider: true,
                            onTap: () => _showHealthGoalPicker(
                              settings[_primaryGoalKey] as String?,
                            ),
                          ),
                          _NavigationSettingRow(
                            icon: Icons.flag_rounded,
                            label: context.l10n.settingsHabitGoals,
                            value: _habitGoalsSummary(context, profile),
                            showDivider: true,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<void>(
                                  builder: (_) => const HabitGoalsScreen(),
                                ),
                              );
                            },
                          ),
                          _ExpandableSettingRow(
                            icon: Icons.straighten_rounded,
                            showDivider: true,
                            label: context.l10n.settingsHeight,
                            value: _heightSummary(context, settings),
                            expanded: _expandedField == _heightKey,
                            saving: _savingField == _heightKey,
                            onTap: () => _toggleField(_heightKey),
                            child: _HeightEditor(
                              initialValue: settings[_heightKey],
                              enabled: _savingField == null,
                              onSave: (value) => _updateSettings(
                                  _heightKey, {_heightKey: value}),
                            ),
                          ),
                          _ExpandableSettingRow(
                            icon: Icons.cake_outlined,
                            showDivider: true,
                            label: context.l10n.settingsAge,
                            value: _ageSummary(context, settings),
                            expanded: _expandedField == _ageKey,
                            saving: _savingField == _ageKey,
                            onTap: () => _toggleField(_ageKey),
                            child: _AgeEditor(
                              initialValue: _ageValue(settings),
                              enabled: _savingField == null,
                              onSave: (value) =>
                                  _updateSettings(_ageKey, {_ageKey: value}),
                            ),
                          ),
                          _NavigationSettingRow(
                            icon: Icons.person_outline_rounded,
                            showDivider: true,
                            label: context.l10n.settingsGender,
                            value: _genderSummary(context, settings),
                            onTap: () => _showGenderPicker(
                              settings[_genderKey] as String?,
                            ),
                          ),
                          _ExpandableSettingRow(
                            icon: Icons.swap_horiz_rounded,
                            showDivider: true,
                            label: context.l10n.settingsMeasurementUnit,
                            value: measurementUnit.toUpperCase(),
                            expanded: _expandedField == _measurementUnitKey,
                            saving: _savingField == _measurementUnitKey,
                            onTap: () => _toggleField(_measurementUnitKey),
                            child: _MeasurementUnitToggle(
                              value: measurementUnit,
                              enabled: _savingField == null,
                              onChanged: (unit) => _updateSettings(
                                _measurementUnitKey,
                                {_measurementUnitKey: unit},
                              ),
                            ),
                          ),
                          _NavigationSettingRow(
                            icon: Icons.language_rounded,
                            label: context.l10n.settingsLanguage,
                            value: languageNameForLocale(
                              resolveAppLocale(
                                WidgetsBinding.instance.platformDispatcher
                                    .locale,
                                settings[_appLocaleKey] as String?,
                              ),
                            ),
                            showDivider: false,
                            onTap: () => _showLanguagePicker(
                              resolveAppLocale(
                                WidgetsBinding.instance.platformDispatcher
                                    .locale,
                                settings[_appLocaleKey] as String?,
                              ).languageCode,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionLabel(label: context.l10n.settingsReminders),
                    const SizedBox(height: 8),
                    _SettingsCard(
                      child: Column(
                        children: [
                          if (isPro)
                            _NavigationSettingRow(
                              icon: Icons.vaccines_outlined,
                              label: context.l10n.settingsDoseReminder,
                              value: _nextDoseReminderSummary(context, profile),
                              showDivider: true,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => const DoseReminderScreen(),
                                  ),
                                );
                              },
                            )
                          else
                            _LockedProSettingRow(
                              icon: Icons.vaccines_outlined,
                              label: context.l10n.settingsDoseReminder,
                              onTap: () => openProAccessScreen(
                                context,
                                ref,
                                source: 'settings_next_dose',
                              ),
                            ),
                          if (isPro)
                            _NavigationSettingRow(
                              icon: Icons.medication_liquid_outlined,
                              label: context.l10n.settingsSupplementReminder,
                              value: _supplementReminderSummary(context, profile),
                              showDivider: true,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        const SupplementReminderScreen(),
                                  ),
                                );
                              },
                            )
                          else
                            _LockedProSettingRow(
                              icon: Icons.medication_liquid_outlined,
                              label: context.l10n.settingsSupplementReminder,
                              onTap: () => openProAccessScreen(
                                context,
                                ref,
                                source: 'settings_supplement_reminder',
                              ),
                            ),
                          _ToggleSettingRow(
                            icon: Icons.calendar_today_outlined,
                            label: context.l10n.settingsDailyReminders,
                            value: dailyRemindersEnabled,
                            saving: _savingField == _dailyRemindersKey,
                            showDivider: false,
                            onChanged: _updateDailyReminders,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionLabel(label: context.l10n.settingsSubscription),
                    const SizedBox(height: 8),
                    _SubscriptionSettingCard(
                      isPro: isPro,
                      onTap: () => openProAccessScreen(
                        context,
                        ref,
                        source: 'settings_subscription',
                      ),
                    ),
                    const SizedBox(height: 18),
                    _SectionLabel(label: context.l10n.settingsSupport),
                    const SizedBox(height: 8),
                    _SettingsCard(
                      child: Column(
                        children: [
                          _buildFeedbackRow(context, profileState),
                          _NavigationSettingRow(
                            icon: Icons.description_outlined,
                            label: context.l10n.settingsTermsOfService,
                            value: '',
                            showDivider: true,
                            onTap: () =>
                                _openExternalUrl('https://myglu.health/terms'),
                          ),
                          _NavigationSettingRow(
                            icon: Icons.privacy_tip_outlined,
                            label: context.l10n.settingsPrivacyPolicy,
                            value: '',
                            showDivider: false,
                            onTap: () => _openExternalUrl(
                                'https://myglu.health/privacy'),
                          ),
                        ],
                      ),
                    ),
                    if (userEmail.endsWith('@layline.ventures')) ...[
                      const SizedBox(height: 18),
                      _SectionLabel(label: context.l10n.settingsInternal),
                      const SizedBox(height: 8),
                      _SettingsCard(
                        child: Column(
                          children: [
                            _NavigationSettingRow(
                              icon: Icons.workspace_premium_outlined,
                              label: context.l10n.settingsSubscriptionOverride,
                              value: switch (
                                  (settings[debugSubscriptionOverrideKey]
                                          as String?)
                                      ?.trim()
                                      .toLowerCase()) {
                                'free' => context
                                    .l10n.settingsSubscriptionOverrideForceFree,
                                'pro' => context
                                    .l10n.settingsSubscriptionOverrideForcePro,
                                _ => context.l10n.settingsSubscriptionOverrideAuto,
                              },
                              showDivider: true,
                              onTap: () => _showSubscriptionOverridePicker(
                                (settings[debugSubscriptionOverrideKey]
                                        as String?)
                                    ?.trim()
                                    .toLowerCase(),
                              ),
                            ),
                            _NavigationSettingRow(
                              icon: Icons.auto_awesome_outlined,
                              label: context.l10n.settingsTodayInsightCard,
                              value: switch (
                                  (settings[_debugInsightCardModeKey]
                                          as String?)
                                      ?.trim()
                                      .toLowerCase()) {
                                'on' => context.l10n.settingsTodayInsightCardOn,
                                'off' =>
                                    context.l10n.settingsTodayInsightCardOff,
                                _ => context.l10n.settingsTodayInsightCardAuto,
                              },
                              showDivider: true,
                              onTap: () => _showInsightCardModePicker(
                                (settings[_debugInsightCardModeKey]
                                        as String?)
                                    ?.trim()
                                    .toLowerCase(),
                              ),
                            ),
                            _NavigationSettingRow(
                              icon: Icons.bug_report_outlined,
                              label: context.l10n.settingsResetOnboarding,
                              value:
                                  _isResettingOnboarding ? 'Resetting...' : '',
                              showDivider: true,
                              onTap: _isResettingOnboarding
                                  ? () {}
                                  : _resetOnboarding,
                            ),
                            _NavigationSettingRow(
                              icon: Icons.visibility_off_outlined,
                              label: context.l10n.settingsResetShowcases,
                              value:
                                  _isResettingShowcases ? 'Resetting...' : '',
                              showDivider: true,
                              onTap: _isResettingShowcases
                                  ? () {}
                                  : _resetShowcases,
                            ),
                            _NavigationSettingRow(
                              icon: Icons.delete_sweep_outlined,
                              label: context.l10n.settingsResetUserData,
                              value: _isResettingUserData ? 'Resetting...' : '',
                              showDivider: false,
                              onTap:
                                  _isResettingUserData ? () {} : _resetUserData,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0;
                            i < footerAccountActions.length;
                            i++) ...[
                          if (i > 0)
                            Text(
                              ' · ',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.textSecondary,
                              ),
                            ),
                          Builder(
                            builder: (_) {
                              final entry = footerAccountActions[i];
                              return TextButton(
                                onPressed: entry.onTap,
                                style: TextButton.styleFrom(
                                  foregroundColor: entry.isDestructive
                                      ? const Color(0xFFBF3B36)
                                      : colors.textSecondary,
                                  textStyle: theme.textTheme.bodySmall,
                                  visualDensity: VisualDensity.compact,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(entry.label),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        packageInfoState.maybeWhen(
                          data: (info) => 'Glu ${info.version}',
                          orElse: () => 'Glu --',
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        context.l10n.commonDisclaimer,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary.withValues(alpha: 0.6),
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          if (_accountActionInFlight)
            Positioned.fill(
              child: _BlockingProgressOverlay(
                label: context.l10n.settingsDeletingAccount,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeedbackRow(
      BuildContext context, AsyncValue<AppProfile?> profileState) {
    return _NavigationSettingRow(
      icon: Icons.chat_bubble_outline_rounded,
      label: context.l10n.settingsSendFeedback,
      value: '',
      showDivider: true,
      onTap: () async {
        final profile = profileState.asData?.value;
        final name =
            (profile?.settings['preferred_name'] as String?)?.trim();
        final currentUser = Supabase.instance.client.auth.currentUser;
        final email = currentUser?.email;
        final userId = currentUser?.id;
        final successMessage = context.l10n.feedbackSheetSuccess;
        final messenger = ScaffoldMessenger.of(context);
        final sent = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => FeedbackSheet(
            name: name,
            email: email,
            userId: userId,
          ),
        );
        if (sent == true && mounted) {
          messenger.showSnackBar(
            SnackBar(content: Text(successMessage)),
          );
        }
      },
    );
  }

  Future<void> _openExternalUrl(String url) async {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  String _providerDisplayName(String provider) {
    switch (provider) {
      case 'google':
        return 'Google';
      case 'apple':
        return 'Apple';
      default:
        return provider;
    }
  }

  List<_FooterAccountAction> _footerAccountActions(
    BuildContext context,
    List<UserIdentity> identities,
  ) {
    final linked = identities
        .where(
          (identity) =>
              identity.provider == 'google' || identity.provider == 'apple',
        )
        .toList();
    final canDisconnect = linked.length > 1;
    final actions = <_FooterAccountAction>[];

    if (canDisconnect) {
      for (final identity in linked) {
        actions.add(
          _FooterAccountAction(
            label: context.l10n.settingsDisconnectProviderShort(
              _providerDisplayName(identity.provider),
            ),
            onTap:
                _accountActionInFlight ? null : () => _unlinkIdentity(identity),
          ),
        );
      }
    }

    actions.add(
      _FooterAccountAction(
        label: context.l10n.settingsDeleteAccount,
        onTap: _accountActionInFlight ? null : _deleteAccount,
        isDestructive: true,
      ),
    );
    return actions;
  }
}

class _FooterAccountAction {
  const _FooterAccountAction({
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;
}

class _BlockingProgressOverlay extends StatelessWidget {
  const _BlockingProgressOverlay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return ColoredBox(
      color: colors.canvas.withValues(alpha: 0.72),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: colors.lineSubtle),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: colors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationSettingRow extends StatelessWidget {
  const _NavigationSettingRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _SettingLeadingIcon(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 92,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: colors.lineSubtle),
      ],
    );
  }
}

class _ToggleSettingRow extends StatelessWidget {
  const _ToggleSettingRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.saving = false,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool saving;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: saving ? null : () => onChanged(!value),
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _SettingLeadingIcon(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                if (saving)
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.textSecondary,
                    ),
                  )
                else
                  Switch.adaptive(
                    value: value,
                    onChanged: onChanged,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider) Divider(height: 1, color: colors.lineSubtle),
      ],
    );
  }
}

class _LockedProSettingRow extends StatelessWidget {
  const _LockedProSettingRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _SettingLeadingIcon(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.accentButter,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium_outlined,
                        size: 14,
                        color: colors.textPrimary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Pro',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: colors.lineSubtle),
      ],
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: child,
    );
  }
}

class _ExpandableSettingRow extends StatelessWidget {
  const _ExpandableSettingRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.expanded,
    required this.saving,
    required this.onTap,
    required this.child,
    this.showDivider = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool expanded;
  final bool saving;
  final VoidCallback onTap;
  final Widget child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _SettingLeadingIcon(icon: icon),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 92,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                if (saving)
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colors.textSecondary,
                    ),
                  )
                else
                  Icon(
                    expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.chevron_right_rounded,
                    color: colors.textSecondary,
                  ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 180),
          crossFadeState:
              expanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: child,
          ),
          secondChild: const SizedBox.shrink(),
        ),
        if (showDivider) Divider(height: 1, color: colors.lineSubtle),
      ],
    );
  }
}

class _SubscriptionSettingCard extends StatelessWidget {
  const _SubscriptionSettingCard({
    required this.isPro,
    required this.onTap,
  });

  final bool isPro;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.lineSubtle),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              const _SettingLeadingIcon(icon: Icons.workspace_premium_outlined),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPro
                          ? context.l10n.manageSubscriptionActiveCopy
                          : context.l10n.manageSubscriptionFreePlan,
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      isPro
                          ? context.l10n.manageSubscriptionManageButton
                          : context.l10n.manageSubscriptionUpgradeButton,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPro)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4A853).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    context.l10n.manageSubscriptionProBadge,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF9C7720),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: colors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Text(
      label,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: colors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _ProfileSummaryHeader extends StatefulWidget {
  const _ProfileSummaryHeader({
    required this.name,
    required this.email,
    required this.editing,
    required this.saving,
    required this.onEdit,
    required this.onSaveName,
    required this.onSignOut,
  });

  final String name;
  final String email;
  final bool editing;
  final bool saving;
  final VoidCallback onEdit;
  final ValueChanged<String> onSaveName;
  final Future<void> Function() onSignOut;

  @override
  State<_ProfileSummaryHeader> createState() => _ProfileSummaryHeaderState();
}

class _ProfileSummaryHeaderState extends State<_ProfileSummaryHeader> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _editableName(widget.name));
  }

  @override
  void didUpdateWidget(covariant _ProfileSummaryHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.name != widget.name && !widget.editing) {
      _controller.text = _editableName(widget.name);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final displayName = widget.name == 'Not set'
        ? context.l10n.settingsYourProfile
        : widget.name;
    final initials = displayName
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part.characters.first.toUpperCase())
        .join();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.lineSubtle.withValues(alpha: 0.75)),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: colors.accentLilac.withValues(alpha: 0.28),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              initials.isEmpty ? 'G' : initials,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: widget.editing
                      ? Row(
                          key: const ValueKey('editing'),
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: _controller,
                                    enabled: !widget.saving,
                                    autofocus: true,
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (_) => _submitName(),
                                    style:
                                        theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: context.l10n.settingsYourName,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    height: 1,
                                    color: colors.lineSubtle,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: widget.onEdit,
                              child: _HeaderCircleAction(
                                icon: Icons.close_rounded,
                                tint: colors.surface.withValues(alpha: 0.78),
                                iconColor:
                                    colors.textPrimary.withValues(alpha: 0.78),
                                bordered: true,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: widget.saving ? null : _submitName,
                              child: _HeaderCircleAction(
                                icon: Icons.check_rounded,
                                tint: colors.accentSky.withValues(alpha: 0.18),
                                iconColor: colors.textPrimary,
                                loading: widget.saving,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          key: const ValueKey('display'),
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                displayName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: widget.onEdit,
                              child: _HeaderCircleAction(
                                icon: Icons.edit_outlined,
                                tint: colors.surface.withValues(alpha: 0.78),
                                iconColor:
                                    colors.textPrimary.withValues(alpha: 0.78),
                                bordered: true,
                              ),
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.email,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: widget.onSignOut,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.logout_rounded,
                        size: 13,
                        color: Color(0xFFBF3B36),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        context.l10n.settingsSignOut,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: const Color(0xFFBF3B36),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _submitName() {
    widget.onSaveName(_controller.text);
  }

  String _editableName(String value) {
    return value == 'Not set' ? '' : value;
  }
}

class _HeaderCircleAction extends StatelessWidget {
  const _HeaderCircleAction({
    required this.icon,
    required this.tint,
    required this.iconColor,
    this.bordered = false,
    this.loading = false,
  });

  final IconData icon;
  final Color tint;
  final Color iconColor;
  final bool bordered;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: tint,
        shape: BoxShape.circle,
        border: bordered ? Border.all(color: colors.lineSubtle) : null,
      ),
      alignment: Alignment.center,
      child: loading
          ? SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: iconColor,
              ),
            )
          : Icon(icon, size: 14, color: iconColor),
    );
  }
}

class _SettingLeadingIcon extends StatelessWidget {
  const _SettingLeadingIcon({
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: colors.softSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 16, color: colors.textSecondary),
    );
  }
}

class _NameEditor extends StatefulWidget {
  const _NameEditor({
    required this.initialValue,
    required this.enabled,
    required this.onSave,
  });

  final String initialValue;
  final bool enabled;
  final ValueChanged<String> onSave;

  @override
  State<_NameEditor> createState() => _NameEditorState();
}

class _NameEditorState extends State<_NameEditor> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant _NameEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _InlineEditorScaffold(
      enabled: widget.enabled,
      onSave: () => widget.onSave(_controller.text),
      child: TextField(
        controller: _controller,
        enabled: widget.enabled,
        textInputAction: TextInputAction.done,
        decoration:
            InputDecoration(hintText: context.l10n.settingsYourName),
      ),
    );
  }
}

class _AgeEditor extends StatefulWidget {
  const _AgeEditor({
    required this.initialValue,
    required this.enabled,
    required this.onSave,
  });

  final int initialValue;
  final bool enabled;
  final ValueChanged<int> onSave;

  @override
  State<_AgeEditor> createState() => _AgeEditorState();
}

class _AgeEditorState extends State<_AgeEditor> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue.toString());
  }

  @override
  void didUpdateWidget(covariant _AgeEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      _controller.text = widget.initialValue.toString();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            enabled: widget.enabled,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: context.l10n.settingsAge,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
            ),
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: widget.enabled
              ? () {
                  final value = int.tryParse(_controller.text.trim());
                  if (value == null) return;
                  widget.onSave(value.clamp(13, 100));
                }
              : null,
          style: FilledButton.styleFrom(
            minimumSize: const Size(0, 34),
            padding: const EdgeInsets.symmetric(horizontal: 14),
            textStyle: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            backgroundColor: colors.textPrimary,
            foregroundColor: colors.surface,
          ),
          child: Text(context.l10n.commonSave),
        ),
      ],
    );
  }
}

class _HeightEditor extends StatefulWidget {
  const _HeightEditor({
    required this.initialValue,
    required this.enabled,
    required this.onSave,
  });

  final dynamic initialValue;
  final bool enabled;
  final ValueChanged<Map<String, dynamic>> onSave;

  @override
  State<_HeightEditor> createState() => _HeightEditorState();
}

class _HeightEditorState extends State<_HeightEditor> {
  late String _unit;
  late final TextEditingController _primaryController;
  late final TextEditingController _secondaryController;

  @override
  void initState() {
    super.initState();
    final map = _heightMap(widget.initialValue);
    _unit = (map['unit'] as String?) ?? 'metric';
    _primaryController =
        TextEditingController(text: map['primary']?.toString() ?? '170');
    _secondaryController =
        TextEditingController(text: map['secondary']?.toString() ?? '0');
  }

  @override
  void didUpdateWidget(covariant _HeightEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      final map = _heightMap(widget.initialValue);
      _unit = (map['unit'] as String?) ?? 'metric';
      _primaryController.text = map['primary']?.toString() ?? '170';
      _secondaryController.text = map['secondary']?.toString() ?? '0';
    }
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return _InlineEditorScaffold(
      enabled: widget.enabled,
      onSave: () => widget.onSave(_normalizedHeight()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: colors.canvas,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: colors.lineSubtle),
            ),
            child: Row(
              children: [
                _HeightUnitChip(
                  label: context.l10n.settingsHeightCm,
                  selected: _unit == 'metric',
                  flex: 1,
                  onTap: widget.enabled
                      ? () => setState(() => _unit = 'metric')
                      : null,
                ),
                _HeightUnitChip(
                  label: context.l10n.settingsHeightFtIn,
                  selected: _unit == 'imperial',
                  flex: 1,
                  onTap: widget.enabled
                      ? () => setState(() => _unit = 'imperial')
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _primaryController,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.number,
                  style: theme.textTheme.bodyMedium,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: _unit == 'metric'
                        ? context.l10n.settingsHeightCm
                        : context.l10n.settingsHeightFt,
                  ),
                ),
              ),
              if (_unit == 'imperial') ...[
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _secondaryController,
                    enabled: widget.enabled,
                    keyboardType: TextInputType.number,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: context.l10n.settingsHeightIn,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _normalizedHeight() {
    final primary = int.tryParse(_primaryController.text.trim());
    final secondary = int.tryParse(_secondaryController.text.trim());

    if (_unit == 'metric') {
      final cm = (primary ?? 170).clamp(120, 230);
      return {
        'unit': 'metric',
        'primary': '$cm',
        'secondary': null,
      };
    }

    final feet = (primary ?? 5).clamp(4, 7);
    final inches = (secondary ?? 0).clamp(0, 11);
    return {
      'unit': 'imperial',
      'primary': '$feet',
      'secondary': '$inches',
    };
  }
}

class _HeightUnitChip extends StatelessWidget {
  const _HeightUnitChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.flex = 1,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: selected ? colors.textPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected ? colors.surface : colors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _InlineEditorScaffold extends StatelessWidget {
  const _InlineEditorScaffold({
    required this.enabled,
    required this.onSave,
    required this.child,
  });

  final bool enabled;
  final VoidCallback onSave;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton(
            onPressed: enabled ? onSave : null,
            style: FilledButton.styleFrom(
              minimumSize: const Size(0, 34),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              textStyle: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            child: Text(context.l10n.commonSave),
          ),
        ),
      ],
    );
  }
}

class _MeasurementUnitToggle extends StatelessWidget {
  const _MeasurementUnitToggle({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String value;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final options = const ['kg', 'lb'];

    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: IgnorePointer(
        ignoring: !enabled,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colors.canvas,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: colors.lineSubtle),
          ),
          child: Row(
            children: [
              for (final option in options)
                Expanded(
                  child: GestureDetector(
                    onTap: () => onChanged(option),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: option == value
                            ? colors.textPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        option.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: option == value
                              ? colors.surface
                              : colors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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

String _preferredNameSummary(Map<String, dynamic> settings) {
  final name = (settings['preferred_name'] as String?)?.trim();
  return name == null || name.isEmpty ? 'Not set' : name;
}

String _healthGoalSummary(BuildContext context, Map<String, dynamic> settings) {
  final healthGoal = (settings['primary_goal'] as String?)?.trim();
  if (healthGoal == null || healthGoal.isEmpty) {
    return context.l10n.settingsNotSet;
  }
  return _localizedPrimaryGoalValue(context, healthGoal);
}

String _habitGoalsSummary(BuildContext context, AppProfile? profile) {
  final goals = profile?.goals;
  if (goals == null) {
    return context.l10n.settingsDisabled;
  }
  final enabledCount = [
    goals.water.enabled,
    goals.exercise.enabled,
    goals.meals.enabled,
    goals.protein.enabled,
    goals.fiber.enabled,
    goals.weight.enabled,
  ].where((enabled) => enabled).length;
  if (enabledCount == 0) {
    return context.l10n.settingsDisabled;
  }
  return context.l10n.settingsGoalsActiveCount(enabledCount.toString());
}

String _localizedPrimaryGoalValue(BuildContext context, String value) {
  final l10n = context.l10n;
  return switch (value) {
    'Lose weight' => l10n.onboardingGoalLoseWeight,
    'Maintain my weight' => l10n.onboardingGoalMaintainWeight,
    'Manage my diabetes' => l10n.onboardingGoalManageDiabetes,
    'Manage my PCOS' => l10n.onboardingGoalManagePcos,
    'Improve my heart health' => l10n.onboardingGoalImproveHeartHealth,
    _ => value,
  };
}

List<({String value, String label})> _primaryGoalOptions(BuildContext context) {
  final l10n = context.l10n;
  return [
    (value: 'Lose weight', label: l10n.onboardingGoalLoseWeight),
    (
      value: 'Maintain my weight',
      label: l10n.onboardingGoalMaintainWeight,
    ),
    (
      value: 'Manage my diabetes',
      label: l10n.onboardingGoalManageDiabetes,
    ),
    (
      value: 'Manage my PCOS',
      label: l10n.onboardingGoalManagePcos,
    ),
    (
      value: 'Improve my heart health',
      label: l10n.onboardingGoalImproveHeartHealth,
    ),
  ];
}

List<({String value, String label})> _genderOptions(BuildContext context) {
  final l10n = context.l10n;
  return [
    (value: 'Male', label: l10n.settingsGenderMale),
    (value: 'Female', label: l10n.settingsGenderFemale),
    (
      value: 'Prefer not to say',
      label: l10n.settingsGenderPreferNotToSay,
    ),
    (value: 'Other', label: l10n.settingsGenderOther),
  ];
}

int _ageValue(Map<String, dynamic> settings) {
  final age = settings['age'];
  return switch (age) {
    final int value => value,
    final num value => value.toInt(),
    final String value => int.tryParse(value) ?? 30,
    _ => 30,
  };
}

String _ageSummary(BuildContext context, Map<String, dynamic> settings) {
  final age = settings['age'];
  if (age == null) return context.l10n.settingsNotSet;
  return context.l10n.settingsYears(_ageValue(settings).toString());
}

String _genderSummary(BuildContext context, Map<String, dynamic> settings) {
  final gender = (settings['gender'] as String?)?.trim();
  if (gender == null || gender.isEmpty) return context.l10n.settingsNotSet;

  return switch (gender) {
    'Male' => context.l10n.settingsGenderMale,
    'Female' => context.l10n.settingsGenderFemale,
    'Prefer not to say' => context.l10n.settingsGenderPreferNotToSay,
    'Other' => context.l10n.settingsGenderOther,
    _ => gender,
  };
}

Map<String, dynamic> _heightMap(dynamic value) {
  if (value is Map<String, dynamic>) {
    return Map<String, dynamic>.from(value);
  }
  return <String, dynamic>{};
}

String _heightSummary(BuildContext context, Map<String, dynamic> settings) {
  final map = _heightMap(settings['height']);
  final unit = map['unit'] as String?;
  final primary = map['primary']?.toString();
  final secondary = map['secondary']?.toString();

  if (unit == 'metric' && primary != null && primary.isNotEmpty) {
    return '$primary cm';
  }

  if (unit == 'imperial' && primary != null && primary.isNotEmpty) {
    final inches = (secondary == null || secondary.isEmpty) ? '0' : secondary;
    return '$primary ft $inches in';
  }

  return context.l10n.settingsNotSet;
}

String _nextDoseReminderSummary(BuildContext context, AppProfile? profile) {
  final reminder = profile?.reminders.dose;
  if (reminder == null || !reminder.enabled || reminder.items.isEmpty) {
    return context.l10n.settingsOff;
  }
  final raw = reminder.items.first.schedule.scheduledAt;
  final parsed = raw == null ? null : DateTime.tryParse(raw)?.toLocal();
  if (parsed == null) return context.l10n.settingsOn;
  return DateFormat('EEE, MMM d').format(parsed);
}

String _supplementReminderSummary(BuildContext context, AppProfile? profile) {
  final count = profile?.reminders.supplement.items.length ?? 0;
  if (count == 0) return context.l10n.settingsNoneSet;
  return context.l10n.settingsSupplementCount(count.toString());
}
