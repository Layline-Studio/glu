import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/goals.dart';

class GoalsService {
  SupabaseClient get _client => Supabase.instance.client;

  Future<AppGoals> loadGoals() async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('No authenticated user found.');

    final response = await _client
        .from('profiles')
        .select('goals')
        .eq('id', user.id)
        .single();

    final raw = response['goals'];
    if (raw == null) return AppGoals.empty;
    return AppGoals.fromJson(Map<String, dynamic>.from(raw as Map));
  }

  Future<AppGoals> saveGoals(AppGoals goals) async {
    final user = _client.auth.currentUser;
    if (user == null) throw Exception('No authenticated user found.');

    await _client
        .from('profiles')
        .update({'goals': goals.toJson()})
        .eq('id', user.id);

    return goals;
  }
}
