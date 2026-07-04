import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n/l10n.dart';
import '../../models/goals.dart';
import '../../providers/goals_provider.dart';
import '../../providers/meal_photo_service_provider.dart';
import '../../providers/today_meals_provider.dart';
import '../../services/meal_photo_service.dart';
import '../../theme/app_colors.dart';
import '../log/meals_log_screen.dart';

// ── Data ─────────────────────────────────────────────────────────────────────

class _PortionCheckResult {
  const _PortionCheckResult({
    required this.mealName,
    required this.portionPercent,
    required this.calories,
    required this.dailyCalories,
    required this.carbs,
    required this.proteins,
    required this.dailyProteins,
    required this.fats,
    required this.dailyFats,
    required this.fiber,
    required this.dailyFiber,
    this.note,
    this.imageBytes,
    this.imagePath,
  });

  final String mealName;
  final double portionPercent;
  final int calories;
  final int dailyCalories;
  final double carbs;
  final double proteins;
  final double dailyProteins;
  final double fats;
  final double dailyFats;
  final double fiber;
  final double dailyFiber;
  final String? note;
  final Uint8List? imageBytes;
  final String? imagePath;
}

// DEV: stub result shown when running on a simulator (no camera available)
const _kDevStub = _PortionCheckResult(
  mealName: 'Grilled Chicken, Rice & Broccoli',
  portionPercent: 0.5,
  calories: 560,
  dailyCalories: 700,
  carbs: 58,
  proteins: 42,
  dailyProteins: 65,
  fats: 18,
  dailyFats: 25,
  fiber: 6,
  dailyFiber: 8,
);

// ── Tips pool ─────────────────────────────────────────────────────────────────

List<String> _pickTips(List<String> tips, [int count = 3]) {
  final rng = math.Random();
  final shuffled = List<String>.from(tips)..shuffle(rng);
  return shuffled.take(count).toList();
}

List<String> _localizedPortionCheckTips(AppLocalizations l10n) {
  return l10n.portionCheckTipsPool
      .split('\n')
      .map((tip) => tip.trim())
      .where((tip) => tip.isNotEmpty)
      .toList();
}

// ── Screen ───────────────────────────────────────────────────────────────────

enum _Phase { loading, result, error }

class PortionCheckScreen extends ConsumerStatefulWidget {
  const PortionCheckScreen({super.key});

  @override
  ConsumerState<PortionCheckScreen> createState() => _PortionCheckScreenState();
}

