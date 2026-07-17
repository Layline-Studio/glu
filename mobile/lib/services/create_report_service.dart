import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

enum CreateReportFailureStage {
  request,
  polling,
  download,
}

class CreateReportException implements Exception {
  const CreateReportException(this.stage, this.message);

  final CreateReportFailureStage stage;
  final String message;

  @override
  String toString() => message;
}

class CreateReportService {
  CreateReportService({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;
  static const int _pollingRetryLimit = 3;
  static const int _downloadRetryLimit = 3;
  static const Duration _pollDelay = Duration(seconds: 2);
  static const Duration _retryDelay = Duration(seconds: 1);

  Future<Uint8List> createTodayReport({
    void Function(String status)? onStatusChanged,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    onStatusChanged?.call('Preparing your report…');
    final requestId = await _requestReport();

    return _pollReport(requestId: requestId, onStatusChanged: onStatusChanged);
  }

  Future<String> _requestReport() async {
    late final FunctionResponse response;
    try {
      response = await _client.functions.invoke('create-report');
    } on Exception catch (error) {
      throw CreateReportException(
        CreateReportFailureStage.request,
        'Could not start the report request: $error',
      );
    }

    final data = response.data;
    if (response.status >= 400 || data is! Map<String, dynamic>) {
      final error = data is Map<String, dynamic> ? data['error'] : null;
      throw CreateReportException(
        CreateReportFailureStage.request,
        (error as String? ?? 'create-report failed.').trim(),
      );
    }

    final requestId = (data['id'] as String? ?? '').trim();
    if (requestId.isEmpty) {
      throw const CreateReportException(
        CreateReportFailureStage.request,
        'create-report did not return a request id.',
      );
    }

    return requestId;
  }

  Future<Uint8List> _pollReport({
    required String requestId,
    void Function(String status)? onStatusChanged,
  }) async {
    var transientFailures = 0;

    while (true) {
      late final FunctionResponse response;
      try {
        response = await _client.functions.invoke(
          'create-report',
          method: HttpMethod.get,
          queryParameters: <String, String>{'id': requestId},
        );
      } on FunctionException catch (error) {
        if (error.status == 404) {
          throw const CreateReportException(
            CreateReportFailureStage.polling,
            'Report request not found.',
          );
        }

        transientFailures++;
        if (transientFailures >= _pollingRetryLimit) {
          throw CreateReportException(
            CreateReportFailureStage.polling,
            'Could not confirm the report status: $error',
          );
        }

        await Future<void>.delayed(_retryDelay);
        continue;
      } on Exception catch (error) {
        transientFailures++;
        if (transientFailures >= _pollingRetryLimit) {
          throw CreateReportException(
            CreateReportFailureStage.polling,
            'Could not confirm the report status: $error',
          );
        }

        await Future<void>.delayed(_retryDelay);
        continue;
      }

      final data = response.data;
      if (response.status >= 400 || data is! Map<String, dynamic>) {
        final error = data is Map<String, dynamic> ? data['error'] : null;
        final message = (error as String? ?? 'create-report failed.').trim();
        if (response.status >= 500) {
          transientFailures++;
          if (transientFailures >= _pollingRetryLimit) {
            throw CreateReportException(
              CreateReportFailureStage.polling,
              message,
            );
          }
          await Future<void>.delayed(_retryDelay);
          continue;
        }
        throw CreateReportException(CreateReportFailureStage.polling, message);
      }

      transientFailures = 0;
      final payload = Map<String, dynamic>.from(data);
      final status = (payload['status'] as String? ?? '').trim();

      if (status == 'pending') {
        onStatusChanged?.call('Generating your report…');
        await Future<void>.delayed(_pollDelay);
        continue;
      }

      final responsePayload = payload['response'];
      if (status == 'failed' || responsePayload is! Map<String, dynamic>) {
        final reason = responsePayload is Map<String, dynamic>
            ? responsePayload['reason']
            : null;
        throw CreateReportException(
          CreateReportFailureStage.polling,
          (reason as String? ?? 'Report generation failed.').trim(),
        );
      }

      final path = (responsePayload['path'] as String? ?? '').trim();
      if (path.isEmpty) {
        throw const CreateReportException(
          CreateReportFailureStage.polling,
          'Report path is missing.',
        );
      }

      return _downloadReportBytes(path);
    }
  }

  Future<Uint8List> _downloadReportBytes(String path) async {
    for (var attempt = 1; attempt <= _downloadRetryLimit; attempt++) {
      try {
        final bytes = await _client.storage.from('assets').download(path);

        if (bytes.isEmpty) {
          throw const CreateReportException(
            CreateReportFailureStage.download,
            'Downloaded report is empty.',
          );
        }

        return bytes;
      } on CreateReportException {
        rethrow;
      } on Exception catch (error) {
        if (attempt >= _downloadRetryLimit) {
          throw CreateReportException(
            CreateReportFailureStage.download,
            'Could not download the report: $error',
          );
        }
        await Future<void>.delayed(_retryDelay);
      }
    }

    throw const CreateReportException(
      CreateReportFailureStage.download,
      'Could not download the report.',
    );
  }
}
