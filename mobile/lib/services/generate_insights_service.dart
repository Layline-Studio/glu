import 'dart:async';

import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/datetime_utils.dart';

class GenerateInsightsService {
  GenerateInsightsService({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<TodayInsightResult> loadTodayInsight({
    required DateTime currentTimestamp,
    void Function(String status)? onStatusChanged,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final request = await _findExistingRequest(user.id, currentTimestamp);
    if (request == null) {
      onStatusChanged?.call('Requesting today\'s insight...');
      final requestId = await _createRequest(currentTimestamp);
      return _pollRequest(
        requestId: requestId,
        onStatusChanged: onStatusChanged,
      );
    }

    if (request.status == 'completed' && request.summary != null) {
      return TodayInsightResult(
        requestId: request.id,
        summary: request.summary!,
        status: request.status,
        feedbackValue: request.feedbackValue,
        feedbackReason: request.feedbackReason,
      );
    }

      onStatusChanged?.call('Loading today\'s insight...');
    return _pollRequest(
      requestId: request.id,
      onStatusChanged: onStatusChanged,
    );
  }

  Future<List<InsightHistoryEntry>> loadInsightHistory({
    int limit = 20,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final query = _client
        .from('ai_requests')
        .select('id, status, response, request, feedback, created_at')
        .eq('user_id', user.id)
        .eq('feature_name', 'generate-insights')
        .eq('status', 'completed')
        .order('created_at', ascending: false)
        .limit(limit);

    final data = await query;
    final entries = (data as List)
        .whereType<Map>()
        .map((row) => InsightHistoryEntry.fromJson(
              Map<String, dynamic>.from(row),
            ))
        .whereType<InsightHistoryEntry>()
        .toList(growable: false);

    return entries.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<_GenerateInsightsRequest?> _findExistingRequest(
    String userId,
    DateTime currentTimestamp,
  ) async {
    final start = DateTime(
      currentTimestamp.year,
      currentTimestamp.month,
      currentTimestamp.day,
    );
    final end = start.add(const Duration(days: 1));

    final query = _client
        .from('ai_requests')
        .select('id, status, response, request, created_at')
        .eq('user_id', userId)
        .eq('feature_name', 'generate-insights')
        .gte('created_at', start.toUtc().toIso8601String())
        .lt('created_at', end.toUtc().toIso8601String())
        .order('created_at', ascending: false)
        .limit(1);

    final data = await query.maybeSingle();
    if (data == null) {
      return null;
    }

    return _GenerateInsightsRequest.fromJson(
      Map<String, dynamic>.from(data as Map),
    );
  }

  Future<String> _createRequest(DateTime currentTimestamp) async {
    final response = await _client.functions.invoke(
      'generate-insights',
      body: <String, dynamic>{
        'currentTimestamp': formatIsoWithTimezone(currentTimestamp),
      },
    );

    final data = response.data;
    if (response.status >= 400 || data is! Map<String, dynamic>) {
      final error = data is Map<String, dynamic> ? data['error'] : null;
      throw Exception((error as String? ?? 'generate-insights failed.').trim());
    }

    final requestId = (data['id'] as String? ?? '').trim();
    if (requestId.isEmpty) {
      throw Exception('generate-insights did not return a request id.');
    }

    return requestId;
  }

  Future<TodayInsightResult> _pollRequest({
    required String requestId,
    void Function(String status)? onStatusChanged,
  }) async {
    while (true) {
      late final FunctionResponse response;
      try {
        response = await _client.functions.invoke(
          'generate-insights',
          method: HttpMethod.get,
          queryParameters: <String, String>{'id': requestId},
        );
      } on FunctionException catch (error) {
        if (error.status == 404) {
          throw Exception('generate-insights request not found.');
        }
        rethrow;
      }

      final data = response.data;
      if (response.status >= 400 || data is! Map<String, dynamic>) {
        final error = data is Map<String, dynamic> ? data['error'] : null;
        throw Exception((error as String? ?? 'generate-insights failed.').trim());
      }

      final payload = Map<String, dynamic>.from(data);
      final status = (payload['status'] as String? ?? '').trim();
      if (status == 'pending') {
        onStatusChanged?.call('Loading today\'s insight...');
        await Future<void>.delayed(const Duration(seconds: 2));
        continue;
      }

      String? summary;
      final responsePayload = payload['response'];
      if (responsePayload is Map<String, dynamic>) {
        final reason = responsePayload['reason'];
        if (status == 'failed') {
          throw Exception((reason as String? ?? 'generate-insights failed.').trim());
        }
        final nestedResponse = responsePayload['response'];
        if (nestedResponse is Map<String, dynamic>) {
          final nestedSummary = nestedResponse['summary'];
          summary = nestedSummary is String ? nestedSummary.trim() : null;
        }
      }
      final cleanSummary = summary?.trim() ?? '';
      if (cleanSummary.isEmpty) {
        throw Exception('generate-insights returned an empty summary.');
      }

      return TodayInsightResult(
        requestId: requestId,
        summary: cleanSummary,
        status: status.isEmpty ? 'completed' : status,
        feedbackValue: null,
        feedbackReason: null,
      );
    }
  }
}

class TodayInsightResult {
  const TodayInsightResult({
    required this.requestId,
    required this.summary,
    required this.status,
    this.feedbackValue,
    this.feedbackReason,
  });

  final String requestId;
  final String summary;
  final String status;
  final String? feedbackValue;
  final String? feedbackReason;
}

class InsightHistoryEntry {
  const InsightHistoryEntry({
    required this.id,
    required this.createdAt,
    required this.summary,
    required this.period,
  });

  final String id;
  final DateTime createdAt;
  final String summary;
  final String period;

  String get dateLabel => DateFormat('MMM d, yyyy').format(createdAt.toLocal());

  factory InsightHistoryEntry.fromJson(Map<String, dynamic> json) {
    final createdAtRaw = json['created_at'];
    final responseRaw = json['response'];
    final requestRaw = json['request'];

    String? summary;
    if (responseRaw is Map<String, dynamic>) {
      final nestedResponse = responseRaw['response'];
      if (nestedResponse is Map<String, dynamic>) {
        final nestedSummary = nestedResponse['summary'];
        summary = nestedSummary is String ? nestedSummary.trim() : null;
      }
    }

    if (summary == null || summary.isEmpty) {
      throw Exception('Missing insight summary.');
    }

    final requestMap = requestRaw is Map<String, dynamic>
        ? requestRaw
        : requestRaw is Map
            ? Map<String, dynamic>.from(requestRaw)
            : const <String, dynamic>{};
    final currentTimestamp = (requestMap['currentTimestamp'] as String? ?? '')
        .trim();
    final period = _inferInsightPeriod(currentTimestamp);

    return InsightHistoryEntry(
      id: json['id'] as String,
      createdAt: DateTime.parse(createdAtRaw as String),
      summary: summary,
      period: period,
    );
  }
}

String _inferInsightPeriod(String currentTimestamp) {
  if (currentTimestamp.trim().isEmpty) {
    return 'DAY';
  }

  final parsed = DateTime.tryParse(currentTimestamp);
  if (parsed == null) {
    return 'DAY';
  }

  final local = parsed.toLocal();
  if (local.day == 1) {
    return 'MONTH';
  }
  if (local.weekday == DateTime.monday) {
    return 'WEEK';
  }
  return 'DAY';
}

class _GenerateInsightsRequest {
  const _GenerateInsightsRequest({
    required this.id,
    required this.status,
    required this.response,
    required this.feedbackValue,
    required this.feedbackReason,
  });

  final String id;
  final String status;
  final Map<String, dynamic>? response;
  final String? feedbackValue;
  final String? feedbackReason;

  String? get summary {
    final responsePayload = response?['response'];
    if (responsePayload is Map<String, dynamic>) {
      final summary = responsePayload['summary'];
      return summary is String ? summary.trim() : null;
    }
    return null;
  }

  factory _GenerateInsightsRequest.fromJson(Map<String, dynamic> json) {
    final response = json['response'];
    final feedback = json['feedback'];
    return _GenerateInsightsRequest(
      id: json['id'] as String,
      status: (json['status'] as String? ?? '').trim(),
      response: response is Map<String, dynamic>
          ? response
          : response is Map
              ? Map<String, dynamic>.from(response)
              : null,
      feedbackValue: feedback is Map<String, dynamic>
          ? (feedback['value'] as String? ?? '').trim().isEmpty
              ? null
              : (feedback['value'] as String).trim()
          : feedback is Map
              ? (() {
                  final map = Map<String, dynamic>.from(feedback);
                  final value = (map['value'] as String? ?? '').trim();
                  return value.isEmpty ? null : value;
                })()
              : null,
      feedbackReason: feedback is Map<String, dynamic>
          ? ((feedback['reason'] as String?) ?? '').trim().isEmpty
              ? null
              : (feedback['reason'] as String).trim()
          : feedback is Map
              ? (() {
                  final map = Map<String, dynamic>.from(feedback);
                  final reason = (map['reason'] as String? ?? '').trim();
                  return reason.isEmpty ? null : reason;
                })()
              : null,
    );
  }
}
