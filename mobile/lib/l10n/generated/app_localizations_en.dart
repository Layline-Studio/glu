// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Waking up...';

  @override
  String get startupFailed => 'Startup failed';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonSaving => 'Saving...';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonNotNow => 'Not now';

  @override
  String get commonNow => 'Now';

  @override
  String get commonTomorrow => 'Tomorrow';

  @override
  String get noteTriggerAddNote => 'Add note';

  @override
  String get noteTriggerCancelNote => 'Cancel note';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'In $count days';
  }

  @override
  String get homeDoseReminderInOneWeek => 'In 1 week';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'In $count weeks';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Due 1 day ago';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Due $count days ago';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Due 1 week ago';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Due $count weeks ago';
  }

  @override
  String get bmiIndicatorYourBmi => 'Your BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Your current BMI';

  @override
  String get bmiIndicatorUnderweight => 'Underweight';

  @override
  String get bmiIndicatorNormal => 'Normal';

  @override
  String get bmiIndicatorOverweight => 'Overweight';

  @override
  String get bmiIndicatorObesity => 'Obesity';

  @override
  String get heightRulerCmUnit => 'cm';

  @override
  String get heightRulerFtUnit => 'ft';

  @override
  String get heightRulerInUnit => 'in';

  @override
  String get heightRulerFtInUnit => 'ft/in';

  @override
  String get weightDialKgUnit => 'kg';

  @override
  String get weightDialLbUnit => 'lb';

  @override
  String get logNoteIndicatorHasNote => 'Has note';

  @override
  String get paywallTitle => 'Unlock Glu Pro';

  @override
  String get paywallSubtitle => 'Without Pro, here\'s what you lose:';

  @override
  String get paywallMonthlyTitle => 'Monthly';

  @override
  String get paywallMonthlySubtitle => 'No trial';

  @override
  String get paywallYearlyTitle => 'Yearly';

  @override
  String get paywallYearlySubtitle => '7-day free trial';

  @override
  String get paywallNoCommitment => 'No commitment';

  @override
  String get paywallCancelAnytime => 'Cancel anytime';

  @override
  String get paywallContinue => 'Continue';

  @override
  String get paywallRestore => 'Restore';

  @override
  String get paywallTerms => 'Terms';

  @override
  String get paywallPrivacy => 'Privacy';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Save $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Could not open link right now.';

  @override
  String get paywallAlreadySubscribed => 'You already have Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Welcome to Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'Purchase did not complete. Please try again.';

  @override
  String get paywallPurchaseFailed => 'Purchase failed. Please try again.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Purchase failed: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Subscription restored!';

  @override
  String get paywallRestoreNoSubscription => 'No active subscription found.';

  @override
  String get paywallRestoreFailed => 'Restore failed. Please try again.';

  @override
  String get paywallBenefitReminders => 'Miss doses without reminders';

  @override
  String get paywallBenefitShareProgress => 'Harder to share your progress';

  @override
  String get paywallBenefitSpotRegain => 'Miss regain signs';

  @override
  String get paywallBenefitInsights => 'Miss your daily patterns';

  @override
  String get paywallBenefitWeeklyGoals => 'Lose your weekly structure';

  @override
  String get paywallBenefitHealthyHabits => 'Habits slip without support';

  @override
  String get onboardingWelcomeTitle => 'Keep the weight off';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu helps you protect your progress around treatment, goals, and weekly habits.';

  @override
  String get onboardingWelcomeBullet1 => 'Fits your treatment and goals';

  @override
  String get onboardingWelcomeBullet2 => 'Simple and realistic support';

  @override
  String get onboardingWelcomeBullet3 =>
      'Easily spot early signs of weight regain';

  @override
  String get onboardingWelcomeBullet4 => 'Keep going without starting over';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Are you currently taking a weight loss pen or pill medication?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'We use this to show guidance that matches where you are right now.';

  @override
  String get onboardingMedicationStatusUsing => 'Yes, I’m taking it now';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Yes, I’m weaning off';

  @override
  String get onboardingMedicationStatusNotTaking => 'No, I’m not taking it';

  @override
  String get onboardingMedicationStatusStartingSoon => 'No, I’ll start soon';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'No, I recently stopped';

  @override
  String get onboardingMedicationMethodQuestion =>
      'How do you take your medication?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'We use this to tailor instructions and reminders to your medication format.';

  @override
  String get onboardingMedicationMethodInjection => 'Injection';

  @override
  String get onboardingMedicationMethodPill => 'Pill';

  @override
  String get onboardingMedicationMethodUnknown => 'I don’t know yet';

  @override
  String get onboardingMedicationNameQuestion =>
      'Which medication are you taking?';

  @override
  String get onboardingMedicationNameExplainer =>
      'We use this to personalize dose tracking and medication-specific guidance.';

  @override
  String get onboardingCurrentDoseQuestion => 'What’s your current dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'We use this to tailor dose tracking and future progress check-ins.';

  @override
  String get onboardingMedicationCustomDose => 'Custom';

  @override
  String get onboardingDeviceTypeQuestion =>
      'What device do you use to take your medication?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'We use this to make reminders and tips match the way you take it.';

  @override
  String get onboardingDeviceSinglePen => 'Single pen';

  @override
  String get onboardingDeviceAutoInjector => 'Auto-injector';

  @override
  String get onboardingDeviceSyringeAndVial => 'Syringe and vial';

  @override
  String get onboardingOther => 'Other';

  @override
  String get onboardingTypeYourDevice => 'Type your device';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'How often do you take your medication?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'We use this to time reminders and routine support around your schedule.';

  @override
  String get onboardingEveryDay => 'Every day';

  @override
  String get onboardingEvery7Days => 'Every 7 days';

  @override
  String get onboardingEvery14Days => 'Every 14 days';

  @override
  String get onboardingCustom => 'Custom';

  @override
  String get onboardingDaysBetweenDoses => 'Days between doses';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'What’s your primary goal right now?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'We use this to focus your plan, reminders, and progress around what matters most to you.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'We use this to shape your plan from the very beginning.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'We use this to support your next phase and help you stay on track.';

  @override
  String get onboardingGoalLoseWeight => 'Lose weight';

  @override
  String get onboardingGoalMaintainWeight => 'Maintain my weight';

  @override
  String get onboardingGoalManageDiabetes => 'Manage my diabetes';

  @override
  String get onboardingGoalManagePcos => 'Manage my PCOS';

  @override
  String get onboardingGoalImproveHeartHealth => 'Improve my heart health';

  @override
  String get onboardingAgeQuestion => 'What’s your age?';

  @override
  String get onboardingAgeExplainer =>
      'We use this to adjust guidance and health calculations more appropriately.';

  @override
  String get onboardingHeightQuestion => 'What’s your height?';

  @override
  String get onboardingHeightExplainer =>
      'We use this with your weight to calculate things like BMI and healthy ranges.';

  @override
  String get onboardingWeightQuestion => 'What’s your current weight?';

  @override
  String get onboardingWeightExplainer =>
      'We use this as your starting point for progress, goals, and health estimates.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'When did you stop the medication?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'When did you start weaning off the medication?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'When did you start the medication?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'We use this to understand your recent treatment history and next phase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'We use this to understand your transition phase and support the habits that matter most now.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'We use this to understand how long you’ve been on treatment and track change over time.';

  @override
  String get onboardingGoalWeightQuestion => 'What’s your goal weight?';

  @override
  String get onboardingGoalWeightExplainer =>
      'We use this to frame progress and show a target BMI range for you.';

  @override
  String get onboardingBenefitsQuestion => 'What Glu will help you do next';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu turns what you shared into reminders, support, and structure that fit your routine.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Here’s how Glu can help you maintain your progress';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Here’s how Glu can support your diabetes routine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Here’s how Glu can support your PCOS routine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Here’s how Glu can support your heart health';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Here’s how Glu can help you lose weight';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'See how Glu helps you protect your current weight and catch regain early.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'See how Glu helps you keep meals, weight, and routines steadier week to week.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'See how Glu helps you stay steadier around symptoms, weight, and routine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'See how Glu helps you stay consistent with the habits that support heart health.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'See how Glu helps you spot the patterns that keep weight moving down.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Without structure, regain can build quietly. Glu helps you catch it earlier and stay steady.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Without structure, meals and weight patterns get noisy. Glu keeps the signals clearer.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Without structure, symptoms and routines can swing more. Glu helps you stay steadier.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Without structure, healthy habits drift. Glu helps you keep activity and weight on track.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Without structure, weight can stall or drift up. Glu helps keep progress moving in the right direction.';

  @override
  String get onboardingBenefitsAxisWeight => 'Weight';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Meals & weight';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptoms & weight';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Exercise & weight';

  @override
  String get onboardingNotificationsQuestion =>
      'Turn on reminders that support your goal';

  @override
  String get onboardingNotificationsExplainer =>
      'We’ll use notifications to help you stay consistent, prepared, and on track.';

  @override
  String get onboardingNotificationsHeadline =>
      'Set Glu up to help at the right moment.';

  @override
  String get onboardingNotificationsBody =>
      'Turn on notifications so Glu can reinforce the habits that support your goal.';

  @override
  String get onboardingNotificationsDaily =>
      'Timed reminders that match your daily medication rhythm';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Longer-range reminders so dose days do not sneak up on you';

  @override
  String get onboardingNotificationsCustom =>
      'Reminders shaped around your custom schedule';

  @override
  String get onboardingNotificationsWeekly =>
      'Dose reminders that stay aligned with your weekly rhythm';

  @override
  String get onboardingNotificationsSupportive =>
      'Supportive reminders that keep your routine visible when motivation dips';

  @override
  String get onboardingNotificationsProgress =>
      'Timely nudges around progress, habits, and the goals you told us matter most';

  @override
  String get onboardingNotificationsHelpful =>
      'Helpful prompts that make Glu more useful in the moments you need it';

  @override
  String get onboardingDailyRoutineQuestion => 'What’s your daily routine?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'We use this to make your plan feel realistic for your day-to-day life.';

  @override
  String get onboardingRoutineSedentary => 'Sedentary';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Mostly sitting, desk work, and very little intentional exercise.';

  @override
  String get onboardingRoutineLightlyActive => 'Lightly active';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regular walking, errands, or light workouts a few times a week.';

  @override
  String get onboardingRoutineActive => 'Active';

  @override
  String get onboardingRoutineActiveDescription =>
      'Frequent movement or exercise, like daily walks, gym, or active work.';

  @override
  String get onboardingRoutineVeryActive => 'Very active';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard training, physically demanding work, or high activity most days.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Which symptoms are you most concerned about, if any?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'We use this to prioritize tips and guidance around the symptoms you care about most.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'We use this to focus on the symptoms you want to stay ahead of.';

  @override
  String get onboardingGenderQuestion => 'How do you describe your gender?';

  @override
  String get onboardingGenderExplainer =>
      'We use this for more relevant guidance and future personalization.';

  @override
  String get onboardingGenderFemale => 'Female';

  @override
  String get onboardingGenderMale => 'Male';

  @override
  String get onboardingGenderPreferNotToSay => 'Prefer not to say';

  @override
  String get onboardingTypeYourGender => 'Type your gender';

  @override
  String get onboardingPreferredNameQuestion => 'What should we call you?';

  @override
  String get onboardingPreferredNameExplainer =>
      'We use this to make Glu feel more personal when we talk to you.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Setting up your plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'We’re turning what you shared into a plan Glu can support right away.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Locking in weight-maintenance targets...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Setting up regain watchpoints...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Tuning reminders around your routine...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Preparing a steadier weekly plan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Defining meal and weight patterns...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Setting hydration support...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Preparing consistency reminders...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Building a clearer daily structure...';

  @override
  String get onboardingSetupSummaryPcosStep1 => 'Organizing symptom support...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Defining weekly movement targets...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Setting hydration and routine anchors...';

  @override
  String get onboardingSetupSummaryPcosStep4 => 'Preparing a steadier plan...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'Setting activity targets...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Defining hydration support...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Preparing weekly habit reminders...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Building a heart-health routine...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Defining calorie boundaries...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Setting water amounts...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Building exercise targets...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Preparing your weekly plan...';

  @override
  String get onboardingSetupSummaryHeadline => 'Your Glu setup is ready.';

  @override
  String get onboardingSetupLoadingTitle => 'Building your setup';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu is ready to help you protect your progress with clearer structure and earlier regain signals.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu is ready to support steadier meals, weight tracking, and habits that matter day to day.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu is ready to support steadier routines around symptoms, treatment, and progress.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu is ready to reinforce the habits that support your long-term heart health.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu is ready to support the routines that help you keep the weight off.';

  @override
  String get onboardingSetupSummaryLabel => 'Summary';

  @override
  String get onboardingSetupAdjustLater =>
      'You can adjust any of this later in Settings.';

  @override
  String get onboardingSummaryGoal => 'Goal';

  @override
  String get onboardingSummaryCurrentWeight => 'Current weight';

  @override
  String get onboardingSummaryMedication => 'Medication';

  @override
  String get onboardingSummaryCurrentDose => 'Current dose';

  @override
  String get onboardingSummaryCadence => 'Cadence';

  @override
  String get onboardingSummaryStarted => 'Started';

  @override
  String get onboardingSummaryTargetWeight => 'Target weight';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'Focus';

  @override
  String get onboardingFrequencyEveryDay => 'Every day';

  @override
  String get onboardingFrequencyEveryWeek => 'Every week';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Every 2 weeks';

  @override
  String get onboardingFrequencyCustomSchedule => 'Custom schedule';

  @override
  String get onboardingTapOptionContinue => 'Tap an option to continue.';

  @override
  String get onboardingTypeGenderContinue => 'Type your gender to continue.';

  @override
  String get onboardingTypeDeviceContinue => 'Type your device to continue.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Type your medication to continue.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Enter days between doses to continue.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Choose a schedule to continue.';

  @override
  String get onboardingScrollChooseAge => 'Scroll to choose your age.';

  @override
  String get onboardingDragOrTapHeight =>
      'Drag or tap the ruler to choose your height.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Drag, tap, or use the step buttons to choose a weight.';

  @override
  String get onboardingPickDateAndWeight =>
      'Pick a date and choose a weight to continue.';

  @override
  String get onboardingSelectSymptoms =>
      'Select any symptoms you want Glu to focus on.';

  @override
  String get onboardingTypeName => 'Type the name you want Glu to use.';

  @override
  String get onboardingSaving => 'Saving...';

  @override
  String get onboardingLetsBegin => 'Let’s begin';

  @override
  String get onboardingContinueWithGlu => 'Continue with Glu';

  @override
  String get onboardingKeepGoing => 'Keep going';

  @override
  String get onboardingTurnOnNotifications => 'Turn on notifications';

  @override
  String get onboardingFinish => 'Finish';

  @override
  String get onboardingTargetBmiTitle => 'Your target BMI';

  @override
  String get onboardingChartToday => 'Today';

  @override
  String get onboardingChartOverTime => 'Over time';

  @override
  String get onboardingChartWithoutGlu => 'Without Glu';

  @override
  String get onboardingChartWithGlu => 'With Glu';

  @override
  String get onboardingReviewQuestion =>
      'People use Glu to stay steady and supported';

  @override
  String get onboardingReviewExplainer =>
      'A quick rating helps more people find support that feels this simple.';

  @override
  String get onboardingReviewBody =>
      'People use Glu to feel more supported, more consistent, and less alone in the process.';

  @override
  String get onboardingTypeYourMedication => 'Type your medication';

  @override
  String get onboardingSelectStartDate => 'Select start date';

  @override
  String get goalsSaveDialogTitle => 'Save goals?';

  @override
  String get goalsSaveDialogMessage =>
      'You have unsaved goal changes. Save them before leaving this tab?';

  @override
  String get commonLater => 'Later';

  @override
  String get homeGreetingAnonymous => 'Hi';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hi, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Track today to see insight';

  @override
  String get homeInsightEmptyBody =>
      'Log something today, and you’ll see your insight tonight.';

  @override
  String get homeInsightLogTodayTitle => 'Tap to see your insight';

  @override
  String get homeInsightMoreLogsVariant1Title => 'Tap to see today\'s insight';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Your logs are starting to show a pattern — tap in to see it.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Tap to see your insight';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'A few more logs could make the picture clearer — tap in anytime.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Tap to uncover today\'s insight';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'There may already be a pattern hiding in your day — tap to see.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Log something today, then tap to see what it reveals.';

  @override
  String get homeInsightExpandedTitle => 'Was this helpful?';

  @override
  String get homeInsightExpandedBody =>
      'A quick rating helps Glu learn what matters most to you.';

  @override
  String get homeInsightReasonHint => 'What could be better? (optional)';

  @override
  String get homeInsightReasonSubmit => 'Submit';

  @override
  String get homeInsightLearningMessage => 'I\'ll learn from this.';

  @override
  String get homeInsightChecking => 'Checking today’s insight...';

  @override
  String get homeInsightGenerating => 'Loading today’s insight...';

  @override
  String get homeInsightTryAgain => 'Try again';

  @override
  String get homeSeeAllInsights => 'See all insights';

  @override
  String get insightsProgressTitle => 'All insights';

  @override
  String get insightsProgressEmptyState =>
      'Your insights will appear here once they are generated.';

  @override
  String get homeDoseReminderTitle => 'Dose reminder';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Log $label interaction goes here.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Calorie goal required';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check needs a Meal goal set to Calories to estimate your portion. Set one in Goals to get started.';

  @override
  String get homeSetGoal => 'Set goal';

  @override
  String get homeYourProgress => 'Your progress';

  @override
  String get homeRemindersShowcaseTitle => 'Stay on track';

  @override
  String get homeRemindersShowcaseDescription =>
      'Set up reminders to keep doses and supplements on time.';

  @override
  String get homePickNextDoseDate => 'Pick your next dose date';

  @override
  String get homeSetReminder => 'Set reminder';

  @override
  String get homeSupplementReminders => 'Supplement reminders';

  @override
  String get homeNoUpcomingSupplements => 'No upcoming supplements';

  @override
  String get homeNoMoreUpcomingSupplements => 'No more upcoming';

  @override
  String get homeSetUpYourSupplements => 'Set up your supplements';

  @override
  String get homeSetUp => 'Set up';

  @override
  String get homeSupplementFallback => 'Supplement';

  @override
  String get doseReminderNotificationTitle => 'Ready for your dose?';

  @override
  String get doseReminderFallbackBody => 'Open Glu to review your next dose.';

  @override
  String get supplementReminderNotificationTitle => 'Time for your supplement';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'This morning';

  @override
  String get supplementReminderThisAfternoon => 'This afternoon';

  @override
  String get supplementReminderTonight => 'Tonight';

  @override
  String get dailyReminderMorningTitle => 'Morning check-in';

  @override
  String get dailyReminderMorningBodies =>
      'Morning mission: give Glu a little data to play with.\nKick off the day with a quick log and some good momentum.\nRise and log. Future you will appreciate it.\nStart the day with a tiny update and a big head start.\nGive Glu a morning clue and keep moving.\nA quick log now can make today way more interesting.\nLet’s make the morning count with a fast check-in.';

  @override
  String get dailyReminderMiddayTitle => 'Midday check-in';

  @override
  String get dailyReminderMiddayBodies =>
      'Midday pit stop: drop a quick log and keep cruising.\nLunch break? Perfect time to give Glu an update.\nHalfway there. Toss Glu a quick clue.\nA tiny midday log can keep the story going.\nCheck in now and keep the day rolling.\nGive your day a little nudge with a fast update.\nKeep the energy up with a quick midday tap.';

  @override
  String get dailyReminderAfternoonTitle => 'Afternoon check-in';

  @override
  String get dailyReminderAfternoonBodies =>
      'Almost done. Give Glu one more breadcrumb.\nA quick afternoon log can make tonight’s insight pop.\nWrap the day with a small update and a big win.\nOne more log before the day wraps up?\nHelp Glu connect the dots with a quick afternoon check-in.\nClose the loop with a tiny log and keep the magic going.\nA final tap now can make tonight’s insight way better.';

  @override
  String get homePortionCheckTitle => 'Portion Check';

  @override
  String get homePortionCheckBody => 'Know how much to eat at every meal';

  @override
  String get homeGlowUpTitle => 'Your\nGlow up';

  @override
  String get homeGlowUpBody => 'Create your before-and-after story';

  @override
  String get homeDoctorReportTitle => 'Doctor Report';

  @override
  String get homeDoctorReportBody => 'Share your progress with your doctor';

  @override
  String get doctorReportViewerRenderError =>
      'Couldn\'t display the report. Please try again.';

  @override
  String get doctorReportViewerShare => 'Share';

  @override
  String get homeGoalsStatusTitle => 'Goals today';

  @override
  String get homeGoalsStatusViewAll => 'View all';

  @override
  String get homeWaterTitle => 'Water';

  @override
  String get homeWeightTitle => 'Weight';

  @override
  String get homeExerciseTitle => 'Exercise';

  @override
  String get homeMealsTitle => 'Meals';

  @override
  String get homeCaloriesTitle => 'Calories';

  @override
  String get homeProteinsTitle => 'Proteins';

  @override
  String get homeFibersTitle => 'Fibers';

  @override
  String get homeSymptomsTitle => 'Symptoms';

  @override
  String get homeMoodTitle => 'Mood';

  @override
  String get homeCravingsTitle => 'Cravings';

  @override
  String get homeDoseTitle => 'Dose';

  @override
  String get homeMedicationLevelTitle => 'Estimated medication level';

  @override
  String get homeMedicationLevelInfoTitle => 'How to read this chart';

  @override
  String get homeMedicationLevelInfoBody =>
      'This chart estimates how much of your medication may still be active based on the doses you logged and the medication\'s half-life.\n\nHigher points usually mean a more recent or larger dose. The line slopes down over time as the medication clears from your system.\n\nUse this as a trend view, not as an exact measurement or medical recommendation.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Got it';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Log your doses so Glu can estimate how much medication is still active in your system.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'of recent peak';

  @override
  String get homeMedicationLevelActiveNow => 'Active now';

  @override
  String get homeMedicationLevelHalfLife => 'Half-life';

  @override
  String get homeMedicationLevelLastDose => 'Last dose';

  @override
  String get homeStartHydration => 'Start hydration';

  @override
  String get homeLogFirstSession => 'Log your first session';

  @override
  String get homeLogTodayWeight => 'Log today’s weight';

  @override
  String get homeAtYourTarget => 'You are at your target';

  @override
  String get homeLogMealsToTrackCalories => 'Log meals to track calories';

  @override
  String get homeLogFirstMeal => 'Log your first meal';

  @override
  String get homeTrackProteinFromMeals => 'Track protein from meals';

  @override
  String get homeTrackFiberFromMeals => 'Track fiber from meals';

  @override
  String get homeAllClear => 'All clear';

  @override
  String get homeTrackSymptoms => 'Track symptoms';

  @override
  String get homeGreat => 'Great';

  @override
  String get homeGood => 'Good';

  @override
  String get homeBad => 'Bad';

  @override
  String get homeOkay => 'Okay';

  @override
  String get homeLogHowYouFeel => 'Log how you feel';

  @override
  String get homeLogACraving => 'Log a craving';

  @override
  String get homeLogTodaysDose => 'Log today’s dose';

  @override
  String get homeTaken => 'Taken';

  @override
  String get homeStartHereTitle => 'Start here';

  @override
  String get homeStartHereBody =>
      'Begin with this card, then expand to others. As Glu learns more about your journey, it can show you better patterns and insights over time.';

  @override
  String get waterLogTitle => 'Hydration';

  @override
  String get waterLogEditTitle => 'Edit hydration';

  @override
  String get waterLogLogTitle => 'Log water';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Add drink ($amount)';
  }

  @override
  String get waterLogSaving => 'Saving...';

  @override
  String get waterLogCustomDrinkTitle => 'Custom drink';

  @override
  String get waterLogCustomDrinkBody =>
      'Choose the amount you want to add right now.';

  @override
  String get waterLogUseThisAmount => 'Use this amount';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount added to your hydration log';
  }

  @override
  String get waterLogCouldNotSave => 'Could not save this water log yet.';

  @override
  String get waterLogDeleteTitle => 'Delete this hydration log?';

  @override
  String get waterLogDeleteMessage => 'This action cannot be undone.';

  @override
  String get waterLogCouldNotDelete =>
      'Could not delete this hydration log yet.';

  @override
  String get waterLogDeleteLog => 'Delete log';

  @override
  String get waterLogDeleted => 'Hydration deleted';

  @override
  String get moodLogTitle => 'Mood';

  @override
  String get moodEditTitle => 'Edit mood';

  @override
  String get moodHowYouFeel => 'How you feel';

  @override
  String get moodBad => 'Bad';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Good';

  @override
  String get moodGreat => 'Great';

  @override
  String get moodNotes => 'Notes';

  @override
  String get moodAnythingWorthRemembering =>
      'Anything worth remembering about your mood?';

  @override
  String get moodCouldNotSave => 'Could not save this mood log yet.';

  @override
  String get moodDeleteTitle => 'Delete this mood log?';

  @override
  String get moodDeleteMessage => 'This action cannot be undone.';

  @override
  String get moodDeleteLog => 'Delete log';

  @override
  String get moodSaving => 'Saving...';

  @override
  String get moodAddMoodLog => '+ Add mood log';

  @override
  String get moodLogged => 'Mood logged';

  @override
  String get moodDeleted => 'Mood deleted';

  @override
  String get moodCouldNotDelete => 'Could not delete this mood log yet.';

  @override
  String get moodAddedToMoodLog => 'Added to your mood log';

  @override
  String get cravingsLogTitle => 'Cravings';

  @override
  String get cravingsEditTitle => 'Edit craving';

  @override
  String get cravingsWhatsGoingOn => 'What\'s going on';

  @override
  String get cravingsTypeGeneral => 'Urge to eat';

  @override
  String get cravingsTypeSweet => 'Something sweet';

  @override
  String get cravingsTypeSalty => 'Something salty';

  @override
  String get cravingsIntensityLabel => 'Intensity (optional)';

  @override
  String get cravingsIntensityMild => 'Mild';

  @override
  String get cravingsIntensityModerate => 'Moderate';

  @override
  String get cravingsIntensityStrong => 'Strong';

  @override
  String get cravingsOutcomeLabel => 'What happened (optional)';

  @override
  String get cravingsOutcomeResisted => 'Resisted';

  @override
  String get cravingsOutcomeGaveIn => 'Gave in';

  @override
  String get cravingsNotes => 'Notes';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Anything worth remembering about this craving?';

  @override
  String get cravingsCouldNotSave => 'Could not save this craving log yet.';

  @override
  String get cravingsDeleteTitle => 'Delete this craving log?';

  @override
  String get cravingsDeleteMessage => 'This action cannot be undone.';

  @override
  String get cravingsDeleteLog => 'Delete log';

  @override
  String get cravingsSaving => 'Saving...';

  @override
  String get cravingsAddLog => '+ Add craving log';

  @override
  String get cravingsLogged => 'Craving logged';

  @override
  String get cravingsDeleted => 'Craving deleted';

  @override
  String get cravingsCouldNotDelete => 'Could not delete this craving log yet.';

  @override
  String get cravingsAddedToLog => 'Added to your cravings log';

  @override
  String get portionCheckTitle => 'Portion Check';

  @override
  String get portionCheckAnalyzingMeal => 'Analyzing your meal…';

  @override
  String get portionCheckCouldNotAnalyzePhoto => 'Couldn\'t analyze this photo';

  @override
  String get portionCheckTakeNewPhoto => 'Take a new photo';

  @override
  String get portionCheckSomethingWentWrong => 'Something went wrong.';

  @override
  String get portionCheckYouHitDailyLimit => 'You\'ve hit your daily limit';

  @override
  String get portionCheckYouCanEat => 'You can eat';

  @override
  String get portionCheckYouCanEatUpTo => 'You can eat up to';

  @override
  String get portionCheckTryLighterOption =>
      'Try a lighter option instead or skip this one';

  @override
  String get portionCheckThisEntireMeal => 'this entire meal';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% of this meal';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'to stay within your daily goals.';

  @override
  String get portionCheckNutritionBreakdown => 'Nutrition breakdown';

  @override
  String get portionCheckTipsToBalanceMeal => 'Tips to balance your meal';

  @override
  String get portionCheckTipsPool =>
      'Eat slowly — it takes about 20 minutes for fullness signals to catch up.\nFill half your plate with vegetables.\nInclude protein at every meal.\nDrink water before meals.\nPre-portion snacks into small containers.\nPair carbs with protein or fat to stay full longer.\nChoose whole foods when possible.\nAvoid eating while distracted by screens.\nDon\'t skip meals if it makes you overeat later.\nPlan your snacks before you get hungry.';

  @override
  String get portionCheckRetake => 'Retake';

  @override
  String get portionCheckLogThisPortion => 'Log this portion';

  @override
  String get portionCheckCarbs => 'Carbs';

  @override
  String get portionCheckProteins => 'Proteins';

  @override
  String get portionCheckFats => 'Fats';

  @override
  String get portionCheckFiber => 'Fiber';

  @override
  String get mealLogScreenTitle => 'Meals';

  @override
  String get mealLogEditTitle => 'Edit meal';

  @override
  String get mealLogLogTitle => 'Log meal';

  @override
  String get mealLogSaving => 'Saving...';

  @override
  String get mealLogAddMealLog => '+ Add meal log';

  @override
  String get mealLogCouldNotStartRecording => 'Could not start recording.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'Recording stopped at 60 seconds.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Could not analyze this recording.';

  @override
  String get mealLogCouldNotAnalyzeText => 'Could not analyze this text.';

  @override
  String get mealLogCouldNotAnalyzePhoto => 'Could not analyze this photo.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Could not process this meal photo yet.';

  @override
  String get mealLogDiscardTitle => 'Discard this meal?';

  @override
  String get mealLogDiscardMessage =>
      'You reviewed a photo but didn\'t save the entry. It won\'t be logged.';

  @override
  String get mealLogDiscard => 'Discard';

  @override
  String get mealLogDeleteTitle => 'Delete this meal log?';

  @override
  String get mealLogDeleteMessage => 'This action cannot be undone.';

  @override
  String get mealLogDelete => 'Delete';

  @override
  String get mealLogDeleteLog => 'Delete log';

  @override
  String get mealLogCouldNotSave => 'Could not save this meal log yet.';

  @override
  String get mealLogCouldNotDelete => 'Could not delete this meal log yet.';

  @override
  String get mealLogAnalyzing => 'Analyzing...';

  @override
  String get mealLogAnalyzeText => 'Analyze text';

  @override
  String get mealLogSendRecording => 'Send recording';

  @override
  String get mealLogMealDefaultName => 'Meal';

  @override
  String get mealLogMealNameHint => 'Meal name';

  @override
  String get mealLogCouldNotPrefillTitle => 'Couldn’t prefill this meal';

  @override
  String get mealLogHowMuchDidYouEat => 'How much did you eat?';

  @override
  String get mealLogNotes => 'Notes';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Anything worth remembering about this meal?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analyzing your meal';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Turning your input into nutrition fields. You can review everything before saving.';

  @override
  String get mealLogDescribeYourMealTitle => 'Describe your meal';

  @override
  String get mealLogDescribeYourMealBody =>
      'Write what you ate and any amounts you know. We’ll turn it into nutrition fields.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Example: grilled chicken salad, olive oil dressing, 1 apple, sparkling water';

  @override
  String get mealLogCaptureYourMealTitle => 'Capture your meal';

  @override
  String get mealLogCaptureYourMealBody =>
      'Take a photo and we’ll estimate the nutrition fields for you.';

  @override
  String get mealLogTakePhoto => 'Take photo';

  @override
  String get mealLogRecordingYourMealTitle => 'Recording your meal';

  @override
  String get mealLogRecordingReadyTitle => 'Recording ready';

  @override
  String get mealLogRecordMealDescriptionTitle => 'Record a meal description';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tap stop when you’re done. ${remaining}s left';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Send it below to analyze, or record again.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Speak naturally about what you ate and we’ll parse it into macros.';

  @override
  String get mealLogStopRecording => 'Stop recording';

  @override
  String get mealLogRecordAgain => 'Record again';

  @override
  String get mealLogStartRecording => 'Start recording';

  @override
  String get mealLogBreakfast => 'Breakfast';

  @override
  String get mealLogLunch => 'Lunch';

  @override
  String get mealLogSnack => 'Snack';

  @override
  String get mealLogDinner => 'Dinner';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'Today';

  @override
  String get mealLogYesterday => 'Yesterday';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal logged';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro logged';
  }

  @override
  String get mealLogDeleted => 'Meal deleted';

  @override
  String get mealLogAddedToMealLog => 'Added to your meal log';

  @override
  String get mealLogCarbs => 'Carbs';

  @override
  String get mealLogProteins => 'Proteins';

  @override
  String get mealLogFats => 'Fats';

  @override
  String get mealLogFiber => 'Fiber';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageDialogTitle => 'Select language';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsPreferences => 'Preferences';

  @override
  String get settingsHealthGoal => 'Health goal';

  @override
  String get settingsHealthGoalDialogTitle => 'Select health goal';

  @override
  String get settingsHabitGoals => 'Habit goals';

  @override
  String get settingsDisabled => 'Disabled';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count active';
  }

  @override
  String get settingsHeight => 'Height';

  @override
  String get settingsAge => 'Age';

  @override
  String get settingsGender => 'Gender';

  @override
  String get settingsMeasurementUnit => 'Measurement unit';

  @override
  String get settingsReminders => 'Reminders';

  @override
  String get settingsDoseReminder => 'Dose reminder';

  @override
  String get settingsSupplementReminder => 'Supplement reminder';

  @override
  String get settingsDailyReminders => 'Daily reminders';

  @override
  String get settingsSubscription => 'Subscription';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsSendFeedback => 'Send Feedback';

  @override
  String get feedbackSheetTitle => 'Send Feedback';

  @override
  String get feedbackSheetHint => 'Tell us what you think…';

  @override
  String get feedbackSheetSend => 'Send';

  @override
  String get feedbackSheetSuccess => 'Thanks for your feedback!';

  @override
  String get feedbackSheetError => 'Failed to send. Please try again.';

  @override
  String get settingsTermsOfService => 'Terms of Service';

  @override
  String get settingsPrivacyPolicy => 'Privacy Policy';

  @override
  String get settingsInternal => 'Internal';

  @override
  String get settingsSubscriptionOverride => 'Subscription override';

  @override
  String get settingsTodayInsightCard => 'Today insight card';

  @override
  String get settingsResetOnboarding => 'Reset onboarding';

  @override
  String get settingsResetShowcases => 'Reset showcases';

  @override
  String get settingsResetUserData => 'Reset user data';

  @override
  String get settingsDeletingAccount => 'Deleting account...';

  @override
  String get settingsDisconnect => 'Disconnect';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Disconnect $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Disconnect $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'You will no longer be able to sign in with $provider on this device unless you reconnect it later.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Delete account?';

  @override
  String get settingsDeleteAccountBody =>
      'This will permanently remove your account and all of your data. This action cannot be undone.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Type DELETE to confirm';

  @override
  String get settingsDeleteAccountError =>
      'Something went wrong while deleting your account. Please contact support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Restart app to see onboarding';

  @override
  String get settingsShowcasesReset => 'Showcases reset';

  @override
  String get settingsResetUserDataTitle => 'Reset user data?';

  @override
  String get settingsResetUserDataBody =>
      'This will clear all logged records for meals, water, exercise, weight, mood, symptoms, supplements, and doses.';

  @override
  String get settingsUserDataReset => 'User data reset';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Saved, but daily reminders could not be scheduled right now.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Subscription override';

  @override
  String get settingsSubscriptionOverrideAuto => 'Auto';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Force Free';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Force Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Today insight card';

  @override
  String get settingsTodayInsightCardAuto => 'Auto';

  @override
  String get settingsTodayInsightCardOn => 'On';

  @override
  String get settingsTodayInsightCardOff => 'Off';

  @override
  String get settingsYourName => 'Your name';

  @override
  String get settingsSignOut => 'Sign out';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'ft/in';

  @override
  String get settingsHeightFt => 'ft';

  @override
  String get settingsHeightIn => 'in';

  @override
  String get settingsGenderMale => 'Male';

  @override
  String get settingsGenderFemale => 'Female';

  @override
  String get settingsGenderPreferNotToSay => 'Prefer not to say';

  @override
  String get settingsGenderOther => 'Other';

  @override
  String get settingsYourProfile => 'Your profile';

  @override
  String get settingsNotSet => 'Not set';

  @override
  String settingsYears(Object value) {
    return '$value years';
  }

  @override
  String get settingsOff => 'Off';

  @override
  String get settingsOn => 'On';

  @override
  String get settingsNoneSet => 'None set';

  @override
  String settingsSupplementCount(Object count) {
    return '$count supplement(s)';
  }

  @override
  String get commonToday => 'Today';

  @override
  String get mainShellHome => 'Home';

  @override
  String get mainShellLog => 'Log';

  @override
  String get mainShellProgress => 'Progress';

  @override
  String get mainShellSettings => 'Settings';

  @override
  String get mainShellLogShowcaseTitle => 'Track what matters daily';

  @override
  String get mainShellLogShowcaseDescription =>
      'Log the activities that matter most to you, every day.';

  @override
  String get logMoodShowcaseTitle => 'Start with your mood';

  @override
  String get logMoodShowcaseDescription =>
      'Log your mood now, and keep logging the rest as you go so Glu can spot habits and patterns more accurately.';

  @override
  String get mainShellProgressShowcaseTitle => 'See your progress';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Check your patterns and trends to understand how your habits and weight are changing over time.';

  @override
  String get progressMenuShowcaseTitle => 'Explore your data';

  @override
  String get progressMenuShowcaseDescription =>
      'View all charts, read AI-generated insights, or create a doctor report to share with your care team.';

  @override
  String get settingsFeedbackShowcaseTitle => 'We\'d love your feedback';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Tap here to share what\'s working, what\'s not, or any ideas you have.';

  @override
  String get authCouldNotOpenLink => 'Could not open link right now.';

  @override
  String get authWelcomeTitle => 'Welcome to Glu';

  @override
  String get authSubtitle => 'Secure sign-in for your wellness companion';

  @override
  String get authContinueWithGoogle => 'Continue with Google';

  @override
  String get authContinueWithApple => 'Continue with Apple';

  @override
  String get authEmailHint => 'name@email.com';

  @override
  String get authSending => 'Sending...';

  @override
  String get authResendLink => 'Resend link';

  @override
  String get authUseDifferentEmail => 'Use a different email';

  @override
  String get habitGoalsTitle => 'Habit goals';

  @override
  String get goalsProteins => 'Proteins';

  @override
  String get goalsFibers => 'Fibers';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g per day';
  }

  @override
  String get goalsWater => 'Water';

  @override
  String goalsLitersPerDay(Object value) {
    return '${value}L per day';
  }

  @override
  String get goalsExercise => 'Exercise';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min per day';
  }

  @override
  String get goalsMeals => 'Meals';

  @override
  String get goalsCalories => 'Calories';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'per week';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count meals per day';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal per day';
  }

  @override
  String get goalsWeight => 'Weight';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Add a logged weight to calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'You are already at this target';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/week to target';
  }

  @override
  String get goalsSetTargetForNextWeek => 'Set the target for next week.';

  @override
  String get progressWeightTitle => 'Weight';

  @override
  String get progressWeightLabel => 'Weight ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Healthy BMI';

  @override
  String get progressTotal => 'Total';

  @override
  String get progressPercent => 'Percent';

  @override
  String get progressWeeklyAvg => 'Weekly avg';

  @override
  String get progressRangeAllTime => 'All time';

  @override
  String get progressRange1Month => '1 month';

  @override
  String get progressRange3Months => '3 months';

  @override
  String get progressRange6Months => '6 months';

  @override
  String get progressLow => 'Low';

  @override
  String get progressMed => 'Med';

  @override
  String get progressHigh => 'High';

  @override
  String get progressSeverity => 'Severity';

  @override
  String get progressBad => 'Bad';

  @override
  String get progressOkay => 'Okay';

  @override
  String get progressGood => 'Good';

  @override
  String get progressGreat => 'Great';

  @override
  String get progressMostlyBad => 'Mostly bad';

  @override
  String get progressMostlyOkay => 'Mostly okay';

  @override
  String get progressMostlyGood => 'Mostly good';

  @override
  String get progressMostlyGreat => 'Mostly great';

  @override
  String get progressNoDose => 'No dose';

  @override
  String get progressLogged => 'Logged';

  @override
  String get progressAllClear => 'All clear';

  @override
  String get progressFreq => 'Freq';

  @override
  String get progressAverage => 'Average';

  @override
  String get progressDaily => 'Daily';

  @override
  String get progressWeekly => 'Weekly';

  @override
  String get progressMinutes => 'Minutes';

  @override
  String get progressIntensity => 'Intensity';

  @override
  String get progressCalories => 'Calories';

  @override
  String get progressByDose => 'By dose';

  @override
  String get progressWeightProgressTitle => 'Weight progress';

  @override
  String get progressWaterProgressTitle => 'Water progress';

  @override
  String get progressExerciseProgressTitle => 'Exercise progress';

  @override
  String get progressDoseProgressTitle => 'Dose progress';

  @override
  String get progressMealsProgressTitle => 'Meals progress';

  @override
  String get progressSymptomsProgressTitle => 'Symptoms progress';

  @override
  String get progressMoodProgressTitle => 'Mood progress';

  @override
  String get progressCravingsProgressTitle => 'Cravings progress';

  @override
  String get progressResisted => 'Resisted';

  @override
  String get progressCravingsResistedSubtitle =>
      'Share of logged cravings you resisted.';

  @override
  String get progressWeightChangeTitle => 'Weight change';

  @override
  String get progressTitle => 'Progress';

  @override
  String get progressMenuViewAllInsights => 'View all insights';

  @override
  String get progressMenuViewAllCharts => 'View all charts';

  @override
  String get progressMenuCreateDoctorReport => 'Create doctor report';

  @override
  String get progressReportGenerating => 'Generating your report…';

  @override
  String get progressReportError =>
      'Could not generate the report. Please try again.';

  @override
  String get progressReportPendingRetry =>
      'Your report may still finish in a moment. Please try again.';

  @override
  String get progressReportOpenError =>
      'Your report was generated, but we could not open it. Please try again.';

  @override
  String get progressAllProgressTitle => 'All progress';

  @override
  String get progressWeightTrendExplanation =>
      'See how your weight is changing over time.';

  @override
  String get progressNoWeightLogsYet => 'No weight logs yet';

  @override
  String get progressNoLogsYet => 'No logs yet';

  @override
  String get progressLogWeightToStartTrend =>
      'Log weight to start tracking your trend.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Log weight and dose to compare how dosage aligns with change.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Each point is colored by the latest dose used before that weigh-in.';

  @override
  String get progressNoHydrationYet => 'No hydration yet';

  @override
  String get progressNoMovementYet => 'No movement yet';

  @override
  String get progressNoDoseLogsYet => 'No dose logs yet';

  @override
  String get progressNoMealsLoggedYet => 'No meals logged yet';

  @override
  String get progressNoSymptomsLoggedYet => 'No symptoms logged yet';

  @override
  String get progressNoMoodLogsYet => 'No mood logs yet';

  @override
  String get progressNoCravingsLoggedYet => 'No cravings logged yet';

  @override
  String get progressFutureTrendTitle => 'Future trend';

  @override
  String get progressFutureTrendBody => 'A beautiful timeline of your momentum';

  @override
  String get progressGoal => 'Goal';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Your latest logged weight is ready to track.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'About $gap $unit from your target.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText vs your previous log.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText vs previous log. $gap $unit from target.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Compared with your previous log, the trend is now visible.';

  @override
  String get progressWaterTitle => 'Water';

  @override
  String get manageSubscriptionTitle => 'Manage Subscription';

  @override
  String get manageSubscriptionProPlan => 'Pro Plan';

  @override
  String get manageSubscriptionFreePlan => 'Free Plan';

  @override
  String get manageSubscriptionActiveCopy => 'Your subscription is active.';

  @override
  String get manageSubscriptionUpgradeCopy => 'Upgrade to unlock Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Plan';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Free';

  @override
  String get manageSubscriptionProduct => 'Product';

  @override
  String get manageSubscriptionRenewal => 'Renewal';

  @override
  String get manageSubscriptionStatus => 'Status';

  @override
  String get manageSubscriptionStatusActive => 'Active';

  @override
  String get manageSubscriptionStatusInactive => 'Not active';

  @override
  String get manageSubscriptionManageButton => 'Manage subscription';

  @override
  String get manageSubscriptionUpgradeButton => 'Upgrade to Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Open store subscription settings';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Restore purchases';

  @override
  String get manageSubscriptionRenewsAutomatically => 'Renews automatically';

  @override
  String get manageSubscriptionLifetime => 'Lifetime';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Renews on $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Expires on $date';
  }

  @override
  String get supplementReminderDayMon => 'Mo';

  @override
  String get supplementReminderDayTue => 'Tu';

  @override
  String get supplementReminderDayWed => 'We';

  @override
  String get supplementReminderDayThu => 'Th';

  @override
  String get supplementReminderDayFri => 'Fr';

  @override
  String get supplementReminderDaySat => 'Sa';

  @override
  String get supplementReminderDaySun => 'Su';

  @override
  String supplementReminderInDays(Object count) {
    return 'In $count days';
  }

  @override
  String get supplementReminderInOneWeek => 'In 1 week';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'In $count weeks';
  }

  @override
  String get subscriptionDebugTitle => 'Glu Subscriptions';

  @override
  String get subscriptionDebugMonthly => 'Monthly';

  @override
  String get subscriptionDebugYearly => 'Yearly';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Refresh Customer Info';

  @override
  String get subscriptionDebugPresentPaywall => 'Present Paywall';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Open Customer Center';

  @override
  String get subscriptionDebugRestorePurchases => 'Restore Purchases';

  @override
  String get subscriptionDebugSyncPurchases => 'Sync Purchases';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat Status';

  @override
  String get subscriptionDebugConfigured => 'Configured';

  @override
  String get subscriptionDebugBusy => 'Busy';

  @override
  String get subscriptionDebugAppUserId => 'App user ID';

  @override
  String get subscriptionDebugAnonymous => 'anonymous';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API key available';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro active';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Active subscriptions';

  @override
  String get subscriptionDebugManagementUrl => 'Management URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Entitlement product';

  @override
  String get subscriptionDebugWillRenew => 'Will renew';

  @override
  String get subscriptionDebugExpiration => 'Expiration';

  @override
  String get subscriptionDebugLifetime => 'lifetime';

  @override
  String get subscriptionDebugPackageFound => 'Package found';

  @override
  String get subscriptionDebugProductId => 'Product ID';

  @override
  String get subscriptionDebugTitleLabel => 'Title';

  @override
  String get subscriptionDebugPrice => 'Price';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Purchase $title';
  }

  @override
  String get progressExerciseTitle => 'Exercise';

  @override
  String get progressDoseTitle => 'Dose';

  @override
  String get progressMealsTitle => 'Meals';

  @override
  String get progressSymptomsTitle => 'Symptoms';

  @override
  String get progressMoodTitle => 'Mood';

  @override
  String get progressCravingsTitle => 'Cravings';

  @override
  String get progressTrend => 'Trend';

  @override
  String get progressTarget => 'Target';

  @override
  String get progressNoTrendYet => 'No trend yet';

  @override
  String get progressNoActivityYet => 'No activity yet';

  @override
  String get progressNoCheckInsYet => 'No check-ins yet';

  @override
  String get progressWeightSignatureChip =>
      'Weight will become your signature chart';

  @override
  String get progressWeightStartTrendTitle =>
      'Start your trend with one weigh-in';

  @override
  String get progressWeightStartTrendBody =>
      'This chart is the centerpiece of your progress story. Log your first weight to unlock momentum, milestones, and a view worth sharing.';

  @override
  String get progressWeightMomentum => 'Momentum';

  @override
  String get progressWeightMilestones => 'Milestones';

  @override
  String get progressWeightShareReady => 'Share-ready';

  @override
  String get progressWeightLogWeight => 'Log weight';

  @override
  String get weightProgressUnlocksViewChip =>
      'Your first weigh-in unlocks this view';

  @override
  String get weightProgressStartsHereTitle => 'Your progress story starts here';

  @override
  String get weightProgressStartsHereBody =>
      'Log your first weight to unlock trends, milestones, and dose-aware insights in a view worth sharing.';

  @override
  String get weightProgressTrendView => 'Trend view';

  @override
  String get weightProgressDoseOverlays => 'Dose overlays';

  @override
  String get weightProgressMilestones => 'Milestones';

  @override
  String get weightProgressLogWeight => 'Log weight';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Add both a before and after photo first.';

  @override
  String get glowUpSavedToGallery => 'Saved to your gallery';

  @override
  String get glowUpSaveToGallery => 'Save to gallery';

  @override
  String get glowUpYourProgress => 'Your progress';

  @override
  String get glowUpWeightChange => 'Weight change';

  @override
  String get glowUpTime => 'Time';

  @override
  String get glowUpShare => 'Share';

  @override
  String get glowUpBefore => 'BEFORE';

  @override
  String get glowUpAfter => 'AFTER';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight in $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'days';

  @override
  String get glowUpTimeUnitWeeksLabel => 'weeks';

  @override
  String get glowUpTimeUnitMonthsLabel => 'months';

  @override
  String get glowUpTimeUnitYearsLabel => 'years';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weeks',
      one: '$count week',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Yesterday';

  @override
  String get commonSelect => 'Select';

  @override
  String get doseReminderTitle => 'Dose reminder';

  @override
  String get doseReminderCustomDoseTitle => 'Custom dose';

  @override
  String get doseReminderCustomDoseHint => 'Type dose in mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Keep your next dose ready on home.';

  @override
  String get doseReminderTime => 'Time';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Turn this on to show the next dose on home.';

  @override
  String get doseReminderSaveReminder => 'Save reminder';

  @override
  String loggedOn(Object date) {
    return 'Logged on $date';
  }

  @override
  String get waterLogSmallGlass => 'Small glass';

  @override
  String get waterLogGlass => 'Glass';

  @override
  String get waterLogBottle => 'Bottle';

  @override
  String get waterLogLargeBottle => 'Large bottle';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Custom';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dose';

  @override
  String get doseLogEditTitle => 'Edit dose';

  @override
  String get doseLogLogTitle => 'Log dose';

  @override
  String get doseLogCustomDose => 'Custom dose';

  @override
  String get doseLogCustomDoseBody => 'Adjust the dose in mg for this log.';

  @override
  String get doseLogUseThisDose => 'Use this dose';

  @override
  String get doseLogMedication => 'Medication';

  @override
  String get doseLogInjectionSite => 'Site';

  @override
  String get doseLogNotes => 'Notes';

  @override
  String get doseLogSaveChanges => 'Save changes';

  @override
  String get doseLogAddDose => '+ Log dose';

  @override
  String get doseLogDeleteTitle => 'Delete this dose log?';

  @override
  String get doseLogDeleteMessage => 'This action cannot be undone.';

  @override
  String get doseLogDeleteLog => 'Delete log';

  @override
  String get doseLogSaving => 'Saving...';

  @override
  String get doseLogCouldNotSave => 'Could not save this dose log yet.';

  @override
  String get doseLogCouldNotDelete => 'Could not delete this dose log yet.';

  @override
  String get doseLogDeleted => 'Dose deleted';

  @override
  String get doseLogAddedToDoseLog => 'Added to your dose log';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Anything worth remembering about this dose?';

  @override
  String get doseLogDoseLabel => 'Dose';

  @override
  String get exerciseLogTitle => 'Exercise';

  @override
  String get exerciseLogEditTitle => 'Edit exercise';

  @override
  String get exerciseLogLogTitle => 'Log exercise';

  @override
  String get exerciseLogActivityType => 'Activity type';

  @override
  String get exerciseLogCustomActivity => 'Custom activity';

  @override
  String get exerciseLogTypeActivity => 'Type the activity';

  @override
  String get exerciseLogDuration => 'Duration';

  @override
  String get exerciseLogIntensity => 'Intensity';

  @override
  String get exerciseLogNotes => 'Notes';

  @override
  String get exerciseLogLight => 'Light';

  @override
  String get exerciseLogModerate => 'Moderate';

  @override
  String get exerciseLogIntense => 'Intense';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min logged';
  }

  @override
  String get exerciseLogSaveChanges => 'Save changes';

  @override
  String get exerciseLogAddExercise => '+ Add exercise log';

  @override
  String get exerciseLogDeleteTitle => 'Delete this exercise log?';

  @override
  String get exerciseLogDeleteMessage => 'This action cannot be undone.';

  @override
  String get exerciseLogDeleteLog => 'Delete log';

  @override
  String get exerciseLogSaving => 'Saving...';

  @override
  String get exerciseLogCouldNotSave => 'Could not save this exercise log yet.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Could not delete this exercise log yet.';

  @override
  String get exerciseLogDeleted => 'Exercise deleted';

  @override
  String get exerciseLogAddedToExerciseLog => 'Added to your exercise log';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Anything worth remembering about this session?';

  @override
  String get exerciseLogWalking => 'Walking';

  @override
  String get exerciseLogRunning => 'Running';

  @override
  String get exerciseLogCycling => 'Cycling';

  @override
  String get exerciseLogStrength => 'Strength';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Swim';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Weight';

  @override
  String get weightLogEditTitle => 'Edit weight';

  @override
  String get weightLogLogTitle => 'Log weight';

  @override
  String get weightLogSaveChanges => 'Save changes';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Add weight ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Delete this weight log?';

  @override
  String get weightLogDeleteMessage => 'This action cannot be undone.';

  @override
  String get weightLogDeleteLog => 'Delete log';

  @override
  String get weightLogSaving => 'Saving...';

  @override
  String get weightLogCouldNotSave => 'Could not save this weight log yet.';

  @override
  String get weightLogCouldNotDelete => 'Could not delete this weight log yet.';

  @override
  String get weightLogDeleted => 'Weight deleted';

  @override
  String get weightLogAddedToWeightLog => 'Added to your weight log';

  @override
  String get weightLogNoWeightForDay => 'No weight logged for this day yet.';

  @override
  String get injectionSiteAbdomen => 'Abdomen';

  @override
  String get injectionSiteThigh => 'Thigh';

  @override
  String get injectionSiteUpperArm => 'Upper arm';

  @override
  String get injectionSiteButtocks => 'Buttocks';

  @override
  String get injectionSiteAbdomenUpperLeft => 'Abdomen, upper left';

  @override
  String get injectionSiteAbdomenUpperRight => 'Abdomen, upper right';

  @override
  String get injectionSiteAbdomenLowerRight => 'Abdomen, lower right';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Abdomen, lower left';

  @override
  String get injectionSiteThighUpperLeft => 'Thigh, upper left';

  @override
  String get injectionSiteThighUpperRight => 'Thigh, upper right';

  @override
  String get injectionSiteThighLowerRight => 'Thigh, lower right';

  @override
  String get injectionSiteThighLowerLeft => 'Thigh, lower left';

  @override
  String get injectionSiteUpperArmLeft => 'Upper arm, left';

  @override
  String get injectionSiteUpperArmRight => 'Upper arm, right';

  @override
  String get injectionSiteButtocksUpperLeft => 'Buttocks, upper left';

  @override
  String get injectionSiteButtocksUpperRight => 'Buttocks, upper right';

  @override
  String get doseReminderFormat => 'Format';

  @override
  String get doseReminderInjection => 'Injection';

  @override
  String get doseReminderPill => 'Pill';

  @override
  String get doseReminderSite => 'Site';

  @override
  String get doseReminderDate => 'Date';

  @override
  String get supplementReminderTitle => 'Supplement reminder';

  @override
  String get supplementReminderAddSupplement => 'Add supplement';

  @override
  String get supplementReminderNoSupplementsYet => 'No supplements yet';

  @override
  String get supplementReminderAddFirstBody =>
      'Add your first supplement reminder to track your daily intake.';

  @override
  String get supplementReminderSupplementFallback => 'Supplement';

  @override
  String get supplementReminderEveryDay => 'Every day';

  @override
  String get supplementReminderEveryXDaysLabel => 'Every X days';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Every $interval days';
  }

  @override
  String get supplementReminderNoDaysSet => 'No days set';

  @override
  String get supplementReminderSupplementName => 'Supplement name';

  @override
  String get supplementReminderTime => 'Time';

  @override
  String get supplementReminderStartDate => 'Start date';

  @override
  String get supplementReminderRepeat => 'Repeat';

  @override
  String get supplementReminderDaysOfWeek => 'Days of week';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Select at least one day.';

  @override
  String get supplementReminderEvery => 'Every';

  @override
  String get supplementReminderDay => 'day';

  @override
  String get supplementReminderDays => 'days';

  @override
  String get supplementReminderAdd => 'Add';

  @override
  String get symptomsLogTitle => 'Symptoms';

  @override
  String get symptomsLogEditTitle => 'Edit symptoms';

  @override
  String get symptomsLogLogTitle => 'Log symptoms';

  @override
  String get symptomsLogSymptomsExperienced => 'Symptoms experienced';

  @override
  String get symptomsLogNoSymptoms => 'No symptoms';

  @override
  String get symptomsLogNoSymptomsToday => 'No symptoms today';

  @override
  String get symptomsLogOther => 'Other...';

  @override
  String get symptomsLogSeverityLevel => 'Severity level';

  @override
  String get symptomsLogNotes => 'Notes';

  @override
  String get symptomsLogAnxiety => 'Anxiety';

  @override
  String get symptomsLogBelching => 'Belching';

  @override
  String get symptomsLogBloating => 'Bloating';

  @override
  String get symptomsLogConstipation => 'Constipation';

  @override
  String get symptomsLogDiarrhea => 'Diarrhea';

  @override
  String get symptomsLogFatigue => 'Fatigue';

  @override
  String get symptomsLogFoodNoise => 'Food noise';

  @override
  String get symptomsLogHairLoss => 'Hair loss';

  @override
  String get symptomsLogHeartburn => 'Heartburn';

  @override
  String get symptomsLogIndigestion => 'Indigestion';

  @override
  String get symptomsLogInjectionSiteReaction => 'Injection site reaction';

  @override
  String get symptomsLogMetallicTaste => 'Metallic taste';

  @override
  String get symptomsLogHeadache => 'Headache';

  @override
  String get symptomsLogMoodSwings => 'Mood swings';

  @override
  String get symptomsLogNausea => 'Nausea';

  @override
  String get symptomsLogReflux => 'Reflux';

  @override
  String get symptomsLogStomachPain => 'Stomach pain';

  @override
  String get symptomsLogSuppressedAppetite => 'Suppressed appetite';

  @override
  String get symptomsLogVomiting => 'Vomiting';

  @override
  String get symptomsLogLogged => 'Symptoms logged';

  @override
  String get symptomsLogMild => 'Mild';

  @override
  String get symptomsLogModerate => 'Moderate';

  @override
  String get symptomsLogSevere => 'Severe';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Anything worth remembering about how you felt?';

  @override
  String get symptomsLogSaveChanges => 'Save changes';

  @override
  String get symptomsLogAddSymptoms => '+ Add symptoms log';

  @override
  String get symptomsLogDeleteTitle => 'Delete this symptoms log?';

  @override
  String get symptomsLogDeleteMessage => 'This action cannot be undone.';

  @override
  String get symptomsLogDeleteLog => 'Delete log';

  @override
  String get symptomsLogSaving => 'Saving...';

  @override
  String get symptomsLogCouldNotSave => 'Could not save this symptoms log yet.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Could not delete this symptoms log yet.';

  @override
  String get symptomsLogDeleted => 'Symptoms deleted';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Added to your symptoms log';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% of daily goal';
  }

  @override
  String get commonDisclaimer =>
      'Glu is a tracking tool, not a medical device. It does not provide medical advice, diagnosis, or treatment. Always consult your healthcare provider about your medication and health decisions.';
}
