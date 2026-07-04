import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/l10n.dart';
import '../../providers/app_refresh_provider.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/meal_photo_service_provider.dart';
import '../../providers/record_service_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../services/meal_photo_service.dart';
import '../../services/record_service.dart';
import '../../theme/app_colors.dart';
import '../../utils/datetime_utils.dart';
import '../../widgets/expandable_notes.dart';
import '../../widgets/log_note_indicator.dart';
import '../../widgets/log_success_overlay.dart';
import '../../widgets/log_week_day_selector.dart';
import '../../widgets/pro_gate.dart';
import 'swipe_back_detector.dart';

final _mealLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final start = date;
  final end = date.add(const Duration(days: 1));
  final results =
      await service.loadTimeseries(RecordService.mealsColumn, start, end);
  results.sort(
      (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String));
  return results;
});

final _mealWeekDatesProvider = FutureProvider.autoDispose
    .family<Set<DateTime>, DateTime>((ref, date) async {
  final service = ref.read(recordServiceProvider);
  final weekStart = startOfWeek(date);
  final results = await service.loadTimeseries(
    RecordService.mealsColumn,
    weekStart,
    weekStart.add(const Duration(days: 7)),
  );
  return results
      .map((entry) => DateTime.tryParse(entry['logged_at'] as String? ?? ''))
      .whereType<DateTime>()
      .map((value) => dateOnly(value.toLocal()))
      .toSet();
});

final _allMealLogsProvider = FutureProvider.autoDispose
    .family<List<Map<String, dynamic>>, int>((ref, _) async {
  final service = ref.read(recordServiceProvider);
  final results = await service.loadTimeseries(
    RecordService.mealsColumn,
    DateTime(2000, 1, 1),
    DateTime.now().add(const Duration(days: 1)),
  );
  results.sort(
      (a, b) => (b['logged_at'] as String).compareTo(a['logged_at'] as String));
  return results;
});

class MealsLogScreen extends ConsumerStatefulWidget {
  const MealsLogScreen({super.key, this.existingEntry, this.prefill});

  final Map<String, dynamic>? existingEntry;
  final Map<String, dynamic>? prefill;

  @override
  ConsumerState<MealsLogScreen> createState() => _MealsLogScreenState();
}

class _MealsLogScreenState extends ConsumerState<MealsLogScreen> {
  late DateTime _selectedDate = _today;
  String? _successLabel;
  bool _isListView = true;

