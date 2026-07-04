import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../l10n/l10n.dart';
import '../../models/app_profile.dart';
import '../../models/goals.dart';
import '../../models/medication_catalog.dart';
import '../../models/symptom_catalog.dart';
import '../../providers/analytics_provider.dart';
import '../../providers/profile_provider.dart';
import '../../providers/profile_service_provider.dart';
import '../../providers/reminder_service_provider.dart';
import '../payment/payment_screen.dart';
import '../../theme/app_colors.dart';
import '../../widgets/bmi_indicator.dart';
import '../../widgets/custom_dose_slider.dart';
import '../../widgets/height_ruler_selector.dart';
import '../../widgets/weight_dial_selector.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.profile,
  });

  final AppProfile profile;

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  static const _medicationStatusKey = 'medication_status';
  static const _medicationMethodKey = 'medication_method';
  static const _medicationNameKey = 'medication_name';
  static const _currentDoseMgKey = 'current_dose_mg';
  static const _deviceTypeKey = 'device_type';
  static const _medicationFrequencyKey = 'medication_frequency';
  static const _medicationFrequencyDaysKey =
      'medication_frequency_days_between_doses';
  static const _primaryGoalKey = 'primary_goal';
  static const _genderKey = 'gender';
  static const _ageKey = 'age';
  static const _heightKey = 'height';
  static const _weightKey = 'weight';
  static const _medicationStartedAtKey = 'medication_started_at';
  static const _medicationStartWeightKey = 'medication_start_weight';
  static const _goalWeightKey = 'goal_weight';
  static const _benefitsSeenAtKey = 'onboarding_benefits_seen_at';
  static const _notificationsPromptedAtKey = 'notifications_prompted_at';
  static const _notificationsPermissionStatusKey =
      'notifications_permission_status';
  static const _reviewPromptedAtKey = 'onboarding_review_prompted_at';
  static const _dailyRoutineKey = 'daily_routine';
  static const _symptomConcernsKey = 'symptom_concerns';
  static const _preferredNameKey = 'preferred_name';
  static const _setupSummarySeenAtKey = 'onboarding_setup_summary_seen_at';
  static const _onboardingStartedAtKey = 'onboarding_started_at';
  static const _onboardingCompletedAtKey = 'onboarding_completed_at';
  static const _measurementUnitKey = 'measurement_unit';
  static const _otherMedicationValue = '__other__';
  static const _otherDeviceValue = '__other_device__';
  static const _otherGenderValue = '__other_gender__';
  static const _customDoseValue = '__custom_dose__';

  static const _medicationStatusUsing = 'using';
  static const _medicationStatusWeaningOff = 'weaning_off';

  final TextEditingController _customFrequencyController =
      TextEditingController();
  final TextEditingController _preferredNameController =
      TextEditingController();
  final TextEditingController _otherMedicationController =
      TextEditingController();
  final FocusNode _otherMedicationFocusNode = FocusNode();
  final TextEditingController _otherDeviceController = TextEditingController();
  final FocusNode _otherDeviceFocusNode = FocusNode();
  final TextEditingController _otherGenderController = TextEditingController();
  final FocusNode _otherGenderFocusNode = FocusNode();
  final FocusNode _customFrequencyFocusNode = FocusNode();

  late Map<String, dynamic> _draftSettings;
  late int _currentStepIndex;
  late bool _welcomeCompleted;
  late bool _goalWeightCompleted;
  bool _isSubmitting = false;
  bool _welcomeCtaVisible = false;
  bool _setupSummaryCtaVisible = false;
  bool _isCustomDoseSelected = false;
  bool _reviewRequestTriggered = false;
  bool _weightInteracted = false;
  String? _lastTrackedStepViewKey;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _draftSettings = Map<String, dynamic>.from(widget.profile.settings);
    _normalizeCatalogBackedDraftValues();
    _ensureDefaultDraftValues();
    _welcomeCompleted = _draftSettings[_onboardingStartedAtKey] != null;
    _goalWeightCompleted = widget.profile.goals.weight.current != null;
    _currentStepIndex = _firstIncompleteStepIndex(_activeSteps);
    _welcomeCtaVisible = _currentStep.id != 'welcome';
    _setupSummaryCtaVisible = _currentStep.id != 'setup_summary';
    _syncControllers();
    _reviewRequestTriggered = _draftSettings[_reviewPromptedAtKey] != null;
    _maybeTriggerReviewPrompt();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _trackCurrentStepView();
    });
  }

  @override
  void didUpdateWidget(covariant OnboardingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.profile.settings != widget.profile.settings) {
      _draftSettings = Map<String, dynamic>.from(widget.profile.settings);
      _normalizeCatalogBackedDraftValues();
      _ensureDefaultDraftValues();
      _welcomeCompleted = _draftSettings[_onboardingStartedAtKey] != null;
      _goalWeightCompleted = widget.profile.goals.weight.current != null;
      _currentStepIndex = _firstIncompleteStepIndex(_activeSteps);
      _welcomeCtaVisible = _currentStep.id != 'welcome';
      _setupSummaryCtaVisible = _currentStep.id != 'setup_summary';
      _syncControllers();
      _reviewRequestTriggered = _draftSettings[_reviewPromptedAtKey] != null;
      _maybeTriggerReviewPrompt();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _trackCurrentStepView();
      });
    }
  }

  void _normalizeCatalogBackedDraftValues() {
    _draftSettings[_symptomConcernsKey] = SymptomCatalog.normalizeValues(
      (_draftSettings[_symptomConcernsKey] as List?) ?? const [],
    );
  }

  void _maybeTriggerReviewPrompt() {
    if (_currentStep.id != 'review_prompt' || _reviewRequestTriggered) {
      return;
    }
    _reviewRequestTriggered = true;
    _trackEvent('onboarding_review_prompt_shown');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      _requestAppReview();
    });
  }

  @override
  void dispose() {
    _customFrequencyController.dispose();
    _preferredNameController.dispose();
    _otherMedicationController.dispose();
    _otherMedicationFocusNode.dispose();
    _otherDeviceController.dispose();
    _otherDeviceFocusNode.dispose();
    _otherGenderController.dispose();
    _otherGenderFocusNode.dispose();
    _customFrequencyFocusNode.dispose();
    super.dispose();
  }

  List<_OnboardingStep> get _activeSteps {
    final medicationStatus = _draftSettings[_medicationStatusKey] as String?;
    final medicationAwareStatus = _isMedicationAwareStatus(medicationStatus);
    final nonMedicationPath = _isNonMedicationPath(medicationStatus);
    final shouldAskMedicationStarted =
        medicationAwareStatus || medicationStatus == 'recently_stopped';
    final medicationMethod = _draftSettings[_medicationMethodKey] as String?;
    final shouldAskMedicationName =
        medicationAwareStatus && medicationMethod != 'unknown';
    final shouldAskCurrentDose =
        medicationAwareStatus && medicationMethod != 'unknown';

    return [
      const _OnboardingStep.welcome(),
      const _OnboardingStep(
        id: 'medication_status',
        question:
            'Are you currently taking a weight loss pen or pill medication?',
        explainer:
            'We use this to show guidance that matches where you are right now.',
        skippable: false,
      ),
      if (medicationAwareStatus) ...[
        const _OnboardingStep(
          id: 'medication_method',
          question: 'How do you take your medication?',
          explainer:
              'We use this to tailor instructions and reminders to your medication format.',
          skippable: false,
        ),
        if (shouldAskMedicationName)
          const _OnboardingStep(
            id: 'medication_name',
            question: 'Which medication are you taking?',
            explainer:
                'We use this to personalize dose tracking and medication-specific guidance.',
            skippable: false,
          ),
        if (shouldAskCurrentDose)
          const _OnboardingStep(
            id: 'current_dose_mg',
            question: 'What’s your current dose?',
            explainer:
                'We use this to tailor dose tracking and future progress check-ins.',
            skippable: false,
          ),
        const _OnboardingStep(
          id: 'device_type',
          question: 'What device do you use to take your medication?',
          explainer:
              'We use this to make reminders and tips match the way you take it.',
          skippable: false,
        ),
        const _OnboardingStep(
          id: 'medication_frequency',
          question: 'How often do you take your medication?',
          explainer:
              'We use this to time reminders and routine support around your schedule.',
          skippable: false,
        ),
      ],
      _OnboardingStep(
        id: 'primary_goal',
        question: 'What’s your primary goal right now?',
        explainer: medicationAwareStatus
            ? 'We use this to focus your plan, reminders, and progress around what matters most to you.'
            : nonMedicationPath
                ? 'We use this to shape your plan from the very beginning.'
                : 'We use this to support your next phase and help you stay on track.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'age',
        question: 'What’s your age?',
        explainer:
            'We use this to adjust guidance and health calculations more appropriately.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'height',
        question: 'What’s your height?',
        explainer:
            'We use this with your weight to calculate things like BMI and healthy ranges.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'weight',
        question: 'What’s your current weight?',
        explainer:
            'We use this as your starting point for progress, goals, and health estimates.',
        skippable: false,
      ),
      if (shouldAskMedicationStarted)
        _OnboardingStep(
          id: 'medication_started',
          question: medicationStatus == 'recently_stopped'
              ? 'When did you stop the medication?'
              : medicationStatus == _medicationStatusWeaningOff
                  ? 'When did you start weaning off the medication?'
                  : 'When did you start the medication?',
          explainer: medicationStatus == 'recently_stopped'
              ? 'We use this to understand your recent treatment history and next phase.'
              : medicationStatus == _medicationStatusWeaningOff
                  ? 'We use this to understand your transition phase and support the habits that matter most now.'
                  : 'We use this to understand how long you’ve been on treatment and track change over time.',
          skippable: false,
        ),
      const _OnboardingStep(
        id: 'goal_weight',
        question: 'What’s your goal weight?',
        explainer:
            'We use this to frame progress and show a target BMI range for you.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'benefits',
        question: 'What Glu will help you do next',
        explainer:
            'Glu turns what you shared into reminders, support, and structure that fit your routine.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'notifications_permission',
        question: 'Turn on reminders that support your goal',
        explainer:
            'We’ll use notifications to help you stay consistent, prepared, and on track.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'daily_routine',
        question: 'What’s your daily routine?',
        explainer:
            'We use this to make your plan feel realistic for your day-to-day life.',
        skippable: false,
      ),
      _OnboardingStep(
        id: 'symptom_concerns',
        question: 'Which symptoms are you most concerned about, if any?',
        explainer: medicationAwareStatus
            ? 'We use this to prioritize tips and guidance around the symptoms you care about most.'
            : 'We use this to focus on the symptoms you want to stay ahead of.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'gender',
        question: 'How do you describe your gender?',
        explainer:
            'We use this for more relevant guidance and future personalization.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'preferred_name',
        question: 'What should we call you?',
        explainer:
            'We use this to make Glu feel more personal when we talk to you.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'setup_summary',
        question: 'Setting up your plan',
        explainer:
            'We’re turning what you shared into a plan Glu can support right away.',
        skippable: false,
      ),
      const _OnboardingStep(
        id: 'review_prompt',
        question: 'People use Glu to stay steady and supported',
        explainer:
            'A quick rating helps more people find support that feels this simple.',
        skippable: false,
      ),
    ];
  }

  bool _isMedicationAwareStatus(String? medicationStatus) {
    return medicationStatus == _medicationStatusUsing ||
        medicationStatus == _medicationStatusWeaningOff;
  }

  bool _isNonMedicationPath(String? medicationStatus) {
    return medicationStatus == 'starting_soon' ||
        medicationStatus == 'not_taking';
  }

  _OnboardingStep get _currentStep => _activeSteps[_currentStepIndex];

  bool get _isWelcomeStep => _currentStep.id == 'welcome';

  bool get _isLastStep => _currentStepIndex == _activeSteps.length - 1;

  bool get _isCurrentStepActionEnabled {
    switch (_currentStep.id) {
      case 'welcome':
        return true;
      case 'setup_summary':
        return _setupSummaryCtaVisible;
      case 'medication_status':
        return (_draftSettings[_medicationStatusKey] as String?) != null;
      case 'medication_method':
        return (_draftSettings[_medicationMethodKey] as String?) != null;
      case 'medication_name':
        final medicationMethod =
            _draftSettings[_medicationMethodKey] as String?;
        if (_selectedMedicationValue(medicationMethod) ==
            _otherMedicationValue) {
          return _otherMedicationController.text.trim().isNotEmpty;
        }
        return (_draftSettings[_medicationNameKey] as String?) != null;
      case 'current_dose_mg':
        return _draftSettings[_currentDoseMgKey] != null;
      case 'device_type':
        if (_selectedDeviceValue == _otherDeviceValue) {
          return _otherDeviceController.text.trim().isNotEmpty;
        }
        return (_draftSettings[_deviceTypeKey] as String?) != null;
      case 'medication_frequency':
        final frequency = _draftSettings[_medicationFrequencyKey] as String?;
        if (frequency == null) {
          return false;
        }
        if (frequency != 'custom') {
          return true;
        }
        final days = int.tryParse(_customFrequencyController.text.trim());
        return days != null && days > 0;
      case 'primary_goal':
        return (_draftSettings[_primaryGoalKey] as String?) != null;
      case 'age':
        final age = (_draftSettings[_ageKey] as num?)?.toInt();
        return age != null && age >= 13 && age <= 100;
      case 'height':
        return _hasValidMeasurement(
          _draftSettings[_heightKey],
          allowedUnits: const {'metric', 'imperial'},
        );
      case 'weight':
        return _hasValidMeasurement(
          _draftSettings[_weightKey],
          allowedUnits: const {'kg', 'lb'},
        );
      case 'medication_started':
        final date = _draftSettings[_medicationStartedAtKey] as String?;
        return date != null &&
            _hasValidMeasurement(
              _draftSettings[_medicationStartWeightKey],
              allowedUnits: const {'kg', 'lb'},
            );
      case 'goal_weight':
        return _hasValidMeasurement(
          _draftSettings[_goalWeightKey] ?? _draftSettings[_weightKey],
          allowedUnits: const {'kg', 'lb'},
        );
      case 'benefits':
      case 'notifications_permission':
      case 'review_prompt':
        return true;
      case 'daily_routine':
        return (_draftSettings[_dailyRoutineKey] as String?) != null;
      case 'symptom_concerns':
        return true;
      case 'gender':
        if (_selectedGenderValue == _otherGenderValue) {
          return _otherGenderController.text.trim().isNotEmpty;
        }
        return (_draftSettings[_genderKey] as String?) != null;
      case 'preferred_name':
        return _preferredNameController.text.trim().isNotEmpty;
      default:
        return false;
    }
  }

  bool _hasValidMeasurement(
    dynamic value, {
    required Set<String> allowedUnits,
  }) {
    if (value is! Map) {
      return false;
    }
    final map = Map<String, dynamic>.from(value);
    final unit = map['unit']?.toString();
    final primary = map['primary']?.toString().trim();
    return unit != null &&
        allowedUnits.contains(unit) &&
        primary != null &&
        primary.isNotEmpty;
  }

  String? _currentStepInstruction(AppLocalizations l10n) {
    if (_currentStep.id == 'weight' || _currentStep.id == 'goal_weight') {
      return _weightInteracted ? null : l10n.onboardingDragTapOrUseWeight;
    }

    if (_isCurrentStepActionEnabled) {
      return null;
    }

    switch (_currentStep.id) {
      case 'medication_status':
      case 'medication_method':
      case 'current_dose_mg':
      case 'primary_goal':
      case 'daily_routine':
        return l10n.onboardingTapOptionContinue;
      case 'gender':
        if (_selectedGenderValue == _otherGenderValue) {
          return l10n.onboardingTypeGenderContinue;
        }
        return l10n.onboardingTapOptionContinue;
      case 'device_type':
        if (_selectedDeviceValue == _otherDeviceValue) {
          return l10n.onboardingTypeDeviceContinue;
        }
        return l10n.onboardingTapOptionContinue;
      case 'medication_name':
        final medicationMethod =
            _draftSettings[_medicationMethodKey] as String?;
        if (_selectedMedicationValue(medicationMethod) ==
            _otherMedicationValue) {
          return l10n.onboardingTypeMedicationContinue;
        }
        return l10n.onboardingTapOptionContinue;
      case 'medication_frequency':
        final frequency = _draftSettings[_medicationFrequencyKey] as String?;
        if (frequency == 'custom') {
          return l10n.onboardingEnterDaysBetweenDosesContinue;
        }
        return l10n.onboardingChooseScheduleContinue;
      case 'age':
        return l10n.onboardingScrollChooseAge;
      case 'height':
        return l10n.onboardingDragOrTapHeight;
      case 'weight':
      case 'goal_weight':
        return l10n.onboardingDragTapOrUseWeight;
      case 'medication_started':
        return l10n.onboardingPickDateAndWeight;
      case 'symptom_concerns':
        return l10n.onboardingSelectSymptoms;
      case 'preferred_name':
        return l10n.onboardingTypeName;
      default:
        return null;
    }
  }

  void _syncControllers() {
    final customFrequency = _draftSettings[_medicationFrequencyDaysKey];
    _customFrequencyController.text =
        customFrequency == null ? '' : '$customFrequency';

    final preferredName = _draftSettings[_preferredNameKey] as String?;
    _preferredNameController.text = preferredName ?? '';

    final medicationMethod = _draftSettings[_medicationMethodKey] as String?;
    final selectedMedication = _draftSettings[_medicationNameKey] as String?;
    final catalogOptions =
        MedicationCatalog.medicationsForMethod(medicationMethod).toSet();
    _otherMedicationController.text = selectedMedication != null &&
            !catalogOptions.contains(selectedMedication)
        ? selectedMedication
        : '';
    final normalizedDose = MedicationCatalog.normalizeDoseValue(
      _draftSettings[_currentDoseMgKey],
      medication: selectedMedication,
    );
    _isCustomDoseSelected = normalizedDose == null &&
        MedicationCatalog.coerceDoseValue(_draftSettings[_currentDoseMgKey]) !=
            null;

    final selectedDevice = _draftSettings[_deviceTypeKey] as String?;
    const knownDeviceOptions = {
      'Single pen',
      'Auto-injector',
      'Syringe and vial',
    };
    _otherDeviceController.text =
        selectedDevice != null && !knownDeviceOptions.contains(selectedDevice)
            ? selectedDevice
            : '';

    final selectedGender = _draftSettings[_genderKey] as String?;
    const knownGenderOptions = {
      'Female',
      'Male',
      'Prefer not to say',
    };
    _otherGenderController.text =
        selectedGender != null && !knownGenderOptions.contains(selectedGender)
            ? selectedGender
            : '';
  }

  void _ensureDefaultDraftValues() {}

  String? _selectedMedicationValue(String? method) {
    final selectedMedication = _draftSettings[_medicationNameKey] as String?;
    if (selectedMedication == null || selectedMedication.isEmpty) {
      return null;
    }
    final catalogOptions =
        MedicationCatalog.medicationsForMethod(method).toSet();
    return catalogOptions.contains(selectedMedication)
        ? selectedMedication
        : _otherMedicationValue;
  }

  String? get _selectedDeviceValue {
    final selectedDevice = _draftSettings[_deviceTypeKey] as String?;
    if (selectedDevice == null || selectedDevice.isEmpty) {
      return null;
    }
    switch (selectedDevice) {
      case 'Single pen':
      case 'Auto-injector':
      case 'Syringe and vial':
        return selectedDevice;
      default:
        return _otherDeviceValue;
    }
  }

  String? get _selectedGenderValue {
    final selectedGender = _draftSettings[_genderKey] as String?;
    if (selectedGender == null || selectedGender.isEmpty) {
      return null;
    }
    switch (selectedGender) {
      case 'Female':
      case 'Male':
      case 'Prefer not to say':
        return selectedGender;
      default:
        return _otherGenderValue;
    }
  }

  int _firstIncompleteStepIndex(List<_OnboardingStep> steps) {
    for (var index = 0; index < steps.length; index++) {
      if (!_isStepComplete(steps[index])) {
        return index;
      }
    }
    return 0;
  }

  bool _isStepComplete(_OnboardingStep step) {
    switch (step.id) {
      case 'welcome':
        return _welcomeCompleted ||
            _draftSettings[_onboardingStartedAtKey] != null;
      case 'medication_status':
        return _draftSettings.containsKey(_medicationStatusKey);
      case 'medication_method':
        return _draftSettings.containsKey(_medicationMethodKey);
      case 'medication_name':
        return _draftSettings.containsKey(_medicationNameKey);
      case 'current_dose_mg':
        return _draftSettings.containsKey(_currentDoseMgKey);
      case 'device_type':
        return _draftSettings.containsKey(_deviceTypeKey);
      case 'medication_frequency':
        return _draftSettings.containsKey(_medicationFrequencyKey);
      case 'primary_goal':
        return _draftSettings.containsKey(_primaryGoalKey);
      case 'gender':
        return _draftSettings.containsKey(_genderKey);
      case 'age':
        return _draftSettings.containsKey(_ageKey);
      case 'height':
        return _draftSettings.containsKey(_heightKey);
      case 'weight':
        return _draftSettings.containsKey(_weightKey);
      case 'medication_started':
        return _draftSettings.containsKey(_medicationStartedAtKey) ||
            _draftSettings.containsKey(_medicationStartWeightKey);
      case 'goal_weight':
        return _goalWeightCompleted ||
            _draftSettings.containsKey(_goalWeightKey);
      case 'benefits':
        return _draftSettings.containsKey(_benefitsSeenAtKey);
      case 'notifications_permission':
        return _draftSettings.containsKey(_notificationsPromptedAtKey);
      case 'setup_summary':
        return _draftSettings.containsKey(_setupSummarySeenAtKey);
      case 'review_prompt':
        return _draftSettings.containsKey(_reviewPromptedAtKey);
      case 'daily_routine':
        return _draftSettings.containsKey(_dailyRoutineKey);
      case 'symptom_concerns':
        return _draftSettings.containsKey(_symptomConcernsKey);
      case 'preferred_name':
        return _draftSettings.containsKey(_preferredNameKey);
      default:
        return false;
    }
  }

  Future<void> _submitCurrentStep({required bool skipped}) async {
    if (_isSubmitting) {
      return;
    }

    final patch =
        skipped ? _buildSkipPatch() : await _buildPatchForCurrentStepAsync();
    if (!skipped && patch == null) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      final effectivePatch = Map<String, dynamic>.from(patch ?? {});
      if (_isWelcomeStep &&
          !_draftSettings.containsKey(_onboardingStartedAtKey)) {
        effectivePatch[_onboardingStartedAtKey] =
            DateTime.now().toUtc().toIso8601String();
        _welcomeCompleted = true;
      }
      if (_isLastStep && !skipped) {
        effectivePatch[_onboardingCompletedAtKey] =
            DateTime.now().toUtc().toIso8601String();
        effectivePatch.putIfAbsent(
          _measurementUnitKey,
          () => (_draftSettings[_measurementUnitKey] as String?) ?? 'kg',
        );
      }

      if (_currentStep.id == 'goal_weight' && !skipped) {
        _draftSettings[_goalWeightKey] ??= _draftSettings[_weightKey];
        final updatedGoals = _updatedGoalsWithGoalWeight();
        await ref.read(profileServiceProvider).updateGoals(updatedGoals);
        _goalWeightCompleted = true;
      }
      if (effectivePatch.isNotEmpty) {
        await ref.read(profileServiceProvider).updateSettings(effectivePatch);
        _draftSettings.addAll(effectivePatch);
      }
      if (_isWelcomeStep && !skipped) {
        _trackEvent(
          'onboarding_started',
          properties: {
            'started_at': effectivePatch[_onboardingStartedAtKey],
          },
        );
      }
      if (_currentStep.id == 'notifications_permission' && !skipped) {
        final status =
            effectivePatch[_notificationsPermissionStatusKey] as String?;
        _trackEvent(
          'onboarding_notifications_result',
          properties: {
            'permission_status': status ?? 'unknown',
          },
        );
        if (status == 'granted' || status == 'provisional') {
          final updatedProfile = await ref
              .read(reminderServiceProvider)
              .updateDailyReminders(enabled: true);
          unawaited(
            ref.read(reminderServiceProvider).syncDailyReminders(updatedProfile),
          );
          _draftSettings['daily_reminders_enabled'] = true;
        }
      }

      if (!mounted) {
        return;
      }

      ref.invalidate(profileBootstrapProvider);

      _trackEvent(
        skipped ? 'onboarding_step_skipped' : 'onboarding_step_completed',
        properties: {
          'skipped': skipped,
          ..._eventSpecificPropertiesForStep(
            _currentStep.id,
            patch: effectivePatch,
          ),
        },
      );

      if (_isLastStep && !skipped) {
        _trackEvent(
          'onboarding_completed',
          properties: {
            'completed_at': effectivePatch[_onboardingCompletedAtKey],
            'active_step_count': _activeSteps.length,
          },
        );
        _trackEvent(
          'onboarding_paywall_presented',
          properties: {
            'completed_at': effectivePatch[_onboardingCompletedAtKey],
            'paywall_source': 'onboarding_final',
          },
        );
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => const PaymentScreen(
              source: 'onboarding_final',
              allowSystemDismiss: false,
            ),
          ),
        );
        return;
      }

      final nextSteps = _activeSteps;
      final nextStepIndex =
          (_currentStepIndex + 1).clamp(0, nextSteps.length - 1);
      setState(() {
        _currentStepIndex = nextStepIndex;
        _welcomeCtaVisible = _currentStep.id != 'welcome';
        _setupSummaryCtaVisible =
            nextSteps[nextStepIndex].id != 'setup_summary';
        _weightInteracted = false;
        _syncControllers();
      });
      _maybeTriggerReviewPrompt();
      _trackCurrentStepView();
    } catch (_) {
      _trackEvent(
        'onboarding_save_failed',
        properties: {
          'attempted_action': skipped ? 'skip' : 'submit',
        },
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _errorMessage = 'We could not save this step right now.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<Map<String, dynamic>?> _buildPatchForCurrentStepAsync() async {
    switch (_currentStep.id) {
      case 'welcome':
        return {
          _onboardingStartedAtKey: DateTime.now().toUtc().toIso8601String()
        };
      case 'medication_status':
        final value = _draftSettings[_medicationStatusKey] as String?;
        return value == null ? null : {_medicationStatusKey: value};
      case 'medication_method':
        final value = _draftSettings[_medicationMethodKey] as String?;
        return value == null ? null : {_medicationMethodKey: value};
      case 'medication_name':
        final medicationMethod =
            _draftSettings[_medicationMethodKey] as String?;
        final selectedValue = _selectedMedicationValue(medicationMethod);
        if (selectedValue == _otherMedicationValue) {
          final customValue = _otherMedicationController.text.trim();
          if (customValue.isEmpty) {
            return null;
          }
          _draftSettings[_medicationNameKey] = customValue;
          return {_medicationNameKey: customValue};
        }
        final value = _draftSettings[_medicationNameKey] as String?;
        return value == null ? null : {_medicationNameKey: value};
      case 'current_dose_mg':
        final value = _draftSettings[_currentDoseMgKey];
        return value == null ? null : {_currentDoseMgKey: value};
      case 'device_type':
        if (_selectedDeviceValue == _otherDeviceValue) {
          final customValue = _otherDeviceController.text.trim();
          if (customValue.isEmpty) {
            return null;
          }
          _draftSettings[_deviceTypeKey] = customValue;
          return {_deviceTypeKey: customValue};
        }
        final value = _draftSettings[_deviceTypeKey] as String?;
        return value == null ? null : {_deviceTypeKey: value};
      case 'medication_frequency':
        final frequency = _draftSettings[_medicationFrequencyKey] as String?;
        if (frequency == null) {
          return null;
        }
        if (frequency == 'custom') {
          final days = int.tryParse(_customFrequencyController.text.trim());
          if (days == null || days <= 0) {
            return null;
          }
          _draftSettings[_medicationFrequencyDaysKey] = days;
          return {
            _medicationFrequencyKey: frequency,
            _medicationFrequencyDaysKey: days,
          };
        }
        return {
          _medicationFrequencyKey: frequency,
          _medicationFrequencyDaysKey: null,
        };
      case 'primary_goal':
        final value = _draftSettings[_primaryGoalKey] as String?;
        return value == null ? null : {_primaryGoalKey: value};
      case 'gender':
        if (_selectedGenderValue == _otherGenderValue) {
          final customValue = _otherGenderController.text.trim();
          if (customValue.isEmpty) {
            return null;
          }
          _draftSettings[_genderKey] = customValue;
          return {_genderKey: customValue};
        }
        final value = _draftSettings[_genderKey] as String?;
        return value == null ? null : {_genderKey: value};
      case 'age':
        final age = (_draftSettings[_ageKey] as num?)?.toInt() ?? 30;
        if (age < 13 || age > 100) {
          return null;
        }
        _draftSettings[_ageKey] = age;
        return {_ageKey: age};
      case 'height':
        final value = _draftSettings[_heightKey];
        final unit = (_draftSettings[_measurementUnitKey] as String?) ??
            _measurementUnit(value);
        return value == null
            ? null
            : {
                _heightKey: value,
                if (unit != null) _measurementUnitKey: unit,
              };
      case 'weight':
        final value = _draftSettings[_weightKey];
        final unit = (_draftSettings[_measurementUnitKey] as String?) ??
            _measurementUnit(value);
        return value == null
            ? null
            : {
                _weightKey: value,
                if (unit != null) _measurementUnitKey: unit,
              };
      case 'medication_started':
        final date = _draftSettings[_medicationStartedAtKey];
        final startWeight = _draftSettings[_medicationStartWeightKey];
        if (date == null || startWeight == null) {
          return null;
        }
        return {
          _medicationStartedAtKey: date,
          _medicationStartWeightKey: startWeight,
        };
      case 'goal_weight':
        final value = _draftSettings[_goalWeightKey];
        return value == null ? null : const <String, dynamic>{};
      case 'benefits':
        return {_benefitsSeenAtKey: DateTime.now().toUtc().toIso8601String()};
      case 'notifications_permission':
        final status = await _requestNotificationPermissionStatus();
        return {
          _notificationsPromptedAtKey: DateTime.now().toUtc().toIso8601String(),
          _notificationsPermissionStatusKey: status,
        };
      case 'setup_summary':
        return {
          _setupSummarySeenAtKey: DateTime.now().toUtc().toIso8601String()
        };
      case 'review_prompt':
        return {_reviewPromptedAtKey: DateTime.now().toUtc().toIso8601String()};
      case 'daily_routine':
        final value = _draftSettings[_dailyRoutineKey] as String?;
        return value == null ? null : {_dailyRoutineKey: value};
      case 'symptom_concerns':
        final value = _draftSettings[_symptomConcernsKey];
        return {
          _symptomConcernsKey:
              value == null ? <String>[] : List<String>.from(value as List),
        };
      case 'preferred_name':
        final value = _preferredNameController.text.trim();
        if (value.isEmpty) {
          return null;
        }
        _draftSettings[_preferredNameKey] = value;
        return {_preferredNameKey: value};
      default:
        return null;
    }
  }

  Map<String, dynamic> _buildSkipPatch() {
    switch (_currentStep.id) {
      case 'welcome':
        return {
          _onboardingStartedAtKey: DateTime.now().toUtc().toIso8601String()
        };
      case 'medication_status':
        return {_medicationStatusKey: null};
      case 'medication_method':
        return {_medicationMethodKey: null};
      case 'medication_name':
        return {_medicationNameKey: null};
      case 'current_dose_mg':
        return {_currentDoseMgKey: null};
      case 'device_type':
        return {_deviceTypeKey: null};
      case 'medication_frequency':
        return {
          _medicationFrequencyKey: null,
          _medicationFrequencyDaysKey: null,
        };
      case 'primary_goal':
        return {_primaryGoalKey: null};
      case 'gender':
        return {_genderKey: null};
      case 'age':
        return {_ageKey: null};
      case 'height':
        return {_heightKey: null};
      case 'weight':
        return {_weightKey: null};
      case 'medication_started':
        return {
          _medicationStartedAtKey: null,
          _medicationStartWeightKey: null,
        };
      case 'goal_weight':
        return {};
      case 'benefits':
        return {_benefitsSeenAtKey: null};
      case 'notifications_permission':
        return {
          _notificationsPromptedAtKey: null,
          _notificationsPermissionStatusKey: null,
        };
      case 'setup_summary':
        return {_setupSummarySeenAtKey: null};
      case 'review_prompt':
        return {_reviewPromptedAtKey: null};
      case 'daily_routine':
        return {_dailyRoutineKey: null};
      case 'symptom_concerns':
        return {_symptomConcernsKey: <String>[]};
      case 'preferred_name':
        return {_preferredNameKey: null};
      default:
        return {};
    }
  }

  void _goBack() {
    if (_currentStepIndex == 0 || _isSubmitting) {
      return;
    }
    HapticFeedback.selectionClick();
    _trackEvent('onboarding_step_back_tapped');
    setState(() {
      _errorMessage = null;
      _currentStepIndex -= 1;
      _welcomeCtaVisible = _currentStep.id != 'welcome';
      _weightInteracted = false;
      _syncControllers();
    });
    _trackCurrentStepView();
  }

  void _handleWelcomeAnimationFinished() {
    if (!mounted || !_isWelcomeStep || _welcomeCtaVisible) {
      return;
    }
    setState(() {
      _welcomeCtaVisible = true;
    });
  }

  Future<String> _requestNotificationPermissionStatus() async {
    try {
      _trackEvent('onboarding_notifications_prompted');
      final status = await Permission.notification.request();
      if (status.isGranted) {
        return 'granted';
      }
      if (status.isPermanentlyDenied) {
        return 'permanently_denied';
      }
      if (status.isProvisional) {
        return 'provisional';
      }
      if (status.isRestricted) {
        return 'restricted';
      }
      if (status.isLimited) {
        return 'limited';
      }
      return 'denied';
    } catch (_) {
      return 'unavailable';
    }
  }

  Future<void> _requestAppReview() async {
    try {
      final inAppReview = InAppReview.instance;
      final available = await inAppReview.isAvailable();
      _trackEvent(
        'onboarding_review_prompt_requested',
        properties: {'review_available': available},
      );
      if (available) {
        await inAppReview.requestReview();
        _trackEvent('onboarding_review_prompt_completed');
      }
    } catch (_) {
      // Ignore review prompt failures so onboarding can continue.
    }
  }

  String _primaryButtonLabel(AppLocalizations l10n) {
    if (_isSubmitting) {
      return l10n.onboardingSaving;
    }

    switch (_currentStep.id) {
      case 'welcome':
        return l10n.onboardingLetsBegin;
      case 'benefits':
        return l10n.onboardingContinueWithGlu;
      case 'setup_summary':
        return l10n.onboardingKeepGoing;
      case 'notifications_permission':
        return l10n.onboardingTurnOnNotifications;
      case 'review_prompt':
        return l10n.commonContinue;
      default:
        return _isLastStep ? l10n.onboardingFinish : l10n.commonContinue;
    }
  }

  String _currentStepQuestion(AppLocalizations l10n) {
    final medicationStatus = _draftSettings[_medicationStatusKey] as String?;
    switch (_currentStep.id) {
      case 'welcome':
        return l10n.onboardingWelcomeTitle;
      case 'medication_status':
        return l10n.onboardingMedicationStatusQuestion;
      case 'medication_method':
        return l10n.onboardingMedicationMethodQuestion;
      case 'medication_name':
        return l10n.onboardingMedicationNameQuestion;
      case 'current_dose_mg':
        return l10n.onboardingCurrentDoseQuestion;
      case 'device_type':
        return l10n.onboardingDeviceTypeQuestion;
      case 'medication_frequency':
        return l10n.onboardingMedicationFrequencyQuestion;
      case 'primary_goal':
        return l10n.onboardingPrimaryGoalQuestion;
      case 'age':
        return l10n.onboardingAgeQuestion;
      case 'height':
        return l10n.onboardingHeightQuestion;
      case 'weight':
        return l10n.onboardingWeightQuestion;
      case 'medication_started':
        if (medicationStatus == 'recently_stopped') {
          return l10n.onboardingMedicationStartedQuestionStopped;
        }
        if (medicationStatus == _medicationStatusWeaningOff) {
          return l10n.onboardingMedicationStartedQuestionWeaning;
        }
        return l10n.onboardingMedicationStartedQuestionStarted;
      case 'goal_weight':
        return l10n.onboardingGoalWeightQuestion;
      case 'benefits':
        return l10n.onboardingBenefitsQuestion;
      case 'notifications_permission':
        return l10n.onboardingNotificationsQuestion;
      case 'daily_routine':
        return l10n.onboardingDailyRoutineQuestion;
      case 'symptom_concerns':
        return l10n.onboardingSymptomConcernsQuestion;
      case 'gender':
        return l10n.onboardingGenderQuestion;
      case 'preferred_name':
        return l10n.onboardingPreferredNameQuestion;
      case 'setup_summary':
        return l10n.onboardingSetupSummaryQuestion;
      case 'review_prompt':
        return l10n.onboardingReviewQuestion;
      default:
        return _currentStep.question;
    }
  }

  String _currentStepExplainer(AppLocalizations l10n) {
    final medicationStatus = _draftSettings[_medicationStatusKey] as String?;
    final medicationAwareStatus = medicationStatus == _medicationStatusUsing ||
        medicationStatus == _medicationStatusWeaningOff;
    final nonMedicationPath = _isNonMedicationPath(medicationStatus);

    switch (_currentStep.id) {
      case 'welcome':
        return '';
      case 'medication_status':
        return l10n.onboardingMedicationStatusExplainer;
      case 'medication_method':
        return l10n.onboardingMedicationMethodExplainer;
      case 'medication_name':
        return l10n.onboardingMedicationNameExplainer;
      case 'current_dose_mg':
        return l10n.onboardingCurrentDoseExplainer;
      case 'device_type':
        return l10n.onboardingDeviceTypeExplainer;
      case 'medication_frequency':
        return l10n.onboardingMedicationFrequencyExplainer;
      case 'primary_goal':
        return medicationAwareStatus
            ? l10n.onboardingPrimaryGoalExplainerWithMedication
            : nonMedicationPath
                ? l10n.onboardingPrimaryGoalExplainerWithoutMedication
                : l10n.onboardingPrimaryGoalExplainerDefault;
      case 'age':
        return l10n.onboardingAgeExplainer;
      case 'height':
        return l10n.onboardingHeightExplainer;
      case 'weight':
        return l10n.onboardingWeightExplainer;
      case 'medication_started':
        if (medicationStatus == 'recently_stopped') {
          return l10n.onboardingMedicationStartedExplainerStopped;
        }
        if (medicationStatus == _medicationStatusWeaningOff) {
          return l10n.onboardingMedicationStartedExplainerWeaning;
        }
        return l10n.onboardingMedicationStartedExplainerStarted;
      case 'goal_weight':
        return l10n.onboardingGoalWeightExplainer;
      case 'benefits':
        return l10n.onboardingBenefitsExplainer;
      case 'notifications_permission':
        return l10n.onboardingNotificationsExplainer;
      case 'daily_routine':
        return l10n.onboardingDailyRoutineExplainer;
      case 'symptom_concerns':
        return medicationAwareStatus
            ? l10n.onboardingSymptomConcernsExplainerWithMedication
            : l10n.onboardingSymptomConcernsExplainerDefault;
      case 'gender':
        return l10n.onboardingGenderExplainer;
      case 'preferred_name':
        return l10n.onboardingPreferredNameExplainer;
      case 'setup_summary':
        return l10n.onboardingSetupSummaryExplainer;
      case 'review_prompt':
        return l10n.onboardingReviewExplainer;
      default:
        return _currentStep.explainer;
    }
  }

  AppGoals _updatedGoalsWithGoalWeight() {
    final weightValue = _draftSettings[_goalWeightKey];
    final primary = _measurementPrimary(weightValue);
    final unit = _measurementUnit(weightValue) ?? 'kg';
    if (primary == null) {
      return widget.profile.goals;
    }
    final targetKg = unit == 'lb' ? primary / 2.20462 : primary;
    final current = widget.profile.goals.weight.current;
    final entry = WeightGoalEntry(
      createdAt: goalToday(),
      timeframe: current?.timeframe ?? GoalTimeframe.weekly,
      targetKg: targetKg,
      targetUnit: unit,
    );
    return widget.profile.goals.copyWith(
      weight:
          widget.profile.goals.weight.copyWith(enabled: true).withEntry(entry),
    );
  }

  String? _measurementUnit(dynamic value) {
    if (value is! Map) {
      return null;
    }
    return value['unit']?.toString();
  }

  void _trackCurrentStepView() {
    if (!mounted) {
      return;
    }

    final currentStep = _currentStep;
    final key = '${currentStep.id}:$_currentStepIndex:${_activeSteps.length}';
    if (_lastTrackedStepViewKey == key) {
      return;
    }
    _lastTrackedStepViewKey = key;

    final properties = _baseAnalyticsProperties(step: currentStep);
    _trackEvent('onboarding_step_viewed', properties: properties);
    ref.read(analyticsServiceProvider).screen(
          screenName: 'Onboarding',
          properties: properties,
        );
  }

  void _trackEvent(String eventName, {Map<String, dynamic>? properties}) {
    ref.read(analyticsServiceProvider).capture(
      eventName: eventName,
      properties: {
        ..._baseAnalyticsProperties(step: _currentStep),
        if (properties != null) ...properties,
      },
    );
  }

  Map<String, dynamic> _baseAnalyticsProperties({
    required _OnboardingStep step,
  }) {
    return {
      'step_id': step.id,
      'step_index': _currentStepIndex,
      'step_count': _activeSteps.length,
      'is_last_step': _isLastStep,
      'medication_status': _draftSettings[_medicationStatusKey] ?? 'unknown',
      'medication_method': _draftSettings[_medicationMethodKey] ?? 'unknown',
      'primary_goal': _draftSettings[_primaryGoalKey] ?? 'unknown',
      'measurement_unit': _draftSettings[_measurementUnitKey] ?? 'unknown',
      'elapsed_seconds_from_start': _elapsedSecondsFromStart,
    };
  }

  Map<String, dynamic> _eventSpecificPropertiesForStep(
    String stepId, {
    required Map<String, dynamic> patch,
  }) {
    switch (stepId) {
      case 'medication_status':
        return {'selected_value': patch[_medicationStatusKey] ?? 'unknown'};
      case 'medication_method':
        return {'selected_value': patch[_medicationMethodKey] ?? 'unknown'};
      case 'medication_name':
        return {
          'used_custom_value': _selectedMedicationValue(
                _draftSettings[_medicationMethodKey] as String?,
              ) ==
              _otherMedicationValue,
        };
      case 'current_dose_mg':
        return {
          'used_custom_value': _isCustomDoseSelected,
        };
      case 'device_type':
        return {
          'used_custom_value':
              (_draftSettings[_deviceTypeKey] as String?) == _otherDeviceValue,
        };
      case 'medication_frequency':
        return {
          'selected_value': patch[_medicationFrequencyKey] ?? 'unknown',
          'custom_days_between_doses':
              patch[_medicationFrequencyDaysKey] != null,
        };
      case 'notifications_permission':
        return {
          'permission_status':
              patch[_notificationsPermissionStatusKey] ?? 'unknown',
        };
      case 'daily_routine':
        return {'selected_value': patch[_dailyRoutineKey] ?? 'unknown'};
      case 'symptom_concerns':
        final concerns = patch[_symptomConcernsKey];
        return {
          'selected_count': concerns is List ? concerns.length : 0,
        };
      case 'gender':
        return {
          'used_custom_value': _selectedGenderValue == _otherGenderValue,
        };
      case 'preferred_name':
        return {'provided_value': patch[_preferredNameKey] != null};
      case 'goal_weight':
        return {'has_goal_weight': _draftSettings[_goalWeightKey] != null};
      default:
        return const {};
    }
  }

  int? get _elapsedSecondsFromStart {
    final rawStartedAt = _draftSettings[_onboardingStartedAtKey] as String?;
    if (rawStartedAt == null || rawStartedAt.isEmpty) {
      return null;
    }

    final startedAt = DateTime.tryParse(rawStartedAt);
    if (startedAt == null) {
      return null;
    }
    return DateTime.now().difference(startedAt.toLocal()).inSeconds;
  }

  void _seedMeasurementUnitFromMeasurement(dynamic value) {
    final unit = _measurementUnit(value);
    if (unit == null || unit.isEmpty) {
      return;
    }
    _draftSettings.putIfAbsent(_measurementUnitKey, () => unit);
  }

  double? _measurementPrimary(dynamic value) {
    if (value is! Map) {
      return null;
    }
    return double.tryParse(value['primary']?.toString() ?? '');
  }

  String _benefitsHeroTitle(AppLocalizations l10n) {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' => l10n.onboardingBenefitsHeroMaintainWeightTitle,
      'Manage my diabetes' => l10n.onboardingBenefitsHeroDiabetesTitle,
      'Manage my PCOS' => l10n.onboardingBenefitsHeroPcosTitle,
      'Improve my heart health' => l10n.onboardingBenefitsHeroHeartTitle,
      _ => l10n.onboardingBenefitsHeroWeightLossTitle,
    };
  }

  String _benefitsHeroBody(AppLocalizations l10n) {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' =>
        l10n.onboardingBenefitsHeroMaintainWeightBody,
      'Manage my diabetes' => l10n.onboardingBenefitsHeroDiabetesBody,
      'Manage my PCOS' => l10n.onboardingBenefitsHeroPcosBody,
      'Improve my heart health' => l10n.onboardingBenefitsHeroHeartBody,
      _ => l10n.onboardingBenefitsHeroWeightLossBody,
    };
  }

  String _benefitsSpecificCopy(AppLocalizations l10n) {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' => l10n.onboardingBenefitsSpecificMaintainWeight,
      'Manage my diabetes' => l10n.onboardingBenefitsSpecificDiabetes,
      'Manage my PCOS' => l10n.onboardingBenefitsSpecificPcos,
      'Improve my heart health' => l10n.onboardingBenefitsSpecificHeart,
      _ => l10n.onboardingBenefitsSpecificWeightLoss,
    };
  }

  String _benefitsAxisLabel(AppLocalizations l10n) {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' => l10n.onboardingBenefitsAxisWeight,
      'Manage my diabetes' => l10n.onboardingBenefitsAxisMealsWeight,
      'Manage my PCOS' => l10n.onboardingBenefitsAxisSymptomsWeight,
      'Improve my heart health' => l10n.onboardingBenefitsAxisExerciseWeight,
      _ => l10n.onboardingBenefitsAxisWeight,
    };
  }

  _BenefitsTrendSpec get _benefitsTrendSpec {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' => const _BenefitsTrendSpec(
          withoutGlu: [0.44, 0.46, 0.52, 0.60, 0.69, 0.79],
          withGlu: [0.44, 0.44, 0.43, 0.44, 0.43, 0.43],
        ),
      'Manage my diabetes' => const _BenefitsTrendSpec(
          withoutGlu: [0.50, 0.70, 0.36, 0.74, 0.40, 0.68],
          withGlu: [0.50, 0.54, 0.51, 0.55, 0.52, 0.54],
        ),
      'Manage my PCOS' => const _BenefitsTrendSpec(
          withoutGlu: [0.46, 0.66, 0.42, 0.72, 0.45, 0.67],
          withGlu: [0.46, 0.49, 0.47, 0.50, 0.48, 0.50],
        ),
      'Improve my heart health' => const _BenefitsTrendSpec(
          withoutGlu: [0.50, 0.54, 0.60, 0.67, 0.75, 0.84],
          withGlu: [0.50, 0.44, 0.37, 0.30, 0.24, 0.18],
        ),
      _ => const _BenefitsTrendSpec(
          withoutGlu: [0.68, 0.72, 0.77, 0.83, 0.89, 0.94],
          withGlu: [0.68, 0.60, 0.51, 0.42, 0.33, 0.24],
        ),
    };
  }

  List<String> _notificationsBullets(AppLocalizations l10n) {
    final frequency = _draftSettings[_medicationFrequencyKey] as String?;
    final medicationStatus = _draftSettings[_medicationStatusKey] as String?;
    final medicationAwareStatus = medicationStatus == _medicationStatusUsing ||
        medicationStatus == _medicationStatusWeaningOff;

    return [
      if (medicationAwareStatus)
        switch (frequency) {
          'daily' => l10n.onboardingNotificationsDaily,
          'every_14_days' => l10n.onboardingNotificationsEvery14Days,
          'custom' => l10n.onboardingNotificationsCustom,
          _ => l10n.onboardingNotificationsWeekly,
        }
      else
        l10n.onboardingNotificationsSupportive,
      l10n.onboardingNotificationsProgress,
      l10n.onboardingNotificationsHelpful,
    ];
  }

  List<String> _setupSummaryMessages(AppLocalizations l10n) {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' => [
          l10n.onboardingSetupSummaryMaintainStep1,
          l10n.onboardingSetupSummaryMaintainStep2,
          l10n.onboardingSetupSummaryMaintainStep3,
          l10n.onboardingSetupSummaryMaintainStep4,
        ],
      'Manage my diabetes' => [
          l10n.onboardingSetupSummaryDiabetesStep1,
          l10n.onboardingSetupSummaryDiabetesStep2,
          l10n.onboardingSetupSummaryDiabetesStep3,
          l10n.onboardingSetupSummaryDiabetesStep4,
        ],
      'Manage my PCOS' => [
          l10n.onboardingSetupSummaryPcosStep1,
          l10n.onboardingSetupSummaryPcosStep2,
          l10n.onboardingSetupSummaryPcosStep3,
          l10n.onboardingSetupSummaryPcosStep4,
        ],
      'Improve my heart health' => [
          l10n.onboardingSetupSummaryHeartStep1,
          l10n.onboardingSetupSummaryHeartStep2,
          l10n.onboardingSetupSummaryHeartStep3,
          l10n.onboardingSetupSummaryHeartStep4,
        ],
      _ => [
          l10n.onboardingSetupSummaryWeightLossStep1,
          l10n.onboardingSetupSummaryWeightLossStep2,
          l10n.onboardingSetupSummaryWeightLossStep3,
          l10n.onboardingSetupSummaryWeightLossStep4,
        ],
    };
  }

  String _setupSummaryHeadline(AppLocalizations l10n) {
    return l10n.onboardingSetupSummaryHeadline;
  }

  String _setupSummaryBody(AppLocalizations l10n) {
    final primaryGoal = _draftSettings[_primaryGoalKey] as String?;
    return switch (primaryGoal) {
      'Maintain my weight' => l10n.onboardingSetupSummaryMaintainBody,
      'Manage my diabetes' => l10n.onboardingSetupSummaryDiabetesBody,
      'Manage my PCOS' => l10n.onboardingSetupSummaryPcosBody,
      'Improve my heart health' => l10n.onboardingSetupSummaryHeartBody,
      _ => l10n.onboardingSetupSummaryWeightLossBody,
    };
  }

  List<({String label, String value, IconData icon})> _setupSummaryItems(
    AppLocalizations l10n,
  ) {
    final primaryGoal = (_draftSettings[_primaryGoalKey] as String?)?.trim();
    final routine = (_draftSettings[_dailyRoutineKey] as String?)?.trim();
    final currentWeight = _formatMeasurementSummary(_draftSettings[_weightKey]);
    final goalWeight =
        _formatMeasurementSummary(_draftSettings[_goalWeightKey]);
    final symptoms = List<String>.from(
      (_draftSettings[_symptomConcernsKey] as List?) ?? const [],
    );
    final symptomValue = symptoms.isEmpty ? null : symptoms.take(2).join(', ');
    final medicationStatus =
        (_draftSettings[_medicationStatusKey] as String?)?.trim();
    final medicationAwareStatus = medicationStatus == _medicationStatusUsing ||
        medicationStatus == _medicationStatusWeaningOff;
    final medicationFrequency = _formatMedicationFrequencySummary(
      _draftSettings[_medicationFrequencyKey] as String?,
      l10n,
    );
    final medication = (_draftSettings[_medicationNameKey] as String?)?.trim();
    final currentDose = _formatDoseSummary(_draftSettings[_currentDoseMgKey]);
    final startedAt = _formatDateSummary(
      _draftSettings[_medicationStartedAtKey] as String?,
    );

    final items = <({String label, String value, IconData icon})>[];

    if (primaryGoal != null && primaryGoal.isNotEmpty) {
      items.add((
        label: l10n.onboardingSummaryGoal,
        value: _localizedPrimaryGoalValue(l10n, primaryGoal),
        icon: Icons.flag_outlined,
      ));
    }
    if (currentWeight != '--') {
      items.add((
        label: l10n.onboardingSummaryCurrentWeight,
        value: currentWeight,
        icon: Icons.straighten_rounded,
      ));
    }
    if (medicationAwareStatus && medication != null && medication.isNotEmpty) {
      items.add((
        label: l10n.onboardingSummaryMedication,
        value: medication,
        icon: Icons.medication_outlined,
      ));
    }
    if (medicationAwareStatus &&
        currentDose != null &&
        currentDose.isNotEmpty) {
      items.add((
        label: l10n.onboardingSummaryCurrentDose,
        value: currentDose,
        icon: Icons.opacity_outlined,
      ));
    }
    if (medicationAwareStatus && medicationFrequency != null) {
      items.add((
        label: l10n.onboardingSummaryCadence,
        value: medicationFrequency,
        icon: Icons.repeat_rounded,
      ));
    }
    if (startedAt != null) {
      items.add((
        label: l10n.onboardingSummaryStarted,
        value: startedAt,
        icon: Icons.event_outlined,
      ));
    }
    if (goalWeight != '--') {
      items.add((
        label: l10n.onboardingSummaryTargetWeight,
        value: goalWeight,
        icon: Icons.monitor_weight_outlined,
      ));
    }
    if (routine != null && routine.isNotEmpty) {
      items.add((
        label: l10n.onboardingSummaryRoutine,
        value: _localizedRoutineValue(l10n, routine),
        icon: Icons.today_outlined,
      ));
    }
    if (symptomValue != null && symptomValue.isNotEmpty) {
      items.add((
        label: l10n.onboardingSummaryFocus,
        value: symptomValue,
        icon: Icons.favorite_border_rounded,
      ));
    }

    return items;
  }

  String _formatMeasurementSummary(dynamic value) {
    final amount = _measurementPrimary(value);
    final unit = _measurementUnit(value);
    if (amount == null || unit == null) {
      return '--';
    }
    return '${amount.round()} $unit';
  }

  String _localizedPrimaryGoalValue(AppLocalizations l10n, String value) {
    return switch (value) {
      'Lose weight' => l10n.onboardingGoalLoseWeight,
      'Maintain my weight' => l10n.onboardingGoalMaintainWeight,
      'Manage my diabetes' => l10n.onboardingGoalManageDiabetes,
      'Manage my PCOS' => l10n.onboardingGoalManagePcos,
      'Improve my heart health' => l10n.onboardingGoalImproveHeartHealth,
      _ => value,
    };
  }

  String _localizedRoutineValue(AppLocalizations l10n, String value) {
    return switch (value) {
      'Sedentary' => l10n.onboardingRoutineSedentary,
      'Lightly active' => l10n.onboardingRoutineLightlyActive,
      'Active' => l10n.onboardingRoutineActive,
      'Very active' => l10n.onboardingRoutineVeryActive,
      _ => value,
    };
  }

  String? _formatMedicationFrequencySummary(
    String? frequency,
    AppLocalizations l10n,
  ) {
    return switch (frequency) {
      'daily' => l10n.onboardingFrequencyEveryDay,
      'weekly' => l10n.onboardingFrequencyEveryWeek,
      'every_14_days' => l10n.onboardingFrequencyEvery2Weeks,
      'custom' => l10n.onboardingFrequencyCustomSchedule,
      _ => null,
    };
  }

  String? _formatDateSummary(String? iso) {
    if (iso == null || iso.isEmpty) {
      return null;
    }
    final parsed = DateTime.tryParse(iso);
    if (parsed == null) {
      return null;
    }
    return DateFormat('MMM d, y').format(parsed.toLocal());
  }

  String? _formatDoseSummary(dynamic value) {
    if (value == null) {
      return null;
    }
    final raw = value.toString().trim();
    if (raw.isEmpty) {
      return null;
    }
    if (raw.toLowerCase().endsWith('mg')) {
      return raw;
    }
    final parsed = double.tryParse(raw);
    if (parsed == null) {
      return raw;
    }
    final normalized = parsed % 1 == 0 ? parsed.toInt().toString() : raw;
    return '$normalized mg';
  }

  bool get _usesCustomInterstitialLayout {
    switch (_currentStep.id) {
      case 'welcome':
      case 'benefits':
      case 'notifications_permission':
      case 'setup_summary':
      case 'review_prompt':
        return true;
      default:
        return false;
    }
  }

  Widget _buildCustomInterstitialContent(
    BuildContext context, {
    required bool compact,
  }) {
    final l10n = context.l10n;
    switch (_currentStep.id) {
      case 'welcome':
        return _WelcomeInterstitial(
          onFinished: _handleWelcomeAnimationFinished,
        );
      case 'benefits':
        return _BenefitsInterstitial(
          title: _benefitsHeroTitle(l10n),
          subtitle: _benefitsHeroBody(l10n),
          compact: compact,
          chart: _BenefitsTrendChart(
            trend: _benefitsTrendSpec,
            axisLabel: _benefitsAxisLabel(l10n),
            compact: compact,
          ),
          insight: _BenefitsInsightPanel(
            specificCopy: _benefitsSpecificCopy(l10n),
            compact: compact,
          ),
        );
      case 'notifications_permission':
        return _NotificationsInterstitial(
          panel: _NotificationsPrimerPanel(
            bullets: _notificationsBullets(l10n),
          ),
        );
      case 'setup_summary':
        return _SetupSummaryInterstitial(
          messages: _setupSummaryMessages(l10n),
          headline: _setupSummaryHeadline(l10n),
          body: _setupSummaryBody(l10n),
          items: _setupSummaryItems(l10n),
          onReady: () {
            if (!mounted) return;
            setState(() {
              _setupSummaryCtaVisible = true;
            });
          },
        );
      case 'review_prompt':
        return const _ReviewInterstitial(panel: _ReviewPromptPanel());
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.l10n;
    final progress = (_currentStepIndex + 1) / _activeSteps.length;

    return Scaffold(
      backgroundColor: colors.canvas,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: [
                  SizedBox(
                    width: 48,
                    child: _currentStepIndex == 0
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: _goBack,
                            iconSize: 18,
                            visualDensity: const VisualDensity(
                              horizontal: -2,
                              vertical: -2,
                            ),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: progress,
                        backgroundColor: colors.softSurface,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(colors.heroEnd),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 48,
                    child: _currentStep.skippable
                        ? TextButton(
                            onPressed: _isSubmitting
                                ? null
                                : () {
                                    HapticFeedback.selectionClick();
                                    _submitCurrentStep(skipped: true);
                                  },
                            child: Text(l10n.commonSkip),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxHeight < 500;
                  final content = _buildStepContent(
                    context,
                    scrollable: _currentStep.id != 'height',
                    compact: compact,
                  );
                  return _currentStep.id == 'height'
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(
                            24,
                            compact ? 8 : 12,
                            24,
                            compact ? 16 : 24,
                          ),
                          child: content,
                        )
                      : SingleChildScrollView(
                          padding: EdgeInsets.fromLTRB(
                            24,
                            compact ? 8 : 12,
                            24,
                            compact ? 16 : 24,
                          ),
                          child: content,
                        );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_currentStepInstruction(l10n) != null) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    _currentStepInstruction(l10n)!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                  ),
                ),
              ),
            ],
            SizedBox(
              height: 62,
              width: double.infinity,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                opacity: _isWelcomeStep ? (_welcomeCtaVisible ? 1 : 0) : 1,
                child: AnimatedSlide(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  offset: _isWelcomeStep && !_welcomeCtaVisible
                      ? const Offset(0, 0.16)
                      : Offset.zero,
                  child: IgnorePointer(
                    ignoring: _isWelcomeStep && !_welcomeCtaVisible,
                    child: FilledButton(
                            onPressed: _isSubmitting ||
                              !_isCurrentStepActionEnabled ||
                              (_isWelcomeStep && !_welcomeCtaVisible)
                          ? null
                          : () {
                              HapticFeedback.lightImpact();
                              _submitCurrentStep(skipped: false);
                            },
                      child: Text(_primaryButtonLabel(l10n)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(
    BuildContext context, {
    required bool scrollable,
    required bool compact,
  }) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;

    if (_usesCustomInterstitialLayout) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomInterstitialContent(context, compact: compact),
          if (_errorMessage != null) ...[
            const SizedBox(height: 20),
            Text(
              _errorMessage!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFFB94C4C),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          SizedBox(
            height: scrollable
                ? switch (_currentStep.id) {
                    'welcome' => 72.0,
                    'setup_summary' => 180.0,
                    _ => 140.0,
                  }
                : 24,
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _currentStepQuestion(l10n),
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: compact ? 28 : null,
            height: compact ? 1.08 : null,
          ),
        ),
        SizedBox(height: compact ? 8 : 12),
        Text(
          _currentStepExplainer(l10n),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.textSecondary,
            height: compact ? 1.28 : null,
          ),
        ),
        SizedBox(height: compact ? 16 : 28),
        _buildInputArea(context, compact: compact),
        if (_errorMessage != null) ...[
          SizedBox(height: compact ? 12 : 20),
          Text(
            _errorMessage!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFFB94C4C),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInputArea(BuildContext context, {required bool compact}) {
    final medicationMethod = _draftSettings[_medicationMethodKey] as String?;
    final l10n = context.l10n;

    switch (_currentStep.id) {
      case 'medication_status':
        return _SingleChoiceGroup(
          value: _draftSettings[_medicationStatusKey] as String?,
          options: [
            _ChoiceOption('using', l10n.onboardingMedicationStatusUsing),
            _ChoiceOption(
              'weaning_off',
              l10n.onboardingMedicationStatusWeaningOff,
            ),
            _ChoiceOption(
              'not_taking',
              l10n.onboardingMedicationStatusNotTaking,
            ),
            _ChoiceOption(
              'starting_soon',
              l10n.onboardingMedicationStatusStartingSoon,
            ),
            _ChoiceOption(
              'recently_stopped',
              l10n.onboardingMedicationStatusRecentlyStopped,
            ),
          ],
          onChanged: (value) => setState(() {
            _draftSettings[_medicationStatusKey] = value;
          }),
        );
      case 'medication_method':
        return _SingleChoiceGroup(
          value: _draftSettings[_medicationMethodKey] as String?,
          options: [
            _ChoiceOption('injection', l10n.onboardingMedicationMethodInjection),
            _ChoiceOption('pill', l10n.onboardingMedicationMethodPill),
            _ChoiceOption('unknown', l10n.onboardingMedicationMethodUnknown),
          ],
          onChanged: (value) => setState(() {
            _draftSettings[_medicationMethodKey] = value;
          }),
        );
      case 'medication_name':
        return _MedicationChoiceGroup(
          value: _selectedMedicationValue(medicationMethod),
          options: MedicationCatalog.medicationsForMethod(medicationMethod)
              .map((option) => _ChoiceOption(option, option))
              .toList(),
          otherController: _otherMedicationController,
          otherFocusNode: _otherMedicationFocusNode,
          onChanged: (value) => setState(() {
            if (value == _otherMedicationValue) {
              _otherMedicationController.clear();
              _draftSettings[_medicationNameKey] = _otherMedicationValue;
              _draftSettings[_currentDoseMgKey] = null;
              _isCustomDoseSelected = false;
              return;
            }
            _otherMedicationController.clear();
            _draftSettings[_medicationNameKey] = value;
            final normalizedDose = MedicationCatalog.normalizeDoseValue(
              _draftSettings[_currentDoseMgKey],
              medication: value,
            );
            _draftSettings[_currentDoseMgKey] =
                normalizedDose == null ? null : double.tryParse(normalizedDose);
            _isCustomDoseSelected = false;
          }),
          onOtherChanged: (value) => setState(() {
            final trimmed = value.trim();
            _draftSettings[_medicationNameKey] =
                trimmed.isEmpty ? _otherMedicationValue : trimmed;
            _draftSettings[_currentDoseMgKey] = null;
            _isCustomDoseSelected = false;
          }),
        );
      case 'current_dose_mg':
        final medication =
            (_draftSettings[_medicationNameKey] as String?)?.trim();
        final coercedDose = MedicationCatalog.coerceDoseValue(
          _draftSettings[_currentDoseMgKey],
        );
        final selectedDose = MedicationCatalog.normalizeDoseValue(
          _draftSettings[_currentDoseMgKey],
          medication: medication,
        );
        final doseOptions = MedicationCatalog.dosesForMedication(medication);
        final customRange =
            MedicationCatalog.customDoseRangeForMedication(medication);
        return _DoseChoiceGroup(
          value: _isCustomDoseSelected
              ? _customDoseValue
              : (selectedDose != null
                  ? MedicationCatalog.formatDoseLabel(selectedDose)
                  : (coercedDose != null ? _customDoseValue : null)),
          options: [
            ...doseOptions.map(
              (value) => _ChoiceOption(
                MedicationCatalog.formatDoseLabel(value),
                MedicationCatalog.formatDoseLabel(value),
              ),
            ),
            _ChoiceOption(_customDoseValue, l10n.onboardingMedicationCustomDose),
          ],
          customValue: coercedDose,
          customMin: customRange.min,
          customMax: customRange.max,
          customStep: customRange.step,
          onChanged: (value) => setState(() {
            if (value == _customDoseValue) {
              _isCustomDoseSelected = true;
              final current = MedicationCatalog.coerceDoseValue(
                  _draftSettings[_currentDoseMgKey]);
              _draftSettings[_currentDoseMgKey] = current == null
                  ? double.tryParse(
                      MedicationCatalog.customInitialDoseForMedication(
                        medication,
                      ),
                    )
                  : double.tryParse(current);
              return;
            }
            _isCustomDoseSelected = false;
            _draftSettings[_currentDoseMgKey] = double.tryParse(
              value.replaceAll(' mg', ''),
            );
          }),
          onCustomChanged: (value) => setState(() {
            _isCustomDoseSelected = true;
            final parsed = double.tryParse(value);
            _draftSettings[_currentDoseMgKey] =
                parsed == null || parsed <= 0 ? null : parsed;
          }),
        );
      case 'device_type':
        return _ExpandableOtherChoiceGroup(
          value: _selectedDeviceValue,
          options: [
            _ChoiceOption('Single pen', l10n.onboardingDeviceSinglePen),
            _ChoiceOption(
              'Auto-injector',
              l10n.onboardingDeviceAutoInjector,
            ),
            _ChoiceOption(
              'Syringe and vial',
              l10n.onboardingDeviceSyringeAndVial,
            ),
          ],
          otherValue: _otherDeviceValue,
          otherLabel: l10n.onboardingOther,
          otherHintText: l10n.onboardingTypeYourDevice,
          otherController: _otherDeviceController,
          otherFocusNode: _otherDeviceFocusNode,
          onChanged: (value) => setState(() {
            if (value == _otherDeviceValue) {
              _otherDeviceController.clear();
              _draftSettings[_deviceTypeKey] = _otherDeviceValue;
              return;
            }
            _otherDeviceController.clear();
            _draftSettings[_deviceTypeKey] = value;
          }),
          onOtherChanged: (value) => setState(() {
            final trimmed = value.trim();
            _draftSettings[_deviceTypeKey] =
                trimmed.isEmpty ? _otherDeviceValue : trimmed;
          }),
        );
      case 'medication_frequency':
        final frequency = _draftSettings[_medicationFrequencyKey] as String?;
        return _ExpandableInputChoiceGroup(
          value: frequency,
          options: [
            _ChoiceOption('daily', l10n.onboardingEveryDay),
            _ChoiceOption('every_7_days', l10n.onboardingEvery7Days),
            _ChoiceOption('every_14_days', l10n.onboardingEvery14Days),
            _ChoiceOption('custom', l10n.onboardingCustom),
          ],
          expandableValue: 'custom',
          controller: _customFrequencyController,
          focusNode: _customFrequencyFocusNode,
          hintText: l10n.onboardingDaysBetweenDoses,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) => setState(() {
            _draftSettings[_medicationFrequencyKey] = value;
          }),
          onExpandedChanged: (_) => setState(() {}),
        );
      case 'primary_goal':
        return _SingleChoiceGroup(
          value: _draftSettings[_primaryGoalKey] as String?,
          options: [
            _ChoiceOption('Lose weight', l10n.onboardingGoalLoseWeight),
            _ChoiceOption(
              'Maintain my weight',
              l10n.onboardingGoalMaintainWeight,
            ),
            _ChoiceOption(
              'Manage my diabetes',
              l10n.onboardingGoalManageDiabetes,
            ),
            _ChoiceOption(
              'Manage my PCOS',
              l10n.onboardingGoalManagePcos,
            ),
            _ChoiceOption(
              'Improve my heart health',
              l10n.onboardingGoalImproveHeartHealth,
            ),
          ],
          onChanged: (value) => setState(() {
            _draftSettings[_primaryGoalKey] = value;
          }),
        );
      case 'gender':
        return _ExpandableOtherChoiceGroup(
          value: _selectedGenderValue,
          options: [
            _ChoiceOption('Female', l10n.onboardingGenderFemale),
            _ChoiceOption('Male', l10n.onboardingGenderMale),
            _ChoiceOption(
              'Prefer not to say',
              l10n.onboardingGenderPreferNotToSay,
            ),
          ],
          otherValue: _otherGenderValue,
          otherLabel: l10n.onboardingOther,
          otherHintText: l10n.onboardingTypeYourGender,
          otherController: _otherGenderController,
          otherFocusNode: _otherGenderFocusNode,
          onChanged: (value) => setState(() {
            if (value == _otherGenderValue) {
              _otherGenderController.clear();
              _draftSettings[_genderKey] = _otherGenderValue;
              return;
            }
            _otherGenderController.clear();
            _draftSettings[_genderKey] = value;
          }),
          onOtherChanged: (value) => setState(() {
            final trimmed = value.trim();
            _draftSettings[_genderKey] =
                trimmed.isEmpty ? _otherGenderValue : trimmed;
          }),
        );
      case 'age':
        return _AgePickerCard(
          value: (_draftSettings[_ageKey] as num?)?.toInt() ?? 30,
          min: 13,
          max: 100,
          onChanged: (value) => setState(() {
            _draftSettings[_ageKey] = value;
          }),
        );
      case 'height':
        return HeightRulerSelector(
          value: _draftSettings[_heightKey],
          compact: compact,
          onChanged: (value) => setState(() {
            _draftSettings[_heightKey] = value;
            _seedMeasurementUnitFromMeasurement(value);
          }),
        );
      case 'weight':
        return WeightDialSelector(
          value: _draftSettings[_weightKey],
          onChanged: (value) => setState(() {
            _weightInteracted = true;
            _draftSettings[_weightKey] = value;
            _seedMeasurementUnitFromMeasurement(value);
          }),
          showStepButtons: true,
        );
      case 'medication_started':
        return _MedicationStartedEditor(
          dateIso: _draftSettings[_medicationStartedAtKey] as String?,
          weightValue: _draftSettings[_medicationStartWeightKey],
          onDateChanged: (value) => setState(() {
            _draftSettings[_medicationStartedAtKey] = value;
          }),
          onWeightChanged: (value) => setState(() {
            _draftSettings[_medicationStartWeightKey] = value;
          }),
        );
      case 'goal_weight':
        return Column(
          children: [
            WeightDialSelector(
              value: _draftSettings[_goalWeightKey],
              fallbackValue: _draftSettings[_weightKey],
              onChanged: (value) => setState(() {
                _weightInteracted = true;
                _draftSettings[_goalWeightKey] = value;
              }),
              showStepButtons: true,
            ),
            const SizedBox(height: 20),
            BmiIndicator(
              age: (_draftSettings[_ageKey] as num?)?.toInt(),
              heightValue: _draftSettings[_heightKey],
              weightValue: _draftSettings[_goalWeightKey] ??
                  {'primary': 80, 'unit': 'kg'},
              title: l10n.onboardingTargetBmiTitle,
              showValueLabel: false,
              showUnitLabel: false,
              showLegend: false,
            ),
          ],
        );
      case 'daily_routine':
        return _SingleChoiceGroup(
          value: _draftSettings[_dailyRoutineKey] as String?,
          options: [
            _ChoiceOption(
              'Sedentary',
              l10n.onboardingRoutineSedentary,
              description: l10n.onboardingRoutineSedentaryDescription,
            ),
            _ChoiceOption(
              'Lightly active',
              l10n.onboardingRoutineLightlyActive,
              description: l10n.onboardingRoutineLightlyActiveDescription,
            ),
            _ChoiceOption(
              'Active',
              l10n.onboardingRoutineActive,
              description: l10n.onboardingRoutineActiveDescription,
            ),
            _ChoiceOption(
              'Very active',
              l10n.onboardingRoutineVeryActive,
              description: l10n.onboardingRoutineVeryActiveDescription,
            ),
          ],
          onChanged: (value) => setState(() {
            _draftSettings[_dailyRoutineKey] = value;
          }),
        );
      case 'symptom_concerns':
        final selected = List<String>.from(
          (_draftSettings[_symptomConcernsKey] as List?) ?? const [],
        );
        return _MultiSelectGroup(
          options: SymptomCatalog.options(context)
              .map((option) => _ChoiceOption(option.value, option.label))
              .toList(),
          selected: selected,
          onChanged: (values) => setState(() {
            _draftSettings[_symptomConcernsKey] = values;
          }),
        );
      case 'preferred_name':
        return SizedBox(
          height: 62,
          child: _TextInputCard(
            child: Center(
              child: TextField(
                controller: _preferredNameController,
                textCapitalization: TextCapitalization.words,
                textAlignVertical: TextAlignVertical.center,
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  isCollapsed: true,
                  filled: false,
                  hintText: l10n.onboardingPreferredNameHint,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _OnboardingStep {
  const _OnboardingStep({
    required this.id,
    required this.question,
    required this.explainer,
    required this.skippable,
  });

  const _OnboardingStep.welcome()
      : id = 'welcome',
        question = 'Welcome to Glu',
        explainer = '',
        skippable = false;

  final String id;
  final String question;
  final String explainer;
  final bool skippable;
}

class _ChoiceOption {
  const _ChoiceOption(this.value, this.label, {this.description});

  final String value;
  final String label;
  final String? description;
}

class _SingleChoiceGroup extends StatelessWidget {
  const _SingleChoiceGroup({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final String? value;
  final List<_ChoiceOption> options;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: options.map((option) {
        final selected = option.value == value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(option.value);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: selected ? colors.surface : colors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? colors.heroEnd : colors.lineSubtle,
                  width: selected ? 1.6 : 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          option.label,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyLarge,
                        ),
                        if (option.description != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            option.description!,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.textSecondary,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    selected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: selected ? colors.heroEnd : colors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ExpandableOtherChoiceGroup extends StatelessWidget {
  const _ExpandableOtherChoiceGroup({
    required this.value,
    required this.options,
    required this.otherValue,
    required this.otherLabel,
    required this.otherHintText,
    required this.otherController,
    required this.otherFocusNode,
    required this.onChanged,
    required this.onOtherChanged,
  });

  final String? value;
  final List<_ChoiceOption> options;
  final String otherValue;
  final String otherLabel;
  final String otherHintText;
  final TextEditingController otherController;
  final FocusNode otherFocusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onOtherChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final allOptions = [
      ...options,
      _ChoiceOption(otherValue, otherLabel),
    ];

    return Column(
      children: allOptions.map((option) {
        final selected = option.value == value;
        final isOther = option.value == otherValue;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(option.value);
              if (isOther) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (otherFocusNode.canRequestFocus) {
                    otherFocusNode.requestFocus();
                  }
                });
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? colors.heroEnd : colors.lineSubtle,
                  width: selected ? 1.6 : 1,
                ),
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            option.label,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color:
                              selected ? colors.heroEnd : colors.textSecondary,
                        ),
                      ],
                    ),
                    if (selected && isOther) ...[
                      const SizedBox(height: 10),
                      TextField(
                        controller: otherController,
                        focusNode: otherFocusNode,
                        textCapitalization: TextCapitalization.words,
                        onChanged: onOtherChanged,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: otherHintText,
                        ),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ExpandableInputChoiceGroup extends StatelessWidget {
  const _ExpandableInputChoiceGroup({
    required this.value,
    required this.options,
    required this.expandableValue,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.keyboardType,
    this.inputFormatters,
    required this.onChanged,
    required this.onExpandedChanged,
  });

  final String? value;
  final List<_ChoiceOption> options;
  final String expandableValue;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onExpandedChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: options.map((option) {
        final selected = option.value == value;
        final isExpandable = option.value == expandableValue;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(option.value);
              if (isExpandable) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (focusNode.canRequestFocus) {
                    focusNode.requestFocus();
                  }
                });
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? colors.heroEnd : colors.lineSubtle,
                  width: selected ? 1.6 : 1,
                ),
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            option.label,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color:
                              selected ? colors.heroEnd : colors.textSecondary,
                        ),
                      ],
                    ),
                    if (selected && isExpandable) ...[
                      const SizedBox(height: 10),
                      TextField(
                        controller: controller,
                        focusNode: focusNode,
                        keyboardType: keyboardType,
                        inputFormatters: inputFormatters,
                        onChanged: onExpandedChanged,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: hintText,
                        ),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _MedicationChoiceGroup extends StatelessWidget {
  const _MedicationChoiceGroup({
    required this.value,
    required this.options,
    required this.otherController,
    required this.otherFocusNode,
    required this.onChanged,
    required this.onOtherChanged,
  });

  final String? value;
  final List<_ChoiceOption> options;
  final TextEditingController otherController;
  final FocusNode otherFocusNode;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onOtherChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final allOptions = [
      ...options,
      _ChoiceOption(
        _OnboardingScreenState._otherMedicationValue,
        l10n.onboardingOther,
      ),
    ];

    return Column(
      children: allOptions.map((option) {
        final selected = option.value == value;
        final isOther =
            option.value == _OnboardingScreenState._otherMedicationValue;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(option.value);
              if (isOther) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (otherFocusNode.canRequestFocus) {
                    otherFocusNode.requestFocus();
                  }
                });
              }
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? colors.heroEnd : colors.lineSubtle,
                  width: selected ? 1.6 : 1,
                ),
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            option.label,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color:
                              selected ? colors.heroEnd : colors.textSecondary,
                        ),
                      ],
                    ),
                    if (selected && isOther) ...[
                      const SizedBox(height: 10),
                      TextField(
                        controller: otherController,
                        focusNode: otherFocusNode,
                        textCapitalization: TextCapitalization.words,
                        onChanged: onOtherChanged,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          filled: false,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: l10n.onboardingTypeYourMedication,
                        ),
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _DoseChoiceGroup extends StatelessWidget {
  const _DoseChoiceGroup({
    required this.value,
    required this.options,
    required this.customValue,
    required this.customMin,
    required this.customMax,
    required this.customStep,
    required this.onChanged,
    required this.onCustomChanged,
  });

  final String? value;
  final List<_ChoiceOption> options;
  final String? customValue;
  final double customMin;
  final double customMax;
  final double customStep;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCustomChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: options.map((option) {
        final selected = option.value == value;
        final isCustom =
            option.value == _OnboardingScreenState._customDoseValue;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () {
              HapticFeedback.selectionClick();
              onChanged(option.value);
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? colors.heroEnd : colors.lineSubtle,
                  width: selected ? 1.6 : 1,
                ),
              ),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            option.label,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          selected
                              ? Icons.radio_button_checked_rounded
                              : Icons.radio_button_off_rounded,
                          color:
                              selected ? colors.heroEnd : colors.textSecondary,
                        ),
                      ],
                    ),
                    if (selected && isCustom) ...[
                      const SizedBox(height: 10),
                      CustomDoseSlider(
                        value: double.tryParse(customValue ?? '') ?? customMin,
                        min: customMin,
                        max: customMax,
                        step: customStep,
                        onChanged: onCustomChanged,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _BenefitsInsightPanel extends StatelessWidget {
  const _BenefitsInsightPanel({
    required this.specificCopy,
    required this.compact,
  });

  final String specificCopy;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(compact ? 14 : 18),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(compact ? 20 : 24),
            border: Border.all(color: colors.lineSubtle),
          ),
          child: _BenefitLine(
            icon: Icons.show_chart_rounded,
            text: specificCopy,
            compact: compact,
          ),
        ),
      ],
    );
  }
}

class _BenefitsTrendSpec {
  const _BenefitsTrendSpec({
    required this.withoutGlu,
    required this.withGlu,
  });

  final List<double> withoutGlu;
  final List<double> withGlu;
}

class _BenefitsTrendChart extends StatefulWidget {
  const _BenefitsTrendChart({
    required this.trend,
    required this.axisLabel,
    required this.compact,
  });

  final _BenefitsTrendSpec trend;
  final String axisLabel;
  final bool compact;

  @override
  State<_BenefitsTrendChart> createState() => _BenefitsTrendChartState();
}

class _BenefitsTrendChartState extends State<_BenefitsTrendChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final compact = widget.compact;
    final axisStyle = theme.textTheme.labelSmall?.copyWith(
      color: colors.textSecondary.withValues(alpha: 0.78),
      fontSize: compact ? 9 : 10,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: compact ? 132 : 164,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: compact ? 16 : 18,
                child: Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      widget.axisLabel,
                      style: axisStyle,
                    ),
                  ),
                ),
              ),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: AnimatedBuilder(
                        animation: _controller,
                          builder: (context, _) {
                            return CustomPaint(
                            size: Size(double.infinity, compact ? 116 : 148),
                            painter: _BenefitsTrendPainter(
                              colors: colors,
                              withoutGlu: widget.trend.withoutGlu,
                              withGlu: widget.trend.withGlu,
                              progress: Curves.easeOutCubic.transform(
                                _controller.value,
                              ),
                            ),
                          );
                        },
                          ),
                        ),
                    SizedBox(height: compact ? 4 : 6),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: compact ? 2 : 4),
                      child: Row(
                        children: [
                          Text(l10n.onboardingChartToday, style: axisStyle),
                          const Spacer(),
                          Text(l10n.onboardingChartOverTime, style: axisStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: compact ? 6 : 10),
        Row(
          children: [
          _TrendLegend(
            color: const Color(0xFFD86A6A),
            label: l10n.onboardingChartWithoutGlu,
            textStyle: compact
                ? theme.textTheme.labelSmall
                : theme.textTheme.labelMedium,
          ),
          SizedBox(width: compact ? 12 : 18),
          _TrendLegend(
            color: const Color(0xFF6F8DBA),
            label: l10n.onboardingChartWithGlu,
            textStyle: compact
                ? theme.textTheme.labelSmall
                : theme.textTheme.labelMedium,
          ),
          ],
        ),
      ],
    );
  }
}

