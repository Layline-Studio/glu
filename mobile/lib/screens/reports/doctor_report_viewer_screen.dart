import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfx/pdfx.dart';
import 'package:share_plus/share_plus.dart';

import '../../l10n/l10n.dart';
import '../../providers/analytics_provider.dart';
import '../../theme/app_colors.dart';

/// Displays a locally downloaded doctor report PDF (see
/// `services/doctor_report_flow.dart`) with pinch-to-zoom, and lets the
/// user share the actual file from here.
class DoctorReportViewerScreen extends ConsumerStatefulWidget {
  const DoctorReportViewerScreen({
    super.key,
    required this.filePath,
    required this.analyticsSource,
  });

  final String filePath;
  final String analyticsSource;

  @override
  ConsumerState<DoctorReportViewerScreen> createState() =>
      _DoctorReportViewerScreenState();
}

class _DoctorReportViewerScreenState
    extends ConsumerState<DoctorReportViewerScreen> {
  late final PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.filePath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    try {
      File(widget.filePath).deleteSync();
    } catch (_) {}
    super.dispose();
  }

  Future<void> _shareReport() async {
    try {
      await SharePlus.instance.share(
        ShareParams(files: [XFile(widget.filePath)]),
      );
      ref.read(analyticsServiceProvider).capture(
        eventName: 'progress_doctor_report_shared',
        properties: {'source': widget.analyticsSource},
      );
    } catch (_) {
      // The OS share sheet failing/being dismissed isn't actionable here.
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            _DoctorReportNavBar(
              title: context.l10n.homeDoctorReportTitle,
              onShare: _shareReport,
            ),
            Expanded(
              child: PdfViewPinch(
                controller: _pdfController,
                builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
                  options: const DefaultBuilderOptions(),
                  documentLoaderBuilder: (_) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorBuilder: (_, __) => _ViewerErrorView(
                    message: context.l10n.doctorReportViewerRenderError,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorReportNavBar extends StatelessWidget {
  const _DoctorReportNavBar({required this.title, required this.onShare});

  final String title;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          InkResponse(
            onTap: () => Navigator.of(context).pop(),
            radius: 20,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: colors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          InkResponse(
            onTap: onShare,
            radius: 20,
            child: Semantics(
              label: l10n.doctorReportViewerShare,
              child: Icon(
                Icons.share_rounded,
                size: 18,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ViewerErrorView extends StatelessWidget {
  const _ViewerErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: colors.textPrimary),
        ),
      ),
    );
  }
}
