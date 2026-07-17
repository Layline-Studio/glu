import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../l10n/l10n.dart';
import '../providers/analytics_provider.dart';
import '../providers/subscription_provider.dart';
import '../screens/reports/doctor_report_viewer_screen.dart';
import '../widgets/pro_gate.dart';
import 'create_report_service.dart';

/// Runs the "create doctor report" flow shared between Progress and Home:
/// gates on Pro subscription, generates today's report, saves it to a temp
/// file, and opens it in [DoctorReportViewerScreen].
Future<void> requestDoctorReport({
  required BuildContext context,
  required WidgetRef ref,
  required String analyticsSource,
  required String proAccessSource,
}) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;

  final status = await ref.read(subscriptionProvider.future).catchError(
        (_) => SubscriptionStatus.free,
      );
  if (!context.mounted) return;
  if (status != SubscriptionStatus.pro) {
    ref.read(analyticsServiceProvider).capture(
      eventName: 'progress_doctor_report_requested',
      properties: {
        'source': analyticsSource,
        'subscription_status': status.name,
        'gated': true,
      },
    );
    await openProAccessScreen(
      context,
      ref,
      source: proAccessSource,
    );
    return;
  }

  final snackBar = SnackBar(
    content: Text(l10n.progressReportGenerating),
    duration: const Duration(minutes: 5),
  );
  messenger.showSnackBar(snackBar);

  try {
    final bytes = await CreateReportService().createTodayReport();
    final dir = await getTemporaryDirectory();
    final filePath =
        '${dir.path}/doctor_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
    await File(filePath).writeAsBytes(bytes);
    if (!context.mounted) return;
    messenger.hideCurrentSnackBar();

    ref.read(analyticsServiceProvider).capture(
      eventName: 'progress_doctor_report_viewed',
      properties: {'source': analyticsSource},
    );

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DoctorReportViewerScreen(
          filePath: filePath,
          analyticsSource: analyticsSource,
        ),
      ),
    );
  } on CreateReportException catch (error) {
    if (!context.mounted) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(_messageForReportError(error, l10n))),
    );
    debugPrint(
      'Create doctor report failed at ${error.stage}: ${error.message}',
    );
  } catch (error) {
    if (!context.mounted) return;
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(l10n.progressReportError)),
    );
    debugPrint('Create doctor report failed: $error');
  }
}

String _messageForReportError(
  CreateReportException error,
  AppLocalizations l10n,
) {
  switch (error.stage) {
    case CreateReportFailureStage.request:
      return l10n.progressReportError;
    case CreateReportFailureStage.polling:
      return l10n.progressReportPendingRetry;
    case CreateReportFailureStage.download:
      return l10n.progressReportOpenError;
  }
}
