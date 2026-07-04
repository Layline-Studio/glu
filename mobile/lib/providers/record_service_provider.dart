import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'review_prompt_provider.dart';
import '../services/record_service.dart';

final recordServiceProvider = Provider<RecordService>((ref) {
  final reviewPromptService = ref.read(reviewPromptServiceProvider);
  return RecordService(reviewPromptService: reviewPromptService);
});
