import 'dart:math';
import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../models/app_profile.dart';
import '../models/injection_site_catalog.dart';
import '../models/reminders.dart';
import '../l10n/app_locale.dart';
import '../l10n/generated/app_localizations.dart';
import '../utils/datetime_utils.dart';

class ReminderService {
  ReminderService();

  static const _androidChannelId = 'glu_reminders';
  static const _androidChannelName = 'Glu reminders';
  static const _androidChannelDescription =
      'Dose and routine reminders from Glu';
  static const _nextDoseReminderId = 'next-dose';
  static const _nextDoseRedirect = '/settings/next-dose-reminder';
  static const _dailyReminderRedirect = '/home';
  static const _supplementRedirect = '/settings/supplement-reminder';
  static const _dailyReminderIds = [
    'morning',
    'midday',
    'afternoon',
  ];
  static final Random _random = Random();
  // Custom interval reminders need explicit one-off schedules, but we keep the
  // horizon intentionally short so unrelated reminder changes do not trigger
  // thousands of scheduling calls.
  static const _supplementIntervalScheduleHorizon = Duration(days: 30);

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  SupabaseClient get _client => Supabase.instance.client;

  Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();
    await _configureLocalTimezone();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('ic_notification'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _notifications.initialize(settings: initializationSettings);

    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.createNotificationChannel(
      const AndroidNotificationChannel(
        _androidChannelId,
        _androidChannelName,
        description: _androidChannelDescription,
        importance: Importance.high,
      ),
    );

    _initialized = true;
  }

  Future<AppReminders> loadReminders() async {
    final profile = await _fetchProfile();
    return profile.reminders;
  }

  Future<AppProfile> saveReminders(
    AppReminders reminders, {
    Map<String, dynamic>? settingsPatch,
  }) async {
    final updated = await _persistReminders(
      reminders,
      settingsPatch: settingsPatch,
    );
    await syncProfileReminders(updated);
    return updated;
  }

  Future<AppProfile> _persistReminders(
    AppReminders reminders, {
    Map<String, dynamic>? settingsPatch,
  }) async {
    await initialize();
    final profile = await _fetchProfile();
    final updatedSettings = Map<String, dynamic>.from(profile.settings);
    if (settingsPatch != null) {
      for (final entry in settingsPatch.entries) {
        if (entry.value == null) {
          updatedSettings.remove(entry.key);
        } else {
          updatedSettings[entry.key] = entry.value;
        }
      }
    }

    final updated = await _updateProfile(
      profile: profile,
      reminders: reminders,
      settings: updatedSettings,
    );
    return updated;
  }

  Future<AppProfile> updateNextDoseReminder({
    required bool enabled,
    String? nextDoseAt,
    String? format,
    String? medication,
    String? dose,
    String? injectionSite,
  }) async {
    await initialize();
    if (enabled) {
      await _requestPermissions();
    }
    final profile = await _fetchProfile();
    final locale = resolveAppLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
      profile.appLocale,
    );
    final l10n = lookupAppLocalizations(locale);
    final nextDoseItem = enabled
        ? ReminderItem(
            id: _nextDoseReminderId,
            enabled: true,
            schedule: ReminderSchedule(
              type: 'once',
              scheduledAt: nextDoseAt,
              timezone: profile.timezone,
            ),
            content: ReminderContent(
              title: l10n.doseReminderNotificationTitle,
              body: _nextDoseBody(
                l10n: l10n,
                medication: medication,
                dose: dose,
                injectionSite: injectionSite,
              ),
              redirectTo: _nextDoseRedirect,
            ),
            metadata: {
              'format': format,
              'medication': medication,
              'dose': dose,
              'injection_site': injectionSite,
            },
          )
        : null;

    final reminders = profile.reminders.copyWith(
      dose: ReminderCollection(
        enabled: enabled,
        items: nextDoseItem == null
            ? const <ReminderItem>[]
            : <ReminderItem>[nextDoseItem],
      ),
    );

