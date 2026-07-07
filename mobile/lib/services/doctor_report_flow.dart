import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../l10n/l10n.dart';
import '../providers/analytics_provider.dart';
import '../providers/subscription_provider.dart';
import '../widgets/pro_gate.dart';
import 'create_report_service.dart';

/// Runs the "create doctor report" flow shared between Progress and Home:
/// gates on Pro subscription, generates today's report, and shares the
/// resulting link (or falls back to opening it / copying it to clipboard).
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
    final url = await CreateReportService().createTodayReport();
    if (!context.mounted) return;
    messenger.hideCurrentSnackBar();
    await _shareReportUrl(context, url);
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

Future<void> _shareReportUrl(BuildContext context, String url) async {
  final messenger = ScaffoldMessenger.of(context);
  final l10n = context.l10n;
  final uri = Uri.parse(url);

  try {
    final result = await SharePlus.instance.share(ShareParams(uri: uri));
    if (result.status != ShareResultStatus.unavailable) {
      return;
    }
  } catch (error) {
    debugPrint('SharePlus.share(uri) failed for report URL: $error');
  }

  try {
    final result = await SharePlus.instance.share(ShareParams(text: url));
    if (result.status != ShareResultStatus.unavailable) {
      return;
    }
  } catch (error) {
    debugPrint('SharePlus.share(text) failed for report URL: $error');
  }

  try {
    final opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (opened) {
      if (!context.mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.progressReportOpenedInBrowser)),
      );
      return;
    }
  } catch (error) {
    debugPrint('launchUrl failed for report URL: $error');
  }

  await Clipboard.setData(ClipboardData(text: url));
  if (!context.mounted) return;
  messenger.showSnackBar(
    SnackBar(content: Text(l10n.progressReportCopiedLink)),
  );
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
    case CreateReportFailureStage.signing:
      return l10n.progressReportOpenError;
  }
}