class _WelcomeInterstitial extends StatefulWidget {
  const _WelcomeInterstitial({required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<_WelcomeInterstitial> createState() => _WelcomeInterstitialState();
}

class _WelcomeInterstitialState extends State<_WelcomeInterstitial> {
  static const _titleDelay = Duration(milliseconds: 900);
  static const _subtitleDelay = Duration(milliseconds: 2800);
  static const _bulletOneDelay = Duration(milliseconds: 5600);
  static const _bulletTwoDelay = Duration(milliseconds: 6200);
  static const _bulletThreeDelay = Duration(milliseconds: 6800);
  static const _bulletFourDelay = Duration(milliseconds: 7500);
  static const _ctaRevealDelay = Duration(milliseconds: 8000);

  Timer? _finishTimer;

  @override
  void initState() {
    super.initState();
    _finishTimer = Timer(_ctaRevealDelay, widget.onFinished);
  }

  @override
  void dispose() {
    _finishTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Center(
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 0.82, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: ((value - 0.82) / 0.18).clamp(0, 1),
                child: Transform.scale(scale: value, child: child),
              );
            },
            child: Container(
              width: 144,
              height: 144,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/icons/app_icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: _TypewriterText(
            l10n.onboardingWelcomeTitle,
            delay: _titleDelay,
            duration: const Duration(milliseconds: 1500),
            textAlign: TextAlign.center,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: 34,
              height: 1.05,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: _TypewriterText(
            l10n.onboardingWelcomeSubtitle,
            delay: _subtitleDelay,
            duration: const Duration(milliseconds: 2300),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.textPrimary.withValues(alpha: 0.72),
              height: 1.38,
            ),
          ),
        ),
        const SizedBox(height: 14),
        _AnimatedWelcomePanel(
          revealDelay: const Duration(milliseconds: 5000),
          entries: [
            (
              label: l10n.onboardingWelcomeBullet1,
              delay: _bulletOneDelay,
              duration: const Duration(milliseconds: 280),
            ),
            (
              label: l10n.onboardingWelcomeBullet2,
              delay: _bulletTwoDelay,
              duration: const Duration(milliseconds: 280),
            ),
            (
              label: l10n.onboardingWelcomeBullet3,
              delay: _bulletThreeDelay,
              duration: const Duration(milliseconds: 360),
            ),
            (
              label: l10n.onboardingWelcomeBullet4,
              delay: _bulletFourDelay,
              duration: const Duration(milliseconds: 320),
            ),
          ],
        ),
      ],
    );
  }
}