  static DateTime get _today {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  @override
  void initState() {
    super.initState();
    // Resolve initial date from existingEntry if editing
    final loggedAt = widget.existingEntry?['logged_at'] as String?;
    if (loggedAt != null) {
      final parsed = DateTime.tryParse(loggedAt)?.toLocal();
      if (parsed != null) {
        _selectedDate = DateTime(parsed.year, parsed.month, parsed.day);
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _openSheet());
  }

  Future<void> _openSheet({Map<String, dynamic>? entry}) async {
    final targetEntry = entry ?? widget.existingEntry;
    final label = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _MealInputSheet(
        existingEntry: targetEntry,
        prefill: widget.prefill,
        selectedDate: _selectedDate,
        onSaved: (savedDate) {
          if (mounted) setState(() => _selectedDate = savedDate);
        },
      ),
    );
    if (label != null && mounted) {
      setState(() => _successLabel = label);
      await Future<void>.delayed(const Duration(milliseconds: 1200));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final highlightedDates =
        ref.watch(_mealWeekDatesProvider(_selectedDate)).asData?.value ??
            const <DateTime>{};
    final allEntries = ref.watch(_allMealLogsProvider(0));

    return SwipeBackDetector(
      child: Scaffold(
        backgroundColor: colors.canvas,
        body: SafeArea(
          child: Stack(
            children: [
              AbsorbPointer(
                absorbing: _successLabel != null,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nav bar
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
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
                            context.l10n.mealLogScreenTitle,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkResponse(
                                onTap: () =>
                                    setState(() => _isListView = !_isListView),
                                radius: 20,
                                child: Icon(
                                  _isListView
                                      ? Icons.view_week_rounded
                                      : Icons.view_agenda_rounded,
                                  size: 22,
                                  color: colors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              InkResponse(
                                onTap: () => _openSheet(),
                                radius: 20,
                                child: Icon(
                                  Icons.add_rounded,
                                  size: 22,
                                  color: colors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (!_isListView) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: LogWeekDaySelector(
                          highlightedDates: highlightedDates,
                          selected: _selectedDate,
                          onSelect: (date) =>
                              setState(() => _selectedDate = date),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                          child: _LoggedMealsSection(
                            date: _selectedDate,
                            onEditEntry: (entry) => _openSheet(entry: entry),
                          ),
                        ),
                      ),
                    ] else
                      Expanded(
                        child: allEntries.when(
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, _) => Center(child: Text('$error')),
                          data: (entries) => _MealLogListSection(
                            entries: entries,
                            onEditEntry: (entry) => _openSheet(entry: entry),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (_successLabel case final label?)
                Positioned.fill(
                  child: _MealsLogSuccessOverlay(label: label),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Input sheet ───────────────────────────────────────────────────────────────

enum _InputMode { manual, camera, text, audio }

const _mealTextInputMaxChars = 500;
const _mealAudioMaxDuration = Duration(seconds: 60);
const _lastMealInputModeKey = 'last_meal_input_mode';

class _MealInputSheet extends ConsumerStatefulWidget {
  const _MealInputSheet({
    required this.selectedDate,
    required this.onSaved,
    this.existingEntry,
    this.prefill,
  });

  final Map<String, dynamic>? existingEntry;
  final Map<String, dynamic>? prefill;
  final DateTime selectedDate;
  final ValueChanged<DateTime> onSaved;

  @override
  ConsumerState<_MealInputSheet> createState() => _MealInputSheetState();
}

class _MealInputSheetState extends ConsumerState<_MealInputSheet> {
  late String _initialTitleValue;
  bool _initialTitleSet = false;
  late final TextEditingController _titleController;
  final _caloriesController = TextEditingController();
  final _carbsController = TextEditingController();
  final _proteinsController = TextEditingController();
  final _fatsController = TextEditingController();
  final _fiberController = TextEditingController();
  final _notesController = TextEditingController();
  final _textInputController = TextEditingController();

  bool _isSubmitting = false;
  bool _isNotesExpanded = false;
  _InputMode _inputMode = _InputMode.camera;
  bool _isAnalyzingPhoto = false;
  bool _isAnalyzingText = false;
  bool _isAnalyzingAudio = false;
  bool _isRecording = false;
  bool _didSave = false;
  double _consumed = 1.0;
  String? _draftImagePath;
  String? _originalImagePath;
  String? _analysisReason;
  String? _imagePreviewUrl;
  Uint8List? _draftImageBytes;
  String? _pendingAudioPath;
  final _audioRecorder = AudioRecorder();
  Timer? _recordingLimitTimer;
  Timer? _recordingProgressTimer;
  DateTime? _recordingStartedAt;
  Duration _recordingElapsed = Duration.zero;

  bool get _isEditing => widget.existingEntry != null;
  bool get _isAnalyzing =>
      _isAnalyzingPhoto || _isAnalyzingText || _isAnalyzingAudio;

  Future<void> _handleModeSelected(_InputMode mode) async {
    if (_isRecording || _isAnalyzing) {
      return;
    }
    if (mode == _InputMode.manual) {
      _discardPendingAudio();
      setState(() => _inputMode = _InputMode.manual);
      unawaited(_persistLastInputMode(_InputMode.manual));
      return;
    }
    if (mode == _InputMode.camera ||
        mode == _InputMode.text ||
        mode == _InputMode.audio) {
      final status = await ref.read(subscriptionProvider.future).catchError(
            (_) => SubscriptionStatus.free,
          );
      if (!mounted) return;
      if (status != SubscriptionStatus.pro) {
        await openProAccessScreen(
          context,
          ref,
          source: switch (mode) {
            _InputMode.camera => 'meals_camera',
            _InputMode.text => 'meals_text',
            _InputMode.audio => 'meals_audio',
            _ => 'meals_log',
          },
        );
        return;
      }
      ref.read(analyticsServiceProvider).capture(
        eventName: 'meal_logging_method_selected',
        properties: {
          'source': 'meals_log',
          'method': switch (mode) {
            _InputMode.camera => 'camera',
            _InputMode.text => 'text',
            _InputMode.audio => 'audio',
            _ => 'manual',
          },
          'is_editing': _isEditing,
        },
      );
      if (mode == _InputMode.audio) _discardPendingAudio();
      setState(() => _inputMode = mode);
      unawaited(_persistLastInputMode(mode));
      return;
    }
  }

  Future<void> _handlePickPhoto(ImageSource source) async {
    final status = await ref.read(subscriptionProvider.future).catchError(
          (_) => SubscriptionStatus.free,
        );
    if (!mounted) return;
    if (status != SubscriptionStatus.pro) {
      await openProAccessScreen(context, ref, source: 'meals_photo');
      return;
    }
    ref.read(analyticsServiceProvider).capture(
      eventName: 'meal_logging_method_selected',
      properties: {
        'source': 'meals_log',
        'method': source == ImageSource.camera ? 'camera' : 'library',
        'is_editing': _isEditing,
      },
    );
    await _pickAndAnalyzeMealPhoto(source);
  }

  Future<void> _handleTextAnalyze() async {
    final text = _textInputController.text.trim();
    if (text.isEmpty || _isAnalyzingText) return;

    HapticFeedback.lightImpact();
    setState(() => _isAnalyzingText = true);

    try {
      final result = await ref.read(mealPhotoServiceProvider).analyzeText(text);
      if (!mounted) return;

      if (result.analysisSucceeded && result.meal != null) {
        _applySnapMacroResult(result.meal!);
      }

      setState(() {
        _inputMode = _InputMode.manual;
        _isAnalyzingText = false;
        _analysisReason = result.analysisSucceeded
            ? null
            : (result.reason.isEmpty
                ? context.l10n.mealLogCouldNotAnalyzeText
                : result.reason);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _inputMode = _InputMode.manual;
        _isAnalyzingText = false;
        _analysisReason = MealPhotoService.technicalErrorMessage;
      });
    }
  }

  Future<void> _handleStartRecording() async {
    if (_isRecording || _isAnalyzingAudio) return;
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission || !mounted) return;

    try {
      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/meal_audio_${DateTime.now().millisecondsSinceEpoch}.m4a';
      await _audioRecorder.start(const RecordConfig(), path: path);
      if (!mounted) return;
      _recordingStartedAt = DateTime.now();
      _recordingElapsed = Duration.zero;
      _startRecordingProgressTimer();
      _recordingLimitTimer?.cancel();
      _recordingLimitTimer = Timer(_mealAudioMaxDuration, () async {
        if (!_isRecording || !mounted) return;
        await _handleStopRecording(showLimitMessage: true);
      });
      setState(() => _isRecording = true);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(context.l10n.mealLogCouldNotStartRecording),
          behavior: SnackBarBehavior.floating,
        ));
    }
  }

  Future<void> _handleStopRecording({bool showLimitMessage = false}) async {
    if (!_isRecording) return;
    _recordingProgressTimer?.cancel();
    _recordingProgressTimer = null;
    _recordingLimitTimer?.cancel();
    _recordingLimitTimer = null;
    _recordingElapsed = _currentRecordingElapsed();
    _recordingStartedAt = null;
    final path = await _audioRecorder.stop();
    if (!mounted) return;
    setState(() {
      _isRecording = false;
      _pendingAudioPath = path;
    });
    if (showLimitMessage) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(context.l10n.mealLogRecordingStoppedAtLimit),
          behavior: SnackBarBehavior.floating,
        ));
    }
  }

  Future<void> _handleAudioAnalyze() async {
    final path = _pendingAudioPath;
    if (path == null || _isAnalyzingAudio) return;

    HapticFeedback.lightImpact();
    setState(() => _isAnalyzingAudio = true);

    try {
      final bytes = await File(path).readAsBytes();
      final base64Audio = base64Encode(bytes);
      final result = await ref
          .read(mealPhotoServiceProvider)
          .analyzeAudio(base64Audio, 'audio/m4a');
      if (!mounted) return;

      if (result.analysisSucceeded && result.meal != null) {
        _applySnapMacroResult(result.meal!);
      }

      setState(() {
        _inputMode = _InputMode.manual;
        _isAnalyzingAudio = false;
        _pendingAudioPath = null;
        _analysisReason = result.analysisSucceeded
            ? null
            : (result.reason.isEmpty
                ? context.l10n.mealLogCouldNotAnalyzeRecording
                : result.reason);
      });
      try {
        await File(path).delete();
      } catch (_) {}
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _inputMode = _InputMode.manual;
        _isAnalyzingAudio = false;
        _analysisReason = MealPhotoService.technicalErrorMessage;
      });
    }
  }

  void _discardPendingAudio() {
    _recordingProgressTimer?.cancel();
    _recordingProgressTimer = null;
    _recordingLimitTimer?.cancel();
    _recordingLimitTimer = null;
    _recordingStartedAt = null;
    _recordingElapsed = Duration.zero;
    final path = _pendingAudioPath;
    if (path != null) {
      _pendingAudioPath = null;
      try {
        File(path).deleteSync();
      } catch (_) {}
    }
  }

  void _startRecordingProgressTimer() {
    _recordingProgressTimer?.cancel();
    _recordingProgressTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted || !_isRecording) {
          return;
        }
        setState(() {
          _recordingElapsed = _currentRecordingElapsed();
        });
      },
    );
  }

  Duration _currentRecordingElapsed() {
    final startedAt = _recordingStartedAt;
    if (startedAt == null) {
      return Duration.zero;
    }

    final elapsed = DateTime.now().difference(startedAt);
    if (elapsed.isNegative) {
      return Duration.zero;
    }
    if (elapsed >= _mealAudioMaxDuration) {
      return _mealAudioMaxDuration;
    }
    return elapsed;
  }

  Future<void> _pickAndAnalyzeMealPhoto(ImageSource source) async {
    if (_isAnalyzingPhoto || _isSubmitting) {
      return;
    }

    final previousDraftPath = _draftImagePath;
    final previousDraftBytes = _draftImageBytes;
    final previousPreviewUrl = _imagePreviewUrl;

    setState(() {
      _isAnalyzingPhoto = true;
      _analysisReason = null;
    });

    try {
      ref.read(analyticsServiceProvider).capture(
        eventName: 'meal_photo_analysis_started',
        properties: {
          'source': 'meals_log',
          'picker_source': source == ImageSource.camera ? 'camera' : 'library',
          'is_editing': _isEditing,
        },
      );

      final photo =
          await ref.read(mealPhotoServiceProvider).pickUploadAndAnalyze(source);

      if (photo == null) {
        if (!mounted) {
          return;
        }
        setState(() => _isAnalyzingPhoto = false);
        return;
      }

      if (previousDraftPath != null &&
          previousDraftPath.isNotEmpty &&
          previousDraftPath != photo.imagePath) {
        unawaited(
          ref.read(mealPhotoServiceProvider).deleteImage(previousDraftPath),
        );
      }

      if (photo.analysisSucceeded && photo.meal != null) {
        _applySnapMacroResult(photo.meal!);
      }

      ref.read(analyticsServiceProvider).capture(
        eventName: photo.analysisSucceeded
            ? 'meal_photo_analysis_succeeded'
            : 'meal_photo_analysis_failed',
        properties: {
          'source': 'meals_log',
          'picker_source': source == ImageSource.camera ? 'camera' : 'library',
          'is_editing': _isEditing,
          'has_reason': photo.reason.isNotEmpty,
          'is_technical_error': photo.isTechnicalError,
        },
      );
      if (photo.isTechnicalError) {
        _trackMealPhotoTechnicalError(
          stage: 'initial_request_result',
          rawError: photo.rawError,
          pickerSource: source,
        );
      }

      if (!mounted) {
        return;
      }
      setState(() {
        _draftImagePath = photo.imagePath;
        _draftImageBytes = photo.imageBytes;
        _imagePreviewUrl = null;
        _analysisReason = photo.analysisSucceeded
            ? null
            : (photo.reason.isEmpty
                ? context.l10n.mealLogCouldNotAnalyzePhoto
                : photo.reason);
        _inputMode = _InputMode.manual;
        _isAnalyzingPhoto = false;
      });
      if (photo.imageBytes == null) {
        unawaited(_loadExistingImagePreview(photo.imagePath));
      }
    } catch (error) {
      _trackMealPhotoTechnicalError(
        stage: 'initial_request_exception',
        rawError: error,
        pickerSource: source,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _draftImagePath = previousDraftPath;
        _draftImageBytes = previousDraftBytes;
        _imagePreviewUrl = previousPreviewUrl;
        _analysisReason = MealPhotoService.technicalErrorMessage;
        _isAnalyzingPhoto = false;
      });
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(context.l10n.mealLogCouldNotProcessMealPhoto),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  static String _friendlyDate(BuildContext context, DateTime date) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (date == today) return context.l10n.mealLogToday;
    if (date == yesterday) return context.l10n.mealLogYesterday;
    final weekday = DateFormat('EEE', locale).format(date);
    final shortDate = DateFormat('d MMM', locale).format(date);
    if (date.isAfter(today.subtract(const Duration(days: 7)))) {
      return weekday;
    }
    return '$weekday, $shortDate';
  }

  static String _mealTitleForTime(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) return l10n.mealLogBreakfast;
    if (hour >= 11 && hour < 14) return l10n.mealLogLunch;
    if (hour >= 14 && hour < 18) return l10n.mealLogSnack;
    if (hour >= 18 && hour < 22) return l10n.mealLogDinner;
    return l10n.mealLogSnack;
  }

  @override
  void initState() {
    super.initState();
    _initialTitleValue = widget.existingEntry == null
        ? ''
        : (widget.existingEntry!['name'] as String? ?? '');
    _titleController = TextEditingController(text: _initialTitleValue);
    final entry = widget.existingEntry;
    if (entry != null) {
      _caloriesController.text = _formatNum(entry['calories']);
      _carbsController.text = _formatNum(entry['carbs']);
      _proteinsController.text = _formatNum(entry['proteins']);
      _fatsController.text = _formatNum(entry['fats']);
      _fiberController.text = _formatNum(entry['fiber']);
      _consumed = (entry['consumed'] as num?)?.toDouble() ?? 1.0;
      _notesController.text = entry['notes'] as String? ?? '';
      _originalImagePath = entry['image_path'] as String?;
      if (_notesController.text.isNotEmpty) _isNotesExpanded = true;
      if (_originalImagePath case final path? when path.trim().isNotEmpty) {
        unawaited(_loadExistingImagePreview(path.trim()));
      }
    }
    final prefill = widget.prefill;
    if (prefill != null) {
      _titleController.text =
          prefill['name'] as String? ?? _titleController.text;
      _caloriesController.text = _formatNum(prefill['calories']);
      _carbsController.text = _formatNum(prefill['carbs']);
      _proteinsController.text = _formatNum(prefill['proteins']);
      _fatsController.text = _formatNum(prefill['fats']);
      _fiberController.text = _formatNum(prefill['fiber']);
      _consumed = (prefill['consumed'] as num?)?.toDouble() ?? 1.0;
      _originalImagePath = prefill['image_path'] as String?;
      _draftImageBytes = prefill['image_bytes'] as Uint8List?;
      final note = (prefill['note'] as String? ?? '').trim();
      if (note.isNotEmpty) {
        _notesController.text = note;
        _isNotesExpanded = true;
      }
      if (_draftImageBytes == null) {
        if (_originalImagePath case final path? when path.trim().isNotEmpty) {
          unawaited(_loadExistingImagePreview(path.trim()));
        }
      }
    }
    for (final c in _controllers) {
      c.addListener(_rebuild);
    }
    unawaited(_restoreLastInputMode());
    unawaited(_resumePendingPhotoAnalysis());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialTitleSet && widget.existingEntry == null) {
      _initialTitleSet = true;
      _initialTitleValue = _mealTitleForTime(context.l10n);
      _titleController.text = _initialTitleValue;
    }
  }

  Future<void> _restoreLastInputMode() async {
    if (_isEditing || widget.prefill != null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(_lastMealInputModeKey)?.trim();
      final restored = switch (stored) {
        'manual' => _InputMode.manual,
        'camera' => _InputMode.camera,
        'text' => _InputMode.text,
        'audio' => _InputMode.audio,
        _ => _InputMode.camera,
      };
      if (!mounted) return;
      setState(() => _inputMode = restored);
    } catch (_) {
      // Ignore preference load failures and keep the default mode.
    }
  }

  Future<void> _persistLastInputMode(_InputMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastMealInputModeKey, mode.name);
    } catch (_) {
      // Ignore preference save failures and keep the session usable.
    }
  }

