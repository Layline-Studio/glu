import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/meal_photo_service.dart';

final mealPhotoServiceProvider = Provider<MealPhotoService>((ref) {
  return MealPhotoService();
});