class _PortionCheckScreenState extends ConsumerState<PortionCheckScreen> {
  _Phase _phase = _Phase.loading;
  _PortionCheckResult? _result;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _analyze();
  }

  Future<void> _analyze() async {
    if (await _isSimulator()) {
      await Future<void>.delayed(const Duration(milliseconds: 1400));
      if (!mounted) return;
      const stubImagePath =
          '91040b26-a321-432e-bc5d-e0d7aae9a1c2/f4127df6-4b3d-4103-9be0-184efd1ae3e2.png';
      Uint8List? stubBytes;
      try {
        stubBytes = await ref
            .read(mealPhotoServiceProvider)
            .downloadImageBytes(stubImagePath);
      } catch (_) {
        // Non-fatal — photo preview won't show but the rest still works.
      }
      if (!mounted) return;
      setState(() {
        _phase = _Phase.result;
        _result = _PortionCheckResult(
          mealName: _kDevStub.mealName,
          portionPercent: _kDevStub.portionPercent,
          calories: _kDevStub.calories,
          dailyCalories: _kDevStub.dailyCalories,
          carbs: _kDevStub.carbs,
          proteins: _kDevStub.proteins,
          dailyProteins: _kDevStub.dailyProteins,
          fats: _kDevStub.fats,
          dailyFats: _kDevStub.dailyFats,
          fiber: _kDevStub.fiber,
          dailyFiber: _kDevStub.dailyFiber,
          imageBytes: stubBytes,
          imagePath: stubImagePath,
        );
      });
      return;
    }

    try {
      final checkPortion = await _buildCheckPortion();
      final photo = await ref
          .read(mealPhotoServiceProvider)
          .pickUploadAndAnalyze(ImageSource.camera, checkPortion: checkPortion);

      if (!mounted) return;

      if (photo == null) {
        Navigator.of(context).pop();
        return;
      }

      // Portion Check owns this result — prevent the meal log sheet from
      // picking it up as a pending analysis on next open.
      unawaited(
        ref
            .read(mealPhotoServiceProvider)
            .clearPendingAnalysisIfMatchesImagePath(photo.imagePath),
      );

      if (!photo.analysisSucceeded) {
        setState(() {
          _phase = _Phase.error;
          _errorMessage = photo.reason.isNotEmpty
              ? photo.reason
              : MealPhotoService.technicalErrorMessage;
        });
        return;
      }

      final meal = photo.meal ?? {};
      final mealName = (meal['name'] as String? ?? '').trim();
      final note = (meal['note'] as String? ?? '').trim();
      setState(() {
        _phase = _Phase.result;
        _result = _PortionCheckResult(
          mealName: mealName.isEmpty ? _kDevStub.mealName : mealName,
          portionPercent: photo.portionPercent,
          calories: (meal['calories'] as num?)?.toInt() ?? _kDevStub.calories,
          dailyCalories: _kDevStub.dailyCalories,
          carbs: (meal['carbs'] as num?)?.toDouble() ?? _kDevStub.carbs,
          proteins: (meal['proteins'] as num?)?.toDouble() ?? _kDevStub.proteins,
          dailyProteins: _kDevStub.dailyProteins,
          fats: (meal['fats'] as num?)?.toDouble() ?? _kDevStub.fats,
          dailyFats: _kDevStub.dailyFats,
          fiber: (meal['fiber'] as num?)?.toDouble() ?? _kDevStub.fiber,
          dailyFiber: _kDevStub.dailyFiber,
          note: note.isEmpty ? null : note,
          imageBytes: photo.imageBytes,
          imagePath: photo.imagePath,
        );
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _phase = _Phase.error;
        _errorMessage = MealPhotoService.technicalErrorMessage;
      });
    }
  }

  Future<Map<String, dynamic>?> _buildCheckPortion() async {
    try {
      final goals = await ref.read(goalsProvider.future);
      final mealGoal = goals.meals;
      if (!mealGoal.enabled) return null;
      final entry = mealGoal.current;
      if (entry == null || entry.mode != MealsGoalMode.calories) return null;
      // targetValue is stored as a weekly total — convert to daily.
      final targetCalories = entry.timeframe == GoalTimeframe.weekly
          ? (entry.targetValue / 7).round()
          : entry.targetValue;
      if (targetCalories <= 0) return null;

      final meals = await ref.read(todayMealsProvider.future);
      final consumed = computeConsumedCalories(meals);

      return {
        'totalDailyConsumedCalories': consumed,
        'totalDailyTargetCalories': targetCalories,
      };
    } catch (_) {
      return null;
    }
  }

  Future<bool> _isSimulator() async {
    try {
      final info = DeviceInfoPlugin();
      if (Platform.isIOS) {
        return !(await info.iosInfo).isPhysicalDevice;
      }
      if (Platform.isAndroid) {
        return !(await info.androidInfo).isPhysicalDevice;
      }
    } catch (_) {}
    return false;
  }

  Future<void> _retake() async {
    setState(() {
      _phase = _Phase.loading;
      _result = null;
      _errorMessage = null;
    });
    await _analyze();
  }

  void _logPortion() => unawaited(_pushLogScreen());

  Future<void> _pushLogScreen() async {
    final result = _result;
    if (result == null) return;

    HapticFeedback.selectionClick();
    final didSave = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => MealsLogScreen(
          prefill: {
            'name': result.mealName,
            'calories': result.calories.toDouble(),
            'carbs': result.carbs,
            'proteins': result.proteins,
            'fats': result.fats,
            'fiber': result.fiber,
            'consumed': result.portionPercent.clamp(0.0, 1.0),
            if (result.imagePath != null) 'image_path': result.imagePath,
            if (result.imageBytes != null) 'image_bytes': result.imageBytes,
            if (result.note != null) 'note': result.note,
          },
        ),
      ),
    );

    if (didSave == true && mounted) {
      Navigator.of(context).pop();
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
            _NavBar(title: context.l10n.portionCheckTitle),
            Expanded(
              child: switch (_phase) {
                _Phase.loading => const _LoadingView(),
                _Phase.error => _ErrorView(
                    message: _errorMessage ?? context.l10n.portionCheckSomethingWentWrong,
                    onRetake: _retake,
                  ),
                _Phase.result => _ResultView(
                    result: _result!,
                    onLog: _logPortion,
                    onRetake: _retake,
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ── Nav bar ──────────────────────────────────────────────────────────────────

class _NavBar extends StatelessWidget {
  const _NavBar({required this.title});

  final String title;

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
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}

// ── Loading ───────────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF3AADAD),
            strokeWidth: 2.5,
          ),
          const SizedBox(height: 18),
          Text(
            context.l10n.portionCheckAnalyzingMeal,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Error ─────────────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetake});

  final String message;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.lineSubtle),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: colors.softSurface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.hide_image_outlined,
                    size: 28,
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.portionCheckCouldNotAnalyzePhoto,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          FilledButton.icon(
            onPressed: onRetake,
            icon: const Icon(Icons.camera_alt_rounded, size: 18),
            label: Text(context.l10n.portionCheckTakeNewPhoto),
          ),
        ],
      ),
    );
  }
}

