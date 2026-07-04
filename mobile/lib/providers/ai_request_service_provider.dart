import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/ai_request_service.dart';

final aiRequestServiceProvider = Provider<AiRequestService>((ref) {
  return AiRequestService();
});
