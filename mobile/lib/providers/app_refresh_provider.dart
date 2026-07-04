import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../screens/home_screen.dart';
import '../screens/progress/progress_screen.dart';
import 'profile_provider.dart';
import 'today_meals_provider.dart';

final appRefreshProvider = Provider<AppRefreshController>((ref) {
  return AppRefreshController(ref);
});

class AppRefreshController {
  const AppRefreshController(this._ref);

  final Ref _ref;

  void recordsChanged() {
    _ref.invalidate(todayMealsProvider);
    _ref.invalidate(homeStatsProvider);
    _ref.invalidate(homeMedicationDoseLogsProvider);
    _ref.invalidate(progressOverviewProvider);
  }

  void goalsChanged() {
    _ref.invalidate(profileBootstrapProvider);
    _ref.invalidate(progressOverviewProvider);
  }
}