// ── Result ───────────────────────────────────────────────────────────────────

class _ResultView extends StatefulWidget {
  const _ResultView({
    required this.result,
    required this.onLog,
    required this.onRetake,
  });

  final _PortionCheckResult result;
  final VoidCallback onLog;
  final VoidCallback onRetake;

  @override
  State<_ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<_ResultView> {
  List<String> _tips = [];
  String? _tipsPool;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tipsPool = context.l10n.portionCheckTipsPool;
    if (_tipsPool != tipsPool) {
      _tipsPool = tipsPool;
      _tips = _pickTips(_localizedPortionCheckTips(context.l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopResultCard(result: widget.result),
                const SizedBox(height: 20),
                _NutritionBreakdownSection(result: widget.result),
                const SizedBox(height: 20),
                _TipsSection(tips: _tips),
              ],
            ),
          ),
        ),
        _BottomActions(onLog: widget.onLog, onRetake: widget.onRetake),
      ],
    );
  }
}

// ── Top result card ───────────────────────────────────────────────────────────

class _TopResultCard extends StatelessWidget {
  const _TopResultCard({required this.result});

  final _PortionCheckResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final pct = (result.portionPercent * 100).round();

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MealPhotoWidget(bytes: result.imageBytes),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.mealName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 88,
                  height: 88,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(88, 88),
                        painter: _ArcPainter(
                          progress: result.portionPercent,
                          trackColor: colors.lineSubtle,
                          progressColor: pct <= 0 ? colors.fat : colors.fiber,
                        ),
                      ),
                      Text(
                        '$pct%',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: pct <= 0 ? colors.fat : colors.fiber,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pct <= 0
                            ? context.l10n.portionCheckYouHitDailyLimit
                            : pct >= 100
                                ? context.l10n.portionCheckYouCanEat
                                : context.l10n.portionCheckYouCanEatUpTo,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      Text(
                        pct <= 0
                            ? context.l10n.portionCheckTryLighterOption
                            : pct >= 100
                                ? context.l10n.portionCheckThisEntireMeal
                                : context.l10n.portionCheckPctOfThisMeal(pct),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (pct > 0)
                        Text(
                          context.l10n.portionCheckToStayWithinGoals,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      if (pct > 0) ...[
                        const SizedBox(height: 6),
                        Text(
                          '~${(result.calories * result.portionPercent).round()} kcal',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.fiber,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Meal photo ────────────────────────────────────────────────────────────────

class _MealPhotoWidget extends StatelessWidget {
  const _MealPhotoWidget({this.bytes});

  final Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final child = bytes != null
        ? Image.memory(
            bytes!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        // DEV: local Supabase food photo for simulator testing
        : Image.network(
            'http://127.0.0.1:54321/storage/v1/object/sign/assets/91040b26-a321-432e-bc5d-e0d7aae9a1c2/f4127df6-4b3d-4103-9be0-184efd1ae3e2.png?token=eyJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJhc3NldHMvOTEwNDBiMjYtYTMyMS00MzJlLWJjNWQtZTBkN2FhZTlhMWMyL2Y0MTI3ZGY2LTRiM2QtNDEwMy05YmUwLTE4NGVmZDFhZTNlMi5wbmciLCJpYXQiOjE3NzY5MDUzOTEsImV4cCI6MTc3NzUxMDE5MX0.vUdBUn_gN7yRKvbEisZ9dqdOeaZn3ncHy6VuUszFwtE',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, __, ___) => Image.asset(
              'assets/icons/app_icon.png',
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          );

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        color: colors.softSurface,
        child: child,
      ),
    );
  }
}

// ── Arc painter ───────────────────────────────────────────────────────────────

class _ArcPainter extends CustomPainter {
  const _ArcPainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
  });

  final double progress;
  final Color trackColor;
  final Color progressColor;

  static const _strokeWidth = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - _strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi,
      false,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    final sweep = math.min(progress, 1.0) * 2 * math.pi;
    canvas.drawArc(
      rect,
      -math.pi / 2,
      sweep,
      false,
      Paint()
        ..color = progressColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = _strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.progress != progress ||
      old.trackColor != trackColor ||
      old.progressColor != progressColor;
}

// ── Nutrition breakdown ───────────────────────────────────────────────────────

class _NutritionBreakdownSection extends StatelessWidget {
  const _NutritionBreakdownSection({required this.result});

  final _PortionCheckResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final items = [
      _NutritionItem(
        icon: Icons.grain_rounded,
        label: context.l10n.portionCheckCarbs,
        value: result.carbs,
        daily: 0,
        unit: 'g',
        tint: colors.carbs.withValues(alpha: 0.18),
        color: colors.carbs,
      ),
      _NutritionItem(
        icon: Icons.fitness_center_rounded,
        label: context.l10n.portionCheckProteins,
        value: result.proteins,
        daily: result.dailyProteins,
        unit: 'g',
        tint: colors.protein.withValues(alpha: 0.18),
        color: colors.protein,
      ),
      _NutritionItem(
        icon: Icons.opacity_rounded,
        label: context.l10n.portionCheckFats,
        value: result.fats,
        daily: result.dailyFats,
        unit: 'g',
        tint: colors.fat.withValues(alpha: 0.18),
        color: colors.fat,
      ),
      _NutritionItem(
        icon: Icons.eco_rounded,
        label: context.l10n.portionCheckFiber,
        value: result.fiber,
        daily: result.dailyFiber,
        unit: 'g',
        tint: colors.fiber.withValues(alpha: 0.18),
        color: colors.fiber,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.portionCheckNutritionBreakdown,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _NutritionCard(item: items[0]),
            const SizedBox(width: 6),
            _NutritionCard(item: items[1]),
            const SizedBox(width: 6),
            _NutritionCard(item: items[2]),
            const SizedBox(width: 6),
            _NutritionCard(item: items[3]),
          ],
        ),
      ],
    );
  }
}