class _BenefitsInterstitial extends StatelessWidget {
  const _BenefitsInterstitial({
    required this.title,
    required this.subtitle,
    required this.compact,
    required this.chart,
    required this.insight,
  });

  final String title;
  final String subtitle;
  final bool compact;
  final Widget chart;
  final Widget insight;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontSize: compact ? 28 : null,
            height: compact ? 1.08 : null,
          ),
        ),
        SizedBox(height: compact ? 6 : 10),
        Text(
          subtitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.textSecondary,
            height: compact ? 1.28 : null,
          ),
        ),
        SizedBox(height: compact ? 16 : 24),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                chart,
                SizedBox(height: compact ? 10 : 16),
                insight,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NotificationsInterstitial extends StatelessWidget {
  const _NotificationsInterstitial({required this.panel});

  final Widget panel;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.onboardingNotificationsHeadline,
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 10),
        Text(
          l10n.onboardingNotificationsBody,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: panel,
          ),
        ),
      ],
    );
  }
}

class _ReviewInterstitial extends StatelessWidget {
  const _ReviewInterstitial({required this.panel});

  final Widget panel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          'A quick rating helps Glu grow.',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 24),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: panel,
          ),
        ),
      ],
    );
  }
}

class _SetupSummaryInterstitial extends StatefulWidget {
  const _SetupSummaryInterstitial({
    required this.messages,
    required this.headline,
    required this.body,
    required this.items,
    required this.onReady,
  });

