import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewPromptService {
  ReviewPromptService({InAppReview? inAppReview})
      : _inAppReview = inAppReview ?? InAppReview.instance;

  static const _logReviewCountKey = 'log_review_count';
  static const _logReviewPromptedAtKey = 'log_review_prompted_at';
  static const _logReviewThreshold = 5;

  final InAppReview _inAppReview;

  Future<void> registerSuccessfulLog() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString(_logReviewPromptedAtKey) != null) {
        return;
      }

      final nextCount = (prefs.getInt(_logReviewCountKey) ?? 0) + 1;
      await prefs.setInt(_logReviewCountKey, nextCount);
      if (nextCount < _logReviewThreshold) {
        return;
      }

      final available = await _inAppReview.isAvailable();
      if (!available) {
        return;
      }

      await _inAppReview.requestReview();
      await prefs.setString(
        _logReviewPromptedAtKey,
        DateTime.now().toUtc().toIso8601String(),
      );
    } catch (_) {
      // Best effort only. Log saves should not fail because the review prompt did.
    }
  }
}
