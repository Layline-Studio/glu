import 'dart:math' show max, min;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../l10n/l10n.dart';
import '../../providers/goals_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';

// ── Screen ────────────────────────────────────────────────────────────────────

class GlowUpScreen extends ConsumerStatefulWidget {
  const GlowUpScreen({super.key});

  @override
  ConsumerState<GlowUpScreen> createState() => _GlowUpScreenState();
}

class _GlowUpScreenState extends ConsumerState<GlowUpScreen> {
  final _cardKey = GlobalKey();
  final _shareButtonKey = GlobalKey();
  final _beforeController = TransformationController();
  final _afterController = TransformationController();
  final _weightController = TextEditingController();
  final _weeksController = TextEditingController();

  Uint8List? _beforeBytes;
  Uint8List? _afterBytes;
  bool _isSharing = false;
  bool _isExporting = false;
  String _weightUnit = 'kg'; // overridden from profile on first build
  String _timeUnit = 'weeks';
  static const _timeUnits = ['days', 'weeks', 'months', 'years'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final goals = ref.read(goalsProvider).asData?.value;
      final unit = goals?.weight.current?.targetUnit ?? 'kg';
      if (mounted) setState(() => _weightUnit = unit);
    });
  }

  @override
  void dispose() {
    _beforeController.dispose();
    _afterController.dispose();
    _weightController.dispose();
    _weeksController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(bool isBefore) async {
    HapticFeedback.selectionClick();
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 95,
    );
    if (file == null) return;
    final bytes = await file.readAsBytes();
    if (!mounted) return;

    final controller = isBefore ? _beforeController : _afterController;
    controller.value = await _coverTransform(bytes);

    setState(() {
      if (isBefore) {
        _beforeBytes = bytes;
      } else {
        _afterBytes = bytes;
      }
    });
  }

  // Computes a Matrix4 that scales + centers the image to cover the slot,
  // matching the cover-fill starting point the user expects.
  Future<Matrix4> _coverTransform(Uint8List bytes) async {
    // Decode natural image dimensions.
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final imgW = frame.image.width.toDouble();
    final imgH = frame.image.height.toDouble();

    // Slot dimensions derived from screen width + card layout constants.
    // ignore: use_build_context_synchronously
    final screenW = MediaQuery.of(context).size.width;
    const padding = 40.0; // 20px each side
    const gap = 2.0;
    final cardW = screenW - padding;
    final cardH = cardW * 5 / 4; // card aspect ratio 4:5
    final sw = (cardW - gap) / 2;
    final sh = cardH;

    // FittedBox(contain) scale: fits the image within the slot.
    final fitScale = min(sw / imgW, sh / imgH);
    final fittedW = imgW * fitScale;
    final fittedH = imgH * fitScale;

    // Cover scale: how much extra to scale so the image fills the slot.
    final coverScale = max(sw / fittedW, sh / fittedH);

    // Scale from the slot center so the image stays centered.
    final cx = sw / 2;
    final cy = sh / 2;
    return Matrix4.identity()
      ..translateByDouble(cx, cy, 0, 1)
      ..scaleByDouble(coverScale, coverScale, 1, 1)
      ..translateByDouble(-cx, -cy, 0, 1);
  }

  Future<Uint8List?> _captureCardBytes() async {
    final boundary =
        _cardKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return null;
    return byteData.buffer.asUint8List();
  }

  Future<Uint8List> _normalizeToPng(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final byteData =
        await frame.image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Could not encode image as PNG.');
    }
    return byteData.buffer.asUint8List();
  }

  Future<void> _persistGlowUpAssets(Uint8List comparisonBytes) async {
    final beforeBytes = _beforeBytes;
    final afterBytes = _afterBytes;
    if (beforeBytes == null || afterBytes == null) {
      throw Exception('Add both a before and after photo first.');
    }

    final recordService = ref.read(recordServiceProvider);
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      throw Exception('No authenticated user found.');
    }

    final now = DateTime.now().toLocal();
    final dateKey = formatCompactDate(now);
    final basePath = '${user.id}/glowup/$dateKey';
    final beforePath = '$basePath/before';
    final afterPath = '$basePath/after';
    final comparisonPath = '$basePath/before-and-after';
    final loggedAt = formatIsoWithTimezone(now);

    final normalizedBefore = await _normalizeToPng(beforeBytes);
    final normalizedAfter = await _normalizeToPng(afterBytes);

    await recordService.uploadAssetBinary(
      beforePath,
      normalizedBefore,
      contentType: 'image/png',
      upsert: true,
    );
    await recordService.uploadAssetBinary(
      afterPath,
      normalizedAfter,
      contentType: 'image/png',
      upsert: true,
    );
    await recordService.uploadAssetBinary(
      comparisonPath,
      comparisonBytes,
      contentType: 'image/png',
      upsert: true,
    );

    await recordService.upsertGlowUpRecord({
      'logged_at': loggedAt,
      'saved_at': loggedAt,
      'date': dateKey,
      'before_path': beforePath,
      'after_path': afterPath,
      'comparison_path': comparisonPath,
    });
  }

  Rect? _sharePositionOrigin(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return null;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return null;
    final topLeft = renderObject.localToGlobal(Offset.zero);
    return topLeft & renderObject.size;
  }

  Future<void> _share(GlobalKey originKey) async {
    if (_isSharing) return;
    HapticFeedback.selectionClick();
    if (_beforeBytes == null || _afterBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(context.l10n.glowUpAddBeforeAndAfterFirst)),
      );
      return;
    }
    setState(() {
      _isSharing = true;
      _isExporting = true;
    });
    // Wait for the frame triggered by setState to fully render before capture
    await WidgetsBinding.instance.endOfFrame;
    try {
      final comparisonBytes = await _captureCardBytes();
      if (comparisonBytes == null) {
        throw Exception('Could not prepare the final image.');
      }

      await _persistGlowUpAssets(comparisonBytes);

      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              comparisonBytes,
              mimeType: 'image/png',
              name: 'glu_glowup_${DateTime.now().millisecondsSinceEpoch}.png',
            ),
          ],
          text: 'My Glow Up progress',
          sharePositionOrigin: _sharePositionOrigin(originKey),
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
          _isExporting = false;
        });
      }
    }
  }

  Future<void> _saveToGallery() async {
    if (_isSharing) return;
    HapticFeedback.selectionClick();
    if (_beforeBytes == null || _afterBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(context.l10n.glowUpAddBeforeAndAfterFirst)),
      );
      return;
    }
    setState(() {
      _isSharing = true;
      _isExporting = true;
    });
    // Wait for the frame triggered by setState to fully render before capture
    await WidgetsBinding.instance.endOfFrame;
    try {
      final comparisonBytes = await _captureCardBytes();
      if (comparisonBytes == null) {
        throw Exception('Could not prepare the final image.');
      }

      await _persistGlowUpAssets(comparisonBytes);

      await Gal.putImageBytes(
        comparisonBytes,
        album: 'Glu',
        name: 'glu_glowup_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.glowUpSavedToGallery)),
        );
      }
    } on GalException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.type.message)),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error.toString().replaceFirst('Exception: ', ''))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
          _isExporting = false;
        });
      }
    }
  }

  String _pluralTime(String raw) {
    final l10n = context.l10n;
    final count = int.tryParse(raw) ?? 0;
    switch (_timeUnit) {
      case 'days':
        return l10n.glowUpTimeValueDays(count);
      case 'weeks':
        return l10n.glowUpTimeValueWeeks(count);
      case 'months':
        return l10n.glowUpTimeValueMonths(count);
      case 'years':
        return l10n.glowUpTimeValueYears(count);
      default:
        return raw;
    }
  }

  String get _timeUnitLabel {
    final l10n = context.l10n;
    switch (_timeUnit) {
      case 'days':
        return l10n.glowUpTimeUnitDaysLabel;
      case 'weeks':
        return l10n.glowUpTimeUnitWeeksLabel;
      case 'months':
        return l10n.glowUpTimeUnitMonthsLabel;
      case 'years':
        return l10n.glowUpTimeUnitYearsLabel;
      default:
        return _timeUnit;
    }
  }

  String get _statLine {
    final l10n = context.l10n;
    final w = _weightController.text.trim();
    final t = _weeksController.text.trim();
    if (w.isEmpty && t.isEmpty) return '';
    if (w.isNotEmpty && t.isNotEmpty) {
      return l10n.glowUpProgressWeightAndTime(
        '$w $_weightUnit',
        _pluralTime(t),
      );
    }
    if (w.isNotEmpty) return '$w $_weightUnit';
    return _pluralTime(t);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final isPro = ref.watch(isProProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: Column(
            children: [
              _NavBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RepaintBoundary(
                        key: _cardKey,
                        child: _GlowUpCard(
                          beforeBytes: _beforeBytes,
                          afterBytes: _afterBytes,
                          beforeController: _beforeController,
                          afterController: _afterController,
                          onPickBefore: () => _pickPhoto(true),
                          onPickAfter: () => _pickPhoto(false),
                          statLine: _statLine,
                          isExporting: _isExporting,
                          showBadge: !isPro,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        context.l10n.glowUpYourProgress,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: colors.lineSubtle),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: _StatField(
                                  controller: _weightController,
                                  label: context.l10n.glowUpWeightChange,
                                  suffix: _weightUnit,
                                  hint: '-12',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true, decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[-0-9.]')),
                                    _NegativeFormatter(),
                                  ],
                                  onChanged: (_) => setState(() {}),
                                  onSuffixTap: () => setState(() {
                                    _weightUnit =
                                        _weightUnit == 'kg' ? 'lb' : 'kg';
                                  }),
                                  useCardChrome: false,
                                ),
                              ),
                              VerticalDivider(
                                width: 1,
                                thickness: 1,
                                indent: 14,
                                endIndent: 14,
                                color: colors.lineSubtle.withValues(alpha: 0.75),
                              ),
                              Expanded(
                                child: _StatField(
                                  controller: _weeksController,
                                  label: context.l10n.glowUpTime,
                                  suffix: _timeUnitLabel,
                                  hint: '10',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  onChanged: (_) => setState(() {}),
                                  onSuffixTap: () => setState(() {
                                    final i = _timeUnits.indexOf(_timeUnit);
                                    _timeUnit =
                                        _timeUnits[(i + 1) % _timeUnits.length];
                                  }),
                                  useCardChrome: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                decoration: BoxDecoration(
                  color: colors.canvas,
                  border: Border(top: BorderSide(color: colors.lineSubtle)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        key: _shareButtonKey,
                        onPressed: _isSharing
                            ? null
                            : () => _share(_shareButtonKey),
                        icon: const Icon(Icons.share_rounded, size: 18),
                        label: Text(context.l10n.glowUpShare),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _isSharing ? null : _saveToGallery,
                        icon: _isSharing
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.photo_library_outlined, size: 18),
                        label: Text(
                          _isSharing
                              ? context.l10n.commonSaving
                              : context.l10n.glowUpSaveToGallery,
                        ),
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Nav bar ───────────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

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
            'Glow Up',
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}

// ── Shareable card ────────────────────────────────────────────────────────────

class _GlowUpCard extends StatelessWidget {
  const _GlowUpCard({
    required this.beforeBytes,
    required this.afterBytes,
    required this.beforeController,
    required this.afterController,
    required this.onPickBefore,
    required this.onPickAfter,
    required this.statLine,
    required this.isExporting,
    required this.showBadge,
  });

  final Uint8List? beforeBytes;
  final Uint8List? afterBytes;
  final TransformationController beforeController;
  final TransformationController afterController;
  final VoidCallback onPickBefore;
  final VoidCallback onPickAfter;
  final String statLine;
  final bool isExporting;
  final bool showBadge;

  static const _gap = 2.0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final cardW = constraints.maxWidth;
          final cardH = constraints.maxHeight;
          final slotW = (cardW - _gap) / 2;

          return ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ColoredBox(
              color: Colors.white,
              child: Stack(
                children: [
                  // BEFORE slot
                  Positioned(
                    left: 0,
                    top: 0,
                    width: slotW,
                    height: cardH,
                    child: _PhotoSlot(
                      bytes: beforeBytes,
                      label: context.l10n.glowUpBefore,
                      controller: beforeController,
                      onTap: onPickBefore,
                      isLeft: true,
                      width: slotW,
                      height: cardH,
                      hideControls: isExporting,
                    ),
                  ),
                  // AFTER slot
                  Positioned(
                    right: 0,
                    top: 0,
                    width: slotW,
                    height: cardH,
                    child: _PhotoSlot(
                      bytes: afterBytes,
                      label: context.l10n.glowUpAfter,
                      controller: afterController,
                      onTap: onPickAfter,
                      isLeft: false,
                      width: slotW,
                      height: cardH,
                      hideControls: isExporting,
                    ),
                  ),
                  // Gradient + centered badge / stat overlay
                  if (statLine.isNotEmpty || showBadge)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 48, 16, 36),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0xDD000000),
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showBadge)
                              Opacity(
                                opacity: 0.4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.asset(
                                          'assets/icons/app_icon.png',
                                          width: 12,
                                          height: 12,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Text(
                                        'Glu App',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (showBadge && statLine.isNotEmpty)
                              const SizedBox(height: 12),
                            if (statLine.isNotEmpty)
                              Text(
                                statLine,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  height: 1.2,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Photo slot ────────────────────────────────────────────────────────────────

class _PhotoSlot extends StatelessWidget {
  const _PhotoSlot({
    required this.bytes,
    required this.label,
    required this.controller,
    required this.onTap,
    required this.isLeft,
    required this.width,
    required this.height,
    this.hideControls = false,
  });

  final Uint8List? bytes;
  final String label;
  final TransformationController controller;
  final VoidCallback onTap;
  final bool isLeft;
  final double width;
  final double height;
  final bool hideControls;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.white,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Background / photo
          Positioned.fill(
            child: bytes != null
                ? ClipRect(
                    child: InteractiveViewer(
                      constrained: false,
                      transformationController: controller,
                      boundaryMargin: const EdgeInsets.all(double.infinity),
                      minScale: 0.25,
                      maxScale: 6.0,
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.memory(bytes!),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: onTap,
                    child: ColoredBox(
                      color: Colors.white,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 36,
                              color: Colors.black.withValues(alpha: 0.2),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add photo',
                              style: TextStyle(
                                color: Colors.black.withValues(alpha: 0.3),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),

          // BEFORE / AFTER label
          Positioned(
            top: 10,
            left: isLeft ? 10 : null,
            right: isLeft ? null : 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          // Change-photo button — hidden during export
          if (bytes != null && !hideControls)
            Positioned(
              top: 8,
              right: isLeft ? 8 : null,
              left: isLeft ? null : 8,
              child: GestureDetector(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.45),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Stat field ────────────────────────────────────────────────────────────────

class _StatField extends StatelessWidget {
  const _StatField({
    required this.controller,
    required this.label,
    required this.suffix,
    required this.hint,
    required this.onChanged,
    this.useCardChrome = true,
    this.keyboardType,
    this.inputFormatters,
    this.onSuffixTap,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;
  final String hint;
  final ValueChanged<String> onChanged;
  final bool useCardChrome;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelSmall?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            onChanged: onChanged,
            textAlign: TextAlign.center,
            cursorHeight: 22,
            keyboardType: keyboardType ??
                const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
            inputFormatters: inputFormatters,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hint,
              hintStyle: theme.textTheme.headlineSmall?.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.25),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: onSuffixTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: colors.lineSubtle,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    suffix,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (onSuffixTap != null) ...[
                    const SizedBox(width: 3),
                    Icon(Icons.swap_horiz_rounded,
                        size: 11, color: colors.textSecondary),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (!useCardChrome) {
      return content;
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: content,
    );
  }
}

// ── Formatters ────────────────────────────────────────────────────────────────

class _NegativeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty || newValue.text.startsWith('-')) {
      return newValue;
    }
    final updated = '-${newValue.text}';
    return newValue.copyWith(
      text: updated,
      selection: TextSelection.collapsed(offset: newValue.selection.end + 1),
    );
  }
}