  final List<String> messages;
  final String headline;
  final String body;
  final List<({String label, String value, IconData icon})> items;
  final VoidCallback onReady;

  @override
  State<_SetupSummaryInterstitial> createState() =>
      _SetupSummaryInterstitialState();
}

class _SetupSummaryInterstitialState extends State<_SetupSummaryInterstitial> {
  static const _messageStep = Duration(milliseconds: 900);
  int _visibleMessages = 0;
  bool _showSummary = false;
  Timer? _messageTimer;
  List<bool> _visibleSummaryRows = const [];
  bool _didNotifyReady = false;

  @override
  void didUpdateWidget(covariant _SetupSummaryInterstitial oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      _visibleSummaryRows = List<bool>.filled(widget.items.length, false);
      _didNotifyReady = false;
      if (_showSummary) {
        _revealSummaryRows();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _visibleSummaryRows = List<bool>.filled(widget.items.length, false);
    _advanceMessages();
  }

  @override
  void dispose() {
    _messageTimer?.cancel();
    super.dispose();
  }

  void _advanceMessages() {
    if (!mounted) {
      return;
    }
    if (_visibleMessages < widget.messages.length) {
      _messageTimer = Timer(_messageStep, () {
        if (!mounted) {
          return;
        }
        setState(() {
          _visibleMessages += 1;
        });
        _advanceMessages();
      });
      return;
    }
    _messageTimer = Timer(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _showSummary = true;
        });
        _revealSummaryRows();
      }
    });
  }

  void _revealSummaryRows() {
    if (widget.items.isEmpty) {
      _notifyReady();
      return;
    }
    for (var i = 0; i < widget.items.length; i++) {
      Future.delayed(Duration(milliseconds: 120 + (i * 110)), () {
        if (!mounted || !_showSummary || i >= _visibleSummaryRows.length) {
          return;
        }
        setState(() {
          _visibleSummaryRows[i] = true;
        });
        if (i == widget.items.length - 1) {
          _notifyReady();
        }
      });
    }
  }

  void _notifyReady() {
    if (_didNotifyReady) return;
    _didNotifyReady = true;
    widget.onReady();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_showSummary) ...[
          Text(
            widget.headline,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            widget.body,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: colors.textSecondary,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 24),
        ],
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 340),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeOut,
              child: !_showSummary
                  ? Container(
                      key: const ValueKey('setup-loading'),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: colors.lineSubtle),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: colors.heroEnd,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                l10n.onboardingSetupLoadingTitle,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...List.generate(widget.messages.length, (index) {
                            final visible = index < _visibleMessages;
                            return AnimatedOpacity(
                              duration: const Duration(milliseconds: 260),
                              opacity: visible ? 1 : 0.18,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: visible
                                            ? const Color(0xFF2E9B63)
                                            : colors.lineSubtle,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        widget.messages[index],
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: colors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    )
                  : Column(
                      key: const ValueKey('setup-summary'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: colors.surface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: colors.lineSubtle.withValues(alpha: 0.9),
                            ),
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final tileWidth = (constraints.maxWidth - 12) / 2;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.onboardingSetupSummaryLabel,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: colors.textSecondary,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Wrap(
                                    spacing: 12,
                                    runSpacing: 12,
                                    children: [
                                      for (var i = 0;
                                          i < widget.items.length;
                                          i++)
                                        SizedBox(
                                          width: tileWidth,
                                          child: AnimatedSlide(
                                            duration: const Duration(
                                                milliseconds: 360),
                                            curve: Curves.easeOutCubic,
                                            offset: _visibleSummaryRows[i]
                                                ? Offset.zero
                                                : const Offset(0, 0.08),
                                            child: AnimatedOpacity(
                                              duration: const Duration(
                                                  milliseconds: 320),
                                              opacity: _visibleSummaryRows[i]
                                                  ? 1
                                                  : 0,
                                              child: _SetupSummaryRow(
                                                label: widget.items[i].label,
                                                value: widget.items[i].value,
                                                icon: widget.items[i].icon,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.onboardingSetupAdjustLater,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary.withValues(alpha: 0.9),
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          l10n.commonDisclaimer,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.textSecondary.withValues(alpha: 0.8),
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SetupSummaryRow extends StatelessWidget {
  const _SetupSummaryRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.softSurface.withValues(alpha: 0.46),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 16,
              color: colors.heroEnd,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              color: colors.textPrimary.withValues(alpha: 0.96),
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitLine extends StatelessWidget {
  const _BenefitLine({
    required this.icon,
    required this.text,
    this.compact = false,
  });

  final IconData icon;
  final String text;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: colors.heroEnd, size: compact ? 16 : 18),
        SizedBox(width: compact ? 8 : 10),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
              height: compact ? 1.25 : 1.4,
              fontSize: compact ? 13 : null,
            ),
          ),
        ),
      ],
    );
  }
}

class _TrendLegend extends StatelessWidget {
  const _TrendLegend({
    required this.color,
    required this.label,
    required this.textStyle,
  });

  final Color color;
  final String label;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: textStyle?.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _BenefitsTrendPainter extends CustomPainter {
  const _BenefitsTrendPainter({
    required this.colors,
    required this.withoutGlu,
    required this.withGlu,
    required this.progress,
  });

  final AppColors colors;
  final List<double> withoutGlu;
  final List<double> withGlu;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final chartRect = Rect.fromLTWH(0, 8, size.width, size.height - 20);
    final gridPaint = Paint()
      ..color = colors.lineSubtle.withValues(alpha: 0.7)
      ..strokeWidth = 1;

    for (final ratio in [0.2, 0.5, 0.8]) {
      final y = chartRect.top + (chartRect.height * ratio);
      _drawDashedLine(
        canvas,
        Offset(chartRect.left, y),
        Offset(chartRect.right, y),
        gridPaint,
      );
    }

    _drawSeries(
      canvas,
      chartRect,
      withoutGlu,
      const Color(0xFFD86A6A),
      2.4,
    );
    _drawSeries(
      canvas,
      chartRect,
      withGlu,
      const Color(0xFF6F8DBA),
      3,
    );
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
  ) {
    const dashWidth = 6.0;
    const dashGap = 5.0;
    var currentX = start.dx;
    while (currentX < end.dx) {
      final nextX = (currentX + dashWidth).clamp(start.dx, end.dx);
      canvas.drawLine(
        Offset(currentX, start.dy),
        Offset(nextX, end.dy),
        paint,
      );
      currentX += dashWidth + dashGap;
    }
  }

  void _drawSeries(
    Canvas canvas,
    Rect rect,
    List<double> points,
    Color color,
    double strokeWidth,
  ) {
    if (points.length < 2) {
      return;
    }

    const horizontalInset = 8.0;
    final usableWidth = rect.width - (horizontalInset * 2);
    final stepX = usableWidth / (points.length - 1);
    final offsets = <Offset>[];
    for (var index = 0; index < points.length; index++) {
      final x = rect.left + horizontalInset + (stepX * index);
      final y = rect.bottom - (rect.height * points[index].clamp(0.0, 1.0));
      offsets.add(Offset(x, y));
    }

    final path = Path()..moveTo(offsets.first.dx, offsets.first.dy);
    for (var index = 0; index < offsets.length - 1; index++) {
      final current = offsets[index];
      final next = offsets[index + 1];
      final control = Offset(
        (current.dx + next.dx) / 2,
        current.dy,
      );
      final end = Offset(
        (current.dx + next.dx) / 2,
        (current.dy + next.dy) / 2,
      );
      path.quadraticBezierTo(control.dx, control.dy, end.dx, end.dy);
      path.quadraticBezierTo(next.dx, next.dy, next.dx, next.dy);
    }

    final areaPath = Path.from(path)
      ..lineTo(offsets.last.dx, rect.bottom)
      ..lineTo(offsets.first.dx, rect.bottom)
      ..close();

    final revealWidth = rect.width * progress.clamp(0.0, 1.0);
    canvas.save();
    canvas.clipRect(
      Rect.fromLTWH(rect.left, rect.top, revealWidth, rect.height + 8),
    );

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.02),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.fill;
    canvas.drawPath(areaPath, fillPaint);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = color;
    for (final point in [offsets.first, offsets.last]) {
      canvas.drawCircle(point, 4.5, dotPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BenefitsTrendPainter oldDelegate) {
    return oldDelegate.colors != colors ||
        oldDelegate.withoutGlu != withoutGlu ||
        oldDelegate.withGlu != withGlu ||
        oldDelegate.progress != progress;
  }
}

class _NotificationsPrimerPanel extends StatelessWidget {
  const _NotificationsPrimerPanel({
    required this.bullets,
  });

  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: colors.softSurface,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              Icons.notifications_active_rounded,
              color: colors.heroEnd,
            ),
          ),
          const SizedBox(height: 18),
          ...List.generate(bullets.length, (index) {
            final bullet = bullets[index];
            final isLast = index == bullets.length - 1;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _BulletLine(bullet),
                ),
                if (!isLast)
                  FractionallySizedBox(
                    widthFactor: 0.84,
                    child: Container(
                      height: 0.45,
                      color: colors.lineSubtle.withValues(alpha: 0.38),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ReviewPromptPanel extends StatelessWidget {
  const _ReviewPromptPanel();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final testimonials = const [
      (
        'Glu makes my medication routine feel lighter and much easier to stay on top of.',
        'Maya, 34',
        'assets/images/reviewers/reviewer_1.jpeg',
      ),
      (
        'I like that it feels supportive without becoming another stressful health app.',
        'Jordan, 41',
        'assets/images/reviewers/reviewer_2.jpeg',
      ),
      (
        'The reminders and structure help me stay focused on my goal instead of guessing what comes next.',
        'Chris, 29',
        'assets/images/reviewers/reviewer_3.jpeg',
      ),
    ];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: colors.lineSubtle),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (_) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Icon(
                      Icons.star_rounded,
                      color: Color(0xFFE4802A),
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.onboardingReviewBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...testimonials.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colors.lineSubtle),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.lineSubtle),
                      image: DecorationImage(
                        image: AssetImage(item.$3),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '“${item.$1}”',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colors.textPrimary,
                            height: 1.45,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.$2,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MultiSelectGroup extends StatelessWidget {
  const _MultiSelectGroup({
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  final List<_ChoiceOption> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Column(
      children: options.map((option) {
        final isSelected = selected.contains(option.value);
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              HapticFeedback.selectionClick();
              final next = List<String>.from(selected);
              if (isSelected) {
                next.remove(option.value);
              } else {
                next.add(option.value);
              }
              onChanged(next);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? colors.accentButter : colors.surface,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: isSelected ? colors.heroEnd : colors.lineSubtle,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option.label,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.radio_button_unchecked_rounded,
                    color: isSelected ? colors.heroEnd : colors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TextInputCard extends StatelessWidget {
  const _TextInputCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: child,
    );
  }
}

class _AgePickerCard extends StatefulWidget {
  const _AgePickerCard({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  State<_AgePickerCard> createState() => _AgePickerCardState();
}

class _AgePickerCardState extends State<_AgePickerCard> {
  late FixedExtentScrollController _controller;
  late int _selectedAge;

  int get _clampedValue => widget.value.clamp(widget.min, widget.max);

  @override
  void initState() {
    super.initState();
    _selectedAge = _clampedValue;
    _controller = FixedExtentScrollController(
      initialItem: _selectedAge - widget.min,
    );
  }

  @override
  void didUpdateWidget(covariant _AgePickerCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextValue = _clampedValue;
    if (nextValue != _selectedAge) {
      _selectedAge = nextValue;
      _controller.jumpToItem(nextValue - widget.min);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);
    final values = List<int>.generate(
      widget.max - widget.min + 1,
      (index) => widget.min + index,
    );

    return _WellnessPanel(
      children: [
        SizedBox(
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: [
              IgnorePointer(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: colors.softSurface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: colors.lineSubtle),
                  ),
                ),
              ),
              ListWheelScrollView.useDelegate(
                controller: _controller,
                itemExtent: 52,
                physics: const FixedExtentScrollPhysics(),
                perspective: 0.003,
                diameterRatio: 1.8,
                onSelectedItemChanged: (index) {
                  final nextAge = values[index];
                  if (nextAge == _selectedAge) {
                    return;
                  }
                  setState(() {
                    _selectedAge = nextAge;
                  });
                  widget.onChanged(nextAge);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: values.length,
                  builder: (context, index) {
                    final age = values[index];
                    final isSelected = age == _selectedAge;
                    return Center(
                      child: Text(
                        '$age',
                        style: (isSelected
                                ? theme.textTheme.headlineSmall
                                : theme.textTheme.titleLarge)
                            ?.copyWith(
                          color: isSelected
                              ? colors.textPrimary
                              : colors.textSecondary,
                          fontWeight:
                              isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MedicationStartedEditor extends StatefulWidget {
  const _MedicationStartedEditor({
    required this.dateIso,
    required this.weightValue,
    required this.onDateChanged,
    required this.onWeightChanged,
  });

  final String? dateIso;
  final dynamic weightValue;
  final ValueChanged<String?> onDateChanged;
  final ValueChanged<Map<String, dynamic>> onWeightChanged;

  @override
  State<_MedicationStartedEditor> createState() =>
      _MedicationStartedEditorState();
}

class _MedicationStartedEditorState extends State<_MedicationStartedEditor> {
  Future<void> _pickDate() async {
    final existing =
        widget.dateIso == null ? null : DateTime.tryParse(widget.dateIso!);
    final picked = await showDatePicker(
      context: context,
      initialDate: existing ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked == null) {
      return;
    }
    HapticFeedback.selectionClick();
    widget.onDateChanged(DateUtils.dateOnly(picked).toIso8601String());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final date =
        widget.dateIso == null ? null : DateTime.tryParse(widget.dateIso!);

    return Column(
      children: [
        GestureDetector(
          onTap: _pickDate,
          child: _TextInputCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_rounded, size: 18),
                  const SizedBox(width: 12),
                  Text(
                    date == null
                        ? l10n.onboardingSelectStartDate
                        : DateFormat('MMM d, yyyy').format(date),
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        WeightDialSelector(
          value: widget.weightValue,
          onChanged: widget.onWeightChanged,
          showStepButtons: true,
        ),
      ],
    );
  }
}

class _WellnessPanel extends StatelessWidget {
  const _WellnessPanel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i != children.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: FractionallySizedBox(
                  widthFactor: 0.84,
                  alignment: Alignment.center,
                  child: Divider(
                    thickness: 0.6,
                    height: 1,
                    color: colors.lineSubtle.withValues(alpha: 0.5),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _AnimatedWelcomePanel extends StatelessWidget {
  const _AnimatedWelcomePanel({
    required this.revealDelay,
    required this.entries,
  });

  final Duration revealDelay;
  final List<({String label, Duration delay, Duration duration})> entries;

  @override
  Widget build(BuildContext context) {
    return _DelayedFadeSlide(
      delay: revealDelay,
      duration: const Duration(milliseconds: 650),
      beginOffset: const Offset(0, -0.06),
      child: _AnimatedWelcomePanelBody(entries: entries),
    );
  }
}

class _AnimatedWelcomePanelBody extends StatelessWidget {
  const _AnimatedWelcomePanelBody({
    required this.entries,
  });

  final List<({String label, Duration delay, Duration duration})> entries;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: colors.lineSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < entries.length; i++) ...[
            _AnimatedWelcomeBullet(
              label: entries[i].label,
              delay: entries[i].delay,
              duration: entries[i].duration,
            ),
            if (i != entries.length - 1)
              _AnimatedWelcomeDivider(
                delay: entries[i].delay + entries[i].duration,
              ),
          ],
        ],
      ),
    );
  }
}

class _DelayedFadeSlide extends StatefulWidget {
  const _DelayedFadeSlide({
    required this.delay,
    required this.duration,
    required this.beginOffset,
    required this.child,
  });

  final Duration delay;
  final Duration duration;
  final Offset beginOffset;
  final Widget child;

  @override
  State<_DelayedFadeSlide> createState() => _DelayedFadeSlideState();
}

class _DelayedFadeSlideState extends State<_DelayedFadeSlide> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      offset: _visible ? Offset.zero : widget.beginOffset,
      child: AnimatedOpacity(
        duration: widget.duration,
        curve: Curves.easeOut,
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}

class _AnimatedWelcomeDivider extends StatefulWidget {
  const _AnimatedWelcomeDivider({
    required this.delay,
  });

  final Duration delay;

  @override
  State<_AnimatedWelcomeDivider> createState() =>
      _AnimatedWelcomeDividerState();
}

class _AnimatedWelcomeDividerState extends State<_AnimatedWelcomeDivider> {
  bool _visible = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
        opacity: _visible ? 1 : 0,
        child: FractionallySizedBox(
          widthFactor: 0.84,
          alignment: Alignment.center,
          child: Divider(
            thickness: 0.45,
            height: 1,
            color: colors.lineSubtle.withValues(alpha: 0.38),
          ),
        ),
      ),
    );
  }
}

class _AnimatedWelcomeBullet extends StatefulWidget {
  const _AnimatedWelcomeBullet({
    required this.label,
    required this.delay,
    required this.duration,
  });

  final String label;
  final Duration delay;
  final Duration duration;

  @override
  State<_AnimatedWelcomeBullet> createState() => _AnimatedWelcomeBulletState();
}

class _AnimatedWelcomeBulletState extends State<_AnimatedWelcomeBullet>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowController;
  bool _visible = false;
  Timer? _revealTimer;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _revealTimer = Timer(widget.delay, () {
      if (mounted) {
        setState(() => _visible = true);
      }
    });
  }

  @override
  void dispose() {
    _revealTimer?.cancel();
    _glowController.dispose();
    super.dispose();
  }

  Future<void> _showGlow() async {
    if (!mounted) return;
    await _glowController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      opacity: _visible ? 1 : 0,
      child: IgnorePointer(
        ignoring: !_visible,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _glowController,
              builder: (context, child) {
                final t = Curves.easeOut.transform(_glowController.value);
                return Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colors.heroEnd.withValues(alpha: 0.78 + (t * 0.22)),
                    shape: BoxShape.circle,
                    boxShadow: t == 0
                        ? null
                        : [
                            BoxShadow(
                              color: colors.heroEnd.withValues(alpha: 0.24 * t),
                              blurRadius: 12 * t,
                              spreadRadius: 1.8 * t,
                            ),
                          ],
                  ),
                );
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _TypewriterText(
                widget.label,
                delay: widget.delay,
                duration: widget.duration,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  color: colors.textPrimary.withValues(alpha: 0.84),
                ),
                onCompleted: _showGlow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: colors.heroEnd,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: colors.textPrimary.withValues(alpha: 0.84),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypewriterText extends StatefulWidget {
  const _TypewriterText(
    this.text, {
    required this.delay,
    required this.duration,
    this.style,
    this.textAlign,
    this.onCompleted,
  });

  final String text;
  final Duration delay;
  final Duration duration;
  final TextStyle? style;
  final TextAlign? textAlign;
  final VoidCallback? onCompleted;

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _startTimer;
  bool _completed = false;
  int _lastHapticIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addListener(() {
        final visibleCount = (_controller.value * widget.text.length)
            .round()
            .clamp(0, widget.text.length);
        if (visibleCount > 0 &&
            visibleCount != _lastHapticIndex &&
            (visibleCount == 1 ||
                visibleCount == widget.text.length ||
                visibleCount % 4 == 0)) {
          _lastHapticIndex = visibleCount;
          HapticFeedback.selectionClick();
        }
        if (mounted) {
          setState(() {});
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed && !_completed) {
          _completed = true;
          widget.onCompleted?.call();
        }
      });
    _startTimer = Timer(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _startTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visibleCount = (_controller.value * widget.text.length)
        .round()
        .clamp(0, widget.text.length);
    final visibleText = widget.text.substring(0, visibleCount);

    return Text(
      visibleText,
      textAlign: widget.textAlign,
      style: widget.style,
    );
  }
}
