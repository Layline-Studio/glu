import 'package:supabase_flutter/supabase_flutter.dart';

class AiRequestService {
  AiRequestService({
    SupabaseClient? client,
  }) : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  Future<void> saveFeedback(
    String requestId,
    String value, {
    String? reason,
  }) async {
    final cleanedRequestId = requestId.trim();
    final cleanedValue = value.trim().toLowerCase();
    final cleanedReason = reason?.trim();

    if (cleanedRequestId.isEmpty) {
      throw Exception('Missing request id.');
    }
    if (cleanedValue != 'positive' && cleanedValue != 'negative') {
      throw Exception('Invalid feedback value.');
    }

    final feedback = <String, dynamic>{
      'value': cleanedValue,
      if (cleanedReason != null && cleanedReason.isNotEmpty) 'reason': cleanedReason,
    };

    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    try {
      await _client
          .from('ai_requests')
          .update({'feedback': feedback})
          .eq('id', cleanedRequestId)
          .eq('user_id', user.id);
    } on PostgrestException catch (error) {
      throw Exception(error.message);
    }
  }
}
