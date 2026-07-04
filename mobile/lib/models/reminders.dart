class ReminderSchedule {
  const ReminderSchedule({
    this.type,
    this.timeOfDay,
    this.daysOfWeek = const <int>[],
    this.scheduledAt,
    this.intervalDays,
    this.startDate,
    this.endDate,
    this.timezone,
  });

  final String? type;
  final String? timeOfDay;
  final List<int> daysOfWeek;
  final String? scheduledAt;
  final int? intervalDays;
  final String? startDate;
  final String? endDate;
  final String? timezone;

  factory ReminderSchedule.fromJson(Map<String, dynamic> json) {
    final rawDays = json['days_of_week'];
    return ReminderSchedule(
      type: json['type'] as String?,
      timeOfDay: json['time_of_day'] as String?,
      daysOfWeek: rawDays is List
          ? rawDays
              .map((value) => value is num ? value.toInt() : null)
              .whereType<int>()
              .toList(growable: false)
          : const <int>[],
      scheduledAt: json['scheduled_at'] as String?,
      intervalDays: (json['interval_days'] as num?)?.toInt(),
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      timezone: json['timezone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'time_of_day': timeOfDay,
      'days_of_week': daysOfWeek,
      'scheduled_at': scheduledAt,
      'interval_days': intervalDays,
      'start_date': startDate,
      'end_date': endDate,
      'timezone': timezone,
    };
  }
}

class ReminderContent {
  const ReminderContent({
    this.title,
    this.body,
    this.redirectTo,
  });

  final String? title;
  final String? body;
  final String? redirectTo;

  factory ReminderContent.fromJson(Map<String, dynamic> json) {
    return ReminderContent(
      title: json['title'] as String?,
      body: json['body'] as String?,
      redirectTo: json['redirect_to'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'redirect_to': redirectTo,
    };
  }
}

class ReminderItem {
  const ReminderItem({
    this.id,
    this.enabled = false,
    this.schedule = const ReminderSchedule(),
    this.content = const ReminderContent(),
    this.metadata = const <String, dynamic>{},
  });

  final String? id;
  final bool enabled;
  final ReminderSchedule schedule;
  final ReminderContent content;
  final Map<String, dynamic> metadata;

  factory ReminderItem.fromJson(Map<String, dynamic> json) {
    final rawSchedule = json['schedule'];
    final rawContent = json['content'];
    final rawMetadata = json['metadata'];

    return ReminderItem(
      id: json['id'] as String?,
      enabled: (json['enabled'] as bool?) ?? false,
      schedule: rawSchedule is Map<String, dynamic>
          ? ReminderSchedule.fromJson(rawSchedule)
          : ReminderSchedule.fromJson(
              Map<String, dynamic>.from(rawSchedule as Map? ?? const {}),
            ),
      content: rawContent is Map<String, dynamic>
          ? ReminderContent.fromJson(rawContent)
          : ReminderContent.fromJson(
              Map<String, dynamic>.from(rawContent as Map? ?? const {}),
            ),
      metadata: rawMetadata is Map<String, dynamic>
          ? rawMetadata
          : Map<String, dynamic>.from(rawMetadata as Map? ?? const {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'enabled': enabled,
      'schedule': schedule.toJson(),
      'content': content.toJson(),
      'metadata': metadata,
    };
  }

  factory ReminderItem.fromSupplementReminderJson(Map<String, dynamic> json) {
    final name = (json['name'] as String?)?.trim() ?? 'Supplement';
    final repeatMode = (json['repeat_mode'] as String?)?.trim();
    final daysOfWeek = (json['days_of_week'] as List?)
            ?.map((value) => value is num ? value.toInt() : null)
            .whereType<int>()
            .toList(growable: false) ??
        const <int>[];

    return ReminderItem(
      id: json['id'] as String?,
      enabled: true,
      schedule: ReminderSchedule(
        type: repeatMode == 'days_of_week' ? 'weekly' : 'interval',
        timeOfDay: json['time_of_day'] as String?,
        daysOfWeek: daysOfWeek,
        intervalDays: (json['interval_days'] as num?)?.toInt(),
        startDate: json['start_date'] as String?,
      ),
      metadata: {
        'name': name,
        'repeat_mode': repeatMode,
      },
    );
  }

  Map<String, dynamic> toSupplementReminderJson() {
    return {
      'id': id,
      'name': (metadata['name'] as String?)?.trim().isNotEmpty == true
          ? (metadata['name'] as String).trim()
          : 'Supplement',
      'time_of_day': schedule.timeOfDay,
      'repeat_mode': (metadata['repeat_mode'] as String?)?.trim() ??
          (schedule.intervalDays != null ? 'every_x_days' : 'days_of_week'),
      'interval_days': schedule.intervalDays,
      'days_of_week': schedule.daysOfWeek,
      'start_date': schedule.startDate,
    };
  }
}

class ReminderCollection {
  const ReminderCollection({
    this.enabled = false,
    this.items = const <ReminderItem>[],
  });

  final bool enabled;
  final List<ReminderItem> items;

  factory ReminderCollection.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'];
    return ReminderCollection(
      enabled: (json['enabled'] as bool?) ?? false,
      items: rawItems is List
          ? rawItems
              .whereType<Map>()
              .map(
                (item) => ReminderItem.fromJson(
                  Map<String, dynamic>.from(item),
                ),
              )
              .toList(growable: false)
          : const <ReminderItem>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'items': items.map((item) => item.toJson()).toList(growable: false),
    };
  }

  factory ReminderCollection.fromSupplementReminderJsonList(List<dynamic> raw) {
    return ReminderCollection(
      enabled: raw.isNotEmpty,
      items: raw
          .whereType<Map>()
          .map(
            (item) => ReminderItem.fromSupplementReminderJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(growable: false),
    );
  }

  List<Map<String, dynamic>> toSupplementReminderJsonList() {
    return items
        .map((item) => item.toSupplementReminderJson())
        .toList(growable: false);
  }
}

class AppReminders {
  const AppReminders({
    this.dose = const ReminderCollection(),
    this.daily = const ReminderCollection(),
    this.supplement = const ReminderCollection(),
  });

  static const empty = AppReminders();

  final ReminderCollection dose;
  final ReminderCollection daily;
  final ReminderCollection supplement;

  factory AppReminders.fromJson(Map<String, dynamic> json) {
    return AppReminders(
      dose: _readCollection(json['dose']),
      daily: _readCollection(json['daily']),
      supplement: _readCollection(json['supplement']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dose': dose.toJson(),
      'daily': daily.toJson(),
      'supplement': supplement.toJson(),
    };
  }

  AppReminders copyWith({
    ReminderCollection? dose,
    ReminderCollection? daily,
    ReminderCollection? supplement,
  }) {
    return AppReminders(
      dose: dose ?? this.dose,
      daily: daily ?? this.daily,
      supplement: supplement ?? this.supplement,
    );
  }

  static ReminderCollection _readCollection(Object? raw) {
    if (raw is Map<String, dynamic>) {
      return ReminderCollection.fromJson(raw);
    }
    if (raw is Map) {
      return ReminderCollection.fromJson(Map<String, dynamic>.from(raw));
    }
    return const ReminderCollection();
  }
}
