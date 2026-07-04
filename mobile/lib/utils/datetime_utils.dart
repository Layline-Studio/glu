import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../l10n/l10n.dart';

final RegExp _isoWithTimezonePattern = RegExp(
  r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$',
);

String formatIsoWithTimezone(DateTime value) {
  final local = value.toLocal();
  final base =
      local.toIso8601String().split(RegExp(r'Z|[+-]\d{2}:\d{2}$')).first;
  final offset = local.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final absolute = offset.abs();
  final hours = absolute.inHours.toString().padLeft(2, '0');
  final minutes = (absolute.inMinutes.remainder(60)).toString().padLeft(2, '0');
  return '$base$sign$hours:$minutes';
}

bool isIsoWithTimezone(String value) {
  return DateTime.tryParse(value) != null &&
      _isoWithTimezonePattern.hasMatch(value);
}

DateTime dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

String formatLoggedSectionDate(BuildContext context, DateTime value) {
  final local = value.toLocal();
  final localeTag = Localizations.localeOf(context).toLanguageTag();
  final date = DateFormat.yMMMd(localeTag).format(local);
  return context.l10n.loggedOn(date);
}

String formatFriendlyLogDate(BuildContext context, DateTime value) {
  final local = value.toLocal();
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  if (local.year == today.year &&
      local.month == today.month &&
      local.day == today.day) {
    return context.l10n.commonToday;
  }
  if (local.year == yesterday.year &&
      local.month == yesterday.month &&
      local.day == yesterday.day) {
    return context.l10n.commonYesterday;
  }
  final localeTag = Localizations.localeOf(context).toLanguageTag();
  if (local.isAfter(today.subtract(const Duration(days: 7)))) {
    return DateFormat.E(localeTag).format(local);
  }
  return DateFormat.yMMMd(localeTag).format(local);
}

String formatCompactDate(DateTime value) {
  return DateFormat('yyyyMMdd').format(value.toLocal());
}

DateTime startOfWeek(DateTime value) {
  final day = dateOnly(value);
  return day.subtract(Duration(days: day.weekday - 1));
}