    return saveReminders(reminders);
  }

  Future<AppProfile> updateDailyReminders({
    required bool enabled,
  }) async {
    await initialize();
    if (enabled) {
      await _requestPermissions();
    }
    final profile = await _fetchProfile();
    final timezone = profile.timezone;
    final locale = resolveAppLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
      profile.appLocale,
    );
    final l10n = lookupAppLocalizations(locale);

    final reminders = profile.reminders.copyWith(
      daily: ReminderCollection(
        enabled: enabled,
        items: enabled
            ? <ReminderItem>[
                _buildDailyReminderItem(
                  id: 'morning',
                  timeOfDay: '08:00',
                  timezone: timezone,
                  title: l10n.dailyReminderMorningTitle,
                  body: _randomDailyReminderBody(l10n.dailyReminderMorningBodies),
                ),
                _buildDailyReminderItem(
                  id: 'midday',
                  timeOfDay: '13:00',
                  timezone: timezone,
                  title: l10n.dailyReminderMiddayTitle,
                  body: _randomDailyReminderBody(l10n.dailyReminderMiddayBodies),
                ),
                _buildDailyReminderItem(
                  id: 'afternoon',
                  timeOfDay: '18:00',
                  timezone: timezone,
                  title: l10n.dailyReminderAfternoonTitle,
                  body: _randomDailyReminderBody(l10n.dailyReminderAfternoonBodies),
                ),
              ]
            : const <ReminderItem>[],
      ),
    );

    return _persistReminders(
      reminders,
      settingsPatch: {
        'daily_reminders_enabled': enabled,
      },
    );
  }

  Future<void> syncDailyReminders(AppProfile? profile) async {
    await initialize();
    await _cancelDailyReminders();

    if (profile == null) {
      return;
    }

    final collection = profile.reminders.daily;
    if (!collection.enabled) {
      return;
    }

    if (Platform.isAndroid) {
      await _ensureExactAlarmPermission();
    }

    final location = await _resolveLocation(profile.timezone);
    await _scheduleCollection('daily', collection, location);
  }

  Future<void> syncProfileReminders(AppProfile? profile) async {
    await initialize();
    await _notifications.cancelAll();

    if (profile == null) {
      return;
    }

    final normalizedProfile = await _normalizeOutdatedNextDoseReminder(profile);
    final locale = resolveAppLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
      normalizedProfile.appLocale,
    );
    final l10n = lookupAppLocalizations(locale);
    final localizedDoseReminders =
        _localizedDoseReminders(normalizedProfile, l10n);
    final localizedDailyReminders =
        _localizedDailyReminders(normalizedProfile);

    final hasReminders = localizedDoseReminders.enabled ||
        localizedDailyReminders.enabled ||
        normalizedProfile.reminders.supplement.enabled;

    if (hasReminders && Platform.isAndroid) {
      await _ensureExactAlarmPermission();
    }

    final location = await _resolveLocation(normalizedProfile.timezone);

    await _scheduleCollection('dose', localizedDoseReminders, location);
    await _scheduleCollection('daily', localizedDailyReminders, location);
    await _scheduleSupplementReminders(normalizedProfile, location, l10n);
  }

  Future<void> updateSupplementReminders(
    List<Map<String, dynamic>> reminders,
  ) async {
    await initialize();
    if (reminders.isNotEmpty) {
      await _requestPermissions();
    }

    final profile = await _fetchProfile();
    final updatedProfile = await _persistReminders(
      profile.reminders.copyWith(
        supplement:
            ReminderCollection.fromSupplementReminderJsonList(reminders),
      ),
      settingsPatch: {
        // TODO(eug): Remove this legacy key cleanup after May 1, 2026 once
        // older settings['supplement_reminders'] rows are no longer expected.
        'supplement_reminders': null,
      },
    );
    await syncProfileReminders(updatedProfile);
  }

  Future<void> cancelAll() async {
    await initialize();
    await _notifications.cancelAll();
  }

  Future<void> _cancelDailyReminders() async {
    for (final reminderId in _dailyReminderIds) {
      await _notifications.cancel(id: _notificationId('daily', reminderId));
    }
  }

  Future<void> _scheduleSupplementReminders(
    AppProfile profile,
    tz.Location location,
    AppLocalizations l10n,
  ) async {
    final collection = profile.reminders.supplement;
    if (!collection.enabled) return;

    for (final item in collection.items) {
      if (!item.enabled) continue;

      final id = item.id;
      final name = (item.metadata['name'] as String?)?.trim() ??
          l10n.homeSupplementFallback;
      final timeOfDay = item.schedule.timeOfDay;
      final mode = (item.metadata['repeat_mode'] as String?)?.trim() ??
          (item.schedule.intervalDays != null
              ? 'every_x_days'
              : 'days_of_week');
      final startDateRaw = item.schedule.startDate;

      if (id == null || timeOfDay == null) continue;

      final startDate =
          startDateRaw != null ? DateTime.tryParse(startDateRaw) : null;

      if (mode == 'days_of_week') {
        final days = item.schedule.daysOfWeek;
        for (final day in days) {
          final scheduled = _nextWeeklyOccurrenceWithEarliest(
            timeOfDay,
            day,
            location,
            earliestDate: startDate,
          );
          if (scheduled == null) continue;
          await _safeZonedSchedule(
            id: _notificationId('supplement', '$id-$day'),
            title: l10n.supplementReminderNotificationTitle,
            body: _supplementBody(l10n: l10n, name: name, scheduledDate: scheduled),
            scheduledDate: scheduled,
            payload: _supplementRedirect,
            matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          );
        }
      } else if (mode == 'every_x_days') {
        final interval = item.schedule.intervalDays ?? 1;
        if (interval <= 0) continue;

        var next = _firstIntervalOccurrence(
          timeOfDay: timeOfDay,
          intervalDays: interval,
          startDate: startDate,
          location: location,
        );
        if (next == null) continue;

        final horizonEnd =
            tz.TZDateTime.now(location).add(_supplementIntervalScheduleHorizon);
        for (int i = 0; next!.isBefore(horizonEnd); i++) {
          await _safeZonedSchedule(
            id: _notificationId('supplement', '$id-interval-$i'),
            title: l10n.supplementReminderNotificationTitle,
            body: _supplementBody(
              l10n: l10n,
              name: name,
              scheduledDate: next,
            ),
            scheduledDate: next,
            payload: _supplementRedirect,
          );
          next = next.add(Duration(days: interval));
        }
      }
    }
  }

  tz.TZDateTime? _nextWeeklyOccurrenceWithEarliest(
    String? timeOfDay,
    int dayOfWeek,
    tz.Location location, {
    DateTime? earliestDate,
  }) {
    final parsed = _parseTimeOfDay(timeOfDay);
    if (parsed == null ||
        dayOfWeek < DateTime.monday ||
        dayOfWeek > DateTime.sunday) {
      return null;
    }

    final now = tz.TZDateTime.now(location);
    final earliest = earliestDate != null
        ? () {
            final e = tz.TZDateTime(
              location,
              earliestDate.year,
              earliestDate.month,
              earliestDate.day,
              parsed.$1,
              parsed.$2,
            );
            return e.isAfter(now) ? e : now;
          }()
        : now;

    final scheduled = tz.TZDateTime(
      location,
      earliest.year,
      earliest.month,
      earliest.day,
      parsed.$1,
      parsed.$2,
    );
    var deltaDays = (dayOfWeek - scheduled.weekday) % 7;
    if (deltaDays == 0 && scheduled.isBefore(now)) {
      deltaDays = 7;
    }
    return scheduled.add(Duration(days: deltaDays));
  }

  tz.TZDateTime? _firstIntervalOccurrence({
    required String? timeOfDay,
    required int intervalDays,
    required DateTime? startDate,
    required tz.Location location,
  }) {
    final parsed = _parseTimeOfDay(timeOfDay);
    if (parsed == null || intervalDays <= 0) return null;

    final now = tz.TZDateTime.now(location);
    final today = DateTime(now.year, now.month, now.day);
    final cycleOrigin = startDate != null
        ? DateTime(startDate.year, startDate.month, startDate.day)
        : today;

    // Find first day >= max(today, cycleOrigin) aligned to the cycle
    final effectiveStart = today.isBefore(cycleOrigin) ? cycleOrigin : today;
    final diffDays = effectiveStart.difference(cycleOrigin).inDays;
    final remainder = diffDays % intervalDays;
    final daysToAdd = remainder == 0 ? 0 : (intervalDays - remainder);
    final nextDay = effectiveStart.add(Duration(days: daysToAdd));

    var scheduled = tz.TZDateTime(
      location,
      nextDay.year,
      nextDay.month,
      nextDay.day,
      parsed.$1,
      parsed.$2,
    );

    // If that time has already passed today, move one interval ahead
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(Duration(days: intervalDays));
    }
    return scheduled;
  }

  Future<void> _scheduleCollection(
    String collectionKey,
    ReminderCollection collection,
    tz.Location location,
  ) async {
    if (!collection.enabled) return;

    for (final item in collection.items) {
      if (!item.enabled) continue;
      await _scheduleItem(collectionKey, item, location);
    }
  }

  Future<AppProfile> _normalizeOutdatedNextDoseReminder(
      AppProfile profile) async {
    final collection = profile.reminders.dose;
    if (!collection.enabled || collection.items.isEmpty) {
      return profile;
    }

    final nextDoseItem = collection.items.first;
    final scheduledAtRaw = nextDoseItem.schedule.scheduledAt;
    final scheduledAt =
        scheduledAtRaw == null ? null : DateTime.tryParse(scheduledAtRaw);
    if (scheduledAt == null || scheduledAt.isAfter(DateTime.now())) {
      return profile;
    }

    final intervalDays = _nextDoseIntervalDays(profile.settings);
    if (intervalDays == null || intervalDays <= 0) {
      return profile;
    }

    var nextScheduledAt = scheduledAt;
    final now = DateTime.now();
    while (!nextScheduledAt.isAfter(now)) {
      nextScheduledAt = nextScheduledAt.add(Duration(days: intervalDays));
    }

    final updatedItem = ReminderItem(
      id: nextDoseItem.id,
      enabled: nextDoseItem.enabled,
      schedule: ReminderSchedule(
        type: nextDoseItem.schedule.type,
        timeOfDay: nextDoseItem.schedule.timeOfDay,
        daysOfWeek: nextDoseItem.schedule.daysOfWeek,
        scheduledAt: formatIsoWithTimezone(nextScheduledAt.toLocal()),
        intervalDays: nextDoseItem.schedule.intervalDays,
        startDate: nextDoseItem.schedule.startDate,
        endDate: nextDoseItem.schedule.endDate,
        timezone: nextDoseItem.schedule.timezone,
      ),
      content: nextDoseItem.content,
      metadata: nextDoseItem.metadata,
    );

    return _persistReminders(
      profile.reminders.copyWith(
        dose: ReminderCollection(
          enabled: collection.enabled,
          items: <ReminderItem>[updatedItem],
        ),
      ),
    );
  }

  int? _nextDoseIntervalDays(Map<String, dynamic> settings) {
    final frequency = settings['medication_frequency'] as String?;
    final daysBetween =
        settings['medication_frequency_days_between_doses'] as int?;
    return switch (frequency) {
      'daily' => 1,
      'every_7_days' => 7,
      'every_14_days' => 14,
      'weekly' => 7,
      'biweekly' => 14,
      'monthly' => 30,
      'custom' => daysBetween,
      _ => null,
    };
  }

  Future<void> _scheduleItem(
    String collectionKey,
    ReminderItem item,
    tz.Location location,
  ) async {
    final type = item.schedule.type;
    if (type == 'once') {
      await _scheduleOnce(collectionKey, item, location);
      return;
    }
    if (type == 'daily') {
      await _scheduleDaily(collectionKey, item, location);
      return;
    }
    if (type == 'weekly') {
      await _scheduleWeekly(collectionKey, item, location);
    }
  }

  Future<void> _scheduleOnce(
    String collectionKey,
    ReminderItem item,
    tz.Location location,
  ) async {
    final raw = item.schedule.scheduledAt;
    if (raw == null || raw.trim().isEmpty) return;

    final scheduledAt = DateTime.tryParse(raw)?.toLocal();
    if (scheduledAt == null || !scheduledAt.isAfter(DateTime.now())) {
      return;
    }

    await _safeZonedSchedule(
      id: _notificationId(collectionKey, item.id ?? 'default'),
      title: item.content.title,
      body: item.content.body,
      scheduledDate: tz.TZDateTime.from(scheduledAt, location),
      payload: item.content.redirectTo,
    );
  }

  Future<void> _scheduleDaily(
    String collectionKey,
    ReminderItem item,
    tz.Location location,
  ) async {
    final scheduled = _nextTimeOfDayOccurrence(
      item.schedule.timeOfDay,
      location,
    );
    if (scheduled == null) return;

    await _safeZonedSchedule(
      id: _notificationId(collectionKey, item.id ?? 'default'),
      title: item.content.title,
      body: item.content.body,
      scheduledDate: scheduled,
      payload: item.content.redirectTo,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _scheduleWeekly(
    String collectionKey,
    ReminderItem item,
    tz.Location location,
  ) async {
    final days = item.schedule.daysOfWeek;
    if (days.isEmpty) return;

    for (final day in days) {
      final scheduled = _nextWeeklyOccurrence(
        item.schedule.timeOfDay,
        day,
        location,
      );
      if (scheduled == null) continue;

      await _safeZonedSchedule(
        id: _notificationId(collectionKey, '${item.id ?? 'default'}-$day'),
        title: item.content.title,
        body: item.content.body,
        scheduledDate: scheduled,
        payload: item.content.redirectTo,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannelId,
        _androidChannelName,
        channelDescription: _androidChannelDescription,
        icon: 'ic_notification',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<AndroidScheduleMode> _resolveScheduleMode() async {
    if (!Platform.isAndroid) return AndroidScheduleMode.exactAllowWhileIdle;
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final canExact = await android?.canScheduleExactNotifications();
    return canExact == true
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }

  Future<void> _safeZonedSchedule({
    required int id,
    required String? title,
    required String? body,
    required tz.TZDateTime scheduledDate,
    required String? payload,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    final resolvedTitle = title ?? '';
    final resolvedBody = body ?? '';
    final scheduleMode = await _resolveScheduleMode();
    try {
      await _notifications.zonedSchedule(
        id: id,
        title: resolvedTitle,
        body: resolvedBody,
        scheduledDate: scheduledDate,
        notificationDetails: _notificationDetails(),
        payload: payload,
        androidScheduleMode: scheduleMode,
        matchDateTimeComponents: matchDateTimeComponents,
      );
    } on Exception {
      // If exact scheduling fails (permission revoked between check and call),
      // retry with inexact mode before giving up.
      if (scheduleMode == AndroidScheduleMode.exactAllowWhileIdle) {
        try {
          await _notifications.zonedSchedule(
            id: id,
            title: resolvedTitle,
            body: resolvedBody,
            scheduledDate: scheduledDate,
            notificationDetails: _notificationDetails(),
            payload: payload,
            androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
            matchDateTimeComponents: matchDateTimeComponents,
          );
        } on Exception {
          // Silently drop — permissions may be fully revoked.
        }
      }
    }
  }

  Future<void> _requestPermissions() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();

    if (Platform.isAndroid) {
      await _ensureExactAlarmPermission();
      await _requestIgnoreBatteryOptimizations();
    }

    final ios = _notifications.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    await ios?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Requests the system to exclude this app from battery optimization.
  /// Shows a one-time system dialog; silently skips if already whitelisted.
  Future<void> _requestIgnoreBatteryOptimizations() async {
    if (!Platform.isAndroid) return;
    final status = await Permission.ignoreBatteryOptimizations.status;
    if (!status.isGranted) {
      await Permission.ignoreBatteryOptimizations.request();
    }
  }

  /// Requests exact alarm permission via the plugin's own method and returns
  /// whether exact scheduling is available. Falls back gracefully if the
  /// Android version doesn't require the permission.
  Future<bool> _ensureExactAlarmPermission() async {
    if (!Platform.isAndroid) return false;
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android == null) return false;
    final canSchedule = await android.canScheduleExactNotifications();
    if (canSchedule == true) return true;
    // Prompt the user to grant the permission via system Settings.
    await android.requestExactAlarmsPermission();
    return await android.canScheduleExactNotifications() == true;
  }

  Future<AppProfile> _fetchProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final response =
        await _client.from('profiles').select().eq('id', user.id).single();
    return AppProfile.fromJson(Map<String, dynamic>.from(response));
  }

  Future<AppProfile> _updateProfile({
    required AppProfile profile,
    required AppReminders reminders,
    required Map<String, dynamic> settings,
  }) async {
    final updated = await _client
        .from('profiles')
        .update({
          'reminders': reminders.toJson(),
          'settings': settings,
        })
        .eq('id', profile.id)
        .select()
        .single();
    return AppProfile.fromJson(Map<String, dynamic>.from(updated));
  }

  Future<void> _configureLocalTimezone() async {
    try {
      final localTimezone = await FlutterTimezone.getLocalTimezone();
      final location = tz.getLocation(localTimezone.identifier);
      tz.setLocalLocation(location);
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('UTC'));
    }
  }

  Future<tz.Location> _resolveLocation(String? timezone) async {
    final candidate = timezone?.trim();
    if (candidate != null && candidate.isNotEmpty) {
      try {
        return tz.getLocation(candidate);
      } catch (_) {
        // Fall through to local timezone.
      }
    }

    try {
      final localTimezone = await FlutterTimezone.getLocalTimezone();
      return tz.getLocation(localTimezone.identifier);
    } catch (_) {
      return tz.local;
    }
  }

  tz.TZDateTime? _nextTimeOfDayOccurrence(
    String? timeOfDay,
    tz.Location location,
  ) {
    final parsed = _parseTimeOfDay(timeOfDay);
    if (parsed == null) return null;

    final now = tz.TZDateTime.now(location);
    var scheduled = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      parsed.$1,
      parsed.$2,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime? _nextWeeklyOccurrence(
    String? timeOfDay,
    int dayOfWeek,
    tz.Location location,
  ) {
    final parsed = _parseTimeOfDay(timeOfDay);
    if (parsed == null ||
        dayOfWeek < DateTime.monday ||
        dayOfWeek > DateTime.sunday) {
      return null;
    }

    final now = tz.TZDateTime.now(location);
    var scheduled = tz.TZDateTime(
      location,
      now.year,
      now.month,
      now.day,
      parsed.$1,
      parsed.$2,
    );
    var deltaDays = dayOfWeek - scheduled.weekday;
    if (deltaDays < 0 || (deltaDays == 0 && !scheduled.isAfter(now))) {
      deltaDays += 7;
    }
    scheduled = scheduled.add(Duration(days: deltaDays));
    return scheduled;
  }

  (int, int)? _parseTimeOfDay(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final parts = raw.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    return (hour, minute);
  }

  int _notificationId(String collectionKey, String key) {
    final input = '$collectionKey:$key';
    var hash = 5381;
    for (final codeUnit in input.codeUnits) {
      hash = ((hash << 5) + hash) + codeUnit;
    }
    return hash & 0x7fffffff;
  }

  ReminderCollection _localizedDailyReminders(AppProfile profile) {
    final locale = resolveAppLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
      profile.appLocale,
    );
    final l10n = lookupAppLocalizations(locale);

    final items = profile.reminders.daily.items.map((item) {
      return switch (item.id) {
        'morning' => _localizedDailyReminderItem(
            item,
            title: l10n.dailyReminderMorningTitle,
            body: _randomDailyReminderBody(l10n.dailyReminderMorningBodies),
          ),
        'midday' => _localizedDailyReminderItem(
            item,
            title: l10n.dailyReminderMiddayTitle,
            body: _randomDailyReminderBody(l10n.dailyReminderMiddayBodies),
          ),
        'afternoon' => _localizedDailyReminderItem(
            item,
            title: l10n.dailyReminderAfternoonTitle,
            body: _randomDailyReminderBody(l10n.dailyReminderAfternoonBodies),
          ),
        _ => item,
      };
    }).toList(growable: false);

    return ReminderCollection(
      enabled: profile.reminders.daily.enabled,
      items: items,
    );
  }

  ReminderCollection _localizedDoseReminders(
    AppProfile profile,
    AppLocalizations l10n,
  ) {
    final items = profile.reminders.dose.items.map((item) {
      final medication =
          (item.metadata['medication'] as String?)?.trim().isNotEmpty == true
              ? (item.metadata['medication'] as String).trim()
              : null;
      final dose = (item.metadata['dose'] as String?)?.trim().isNotEmpty == true
          ? (item.metadata['dose'] as String).trim()
          : null;
      final injectionSite = (item.metadata['injection_site'] as String?)
          ?.trim();
      return ReminderItem(
        id: item.id,
        enabled: item.enabled,
        schedule: item.schedule,
        content: ReminderContent(
          title: l10n.doseReminderNotificationTitle,
          body: _nextDoseBody(
            l10n: l10n,
            medication: medication,
            dose: dose,
            injectionSite: injectionSite,
          ),
          redirectTo: item.content.redirectTo,
        ),
        metadata: item.metadata,
      );
    }).toList(growable: false);

    return ReminderCollection(
      enabled: profile.reminders.dose.enabled,
      items: items,
    );
  }

  String _randomDailyReminderBody(String optionsBlock) {
    final options = optionsBlock
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList(growable: false);
    if (options.isEmpty) return '';
    return options[_random.nextInt(options.length)];
  }

  ReminderItem _localizedDailyReminderItem(
    ReminderItem item, {
    required String title,
    required String body,
  }) {
    return ReminderItem(
      id: item.id,
      enabled: item.enabled,
      schedule: item.schedule,
      content: ReminderContent(
        title: title,
        body: body,
        redirectTo: item.content.redirectTo,
      ),
      metadata: item.metadata,
    );
  }

  String? _nextDoseBody({
    required AppLocalizations l10n,
    required String? medication,
    required String? dose,
    required String? injectionSite,
  }) {
    final injectionSiteLabel =
        injectionSite == null || injectionSite.trim().isEmpty
            ? null
            : _localizedInjectionSiteLabel(l10n, injectionSite.trim());
    final headlineParts = <String>[
      if (medication != null && medication.trim().isNotEmpty) medication.trim(),
      if (dose != null && dose.trim().isNotEmpty) dose.trim(),
    ];
    if (headlineParts.isEmpty && injectionSiteLabel == null) {
      return l10n.doseReminderFallbackBody;
    }
    if (headlineParts.isEmpty) {
      return injectionSiteLabel;
    }
    final firstLine = headlineParts.join(' · ');
    if (injectionSiteLabel == null) {
      return firstLine;
    }
    return '$firstLine\n$injectionSiteLabel';
  }

  String _supplementBody({
    required AppLocalizations l10n,
    required String name,
    required tz.TZDateTime scheduledDate,
  }) {
    final trimmedName =
        name.trim().isEmpty ? l10n.homeSupplementFallback : name.trim();
    final daypart = switch (scheduledDate.hour) {
      < 12 => l10n.supplementReminderThisMorning,
      < 18 => l10n.supplementReminderThisAfternoon,
      _ => l10n.supplementReminderTonight,
    };
    return l10n.supplementReminderBody(trimmedName, daypart);
  }

  String _localizedInjectionSiteLabel(
    AppLocalizations l10n,
    String value,
  ) {
    return switch (value) {
      InjectionSiteCatalog.abdomenUpperLeft =>
        l10n.injectionSiteAbdomenUpperLeft,
      InjectionSiteCatalog.abdomenUpperRight =>
        l10n.injectionSiteAbdomenUpperRight,
      InjectionSiteCatalog.abdomenLowerRight =>
        l10n.injectionSiteAbdomenLowerRight,
      InjectionSiteCatalog.abdomenLowerLeft =>
        l10n.injectionSiteAbdomenLowerLeft,
      InjectionSiteCatalog.thighUpperLeft =>
        l10n.injectionSiteThighUpperLeft,
      InjectionSiteCatalog.thighUpperRight =>
        l10n.injectionSiteThighUpperRight,
      InjectionSiteCatalog.thighLowerRight =>
        l10n.injectionSiteThighLowerRight,
      InjectionSiteCatalog.thighLowerLeft =>
        l10n.injectionSiteThighLowerLeft,
      InjectionSiteCatalog.armUpperLeft => l10n.injectionSiteUpperArmLeft,
      InjectionSiteCatalog.armUpperRight => l10n.injectionSiteUpperArmRight,
      InjectionSiteCatalog.buttocksUpperLeft =>
        l10n.injectionSiteButtocksUpperLeft,
      InjectionSiteCatalog.buttocksUpperRight =>
        l10n.injectionSiteButtocksUpperRight,
      _ => InjectionSiteCatalog.labelFor(value),
    };
  }

  ReminderItem _buildDailyReminderItem({
    required String id,
    required String timeOfDay,
    required String? timezone,
    required String title,
    required String body,
  }) {
    return ReminderItem(
      id: id,
      enabled: true,
      schedule: ReminderSchedule(
        type: 'daily',
        timeOfDay: timeOfDay,
        timezone: timezone,
      ),
      content: ReminderContent(
        title: title,
        body: body,
        redirectTo: _dailyReminderRedirect,
      ),
      metadata: {
        'slot': id,
      },
    );
  }
}

final reminderServiceSingleton = ReminderService();
