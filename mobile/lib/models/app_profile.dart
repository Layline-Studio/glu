import '../l10n/app_locale.dart';
import 'goals.dart';
import 'reminders.dart';

class AppProfile {
  const AppProfile({
    required this.id,
    required this.subscriptionTier,
    required this.platform,
    required this.createdAt,
    required this.updatedAt,
    required this.timezone,
    required this.settings,
    required this.reminders,
    required this.goals,
  });

  final String id;
  final String? subscriptionTier;
  final String? platform;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? timezone;
  final Map<String, dynamic> settings;
  final AppReminders reminders;
  final AppGoals goals;

  factory AppProfile.fromJson(Map<String, dynamic> json) {
    final rawSettings = json['settings'];
    final rawReminders = json['reminders'];
    final rawGoals = json['goals'];
    final settings = rawSettings is Map<String, dynamic>
        ? rawSettings
        : Map<String, dynamic>.from(rawSettings as Map? ?? const {});
    final parsedReminders = rawReminders is Map<String, dynamic>
        ? AppReminders.fromJson(rawReminders)
        : AppReminders.fromJson(
            Map<String, dynamic>.from(rawReminders as Map? ?? const {}),
          );
    final supplementFallback = settings['supplement_reminders'];
    // TODO(eug): Drop this fallback after May 1, 2026 once legacy
    // settings['supplement_reminders'] data has been fully migrated.
    final reminders = parsedReminders.supplement.items.isEmpty &&
            supplementFallback is List
        ? parsedReminders.copyWith(
            supplement: ReminderCollection.fromSupplementReminderJsonList(
              supplementFallback,
            ),
          )
        : parsedReminders;
    return AppProfile(
      id: json['id'] as String,
      subscriptionTier: json['subscription_tier'] as String?,
      platform: json['platform'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      timezone: json['timezone'] as String?,
      settings: settings,
      reminders: reminders,
      goals: rawGoals is Map<String, dynamic>
          ? AppGoals.fromJson(rawGoals)
          : AppGoals.fromJson(
              Map<String, dynamic>.from(rawGoals as Map? ?? const {}),
            ),
    );
  }

  String? get onboardingCompletedAt =>
      settings['onboarding_completed_at'] as String?;

  bool get hasCompletedOnboarding =>
      onboardingCompletedAt != null && onboardingCompletedAt!.isNotEmpty;

  String? get appLocale => normalizeLocaleCode(
        settings['app_locale'] as String?,
      );
}
