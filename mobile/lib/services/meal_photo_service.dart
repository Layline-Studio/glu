import 'dart:convert';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class MealPhotoService {
  MealPhotoService({
    SupabaseClient? client,
    ImagePicker? imagePicker,
  })  : _client = client ?? Supabase.instance.client,
        _imagePicker = imagePicker ?? ImagePicker();

  final SupabaseClient _client;
  final ImagePicker _imagePicker;
  static const _bucket = 'assets';
  static const _uuid = Uuid();
  static const _pendingAnalysisKey = 'pending_snap_macro_analysis';
  static const technicalErrorMessage =
      "We couldn't process your request right now. Please try again.";

  Future<PickedMealPhoto?> pickUploadAndAnalyze(
    ImageSource source, {
    Map<String, dynamic>? checkPortion,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final file = await _imagePicker.pickImage(source: source);
    if (file == null) {
      return null;
    }

    final bytes = await file.readAsBytes();
    final mimeType = _inferMimeType(file.path);
    final extension = _inferExtension(file.path, mimeType);
    final imagePath = '${user.id}/${_uuid.v4()}.$extension';

    await _client.storage.from(_bucket).uploadBinary(
          imagePath,
          bytes,
          fileOptions: FileOptions(
            cacheControl: '3600',
            upsert: false,
            contentType: mimeType,
          ),
        );

    try {
      final request = await _createSnapMacroRequest(
        imagePath: imagePath,
        mimeType: mimeType,
        checkPortion: checkPortion,
      );
      await _persistPendingAnalysis(
        PendingSnapMacroAnalysis(
          requestId: request.requestId,
          imagePath: imagePath,
          mimeType: mimeType,
        ),
      );

      return await _pollSnapMacroResult(
        requestId: request.requestId,
        imagePath: imagePath,
        mimeType: mimeType,
        imageBytes: bytes,
      );
    } catch (error) {
      return PickedMealPhoto.technicalFailure(
        imagePath: imagePath,
        imageBytes: bytes,
        mimeType: mimeType,
        rawError: error,
      );
    }
  }

  Future<PendingSnapMacroAnalysis?> loadPendingAnalysis() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return PendingSnapMacroAnalysis.tryDecode(
        prefs.getString(_pendingAnalysisKey),
      );
    } catch (_) {
      return null;
    }
  }

  Future<PickedMealPhoto?> resumePendingAnalysis() async {
    final pending = await loadPendingAnalysis();
    if (pending == null) {
      return null;
    }

    return _pollSnapMacroResult(
      requestId: pending.requestId,
      imagePath: pending.imagePath,
      mimeType: pending.mimeType,
    );
  }

  Future<void> clearPendingAnalysis() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingAnalysisKey);
    } catch (_) {
      // Best effort only.
    }
  }

  Future<void> clearPendingAnalysisIfMatchesRequest(String requestId) async {
    if (requestId.trim().isEmpty) {
      return;
    }

    final pending = await loadPendingAnalysis();
    if (pending == null || pending.requestId != requestId) {
      return;
    }

    await clearPendingAnalysis();
  }

  Future<void> clearPendingAnalysisIfMatchesImagePath(String imagePath) async {
    if (imagePath.trim().isEmpty) {
      return;
    }

    final pending = await loadPendingAnalysis();
    if (pending == null || pending.imagePath != imagePath) {
      return;
    }

    await clearPendingAnalysis();
  }

  Future<void> deleteImage(String imagePath) async {
    if (imagePath.trim().isEmpty) {
      return;
    }
    await _client.storage.from(_bucket).remove([imagePath]);
  }

  Future<String> createSignedUrl(String imagePath) {
    return _client.storage.from(_bucket).createSignedUrl(imagePath, 3600);
  }

  Future<Uint8List> downloadImageBytes(String imagePath) {
    return _client.storage.from(_bucket).download(imagePath);
  }

  Future<PickedMealPhoto> analyzeText(String text) async {
    final request =
        await _invokeSnapMacro({'text': text, 'mimeType': 'text/plain'});
    return _pollSnapMacroResult(
        requestId: request.requestId, imagePath: '', mimeType: 'text/plain');
  }

  Future<PickedMealPhoto> analyzeAudio(
      String base64Audio, String mimeType) async {
    final request =
        await _invokeSnapMacro({'base64': base64Audio, 'mimeType': mimeType});
    return _pollSnapMacroResult(
        requestId: request.requestId, imagePath: '', mimeType: mimeType);
  }

  Future<_SnapMacroRequest> _createSnapMacroRequest({
    required String imagePath,
    required String mimeType,
    Map<String, dynamic>? checkPortion,
  }) =>
      _invokeSnapMacro({
        'imagePath': imagePath,
        'mimeType': mimeType,
        if (checkPortion != null) 'checkPortion': checkPortion,
      });

  Future<_SnapMacroRequest> _invokeSnapMacro(Map<String, dynamic> body) async {
    final functionResponse =
        await _client.functions.invoke('snap-macro', body: body);
    final data = functionResponse.data;
    if (functionResponse.status >= 400 || data is! Map<String, dynamic>) {
      final error = data is Map<String, dynamic> ? data['error'] : null;
      throw Exception((error as String? ?? 'snap-macro failed.').trim());
    }

    final requestId = (data['id'] as String? ?? '').trim();
    if (requestId.isEmpty) {
      throw Exception('snap-macro did not return a request id.');
    }

    return _SnapMacroRequest(requestId: requestId);
  }

  Future<PickedMealPhoto> _pollSnapMacroResult({
    required String requestId,
    required String imagePath,
    required String mimeType,
    Uint8List? imageBytes,
  }) async {
    while (true) {
      late final FunctionResponse functionResponse;
      try {
        functionResponse = await _client.functions.invoke(
          'snap-macro',
          method: HttpMethod.get,
          queryParameters: {'id': requestId},
        );
      } on FunctionException catch (error) {
        if (error.status == 404) {
          await clearPendingAnalysisIfMatchesRequest(requestId);
        }
        rethrow;
      }

      final data = functionResponse.data;
      if (functionResponse.status >= 400 || data is! Map<String, dynamic>) {
        final error = data is Map<String, dynamic> ? data['error'] : null;
        if (functionResponse.status == 404) {
          await clearPendingAnalysisIfMatchesRequest(requestId);
        }
        throw Exception((error as String? ?? 'snap-macro failed.').trim());
      }

      final payload = Map<String, dynamic>.from(data);
      final status = (payload['status'] as String? ?? '').trim();
      final responsePayload = payload['response'];

      if (status == 'pending') {
        await Future<void>.delayed(const Duration(seconds: 2));
        continue;
      }

      await clearPendingAnalysisIfMatchesRequest(requestId);

      final response = responsePayload is Map<String, dynamic>
          ? Map<String, dynamic>.from(responsePayload)
          : const <String, dynamic>{};
      final meal = response['response'];

      return PickedMealPhoto(
        imagePath: imagePath,
        imageBytes: imageBytes,
        mimeType: mimeType,
        analysisSucceeded: response['success'] == true,
        reason: (response['reason'] as String? ?? '').trim(),
        meal: meal is Map<String, dynamic>
            ? Map<String, dynamic>.from(meal)
            : null,
        portionPercent:
            (response['portionPercent'] as num?)?.toDouble() ?? 1.0,
        isTechnicalError: false,
        rawError: null,
      );
    }
  }

  Future<void> _persistPendingAnalysis(PendingSnapMacroAnalysis pending) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_pendingAnalysisKey, pending.encode());
    } catch (_) {
      // Best effort only.
    }
  }

  Future<bool> hasPendingAnalysisForImagePath(String imagePath) async {
    if (imagePath.trim().isEmpty) {
      return false;
    }

    final pending = await loadPendingAnalysis();
    return pending?.imagePath == imagePath;
  }

  String _inferMimeType(String path) {
    final lowerPath = path.toLowerCase();
    if (lowerPath.endsWith('.png')) {
      return 'image/png';
    }
    if (lowerPath.endsWith('.webp')) {
      return 'image/webp';
    }
    if (lowerPath.endsWith('.heic')) {
      return 'image/heic';
    }
    if (lowerPath.endsWith('.heif')) {
      return 'image/heif';
    }
    return 'image/jpeg';
  }

  String _inferExtension(String path, String mimeType) {
    final lowerPath = path.toLowerCase();
    final dotIndex = lowerPath.lastIndexOf('.');
    if (dotIndex >= 0 && dotIndex < lowerPath.length - 1) {
      return lowerPath.substring(dotIndex + 1);
    }

    return switch (mimeType) {
      'image/png' => 'png',
      'image/webp' => 'webp',
      'image/heic' => 'heic',
      'image/heif' => 'heif',
      _ => 'jpg',
    };
  }
}