  static String _formatNum(dynamic value) {
    if (value == null) return '';
    final d = (value as num).toDouble();
    return d == 0
        ? ''
        : (d == d.truncateToDouble() ? d.toInt().toString() : d.toString());
  }

  @override
  void dispose() {
    if (_isRecording) {
      unawaited(_audioRecorder.stop());
    }
    _recordingProgressTimer?.cancel();
    _recordingLimitTimer?.cancel();
    _discardPendingAudio();
    for (final c in _controllers) {
      c
        ..removeListener(_rebuild)
        ..dispose();
    }
    _audioRecorder.dispose();
    super.dispose();
  }

  List<TextEditingController> get _controllers => [
        _titleController,
        _caloriesController,
        _carbsController,
        _proteinsController,
        _fatsController,
        _fiberController,
        _notesController,
        _textInputController,
      ];

  void _rebuild() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _loadExistingImagePreview(String imagePath) async {
    try {
      final url = await ref.read(mealPhotoServiceProvider).createSignedUrl(
            imagePath,
          );
      if (!mounted) {
        return;
      }
      setState(() => _imagePreviewUrl = url);
    } catch (_) {
      // Ignore preview load failures; the form is still usable.
    }
  }

  Future<void> _resumePendingPhotoAnalysis() async {
    if (_isEditing || widget.prefill != null) {
      return;
    }

    final pending =
        await ref.read(mealPhotoServiceProvider).loadPendingAnalysis();
    if (!mounted || pending == null) {
      return;
    }

    setState(() {
      _draftImagePath = pending.imagePath;
      _draftImageBytes = null;
      _imagePreviewUrl = null;
      _analysisReason = null;
      _isAnalyzingPhoto = true;
    });
    unawaited(_loadExistingImagePreview(pending.imagePath));

    try {
      final photo =
          await ref.read(mealPhotoServiceProvider).resumePendingAnalysis();
      if (!mounted || photo == null) {
        return;
      }

      if (photo.analysisSucceeded && photo.meal != null) {
        _applySnapMacroResult(photo.meal!);
      }

      if (photo.imageBytes == null) {
        unawaited(_loadExistingImagePreview(photo.imagePath));
      }

      setState(() {
        _draftImagePath = photo.imagePath;
        _draftImageBytes = photo.imageBytes;
        _analysisReason = photo.analysisSucceeded
            ? null
            : (photo.reason.isEmpty
                ? context.l10n.mealLogCouldNotAnalyzePhoto
                : photo.reason);
        _inputMode = _InputMode.manual;
        _isAnalyzingPhoto = false;
      });
      if (photo.isTechnicalError) {
        _trackMealPhotoTechnicalError(
          stage: 'resume_pending_result',
          rawError: photo.rawError,
        );
      }
    } catch (error) {
      _trackMealPhotoTechnicalError(
        stage: 'resume_pending_exception',
        rawError: error,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _analysisReason = MealPhotoService.technicalErrorMessage;
        _isAnalyzingPhoto = false;
      });
    }
  }

  void _trackMealPhotoTechnicalError({
    required String stage,
    required Object? rawError,
    ImageSource? pickerSource,
  }) {
    final raw = rawError?.toString().trim() ?? '';
    ref.read(analyticsServiceProvider).capture(
      eventName: 'meal_photo_analysis_technical_error',
      properties: {
        'source': 'meals_log',
        'stage': stage,
        'is_editing': _isEditing,
        'picker_source': pickerSource == null
            ? 'unknown'
            : pickerSource == ImageSource.camera
                ? 'camera'
                : 'library',
        'raw_error': raw,
        'error_type': rawError?.runtimeType.toString() ?? 'unknown',
      },
    );
  }

  void _applySnapMacroResult(Map<String, dynamic> meal) {
    _titleController.text = (meal['name'] as String? ?? '').trim();
    _caloriesController.text = _formatNum(meal['calories']);
    _carbsController.text = _formatNum(meal['carbs']);
    _proteinsController.text = _formatNum(meal['proteins']);
    _fatsController.text = _formatNum(meal['fats']);
    _fiberController.text = _formatNum(meal['fiber']);
    final note = (meal['note'] as String? ?? '').trim();
    _notesController.text = note;
    _isNotesExpanded = note.isNotEmpty;
  }

  Future<void> _handleSheetDismissed() async {
    if (_isRecording) {
      try {
        await _audioRecorder.stop();
      } catch (_) {
        // Best-effort cleanup for abandoned recordings.
      }
    }
    _discardPendingAudio();
    if (_didSave) {
      return;
    }
    final draftImagePath = _draftImagePath;
    if (draftImagePath == null ||
        draftImagePath.isEmpty ||
        draftImagePath == _originalImagePath) {
      return;
    }
    _draftImagePath = null;
    try {
      await ref
          .read(mealPhotoServiceProvider)
          .clearPendingAnalysisIfMatchesImagePath(draftImagePath);
      await ref.read(mealPhotoServiceProvider).deleteImage(draftImagePath);
    } catch (_) {
      // Best-effort cleanup for abandoned drafts.
    }
  }

  bool get _hasUnsavedPhotoDraft =>
      !_didSave &&
      (_draftImagePath?.isNotEmpty ?? false) &&
      _draftImagePath != _originalImagePath;

  Future<void> _confirmAndDismiss() async {
    if (!_hasUnsavedPhotoDraft) {
      if (mounted) Navigator.of(context).pop();
      return;
    }
    final discard = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.mealLogDiscardTitle),
        content: Text(context.l10n.mealLogDiscardMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(context.l10n.mealLogDiscard),
          ),
        ],
      ),
    );
    if (discard == true && mounted) {
      Navigator.of(context).pop();
    }
  }

  double _parseValue(TextEditingController c) =>
      double.tryParse(c.text.trim().replaceAll(',', '.')) ?? 0;

  bool get _hasAnyNutritionValue =>
      _parseValue(_caloriesController) > 0 ||
      _parseValue(_carbsController) > 0 ||
      _parseValue(_proteinsController) > 0 ||
      _parseValue(_fatsController) > 0 ||
      _parseValue(_fiberController) > 0;

  bool get _hasAnyManualDraft =>
      _titleController.text.trim() != _initialTitleValue.trim() ||
      _notesController.text.trim().isNotEmpty ||
      _hasAnyNutritionValue;

  Widget _buildBottomAction(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final slide = Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slide,
            child: child,
          ),
        );
      },
      child: _hasAnyNutritionValue
          ? SizedBox(
              key: const ValueKey('submit'),
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSubmitting ? null : _submit,
                child: Text(
                  _isSubmitting
                      ? context.l10n.mealLogSaving
                      : _isEditing
                          ? context.l10n.commonSave
                          : context.l10n.mealLogAddMealLog,
                ),
              ),
            )
          : _inputMode == _InputMode.manual && _hasAnyManualDraft
              ? SizedBox(
                  key: const ValueKey('manual_draft'),
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: null,
                    child: Text(
                      _isEditing
                          ? context.l10n.commonSave
                          : context.l10n.mealLogAddMealLog,
                    ),
                  ),
                )
              : _isAnalyzing
                  ? SizedBox(
                      key: const ValueKey('analyzing'),
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(context.l10n.mealLogAnalyzing),
                          ],
                        ),
                      ),
                    )
                  : _inputMode == _InputMode.text &&
                          _textInputController.text.trim().isNotEmpty
                      ? SizedBox(
                          key: const ValueKey('analyze_text'),
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _handleTextAnalyze,
                            child: Text(context.l10n.mealLogAnalyzeText),
                          ),
                        )
                      : _inputMode == _InputMode.camera
                          ? _ModeToggle(
                              key: const ValueKey('toggle'),
                              selectedMode: _inputMode,
                              isDisabled: _isAnalyzing || _isRecording,
                              onModeSelected: _handleModeSelected,
                              onLibraryTap: () =>
                                  _handlePickPhoto(ImageSource.gallery),
                            )
                          : _inputMode == _InputMode.audio &&
                                  _pendingAudioPath != null
                              ? SizedBox(
                                  key: const ValueKey('send_audio'),
                                  width: double.infinity,
                                  child: FilledButton(
                                    onPressed: _handleAudioAnalyze,
                                    child:
                                        Text(context.l10n.mealLogSendRecording),
                                  ),
                                )
                              : _ModeToggle(
                                  key: const ValueKey('toggle'),
                                  selectedMode: _inputMode,
                                  isDisabled: _isAnalyzing || _isRecording,
                                  onModeSelected: _handleModeSelected,
                                  onLibraryTap: () =>
                                      _handlePickPhoto(ImageSource.gallery),
                                ),
    );
  }

  Future<void> _submit() async {
    if (_isSubmitting || !_hasAnyNutritionValue) return;

    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final calories = _parseValue(_caloriesController);
    final carbs = _parseValue(_carbsController);
    final proteins = _parseValue(_proteinsController);
    final fats = _parseValue(_fatsController);
    final fiber = _parseValue(_fiberController);
    final title = _titleController.text.trim();
    final notes = _notesController.text.trim();
    final date = widget.selectedDate;
    final currentImagePath = (_draftImagePath?.trim().isNotEmpty ?? false)
        ? _draftImagePath!.trim()
        : ((_originalImagePath?.trim().isNotEmpty ?? false)
            ? _originalImagePath!.trim()
            : null);
    final usedPhoto = currentImagePath != null;

    final payload = {
      'logged_at': formatIsoWithTimezone(date),
      'name': title.isEmpty ? null : title,
      'image_path': currentImagePath,
      'calories': double.parse(calories.toStringAsFixed(1)),
      'carbs': double.parse(carbs.toStringAsFixed(1)),
      'proteins': double.parse(proteins.toStringAsFixed(1)),
      'fats': double.parse(fats.toStringAsFixed(1)),
      'fiber': double.parse(fiber.toStringAsFixed(1)),
      'consumed': _consumed,
      'notes': notes.isEmpty ? null : notes,
    };

    try {
      ref.read(analyticsServiceProvider).capture(
        eventName: 'meal_logged',
        properties: {
          'source': 'meals_log',
          'method': usedPhoto ? 'photo' : 'manual',
          'is_editing': _isEditing,
          'has_notes': notes.isNotEmpty,
          'has_image_path': currentImagePath != null,
          'consumed': _consumed,
          'logged_date': DateUtils.dateOnly(date).toIso8601String(),
        },
      );
      final service = ref.read(recordServiceProvider);
      final existingId = widget.existingEntry?['id'] as String?;
      if (_isEditing && existingId != null) {
        await service.updateRecordEntry(
            RecordService.mealsColumn, existingId, payload);
      } else {
        await service.updateRecord(RecordService.mealsColumn, payload);
      }
      ref.invalidate(_mealLogsProvider(date));
      ref.invalidate(_mealWeekDatesProvider(date));
      ref.invalidate(_allMealLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      _didSave = true;
      if (_originalImagePath != null &&
          _originalImagePath!.isNotEmpty &&
          _draftImagePath != null &&
          _draftImagePath != _originalImagePath) {
        unawaited(
          ref.read(mealPhotoServiceProvider).deleteImage(_originalImagePath!),
        );
      }
      if (!mounted) return;

      final summary = calories > 0
          ? context.l10n.mealLogKcalLogged(calories.round())
          : () {
              final dominant = [
                MapEntry('protein', proteins),
                MapEntry('carbs', carbs),
                MapEntry('fat', fats),
              ]..sort((a, b) => b.value.compareTo(a.value));
              final top = dominant.first;
              final macroLabel = switch (top.key) {
                'protein' => context.l10n.mealLogProteins,
                'carbs' => context.l10n.mealLogCarbs,
                'fat' => context.l10n.mealLogFats,
                _ => context.l10n.mealLogMealDefaultName,
              };
              return context.l10n.mealLogMacroLogged(
                top.value.round(),
                macroLabel,
              );
            }();

      widget.onSaved(date);
      Navigator.of(context).pop(summary);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(context.l10n.mealLogCouldNotSave),
          behavior: SnackBarBehavior.floating,
        ));
    }
  }

  Future<void> _deleteEntry() async {
    final entryId = widget.existingEntry?['id'] as String?;
    if (!_isEditing || _isSubmitting || _isAnalyzing || entryId == null) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.mealLogDeleteTitle),
        content: Text(context.l10n.mealLogDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(context.l10n.mealLogDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;

    HapticFeedback.lightImpact();
    setState(() => _isSubmitting = true);

    final imagePaths = {
      if (_originalImagePath?.trim().isNotEmpty ?? false)
        _originalImagePath!.trim(),
      if (_draftImagePath?.trim().isNotEmpty ?? false) _draftImagePath!.trim(),
    };

    try {
      await ref
          .read(recordServiceProvider)
          .deleteRecordEntry(RecordService.mealsColumn, entryId);
      for (final imagePath in imagePaths) {
        await ref
            .read(mealPhotoServiceProvider)
            .clearPendingAnalysisIfMatchesImagePath(imagePath);
        await ref.read(mealPhotoServiceProvider).deleteImage(imagePath);
      }
      ref.invalidate(_mealLogsProvider(widget.selectedDate));
      ref.invalidate(_mealWeekDatesProvider(widget.selectedDate));
      ref.invalidate(_allMealLogsProvider(0));
      ref.read(appRefreshProvider).recordsChanged();
      _didSave = true;
      if (!mounted) return;
      widget.onSaved(widget.selectedDate);
      Navigator.of(context).pop(context.l10n.mealLogDeleted);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(
          content: Text(context.l10n.mealLogCouldNotDelete),
          behavior: SnackBarBehavior.floating,
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final viewInsets = MediaQuery.viewInsetsOf(context);

    return PopScope(
      canPop: !_isSubmitting &&
          !_isAnalyzing &&
          !_isRecording &&
          !_hasUnsavedPhotoDraft,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          unawaited(_handleSheetDismissed());
        } else if (!_isSubmitting && !_isAnalyzing && !_isRecording) {
          unawaited(_confirmAndDismiss());
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: colors.canvas,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              const SizedBox(height: 12),
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.lineSubtle,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Sheet title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEditing
                              ? context.l10n.mealLogEditTitle
                              : context.l10n.mealLogLogTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _friendlyDate(context, widget.selectedDate),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkResponse(
                      onTap: _isSubmitting || _isAnalyzing || _isRecording
                          ? null
                          : _confirmAndDismiss,
                      radius: 18,
                      child: Icon(Icons.close_rounded,
                          size: 20, color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Form content
              Flexible(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: _isAnalyzing
                      ? const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: _MealPhotoProcessingCard(),
                          ),
                        )
                      : _inputMode == _InputMode.text && !_hasAnyNutritionValue
                  ? _TextInputArea(controller: _textInputController)
                          : _inputMode == _InputMode.camera &&
                                  !_hasAnyNutritionValue
                              ? _CameraInputArea(
                                  onTakePhoto: () =>
                                      _handlePickPhoto(ImageSource.camera),
                                )
                              : _inputMode == _InputMode.audio &&
                                      !_hasAnyNutritionValue
                              ? _AudioRecordArea(
                                  isRecording: _isRecording,
                                  hasRecording: _pendingAudioPath != null,
                                  elapsed: _recordingElapsed,
                                  onStart: _handleStartRecording,
                                  onStop: _handleStopRecording,
                                )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (_draftImageBytes != null ||
                                            _imagePreviewUrl != null) ...[
                                          _MealPhotoPreview(
                                            imageBytes: _draftImageBytes,
                                            imageUrl: _imagePreviewUrl,
                                          ),
                                          const SizedBox(height: 12),
                                        ],
                                        if (_analysisReason case final reason?
                                            when reason.trim().isNotEmpty) ...[
                                          _MealPhotoReasonBadge(reason: reason),
                                          const SizedBox(height: 12),
                                        ],
                                        _MealHeaderRow(
                                          titleController: _titleController,
                                          caloriesController:
                                              _caloriesController,
                                          consumed: _consumed,
                                        ),
                                        const SizedBox(height: 14),
                                        Row(
                                          children: [
                                            _NutritionInputCard(
                                              icon: Icons.rice_bowl_rounded,
                                              title: context.l10n.mealLogCarbs,
                                              unit: 'g',
                                              tint: colors.carbs
                                                  .withValues(alpha: 0.18),
                                              controller: _carbsController,
                                              consumed: _consumed,
                                            ),
                                            const SizedBox(width: 6),
                                            _NutritionInputCard(
                                              icon: Icons.fitness_center_rounded,
                                              title: context.l10n.mealLogProteins,
                                              unit: 'g',
                                              tint: colors.protein
                                                  .withValues(alpha: 0.18),
                                              controller: _proteinsController,
                                              consumed: _consumed,
                                            ),
                                            const SizedBox(width: 6),
                                            _NutritionInputCard(
                                              icon: Icons.opacity_rounded,
                                              title: context.l10n.mealLogFats,
                                              unit: 'g',
                                              tint: colors.fat
                                                  .withValues(alpha: 0.18),
                                              controller: _fatsController,
                                              consumed: _consumed,
                                            ),
                                            const SizedBox(width: 6),
                                            _NutritionInputCard(
                                              icon: Icons.eco_rounded,
                                              title: context.l10n.mealLogFiber,
                                              unit: 'g',
                                              tint: colors.fiber
                                                  .withValues(alpha: 0.18),
                                              controller: _fiberController,
                                              consumed: _consumed,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        _MealConsumedSelector(
                                          value: _consumed,
                                          onChanged: (value) {
                                            HapticFeedback.selectionClick();
                                            setState(() => _consumed = value);
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        _NotesCard(
                                          controller: _notesController,
                                          isExpanded: _isNotesExpanded,
                                          onToggle: () {
                                            HapticFeedback.selectionClick();
                                            setState(
                                              () => _isNotesExpanded =
                                                  !_isNotesExpanded,
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 24),
                                        if (_isEditing) ...[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton.icon(
                                              onPressed: (_isSubmitting ||
                                                      _isAnalyzing)
                                                  ? null
                                                  : _deleteEntry,
                                              icon: const Icon(
                                                  Icons.delete_outline_rounded),
                                              label: Text(
                                                context.l10n.mealLogDeleteLog,
                                              ),
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.red,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                        ],
                                      ],
                                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: _buildBottomAction(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MealHeaderRow extends StatelessWidget {
  const _MealHeaderRow({
    required this.titleController,
    required this.caloriesController,
    required this.consumed,
  });

  final TextEditingController titleController;
  final TextEditingController caloriesController;
  final double consumed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextField(
            controller: titleController,
            maxLines: 2,
            minLines: 1,
            style: theme.textTheme.titleLarge?.copyWith(
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colors.lineSubtle, width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: colors.textSecondary.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              hintText: context.l10n.mealLogMealNameHint,
              hintStyle: theme.textTheme.titleLarge?.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: colors.accentButter.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicWidth(
                        child: TextField(
                          controller: caloriesController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.left,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: colors.textPrimary,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: colors.lineSubtle,
                                width: 1,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: colors.textSecondary.withValues(
                                  alpha: 0.4,
                                ),
                                width: 1,
                              ),
                            ),
                            contentPadding: EdgeInsets.zero,
                            hintText: '0',
                            hintStyle: theme.textTheme.titleMedium?.copyWith(
                              color: colors.textSecondary.withValues(
                                alpha: 0.4,
                              ),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 24,
                              maxWidth: 72,
                            ),
                          ),
                        ),
                      ),
                      if (consumed != 1.0) ...[
                        const SizedBox(height: 4),
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: caloriesController,
                          builder: (context, value, _) {
                            final parsed = double.tryParse(
                                  value.text.trim().replaceAll(',', '.'),
                                ) ??
                                0;
                            return Text(
                              _formatConsumedValue(parsed * consumed),
                              textAlign: TextAlign.left,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colors.textSecondary,
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(width: 3),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      context.l10n.mealLogKcalUnit,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MealPhotoPreview extends StatelessWidget {
  const _MealPhotoPreview({
    this.imageBytes,
    this.imageUrl,
  });

  final Uint8List? imageBytes;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    final child = imageBytes != null
        ? Image.memory(
            imageBytes!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        : imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              )
            : const SizedBox.shrink();

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          color: colors.softSurface,
          child: child,
        ),
      ),
    );
  }
}

class _MealPhotoReasonBadge extends StatelessWidget {
  const _MealPhotoReasonBadge({
    required this.reason,
  });

  final String reason;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.accentPeach.withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.accentPeach.withValues(alpha: 0.55),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.mealLogCouldNotPrefillTitle,
            style: theme.textTheme.labelLarge?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            reason,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MealConsumedSelector extends StatelessWidget {
  const _MealConsumedSelector({
    required this.value,
    required this.onChanged,
  });

  final double value;
  final ValueChanged<double> onChanged;

  static const _options = <(double, String)>[
    (0.25, '25%'),
    (0.5, '50%'),
    (0.75, '75%'),
    (1.0, '100%'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.mealLogHowMuchDidYouEat,
          style: theme.textTheme.labelLarge?.copyWith(
            color: colors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            for (var i = 0; i < _options.length; i++) ...[
              Expanded(
                child: _ConsumedOptionChip(
                  label: _options[i].$2,
                  selected: value == _options[i].$1,
                  onTap: () => onChanged(_options[i].$1),
                ),
              ),
              if (i != _options.length - 1) const SizedBox(width: 8),
            ],
          ],
        ),
      ],
    );
  }
}

class _ConsumedOptionChip extends StatelessWidget {
  const _ConsumedOptionChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Material(
      color: selected ? colors.textPrimary : colors.surface,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.lineSubtle),
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected ? colors.canvas : colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

String _formatConsumedValue(double value) {
  final roundedInt = value.roundToDouble();
  if ((value - roundedInt).abs() < 0.05) {
    return roundedInt.toInt().toString();
  }
  return value.toStringAsFixed(1);
}

class _MealPhotoProcessingCard extends StatelessWidget {
  const _MealPhotoProcessingCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colors.softSurface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.lineSubtle,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            height: 22,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.accentSky.withValues(alpha: 0.25),
                      width: 2.5,
                    ),
                  ),
                ),
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.heroEnd,
                      width: 2.5,
                    ),
                  ),
                )
                    .animate(
                      onPlay: (controller) => controller.repeat(),
                    )
                    .rotate(duration: 900.ms),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.mealLogAnalyzingYourMealTitle,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  context.l10n.mealLogAnalyzingYourMealBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(
          onPlay: (controller) => controller.repeat(reverse: true),
        )
        .shimmer(
          duration: 1200.ms,
          color: colors.accentSky.withValues(alpha: 0.10),
        );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({
    super.key,
    required this.selectedMode,
    required this.isDisabled,
    required this.onModeSelected,
    required this.onLibraryTap,
  });

  final _InputMode selectedMode;
  final bool isDisabled;
  final ValueChanged<_InputMode> onModeSelected;
  final VoidCallback onLibraryTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      children: [
        Expanded(
          child: _ModeToggleButton(
            icon: Icons.edit_rounded,
            selected: selectedMode == _InputMode.manual,
            disabled: isDisabled,
            onTap: () => onModeSelected(_InputMode.manual),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ModeToggleButton(
            icon: Icons.photo_library_rounded,
            disabled: isDisabled,
            onTap: onLibraryTap,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ModeToggleButton(
            icon: Icons.camera_alt_rounded,
            selected: selectedMode == _InputMode.camera,
            disabled: isDisabled,
            onTap: () => onModeSelected(_InputMode.camera),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ModeToggleButton(
            icon: Icons.text_fields_rounded,
            selected: selectedMode == _InputMode.text,
            disabled: isDisabled,
            onTap: () => onModeSelected(_InputMode.text),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ModeToggleButton(
            icon: Icons.mic_rounded,
            selected: selectedMode == _InputMode.audio,
            disabled: isDisabled,
            onTap: () => onModeSelected(_InputMode.audio),
          ),
        ),
      ],
    );
  }
}

class _ModeToggleButton extends StatelessWidget {
  const _ModeToggleButton({
    required this.icon,
    required this.onTap,
    this.selected = false,
    this.disabled = false,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool selected;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Material(
      color: selected ? colors.textPrimary : colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: disabled ? null : onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? colors.textPrimary : colors.lineSubtle,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: selected ? colors.canvas : colors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _TextInputArea extends StatelessWidget {
  const _TextInputArea({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.mealLogDescribeYourMealTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            context.l10n.mealLogDescribeYourMealBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: controller,
            maxLength: _mealTextInputMaxChars,
            maxLines: 4,
            minLines: 4,
            textCapitalization: TextCapitalization.sentences,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: context.l10n.mealLogDescribeYourMealHint,
              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                color: colors.textSecondary.withValues(alpha: 0.6),
              ),
              filled: true,
              fillColor: colors.softSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: colors.lineSubtle),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: colors.lineSubtle),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: colors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CameraInputArea extends StatelessWidget {
  const _CameraInputArea({
    required this.onTakePhoto,
  });

  final VoidCallback onTakePhoto;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colors.softSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              size: 32,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.mealLogCaptureYourMealTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.mealLogCaptureYourMealBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onTakePhoto,
              icon: const Icon(Icons.camera_alt_rounded),
              label: Text(context.l10n.mealLogTakePhoto),
            ),
          ),
        ],
      ),
    );
  }
}

class _AudioRecordArea extends StatelessWidget {
  const _AudioRecordArea({
    required this.isRecording,
    required this.hasRecording,
    required this.elapsed,
    required this.onStart,
    required this.onStop,
  });

  final bool isRecording;
  final bool hasRecording;
  final Duration elapsed;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final progress = isRecording
        ? (elapsed.inMilliseconds / _mealAudioMaxDuration.inMilliseconds)
            .clamp(0.0, 1.0)
        : 0.0;
    final remaining = _mealAudioMaxDuration - elapsed;
    final isWarning = isRecording && remaining.inSeconds <= 10;
    final remainingText = _formatRecordingDuration(
      remaining.isNegative ? Duration.zero : remaining,
    );
    final elapsedText = _formatRecordingDuration(elapsed);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 88,
            height: 88,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 88,
                  height: 88,
                  child: CircularProgressIndicator(
                    value: isRecording ? progress : 0.0,
                    strokeWidth: 6,
                    backgroundColor: colors.lineSubtle,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isWarning ? const Color(0xFFE07A5F) : colors.accentPeach,
                    ),
                  ),
                ),
                Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: isRecording
                        ? (isWarning
                            ? const Color(0xFFE07A5F).withValues(alpha: 0.18)
                            : colors.accentPeach.withValues(alpha: 0.18))
                        : colors.softSurface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isRecording ? Icons.mic_rounded : Icons.graphic_eq_rounded,
                    size: 30,
                    color: colors.textPrimary,
                  ),
                ),
                if (isRecording)
                  Positioned(
                    bottom: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colors.canvas,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colors.lineSubtle),
                      ),
                      child: Text(
                        elapsedText,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isRecording
                ? context.l10n.mealLogRecordingYourMealTitle
                : hasRecording
                    ? context.l10n.mealLogRecordingReadyTitle
                    : context.l10n.mealLogRecordMealDescriptionTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isRecording
                ? context.l10n.mealLogRecordingTapStopBody(remainingText)
                : hasRecording
                    ? context.l10n.mealLogRecordingReadyBody
                    : context.l10n.mealLogRecordMealDescriptionBody,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: isRecording ? onStop : onStart,
              icon: Icon(
                isRecording ? Icons.stop_circle_rounded : Icons.mic_rounded,
              ),
              label: Text(
                isRecording
                    ? context.l10n.mealLogStopRecording
                    : hasRecording
                        ? context.l10n.mealLogRecordAgain
                        : context.l10n.mealLogStartRecording,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatRecordingDuration(Duration duration) {
  final totalSeconds = duration.inSeconds.clamp(0, 5999);
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

class _NutritionInputCard extends StatelessWidget {
  const _NutritionInputCard({
    required this.icon,
    required this.title,
    required this.unit,
    required this.tint,
    required this.controller,
    required this.consumed,
  });

  final IconData icon;
  final String title;
  final String unit;
  final Color tint;
  final TextEditingController controller;
  final double consumed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

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
                icon,
                size: 14,
                color: HSLColor.fromColor(tint)
                    .withLightness(0.46)
                    .toColor()
                    .withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleSmall?.copyWith(
                color: colors.textPrimary,
              ),
              decoration: InputDecoration(
                isCollapsed: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: colors.lineSubtle, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.textSecondary.withValues(alpha: 0.4),
                    width: 1,
                  ),
                ),
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: '0',
                hintStyle: theme.textTheme.titleSmall?.copyWith(
                  color: colors.textSecondary.withValues(alpha: 0.4),
                ),
                suffixText: unit,
                suffixStyle: theme.textTheme.labelSmall?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
            if (consumed != 1.0) ...[
              const SizedBox(height: 6),
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, _) {
                  final parsed = double.tryParse(
                        value.text.trim().replaceAll(',', '.'),
                      ) ??
                      0;
                  return Text(
                    _formatConsumedValue(parsed * consumed),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  const _NotesCard({
    required this.controller,
    required this.isExpanded,
    required this.onToggle,
  });

  final TextEditingController controller;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.edit_note_rounded,
              size: 16,
              color: colors.textSecondary.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 6),
            Text(
              context.l10n.mealLogNotes,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.textSecondary,
              ),
            ),
            const Spacer(),
            InlineNotesTrigger(
              value: controller.text.trim(),
              isExpanded: isExpanded,
              onTap: onToggle,
            ),
          ],
        ),
        if (isExpanded) ...[
          const SizedBox(height: 8),
          ExpandedNotesField(
            controller: controller,
            hintText: context.l10n.mealLogAnythingWorthRemembering,
            margin: EdgeInsets.zero,
            borderRadius: 20,
          ),
        ],
      ],
    );
  }
}

