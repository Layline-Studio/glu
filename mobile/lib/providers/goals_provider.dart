import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/goals.dart';
import '../services/goals_service.dart';

final goalsServiceProvider = Provider<GoalsService>((ref) => GoalsService());

final goalsProvider =
    AsyncNotifierProvider<GoalsNotifier, AppGoals>(GoalsNotifier.new);

class GoalsNotifier extends AsyncNotifier<AppGoals> {
  GoalsService get _service => ref.read(goalsServiceProvider);

  @override
  Future<AppGoals> build() => _service.loadGoals();

  Future<void> save(AppGoals goals) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _service.saveGoals(goals));
  }
}