class _NutritionItem {
  const _NutritionItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.daily,
    required this.unit,
    required this.tint,
    required this.color,
  });

  final IconData icon;
  final String label;
  final double value;
  final double daily;
  final String unit;
  final Color tint;
  final Color color;

  double get percent => daily > 0 ? (value / daily).clamp(0.0, 1.0) : 0;
}

class _NutritionCard extends StatelessWidget {
  const _NutritionCard({required this.item});

  final _NutritionItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final valueStr = item.value % 1 == 0
        ? item.value.toInt().toString()
        : item.value.toStringAsFixed(1);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.lineSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.82),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0F000000),
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                item.icon,
                size: 14,
                color: HSLColor.fromColor(item.tint)
                    .withLightness(0.46)
                    .toColor()
                    .withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '$valueStr ${item.unit}',
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                color: colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Tips ──────────────────────────────────────────────────────────────────────

class _TipsSection extends StatelessWidget {
  const _TipsSection({required this.tips});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded,
                  size: 16, color: colors.textSecondary),
              const SizedBox(width: 6),
              Text(
                context.l10n.portionCheckTipsToBalanceMeal,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final tip in tips) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_rounded,
                    size: 15, color: Color(0xFF5FBF91)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    tip,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            if (tip != tips.last) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

// ── Bottom actions ────────────────────────────────────────────────────────────

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.onLog, required this.onRetake});

  final VoidCallback onLog;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: colors.canvas,
        border: Border(top: BorderSide(color: colors.lineSubtle)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onRetake,
              icon: const Icon(Icons.camera_alt_outlined, size: 16),
              label: Text(context.l10n.portionCheckRetake),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: FilledButton.icon(
              onPressed: onLog,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: Text(context.l10n.portionCheckLogThisPortion),
            ),
          ),
        ],
      ),
    );
  }
}