class _MealsLogSuccessOverlay extends StatelessWidget {
  const _MealsLogSuccessOverlay({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return LogSuccessOverlay(
      title: label,
      subtitle: context.l10n.mealLogAddedToMealLog,
      icons: [
        SuccessOverlayIconSpec(
          icon: Icons.local_fire_department_rounded,
          color: colors.accentPeach,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.rice_bowl_rounded,
          color: colors.carbs,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.fitness_center_rounded,
          color: colors.protein,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.eco_rounded,
          color: colors.fiber,
        ),
        SuccessOverlayIconSpec(
          icon: Icons.icecream_rounded,
          color: colors.accentButter,
        ),
      ],
      rippleColor: colors.accentButter,
    );
  }
}

class _LoggedMealsSection extends ConsumerWidget {
  const _LoggedMealsSection({required this.date, required this.onEditEntry});

  final DateTime date;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final state = ref.watch(_mealLogsProvider(date));

    return state.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (meals) {
        if (meals.isEmpty) return const SizedBox.shrink();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formatLoggedSectionDate(context, date),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.softSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${meals.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...meals.map((meal) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _LoggedMealCard(
                      meal: meal, onTap: () => onEditEntry(meal)),
                )),
          ],
        );
      },
    );
  }
}

class _MealLogListSection extends StatelessWidget {
  const _MealLogListSection({
    required this.entries,
    required this.onEditEntry,
  });