class PickedMealPhoto {
  const PickedMealPhoto({
    required this.imagePath,
    required this.imageBytes,
    required this.mimeType,
    required this.analysisSucceeded,
    required this.reason,
    required this.meal,
    required this.portionPercent,
    required this.isTechnicalError,
    required this.rawError,
  });

  factory PickedMealPhoto.technicalFailure({
    required String imagePath,
    required Uint8List? imageBytes,
    required String mimeType,
    required Object rawError,
  }) {
    return PickedMealPhoto(
      imagePath: imagePath,
      imageBytes: imageBytes,
      mimeType: mimeType,
      analysisSucceeded: false,
      reason: MealPhotoService.technicalErrorMessage,
      meal: null,
      portionPercent: 1.0,
      isTechnicalError: true,
      rawError: rawError.toString(),
    );
  }

  final String imagePath;
  final Uint8List? imageBytes;
  final String mimeType;
  final bool analysisSucceeded;
  final String reason;
  final Map<String, dynamic>? meal;
  final double portionPercent;
  final bool isTechnicalError;
  final String? rawError;
}

class PendingSnapMacroAnalysis {
  const PendingSnapMacroAnalysis({
    required this.requestId,
    required this.imagePath,
    required this.mimeType,
  });

  final String requestId;
  final String imagePath;
  final String mimeType;

  String encode() => jsonEncode({
        'request_id': requestId,
        'image_path': imagePath,
        'mime_type': mimeType,
      });

  static PendingSnapMacroAnalysis? tryDecode(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return null;
      }

      final requestId = (decoded['request_id'] as String? ?? '').trim();
      final imagePath = (decoded['image_path'] as String? ?? '').trim();
      final mimeType = (decoded['mime_type'] as String? ?? '').trim();
      if (requestId.isEmpty || imagePath.isEmpty || mimeType.isEmpty) {
        return null;
      }

      return PendingSnapMacroAnalysis(
        requestId: requestId,
        imagePath: imagePath,
        mimeType: mimeType,
      );
    } catch (_) {
      return null;
    }
  }
}

class _SnapMacroRequest {
  const _SnapMacroRequest({required this.requestId});

  final String requestId;
}