  final List<Map<String, dynamic>> entries;
  final ValueChanged<Map<String, dynamic>> onEditEntry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    if (entries.isEmpty) {
      return Center(
        child: Text(
          context.l10n.progressNoLogsYet,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      );
    }

    final grouped = <DateTime, List<Map<String, dynamic>>>{};
    for (final entry in entries) {
      final loggedAt = DateTime.tryParse(entry['logged_at'] as String? ?? '');
      if (loggedAt == null) continue;
      final day = dateOnly(loggedAt.toLocal());
      grouped.putIfAbsent(day, () => <Map<String, dynamic>>[]).add(entry);
    }

    final days = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      itemCount: days.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (context, index) {
        final day = days[index];
        final dayMeals = grouped[day]!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formatLoggedSectionDate(context, day),
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.softSurface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${dayMeals.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...dayMeals.map(
              (meal) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _LoggedMealCard(
                  meal: meal,
                  onTap: () => onEditEntry(meal),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoggedMealCard extends ConsumerWidget {
  const _LoggedMealCard({required this.meal, required this.onTap});

  final Map<String, dynamic> meal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final name = meal['name'] as String? ?? context.l10n.mealLogMealDefaultName;
    final imagePath = (meal['image_path'] as String?)?.trim();
    final consumed = ((meal['consumed'] as num?)?.toDouble() ?? 1.0).clamp(
      0.25,
      1.0,
    );
    final calories = ((meal['calories'] as num?)?.toDouble() ?? 0) * consumed;
    final carbs = ((meal['carbs'] as num?)?.toDouble() ?? 0) * consumed;
    final proteins = ((meal['proteins'] as num?)?.toDouble() ?? 0) * consumed;
    final fats = ((meal['fats'] as num?)?.toDouble() ?? 0) * consumed;
    final fiber = ((meal['fiber'] as num?)?.toDouble() ?? 0) * consumed;
    final notes = (meal['notes'] as String?)?.trim();
    final hasNotes = notes != null && notes.isNotEmpty;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.lineSubtle),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _LoggedMealThumbnail(
              imagePath: imagePath,
              mealPhotoService: ref.read(mealPhotoServiceProvider),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasNotes) ...[
                        const SizedBox(width: 8),
                        LogNoteIndicator(color: colors.textSecondary),
                      ],
                      if (calories > 0) ...[
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.mealLogKcal(calories.round()),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 5),
                  _MacroRow(
                    carbs: carbs,
                    proteins: proteins,
                    fats: fats,
                    fiber: fiber,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: colors.textSecondary.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoggedMealThumbnail extends StatelessWidget {
  const _LoggedMealThumbnail({
    required this.imagePath,
    required this.mealPhotoService,
  });

  final String? imagePath;
  final MealPhotoService mealPhotoService;

  @override
  Widget build(BuildContext context) {
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    if (!hasImage) {
      return const _LoggedMealFallbackIcon();
    }

    return FutureBuilder<String>(
      future: mealPhotoService.createSignedUrl(imagePath!),
      builder: (context, snapshot) {
        final url = snapshot.data;
        if (url == null || url.isEmpty) {
          return const _LoggedMealFallbackIcon();
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            url,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const _LoggedMealFallbackIcon(),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const _LoggedMealFallbackIcon();
            },
          ),
        );
      },
    );
  }
}

class _LoggedMealFallbackIcon extends StatelessWidget {
  const _LoggedMealFallbackIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFFFAA5B).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.restaurant_menu_rounded,
        size: 18,
        color: HSLColor.fromColor(const Color(0xFFFFAA5B))
            .withLightness(0.46)
            .toColor()
            .withValues(alpha: 0.8),
      ),
    );
  }
}

class _MacroRow extends StatelessWidget {
  const _MacroRow({
    required this.carbs,
    required this.proteins,
    required this.fats,
    required this.fiber,
  });

  final double carbs;
  final double proteins;
  final double fats;
  final double fiber;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    final macros = [
      (Icons.rice_bowl_rounded, carbs, colors.carbs),
      (Icons.fitness_center_rounded, proteins, colors.protein),
      (Icons.opacity_rounded, fats, colors.fat),
      (Icons.eco_rounded, fiber, colors.fiber),
    ].where((m) => m.$2 > 0).toList();

    if (macros.isEmpty) return const SizedBox.shrink();

    return Row(
      children: macros
          .expand((m) => [
                Icon(m.$1, size: 13, color: m.$3),
                const SizedBox(width: 3),
                Text(
                  '${m.$2.round()}g',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(width: 10),
              ])
          .toList(),
    );
  }
}
