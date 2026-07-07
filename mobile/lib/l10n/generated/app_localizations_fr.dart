// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Démarrage en cours...';

  @override
  String get startupFailed => 'Échec du démarrage';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonSaving => 'Enregistrement...';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonNotNow => 'Pas maintenant';

  @override
  String get commonNow => 'Maintenant';

  @override
  String get commonTomorrow => 'Demain';

  @override
  String get noteTriggerAddNote => 'Ajouter une note';

  @override
  String get noteTriggerCancelNote => 'Annuler note';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'Dans $count jours';
  }

  @override
  String get homeDoseReminderInOneWeek => 'Dans 1 semaine';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'Dans $count semaines';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'En retard d’un jour';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'En retard de $count jours';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'En retard d’une semaine';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'En retard de $count semaines';
  }

  @override
  String get bmiIndicatorYourBmi => 'Ton BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Ton BMI actuel';

  @override
  String get bmiIndicatorUnderweight => 'Insuffisance pondérale';

  @override
  String get bmiIndicatorNormal => 'Normal';

  @override
  String get bmiIndicatorOverweight => 'Surpoids';

  @override
  String get bmiIndicatorObesity => 'Obésité';

  @override
  String get heightRulerCmUnit => 'Cm';

  @override
  String get heightRulerFtUnit => 'Ft';

  @override
  String get heightRulerInUnit => 'In';

  @override
  String get heightRulerFtInUnit => 'Ft/in';

  @override
  String get weightDialKgUnit => 'Kg';

  @override
  String get weightDialLbUnit => 'Lb';

  @override
  String get logNoteIndicatorHasNote => 'Note présente';

  @override
  String get paywallTitle => 'Débloquer Glu Pro';

  @override
  String get paywallSubtitle => 'Sans Pro, voici ce que vous perdez :';

  @override
  String get paywallMonthlyTitle => 'Mensuel';

  @override
  String get paywallMonthlySubtitle => 'Sans essai gratuit';

  @override
  String get paywallYearlyTitle => 'Annuel';

  @override
  String get paywallYearlySubtitle => 'Essai gratuit de 7 jours';

  @override
  String get paywallNoCommitment => 'Sans engagement';

  @override
  String get paywallCancelAnytime => 'Annulable à tout moment';

  @override
  String get paywallContinue => 'Continuer';

  @override
  String get paywallRestore => 'Restaurer';

  @override
  String get paywallTerms => 'Conditions d’utilisation';

  @override
  String get paywallPrivacy => 'Confidentialité';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Enregistrer $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Could not ouvrir link right now.';

  @override
  String get paywallAlreadySubscribed => 'Tu already have Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Welcome à Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'L’achat n’a pas pu être finalisé. Réessaie.';

  @override
  String get paywallPurchaseFailed => 'L’achat a échoué. Réessaie.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'L’achat a échoué : $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Abonnement restauré !';

  @override
  String get paywallRestoreNoSubscription => 'Aucun abonnement actif trouvé.';

  @override
  String get paywallRestoreFailed => 'La restauration a échoué. Réessaie.';

  @override
  String get paywallBenefitReminders => 'Doses oubliées sans rappels';

  @override
  String get paywallBenefitShareProgress =>
      'Plus difficile de partager vos progrès';

  @override
  String get paywallBenefitSpotRegain => 'Signes de reprise de poids manqués';

  @override
  String get paywallBenefitInsights =>
      'Vos tendances quotidiennes vous échappent';

  @override
  String get paywallBenefitWeeklyGoals =>
      'Votre structure hebdomadaire disparaît';

  @override
  String get paywallBenefitHealthyHabits =>
      'Vos habitudes s\'effritent sans soutien';

  @override
  String get onboardingWelcomeTitle => 'Garder le poids off';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu helps tu protect ta progression around treatment, objectifs, et hebdomadaire habits.';

  @override
  String get onboardingWelcomeBullet1 => 'Fits ton treatment et objectifs';

  @override
  String get onboardingWelcomeBullet2 => 'Simple et realistic support';

  @override
  String get onboardingWelcomeBullet3 =>
      'Easily repérer early signs de poids regain';

  @override
  String get onboardingWelcomeBullet4 => 'Garder going without starting over';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Are tu currently taking a poids loss pen or pill medication?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'We use this à show guidance that matches where tu are right now.';

  @override
  String get onboardingMedicationStatusUsing => 'Oui, je le prends maintenant';

  @override
  String get onboardingMedicationStatusWeaningOff =>
      'Oui, je réduis progressivement';

  @override
  String get onboardingMedicationStatusNotTaking => 'Non, je n’en prends pas';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'No, I’ll commencer soon';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Non, j’ai arrêté récemment';

  @override
  String get onboardingMedicationMethodQuestion =>
      'How do tu take ton medication?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'We use this à tailor instructions et rappels à ton medication format.';

  @override
  String get onboardingMedicationMethodInjection => 'Injection';

  @override
  String get onboardingMedicationMethodPill => 'Comprimé';

  @override
  String get onboardingMedicationMethodUnknown => 'Je ne sais pas encore';

  @override
  String get onboardingMedicationNameQuestion =>
      'Which medication are tu taking?';

  @override
  String get onboardingMedicationNameExplainer =>
      'We use this à personalize dose tracking et medication-specific guidance.';

  @override
  String get onboardingCurrentDoseQuestion => 'What’s ton current dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'We use this à tailor dose tracking et future progression check-ins.';

  @override
  String get onboardingMedicationCustomDose => 'Personnalisé';

  @override
  String get onboardingDeviceTypeQuestion =>
      'What device do tu use à take ton medication?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'We use this à make rappels et tips match le way tu take it.';

  @override
  String get onboardingDeviceSinglePen => 'Stylo unique';

  @override
  String get onboardingDeviceAutoInjector => 'Auto-injecteur';

  @override
  String get onboardingDeviceSyringeAndVial => 'Syringe et vial';

  @override
  String get onboardingOther => 'Autre';

  @override
  String get onboardingTypeYourDevice => 'Type ton device';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'How often do tu take ton medication?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'We use this à temps rappels et routine support around ton schedule.';

  @override
  String get onboardingEveryDay => 'Tous les jours';

  @override
  String get onboardingEvery7Days => 'Tous les 7 jours';

  @override
  String get onboardingEvery14Days => 'Tous les 14 jours';

  @override
  String get onboardingCustom => 'Personnalisé';

  @override
  String get onboardingDaysBetweenDoses => 'Jours entre les doses';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'What’s ton primary objectif right now?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'We use this à focus ton plan, rappels, et progression around what matters plus à tu.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'We use this à shape ton plan from le very beginning.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'We use this à support ton next phase et aider tu rester on suivre.';

  @override
  String get onboardingGoalLoseWeight => 'Lose poids';

  @override
  String get onboardingGoalMaintainWeight => 'Maintain my poids';

  @override
  String get onboardingGoalManageDiabetes => 'Gérer mon diabète';

  @override
  String get onboardingGoalManagePcos => 'Gérer mon SOPK';

  @override
  String get onboardingGoalImproveHeartHealth => 'Améliorer ma santé cardiaque';

  @override
  String get onboardingAgeQuestion => 'What’s ton age?';

  @override
  String get onboardingAgeExplainer =>
      'We use this à adjust guidance et health calculations more appropriately.';

  @override
  String get onboardingHeightQuestion => 'What’s ton height?';

  @override
  String get onboardingHeightExplainer =>
      'We use this avec ton poids à calculate things like BMI et healthy ranges.';

  @override
  String get onboardingWeightQuestion => 'What’s ton current poids?';

  @override
  String get onboardingWeightExplainer =>
      'We use this as ton starting point pour progression, objectifs, et health estimates.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'When did tu stop le medication?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'When did tu commencer weaning off le medication?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'When did tu commencer le medication?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'We use this à understand ton recent treatment historique et next phase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'We use this à understand ton transition phase et support le habits that compter plus now.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'We use this à understand how long tu’ve been on treatment et suivre change over temps.';

  @override
  String get onboardingGoalWeightQuestion => 'What’s ton objectif poids?';

  @override
  String get onboardingGoalWeightExplainer =>
      'We use this à frame progression et show a target BMI range pour tu.';

  @override
  String get onboardingBenefitsQuestion => 'What Glu will aider tu do next';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu turns what tu shared into rappels, support, et structure that fit ton routine.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Here’s how Glu can aider tu maintain ta progression';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Here’s how Glu can support ton diabetes routine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Here’s how Glu can support ton PCOS routine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Here’s how Glu can support ton heart health';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Here’s how Glu can aider tu lose poids';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'See how Glu helps tu protect ton current poids et catch regain early.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'See how Glu helps tu garder repas, poids, et routines steadier week à week.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'See how Glu helps tu rester steadier around symptoms, poids, et routine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'See how Glu helps tu rester régulier avec le habits that support heart health.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'See how Glu helps tu repérer le schémas that garder poids moving down.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Without structure, regain can construire quietly. Glu helps tu catch it earlier et rester steady.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Without structure, repas et poids schémas get noisy. Glu keeps le signals clearer.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Without structure, symptoms et routines can swing more. Glu helps tu rester steadier.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Without structure, healthy habits drift. Glu helps tu garder activity et poids on suivre.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Without structure, poids can stall or drift up. Glu helps garder progression moving in le right direction.';

  @override
  String get onboardingBenefitsAxisWeight => 'Poids';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Repas & poids';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptoms & poids';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Exercice & poids';

  @override
  String get onboardingNotificationsQuestion =>
      'Turn on rappels that support ton objectif';

  @override
  String get onboardingNotificationsExplainer =>
      'We’ll use notifications à aider tu rester régulier, prepared, et on suivre.';

  @override
  String get onboardingNotificationsHeadline =>
      'Set Glu up à aider at le right moment.';

  @override
  String get onboardingNotificationsBody =>
      'Turn on notifications so Glu can reinforce le habits that support ton objectif.';

  @override
  String get onboardingNotificationsDaily =>
      'Timed rappels that match ton quotidien medication rhythm';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Longer-range rappels so dose days do not sneak up on tu';

  @override
  String get onboardingNotificationsCustom =>
      'Rappels shaped around ton custom schedule';

  @override
  String get onboardingNotificationsWeekly =>
      'Dose rappels that rester aligned avec ton hebdomadaire rhythm';

  @override
  String get onboardingNotificationsSupportive =>
      'Supportive rappels that garder ton routine visible when motivation dips';

  @override
  String get onboardingNotificationsProgress =>
      'Timely nudges around progression, habits, et le objectifs tu told us compter plus';

  @override
  String get onboardingNotificationsHelpful =>
      'Utile prompts that make Glu more useful in le moments tu need it';

  @override
  String get onboardingDailyRoutineQuestion => 'What’s ton quotidien routine?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'We use this à make ton plan feel realistic pour ton day-à-day life.';

  @override
  String get onboardingRoutineSedentary => 'Sédentaire';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Mostly sitting, desk work, et very little intentional exercice.';

  @override
  String get onboardingRoutineLightlyActive => 'Lightly actif';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Marche régulière, courses ou exercices légers quelques fois par semaine.';

  @override
  String get onboardingRoutineActive => 'Actif';

  @override
  String get onboardingRoutineActiveDescription =>
      'Frequent movement or exercice, like quotidien walks, gym, or actif work.';

  @override
  String get onboardingRoutineVeryActive => 'Very actif';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard training, physically demanding work, or high activity plus days.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Which symptoms are tu plus concerned about, if any?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'We use this à prioritize tips et guidance around le symptoms tu care about plus.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'We use this à focus on le symptoms tu want à rester ahead de.';

  @override
  String get onboardingGenderQuestion => 'How do tu describe ton gender?';

  @override
  String get onboardingGenderExplainer =>
      'We use this pour more relevant guidance et future personalization.';

  @override
  String get onboardingGenderFemale => 'Femme';

  @override
  String get onboardingGenderMale => 'Homme';

  @override
  String get onboardingGenderPreferNotToSay => 'Prefer not à say';

  @override
  String get onboardingTypeYourGender => 'Type ton gender';

  @override
  String get onboardingPreferredNameQuestion => 'What should we call tu?';

  @override
  String get onboardingPreferredNameExplainer =>
      'We use this à make Glu feel more personal when we talk à tu.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Setting up ton plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'We’re turning what tu shared into a plan Glu can support right away.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Locking in poids-maintenance targets...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Mise en place des points de vigilance contre la reprise...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Tuning rappels around ton routine...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Preparing a steadier hebdomadaire plan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Defining repas et poids schémas...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Mise en place du soutien à l’hydratation...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Preparing consistency rappels...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Building a clearer quotidien structure...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Organisation du suivi des symptômes...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Defining hebdomadaire movement targets...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Setting hydration et routine anchors...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Préparation d’un plan plus stable...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'Définition des objectifs d’activité...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Définition du soutien à l’hydratation...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Preparing hebdomadaire habitude rappels...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Construction d’une routine pour la santé cardiaque...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Définition des repères caloriques...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 => 'Setting eau amounts...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Building exercice targets...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Preparing ton hebdomadaire plan...';

  @override
  String get onboardingSetupSummaryHeadline => 'Ton Glu setup is ready.';

  @override
  String get onboardingSetupLoadingTitle => 'Building ton setup';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu is ready à aider tu protect ta progression avec clearer structure et earlier regain signals.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu is ready à support steadier repas, poids tracking, et habits that compter day à day.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu is ready à support steadier routines around symptoms, treatment, et progression.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu is ready à reinforce le habits that support ton long-term heart health.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu is ready à support le routines that aider tu garder le poids off.';

  @override
  String get onboardingSetupSummaryLabel => 'Résumé';

  @override
  String get onboardingSetupAdjustLater =>
      'Tu can adjust any de this later in paramètres.';

  @override
  String get onboardingSummaryGoal => 'Objectif';

  @override
  String get onboardingSummaryCurrentWeight => 'Current poids';

  @override
  String get onboardingSummaryMedication => 'Médicament';

  @override
  String get onboardingSummaryCurrentDose => 'Dose actuelle';

  @override
  String get onboardingSummaryCadence => 'Rythme';

  @override
  String get onboardingSummaryStarted => 'Début';

  @override
  String get onboardingSummaryTargetWeight => 'Target poids';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'Objectif';

  @override
  String get onboardingFrequencyEveryDay => 'Tous les jours';

  @override
  String get onboardingFrequencyEveryWeek => 'Chaque semaine';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Toutes les 2 semaines';

  @override
  String get onboardingFrequencyCustomSchedule => 'Programme personnalisé';

  @override
  String get onboardingTapOptionContinue => 'Tap an option à continuer.';

  @override
  String get onboardingTypeGenderContinue => 'Type ton gender à continuer.';

  @override
  String get onboardingTypeDeviceContinue => 'Type ton device à continuer.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Type ton medication à continuer.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Enter days between doses à continuer.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Choose a schedule à continuer.';

  @override
  String get onboardingScrollChooseAge => 'Scroll à choose ton age.';

  @override
  String get onboardingDragOrTapHeight =>
      'Drag or tap le ruler à choose ton height.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Drag, tap, or use le step buttons à choose a poids.';

  @override
  String get onboardingPickDateAndWeight =>
      'Pick a date et choose a poids à continuer.';

  @override
  String get onboardingSelectSymptoms =>
      'Select any symptoms tu want Glu à focus on.';

  @override
  String get onboardingTypeName => 'Type le name tu want Glu à use.';

  @override
  String get onboardingSaving => 'Enregistrement...';

  @override
  String get onboardingLetsBegin => 'Commençons';

  @override
  String get onboardingContinueWithGlu => 'Continuer avec Glu';

  @override
  String get onboardingKeepGoing => 'Garder going';

  @override
  String get onboardingTurnOnNotifications => 'Activer les notifications';

  @override
  String get onboardingFinish => 'Terminer';

  @override
  String get onboardingTargetBmiTitle => 'Ton target BMI';

  @override
  String get onboardingChartToday => 'Aujourd’hui';

  @override
  String get onboardingChartOverTime => 'Over temps';

  @override
  String get onboardingChartWithoutGlu => 'Sans Glu';

  @override
  String get onboardingChartWithGlu => 'Avec Glu';

  @override
  String get onboardingReviewQuestion =>
      'People use Glu à rester steady et supported';

  @override
  String get onboardingReviewExplainer =>
      'A rapide rating helps more people find support that feels this simple.';

  @override
  String get onboardingReviewBody =>
      'People use Glu à feel more supported, more régulier, et less alone in le process.';

  @override
  String get onboardingTypeYourMedication => 'Type ton medication';

  @override
  String get onboardingSelectStartDate => 'Select commencer date';

  @override
  String get goalsSaveDialogTitle => 'Enregistrer objectifs?';

  @override
  String get goalsSaveDialogMessage =>
      'Tu have unsaved objectif changes. enregistrer them before leaving this tab?';

  @override
  String get commonLater => 'Plus tard';

  @override
  String get homeGreetingAnonymous => 'Salut';

  @override
  String homeGreetingWithName(Object name) {
    return 'Salut, $name';
  }

  @override
  String get homeInsightEmptyTitle =>
      'Enregistre aujourd’hui pour voir ton analyse';

  @override
  String get homeInsightEmptyBody =>
      'Si tu enregistres quelque chose aujourd’hui, tu verras ton analyse ce soir.';

  @override
  String get homeInsightLogTodayTitle =>
      'Transforme tes enregistrements en insight';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Plus de logs, meilleure vision';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Tes logs commencent à montrer un schéma.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Ton aperçu prend forme';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Quelques logs de plus pourraient rendre l’image beaucoup plus claire.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Ce que les logs d’aujourd’hui suggèrent';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Il y a peut-être déjà un schéma caché dans ta journée.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Enregistre au moins une fois aujourd’hui pour voir une image plus claire de tes progrès.';

  @override
  String get homeInsightExpandedTitle => 'C’était utile ?';

  @override
  String get homeInsightExpandedBody =>
      'Une évaluation rapide aide Glu à apprendre ce qui compte le plus pour toi.';

  @override
  String get homeInsightReasonHint =>
      'Que pourrait-on améliorer ? (facultatif)';

  @override
  String get homeInsightReasonSubmit => 'Envoyer';

  @override
  String get homeInsightLearningMessage => 'J’en tirerai des leçons.';

  @override
  String get homeInsightChecking => 'Checking aujourd’hui’s analyse...';

  @override
  String get homeInsightGenerating => 'Chargement de l’analyse du jour...';

  @override
  String get homeInsightTryAgain => 'Réessayer';

  @override
  String get homeSeeAllInsights => 'Voir toutes les analyses';

  @override
  String get insightsProgressTitle => 'Tout analyses';

  @override
  String get insightsProgressEmptyState =>
      'Ton analyses will appear here once they are generated.';

  @override
  String get homeDoseReminderTitle => 'Dose rappel';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Journal $label interaction goes here.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Calorie objectif required';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check needs a repas objectif set à Calories à estimate ton portion. Set one in objectifs à get started.';

  @override
  String get homeSetGoal => 'Set objectif';

  @override
  String get homeYourProgress => 'Ta progression';

  @override
  String get homeRemindersShowcaseTitle => 'Reste sur la bonne voie';

  @override
  String get homeRemindersShowcaseDescription =>
      'Configure des rappels pour prendre tes doses et tes compléments à l’heure.';

  @override
  String get homePickNextDoseDate => 'Pick ton next dose date';

  @override
  String get homeSetReminder => 'Set rappel';

  @override
  String get homeSupplementReminders => 'Complément rappels';

  @override
  String get homeNoUpcomingSupplements => 'No upcoming compléments';

  @override
  String get homeNoMoreUpcomingSupplements => 'Aucun autre à venir';

  @override
  String get homeSetUpYourSupplements => 'Set up ton compléments';

  @override
  String get homeSetUp => 'Configurer';

  @override
  String get homeSupplementFallback => 'Complément';

  @override
  String get doseReminderNotificationTitle => 'Ready pour ton dose?';

  @override
  String get doseReminderFallbackBody => 'Ouvrir Glu à review ton next dose.';

  @override
  String get supplementReminderNotificationTitle => 'Temps pour ton complément';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'This matin';

  @override
  String get supplementReminderThisAfternoon => 'This après-midi';

  @override
  String get supplementReminderTonight => 'Ce soir';

  @override
  String get dailyReminderMorningTitle => 'Point du matin';

  @override
  String get dailyReminderMorningBodies =>
      'Matin mission: give Glu a little data à play avec.\nKick off le day avec a rapide journal et some good élan.\nRise et journal. Future tu will appreciate it.\ncommencer le day avec a tiny mettre à jour et a big head commencer.\nGive Glu a matin clue et garder moving.\nA rapide journal now can make aujourd’hui way more interesting.\nLet’s make le matin count avec a fast check-in.';

  @override
  String get dailyReminderMiddayTitle => 'Point de midi';

  @override
  String get dailyReminderMiddayBodies =>
      'Midday pit stop: drop a rapide journal et garder cruising.\nLunch break? Perfect temps à give Glu an mettre à jour.\nHalfway there. Toss Glu a rapide clue.\nA tiny midday journal can garder le story going.\nCheck in now et garder le day rolling.\nGive ton day a little nudge avec a fast mettre à jour.\ngarder le energy up avec a rapide midday tap.';

  @override
  String get dailyReminderAfternoonTitle => 'Point de l’après-midi';

  @override
  String get dailyReminderAfternoonBodies =>
      'Almost done. Give Glu one more breadcrumb.\nA rapide après-midi journal can make ce soir’s analyse pop.\nWrap le day avec a small mettre à jour et a big win.\nOne more journal before le day wraps up?\naider Glu connect le dots avec a rapide après-midi check-in.\nfermer le loop avec a tiny journal et garder le magic going.\nA final tap now can make ce soir’s analyse way meilleur.';

  @override
  String get homePortionCheckTitle => 'Contrôle des portions';

  @override
  String get homePortionCheckBody => 'Sache combien manger à chaque repas';

  @override
  String get homeGlowUpTitle => 'Ton\nGlow up';

  @override
  String get homeGlowUpBody => 'Create ton before-et-after story';

  @override
  String get homeDoctorReportTitle => 'Rapport médical';

  @override
  String get homeDoctorReportBody => 'Partagez vos progrès avec votre médecin';

  @override
  String get homeGoalsStatusTitle => 'Objectifs aujourd’hui';

  @override
  String get homeGoalsStatusViewAll => 'Voir tout';

  @override
  String get homeWaterTitle => 'Eau';

  @override
  String get homeWeightTitle => 'Poids';

  @override
  String get homeExerciseTitle => 'Exercice';

  @override
  String get homeMealsTitle => 'Repas';

  @override
  String get homeCaloriesTitle => 'Calories';

  @override
  String get homeProteinsTitle => 'Protéines';

  @override
  String get homeFibersTitle => 'Fibres';

  @override
  String get homeSymptomsTitle => 'Symptômes';

  @override
  String get homeMoodTitle => 'Humeur';

  @override
  String get homeCravingsTitle => 'Envies';

  @override
  String get homeDoseTitle => 'Dose';

  @override
  String get homeMedicationLevelTitle => 'Niveau estimé du médicament';

  @override
  String get homeMedicationLevelInfoTitle => 'Comment lire ce graphique';

  @override
  String get homeMedicationLevelInfoBody =>
      'Ce graphique estime la quantité de médicament qui pourrait encore être active, en fonction des doses enregistrées et de la demi-vie du médicament.\n\nDes points plus élevés indiquent généralement une dose plus récente ou plus importante. La ligne diminue avec le temps à mesure que le médicament est éliminé de votre organisme.\n\nUtilisez ceci comme une vue de tendance, pas comme une mesure exacte ou une recommandation médicale.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Compris';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Enregistrez vos doses afin que Glu puisse estimer la quantité de médicament encore active dans votre organisme.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'du pic récent';

  @override
  String get homeMedicationLevelActiveNow => 'Actif actuellement';

  @override
  String get homeMedicationLevelHalfLife => 'Demi-vie';

  @override
  String get homeMedicationLevelLastDose => 'Dernière dose';

  @override
  String get homeStartHydration => 'Commencer hydration';

  @override
  String get homeLogFirstSession => 'Journal ton first session';

  @override
  String get homeLogTodayWeight => 'Journal aujourd’hui’s poids';

  @override
  String get homeAtYourTarget => 'Tu are at ton target';

  @override
  String get homeLogMealsToTrackCalories => 'Journal repas à suivre calories';

  @override
  String get homeLogFirstMeal => 'Journal ton first repas';

  @override
  String get homeTrackProteinFromMeals => 'Suivre protéine from repas';

  @override
  String get homeTrackFiberFromMeals => 'Suivre fibre from repas';

  @override
  String get homeAllClear => 'Tout clear';

  @override
  String get homeTrackSymptoms => 'Suivre symptoms';

  @override
  String get homeGreat => 'Très bien';

  @override
  String get homeGood => 'Bien';

  @override
  String get homeBad => 'Mauvais';

  @override
  String get homeOkay => 'Ça va';

  @override
  String get homeLogHowYouFeel => 'Journal how tu feel';

  @override
  String get homeLogACraving => 'Enregistrer une envie';

  @override
  String get homeLogTodaysDose => 'Journal aujourd’hui’s dose';

  @override
  String get homeTaken => 'Pris';

  @override
  String get homeStartHereTitle => 'Commencer here';

  @override
  String get homeStartHereBody =>
      'Begin avec this card, then expand à others. As Glu learns more about ton journey, it can show tu meilleur schémas et analyses over temps.';

  @override
  String get waterLogTitle => 'Hydratation';

  @override
  String get waterLogEditTitle => 'Modifier l’hydratation';

  @override
  String get waterLogLogTitle => 'Journal eau';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Ajouter une boisson ($amount)';
  }

  @override
  String get waterLogSaving => 'Enregistrement...';

  @override
  String get waterLogCustomDrinkTitle => 'Boisson personnalisée';

  @override
  String get waterLogCustomDrinkBody =>
      'Choose le amount tu want à add right now.';

  @override
  String get waterLogUseThisAmount => 'Utiliser cette quantité';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount added à ton hydration journal';
  }

  @override
  String get waterLogCouldNotSave =>
      'Could not enregistrer this eau journal yet.';

  @override
  String get waterLogDeleteTitle => 'Supprimer this hydration journal?';

  @override
  String get waterLogDeleteMessage => 'Cette action est irréversible.';

  @override
  String get waterLogCouldNotDelete =>
      'Could not supprimer this hydration journal yet.';

  @override
  String get waterLogDeleteLog => 'Supprimer journal';

  @override
  String get waterLogDeleted => 'Hydratation supprimée';

  @override
  String get moodLogTitle => 'Humeur';

  @override
  String get moodEditTitle => 'Modifier l’humeur';

  @override
  String get moodHowYouFeel => 'How tu feel';

  @override
  String get moodBad => 'Pas terrible';

  @override
  String get moodOkay => 'Ça va';

  @override
  String get moodGood => 'Bien';

  @override
  String get moodGreat => 'Très bien';

  @override
  String get moodNotes => 'Notes';

  @override
  String get moodAnythingWorthRemembering =>
      'Anything worth remembering about ton mood?';

  @override
  String get moodCouldNotSave => 'Could not enregistrer this mood journal yet.';

  @override
  String get moodDeleteTitle => 'Supprimer this mood journal?';

  @override
  String get moodDeleteMessage => 'Cette action est irréversible.';

  @override
  String get moodDeleteLog => 'Supprimer journal';

  @override
  String get moodSaving => 'Enregistrement...';

  @override
  String get moodAddMoodLog => '+ Add mood journal';

  @override
  String get moodLogged => 'Humeur enregistrée';

  @override
  String get moodDeleted => 'Humeur supprimée';

  @override
  String get moodCouldNotDelete => 'Could not supprimer this mood journal yet.';

  @override
  String get moodAddedToMoodLog => 'Added à ton mood journal';

  @override
  String get cravingsLogTitle => 'Envies';

  @override
  String get cravingsEditTitle => 'Modifier l\'envie';

  @override
  String get cravingsWhatsGoingOn => 'Ce qui se passe';

  @override
  String get cravingsTypeGeneral => 'Envie de manger';

  @override
  String get cravingsTypeSweet => 'Quelque chose de sucré';

  @override
  String get cravingsTypeSalty => 'Quelque chose de salé';

  @override
  String get cravingsIntensityLabel => 'Intensité (facultatif)';

  @override
  String get cravingsIntensityMild => 'Légère';

  @override
  String get cravingsIntensityModerate => 'Modérée';

  @override
  String get cravingsIntensityStrong => 'Forte';

  @override
  String get cravingsOutcomeLabel => 'Ce qui s\'est passé (facultatif)';

  @override
  String get cravingsOutcomeResisted => 'Résisté';

  @override
  String get cravingsOutcomeGaveIn => 'Cédé';

  @override
  String get cravingsNotes => 'Notes';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Quelque chose à retenir sur cette envie ?';

  @override
  String get cravingsCouldNotSave =>
      'Impossible d\'enregistrer cette envie pour le moment.';

  @override
  String get cravingsDeleteTitle => 'Supprimer cette envie ?';

  @override
  String get cravingsDeleteMessage => 'Cette action est irréversible.';

  @override
  String get cravingsDeleteLog => 'Supprimer l\'entrée';

  @override
  String get cravingsSaving => 'Enregistrement...';

  @override
  String get cravingsAddLog => '+ Ajouter une envie';

  @override
  String get cravingsLogged => 'Envie enregistrée';

  @override
  String get cravingsDeleted => 'Envie supprimée';

  @override
  String get cravingsCouldNotDelete =>
      'Impossible de supprimer cette envie pour le moment.';

  @override
  String get cravingsAddedToLog => 'Ajouté à votre journal des envies';

  @override
  String get portionCheckTitle => 'Contrôle des portions';

  @override
  String get portionCheckAnalyzingMeal => 'Analyzing ton repas…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Impossible d’analyser cette photo';

  @override
  String get portionCheckTakeNewPhoto => 'Prendre une nouvelle photo';

  @override
  String get portionCheckSomethingWentWrong => 'Une erreur est survenue.';

  @override
  String get portionCheckYouHitDailyLimit => 'Tu\'ve hit ton quotidien limit';

  @override
  String get portionCheckYouCanEat => 'Tu can eat';

  @override
  String get portionCheckYouCanEatUpTo => 'Tu can eat up à';

  @override
  String get portionCheckTryLighterOption =>
      'Essaie plutôt une option plus légère ou passe celle-ci';

  @override
  String get portionCheckThisEntireMeal => 'This entire repas';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% de this repas';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'À rester within ton quotidien objectifs.';

  @override
  String get portionCheckNutritionBreakdown => 'Répartition nutritionnelle';

  @override
  String get portionCheckTipsToBalanceMeal => 'Tips à balance ton repas';

  @override
  String get portionCheckTipsPool =>
      'Mange lentement - la sensation de satiété met environ 20 minutes à rattraper.\nRemplis la moitié de ton assiette avec des légumes.\nAjoute des protéines à chaque repas.\nBois de l\'eau avant les repas.\nRépartis les encas dans de petits contenants.\nAssocie les glucides à des protéines ou des graisses pour rester rassasié plus longtemps.\nChoisis des aliments peu transformés quand c\'est possible.\nÉvite de manger en étant distrait par les écrans.\nNe saute pas de repas si cela te pousse à trop manger plus tard.\nPrévois tes encas avant d\'avoir faim.';

  @override
  String get portionCheckRetake => 'Reprendre';

  @override
  String get portionCheckLogThisPortion => 'Journal this portion';

  @override
  String get portionCheckCarbs => 'Glucides';

  @override
  String get portionCheckProteins => 'Protéines';

  @override
  String get portionCheckFats => 'Lipides';

  @override
  String get portionCheckFiber => 'Fibre';

  @override
  String get mealLogScreenTitle => 'Repas';

  @override
  String get mealLogEditTitle => 'Edit repas';

  @override
  String get mealLogLogTitle => 'Journal repas';

  @override
  String get mealLogSaving => 'Enregistrement...';

  @override
  String get mealLogAddMealLog => '+ Add repas journal';

  @override
  String get mealLogCouldNotStartRecording => 'Could not commencer recording.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'L’enregistrement a été arrêté à 60 secondes.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Impossible d’analyser cet enregistrement.';

  @override
  String get mealLogCouldNotAnalyzeText => 'Impossible d’analyser ce texte.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Impossible d’analyser cette photo.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Could not process this repas photo yet.';

  @override
  String get mealLogDiscardTitle => 'Discard this repas?';

  @override
  String get mealLogDiscardMessage =>
      'Tu reviewed a photo but didn\'t enregistrer le entry. It won\'t be logged.';

  @override
  String get mealLogDiscard => 'Abandonner';

  @override
  String get mealLogDeleteTitle => 'Supprimer this repas journal?';

  @override
  String get mealLogDeleteMessage => 'Cette action est irréversible.';

  @override
  String get mealLogDelete => 'Supprimer';

  @override
  String get mealLogDeleteLog => 'Supprimer journal';

  @override
  String get mealLogCouldNotSave =>
      'Could not enregistrer this repas journal yet.';

  @override
  String get mealLogCouldNotDelete =>
      'Could not supprimer this repas journal yet.';

  @override
  String get mealLogAnalyzing => 'Analyse en cours...';

  @override
  String get mealLogAnalyzeText => 'Analyser le texte';

  @override
  String get mealLogSendRecording => 'Envoyer l’enregistrement';

  @override
  String get mealLogMealDefaultName => 'Repas';

  @override
  String get mealLogMealNameHint => 'Repas name';

  @override
  String get mealLogCouldNotPrefillTitle => 'Couldn’t prefill this repas';

  @override
  String get mealLogHowMuchDidYouEat => 'How much did tu eat?';

  @override
  String get mealLogNotes => 'Notes';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Anything worth remembering about this repas?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analyzing ton repas';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Turning ton input into nutrition fields. tu can review everything before saving.';

  @override
  String get mealLogDescribeYourMealTitle => 'Describe ton repas';

  @override
  String get mealLogDescribeYourMealBody =>
      'Write what tu ate et any amounts tu know. We’ll turn it into nutrition fields.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Example: grilled chicken salad, olive oil dressing, 1 apple, sparkling eau';

  @override
  String get mealLogCaptureYourMealTitle => 'Capture ton repas';

  @override
  String get mealLogCaptureYourMealBody =>
      'Take a photo et we’ll estimate le nutrition fields pour tu.';

  @override
  String get mealLogTakePhoto => 'Prendre une photo';

  @override
  String get mealLogRecordingYourMealTitle => 'Recording ton repas';

  @override
  String get mealLogRecordingReadyTitle => 'Enregistrement prêt';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Enregistrer a repas description';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tap stop when tu’re done. ${remaining}s left';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Send it below à analyze, or enregistrer again.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Speak naturally about what tu ate et we’ll parse it into macros.';

  @override
  String get mealLogStopRecording => 'Arrêter l’enregistrement';

  @override
  String get mealLogRecordAgain => 'Enregistrer again';

  @override
  String get mealLogStartRecording => 'Commencer recording';

  @override
  String get mealLogBreakfast => 'Petit-déjeuner';

  @override
  String get mealLogLunch => 'Déjeuner';

  @override
  String get mealLogSnack => 'Collation';

  @override
  String get mealLogDinner => 'Dîner';

  @override
  String get mealLogKcalUnit => 'Kcal';

  @override
  String get mealLogToday => 'Aujourd’hui';

  @override
  String get mealLogYesterday => 'Hier';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal enregistrées';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g de $macro enregistrés';
  }

  @override
  String get mealLogDeleted => 'Repas deleted';

  @override
  String get mealLogAddedToMealLog => 'Added à ton repas journal';

  @override
  String get mealLogCarbs => 'Glucides';

  @override
  String get mealLogProteins => 'Protéines';

  @override
  String get mealLogFats => 'Lipides';

  @override
  String get mealLogFiber => 'Fibre';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageDialogTitle => 'Choisir la langue';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsPreferences => 'Préférences';

  @override
  String get settingsHealthGoal => 'Health objectif';

  @override
  String get settingsHealthGoalDialogTitle => 'Select health objectif';

  @override
  String get settingsHabitGoals => 'Habitude objectifs';

  @override
  String get settingsDisabled => 'Désactivé';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count actif';
  }

  @override
  String get settingsHeight => 'Taille';

  @override
  String get settingsAge => 'Âge';

  @override
  String get settingsGender => 'Genre';

  @override
  String get settingsMeasurementUnit => 'Unité de mesure';

  @override
  String get settingsReminders => 'Rappels';

  @override
  String get settingsDoseReminder => 'Dose rappel';

  @override
  String get settingsSupplementReminder => 'Complément rappel';

  @override
  String get settingsDailyReminders => 'Quotidien rappels';

  @override
  String get settingsSubscription => 'Abonnement';

  @override
  String get settingsSupport => 'Aide';

  @override
  String get settingsSendFeedback => 'Envoyer un retour';

  @override
  String get feedbackSheetTitle => 'Envoyer des commentaires';

  @override
  String get feedbackSheetHint => 'Dites-nous ce que vous en pensez…';

  @override
  String get feedbackSheetSend => 'Envoyer';

  @override
  String get feedbackSheetSuccess => 'Merci pour vos commentaires !';

  @override
  String get feedbackSheetError => 'Impossible d’envoyer. Veuillez réessayer.';

  @override
  String get settingsTermsOfService => 'Terms de Service';

  @override
  String get settingsPrivacyPolicy => 'Politique de confidentialité';

  @override
  String get settingsInternal => 'Interne';

  @override
  String get settingsSubscriptionOverride => 'Forçage de l’abonnement';

  @override
  String get settingsTodayInsightCard => 'Aujourd’hui analyse card';

  @override
  String get settingsResetOnboarding => 'Réinitialiser l’onboarding';

  @override
  String get settingsResetShowcases => 'Réinitialiser les présentations';

  @override
  String get settingsResetUserData => 'Réinitialiser les données utilisateur';

  @override
  String get settingsDeletingAccount => 'Suppression du compte...';

  @override
  String get settingsDisconnect => 'Déconnecter';

  @override
  String get settingsDeleteAccount => 'Supprimer Account';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Déconnecter $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Déconnecter $provider ?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Tu will no longer be able à sign in avec $provider on this device unless tu reconnect it later.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Supprimer account?';

  @override
  String get settingsDeleteAccountBody =>
      'This will permanently remove ton account et tout de ton data. This action cannot be undone.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Type supprimer à confirm';

  @override
  String get settingsDeleteAccountError =>
      'Something went wrong while deleting ton account. Please contact support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Restart app à see onboarding';

  @override
  String get settingsShowcasesReset => 'Présentations réinitialisées';

  @override
  String get settingsResetUserDataTitle =>
      'Réinitialiser les données utilisateur ?';

  @override
  String get settingsResetUserDataBody =>
      'This will clear tout logged enregistrements pour repas, eau, exercice, poids, mood, symptoms, compléments, et doses.';

  @override
  String get settingsUserDataReset => 'Données utilisateur réinitialisées';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Saved, but quotidien rappels could not be scheduled right now.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Forçage de l’abonnement';

  @override
  String get settingsSubscriptionOverrideAuto => 'Auto';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Forcer gratuit';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Forcer Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Aujourd’hui analyse card';

  @override
  String get settingsTodayInsightCardAuto => 'Auto';

  @override
  String get settingsTodayInsightCardOn => 'Activé';

  @override
  String get settingsTodayInsightCardOff => 'Désactivé';

  @override
  String get settingsYourName => 'Ton name';

  @override
  String get settingsSignOut => 'Se déconnecter';

  @override
  String get settingsHeightCm => 'Cm';

  @override
  String get settingsHeightFtIn => 'Ft/in';

  @override
  String get settingsHeightFt => 'Ft';

  @override
  String get settingsHeightIn => 'In';

  @override
  String get settingsGenderMale => 'Homme';

  @override
  String get settingsGenderFemale => 'Femme';

  @override
  String get settingsGenderPreferNotToSay => 'Prefer not à say';

  @override
  String get settingsGenderOther => 'Autre';

  @override
  String get settingsYourProfile => 'Ton profile';

  @override
  String get settingsNotSet => 'Non défini';

  @override
  String settingsYears(Object value) {
    return '$value ans';
  }

  @override
  String get settingsOff => 'Désactivé';

  @override
  String get settingsOn => 'Activé';

  @override
  String get settingsNoneSet => 'Aucun défini';

  @override
  String settingsSupplementCount(Object count) {
    return '$count complément(s)';
  }

  @override
  String get commonToday => 'Aujourd’hui';

  @override
  String get mainShellHome => 'Accueil';

  @override
  String get mainShellLog => 'Journal';

  @override
  String get mainShellProgress => 'Progression';

  @override
  String get mainShellSettings => 'Paramètres';

  @override
  String get mainShellLogShowcaseTitle => 'Suis ce qui compte au quotidien';

  @override
  String get mainShellLogShowcaseDescription =>
      'Enregistre les activités qui comptent le plus pour toi, chaque jour.';

  @override
  String get logMoodShowcaseTitle => 'Commencez par votre humeur';

  @override
  String get logMoodShowcaseDescription =>
      'Enregistrez votre humeur maintenant, puis continuez à tout enregistrer au fil de la journée pour que Glu repère vos habitudes et schémas avec plus de précision.';

  @override
  String get mainShellProgressShowcaseTitle => 'Voir ta progression';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Vérifie tes tendances et schémas pour comprendre comment tes habitudes et ton poids évoluent au fil du temps.';

  @override
  String get progressMenuShowcaseTitle => 'Explorez vos données';

  @override
  String get progressMenuShowcaseDescription =>
      'Consultez tous les graphiques, lisez les analyses générées par l’IA ou créez un rapport médical à partager avec votre équipe soignante.';

  @override
  String get settingsFeedbackShowcaseTitle => 'Nous aimerions avoir votre avis';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Appuyez ici pour partager ce qui fonctionne, ce qui ne fonctionne pas ou vos idées.';

  @override
  String get authCouldNotOpenLink => 'Could not ouvrir link right now.';

  @override
  String get authWelcomeTitle => 'Welcome à Glu';

  @override
  String get authSubtitle => 'Secure sign-in pour ton wellness companion';

  @override
  String get authContinueWithGoogle => 'Continuer avec Google';

  @override
  String get authContinueWithApple => 'Continuer avec Apple';

  @override
  String get authEmailHint => 'Name@email.com';

  @override
  String get authSending => 'Envoi...';

  @override
  String get authResendLink => 'Renvoyer le lien';

  @override
  String get authUseDifferentEmail => 'Utiliser une autre adresse e-mail';

  @override
  String get habitGoalsTitle => 'Habitude objectifs';

  @override
  String get goalsProteins => 'Protéines';

  @override
  String get goalsFibers => 'Fibres';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g par jour';
  }

  @override
  String get goalsWater => 'Eau';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value L par jour';
  }

  @override
  String get goalsExercise => 'Exercice';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min par jour';
  }

  @override
  String get goalsMeals => 'Repas';

  @override
  String get goalsCalories => 'Calories';

  @override
  String get goalsKcalUnit => 'Kcal';

  @override
  String get goalsPerWeekSuffix => 'Per week';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count repas per day';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal par jour';
  }

  @override
  String get goalsWeight => 'Poids';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Add a logged poids à calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'Tu are already at this target';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/week à target';
  }

  @override
  String get goalsSetTargetForNextWeek => 'Set le target pour next week.';

  @override
  String get progressWeightTitle => 'Poids';

  @override
  String get progressWeightLabel => 'Poids ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'IMC sain';

  @override
  String get progressTotal => 'Total';

  @override
  String get progressPercent => 'Pourcentage';

  @override
  String get progressWeeklyAvg => 'Hebdomadaire avg';

  @override
  String get progressRangeAllTime => 'Tout temps';

  @override
  String get progressRange1Month => '1 mois';

  @override
  String get progressRange3Months => '3 mois';

  @override
  String get progressRange6Months => '6 mois';

  @override
  String get progressLow => 'Faible';

  @override
  String get progressMed => 'Moyen';

  @override
  String get progressHigh => 'Élevé';

  @override
  String get progressSeverity => 'Gravité';

  @override
  String get progressBad => 'Mauvais';

  @override
  String get progressOkay => 'D’accord';

  @override
  String get progressGood => 'Bien';

  @override
  String get progressGreat => 'Très bien';

  @override
  String get progressMostlyBad => 'Plutôt mauvais';

  @override
  String get progressMostlyOkay => 'Plutôt correct';

  @override
  String get progressMostlyGood => 'Plutôt bien';

  @override
  String get progressMostlyGreat => 'Très bien';

  @override
  String get progressNoDose => 'Pas de dose';

  @override
  String get progressLogged => 'Enregistré';

  @override
  String get progressAllClear => 'Tout clear';

  @override
  String get progressFreq => 'Fréq.';

  @override
  String get progressAverage => 'Moyenne';

  @override
  String get progressDaily => 'Quotidien';

  @override
  String get progressWeekly => 'Hebdomadaire';

  @override
  String get progressMinutes => 'Minutes';

  @override
  String get progressIntensity => 'Intensité';

  @override
  String get progressCalories => 'Calories';

  @override
  String get progressByDose => 'Par dose';

  @override
  String get progressWeightProgressTitle => 'Poids progression';

  @override
  String get progressWaterProgressTitle => 'Eau progression';

  @override
  String get progressExerciseProgressTitle => 'Exercice progression';

  @override
  String get progressDoseProgressTitle => 'Dose progression';

  @override
  String get progressMealsProgressTitle => 'Repas progression';

  @override
  String get progressSymptomsProgressTitle => 'Symptoms progression';

  @override
  String get progressMoodProgressTitle => 'Mood progression';

  @override
  String get progressCravingsProgressTitle => 'Progression des envies';

  @override
  String get progressResisted => 'Résisté';

  @override
  String get progressCravingsResistedSubtitle =>
      'Part des envies enregistrées auxquelles vous avez résisté.';

  @override
  String get progressWeightChangeTitle => 'Poids change';

  @override
  String get progressTitle => 'Progression';

  @override
  String get progressMenuViewAllInsights => 'Voir toutes les analyses';

  @override
  String get progressMenuViewAllCharts => 'Voir tous les graphiques';

  @override
  String get progressMenuCreateDoctorReport => 'Créer un rapport médical';

  @override
  String get progressReportGenerating => 'Génération de votre rapport…';

  @override
  String get progressReportError =>
      'Impossible de générer le rapport. Veuillez réessayer.';

  @override
  String get progressReportPendingRetry =>
      'Votre rapport peut encore être finalisé dans un instant. Veuillez réessayer.';

  @override
  String get progressReportOpenError =>
      'Votre rapport a été généré, mais nous n\'avons pas pu l\'ouvrir. Veuillez réessayer.';

  @override
  String get progressReportOpenedInBrowser =>
      'Rapport prêt. Ouvert dans votre navigateur.';

  @override
  String get progressReportCopiedLink =>
      'Rapport prêt. Le partage n\'était pas disponible, le lien a donc été copié dans votre presse-papiers.';

  @override
  String get progressAllProgressTitle => 'Toute la progression';

  @override
  String get progressWeightTrendExplanation =>
      'Découvre comment ton poids évolue au fil du temps.';

  @override
  String get progressNoWeightLogsYet => 'No poids logs yet';

  @override
  String get progressNoLogsYet => 'Aucun enregistrement pour le moment';

  @override
  String get progressLogWeightToStartTrend =>
      'Journal poids à commencer tracking ton tendance.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Enregistre ton poids et ta dose pour comparer comment le dosage évolue avec le changement.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Chaque point est coloré selon la dernière dose utilisée avant cette pesée.';

  @override
  String get progressNoHydrationYet => 'Aucune hydratation pour le moment';

  @override
  String get progressNoMovementYet => 'Aucun mouvement pour le moment';

  @override
  String get progressNoDoseLogsYet =>
      'Aucun enregistrement de dose pour le moment';

  @override
  String get progressNoMealsLoggedYet => 'No repas logged yet';

  @override
  String get progressNoSymptomsLoggedYet =>
      'Aucun symptôme enregistré pour le moment';

  @override
  String get progressNoMoodLogsYet =>
      'Aucune humeur enregistrée pour le moment';

  @override
  String get progressNoCravingsLoggedYet =>
      'Aucune envie enregistrée pour le moment';

  @override
  String get progressFutureTrendTitle => 'Tendance future';

  @override
  String get progressFutureTrendBody => 'Une jolie chronologie de ton élan';

  @override
  String get progressGoal => 'Objectif';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Ton latest logged poids is ready à suivre.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'About $gap $unit from ton target.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText vs ton previous journal.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText vs previous journal. $gap $unit from target.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Compared avec ton previous journal, le tendance is now visible.';

  @override
  String get progressWaterTitle => 'Eau';

  @override
  String get manageSubscriptionTitle => 'Gérer l’abonnement';

  @override
  String get manageSubscriptionProPlan => 'Forfait Pro';

  @override
  String get manageSubscriptionFreePlan => 'Forfait gratuit';

  @override
  String get manageSubscriptionActiveCopy => 'Ton subscription is actif.';

  @override
  String get manageSubscriptionUpgradeCopy => 'Upgrade à débloquer Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Abonnement';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratuit';

  @override
  String get manageSubscriptionProduct => 'Produit';

  @override
  String get manageSubscriptionRenewal => 'Renouvellement';

  @override
  String get manageSubscriptionStatus => 'Statut';

  @override
  String get manageSubscriptionStatusActive => 'Actif';

  @override
  String get manageSubscriptionStatusInactive => 'Not actif';

  @override
  String get manageSubscriptionManageButton => 'Gérer l’abonnement';

  @override
  String get manageSubscriptionUpgradeButton => 'Upgrade à Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Ouvrir store subscription paramètres';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Restaurer purchases';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Se renouvelle automatiquement';

  @override
  String get manageSubscriptionLifetime => 'À vie';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Renouvellement le $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Expire le $date';
  }

  @override
  String get supplementReminderDayMon => 'Lun';

  @override
  String get supplementReminderDayTue => 'Mar';

  @override
  String get supplementReminderDayWed => 'Mer';

  @override
  String get supplementReminderDayThu => 'Jeu';

  @override
  String get supplementReminderDayFri => 'Ven';

  @override
  String get supplementReminderDaySat => 'Sam';

  @override
  String get supplementReminderDaySun => 'Dim';

  @override
  String supplementReminderInDays(Object count) {
    return 'Dans $count jours';
  }

  @override
  String get supplementReminderInOneWeek => 'Dans 1 semaine';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Dans $count semaines';
  }

  @override
  String get subscriptionDebugTitle => 'Abonnements Glu';

  @override
  String get subscriptionDebugMonthly => 'Mensuel';

  @override
  String get subscriptionDebugYearly => 'Annuel';

  @override
  String get subscriptionDebugRefreshCustomerInfo =>
      'Actualiser les infos client';

  @override
  String get subscriptionDebugPresentPaywall => 'Afficher le paywall';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Ouvrir Customer Center';

  @override
  String get subscriptionDebugRestorePurchases => 'Restaurer Purchases';

  @override
  String get subscriptionDebugSyncPurchases => 'Synchroniser les achats';

  @override
  String get subscriptionDebugRevenuecatStatus => 'État de RevenueCat';

  @override
  String get subscriptionDebugConfigured => 'Configuré';

  @override
  String get subscriptionDebugBusy => 'Occupé';

  @override
  String get subscriptionDebugAppUserId => 'ID utilisateur de l’app';

  @override
  String get subscriptionDebugAnonymous => 'Anonymous';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API key disponible';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro actif';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Actif subscriptions';

  @override
  String get subscriptionDebugManagementUrl => 'URL de gestion';

  @override
  String get subscriptionDebugEntitlementProduct => 'Produit d’accès';

  @override
  String get subscriptionDebugWillRenew => 'Se renouvellera';

  @override
  String get subscriptionDebugExpiration => 'Expiration';

  @override
  String get subscriptionDebugLifetime => 'Lifetime';

  @override
  String get subscriptionDebugPackageFound => 'Forfait trouvé';

  @override
  String get subscriptionDebugProductId => 'ID du produit';

  @override
  String get subscriptionDebugTitleLabel => 'Titre';

  @override
  String get subscriptionDebugPrice => 'Prix';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Acheter $title';
  }

  @override
  String get progressExerciseTitle => 'Exercice';

  @override
  String get progressDoseTitle => 'Dose';

  @override
  String get progressMealsTitle => 'Repas';

  @override
  String get progressSymptomsTitle => 'Symptômes';

  @override
  String get progressMoodTitle => 'Humeur';

  @override
  String get progressCravingsTitle => 'Envies';

  @override
  String get progressTrend => 'Tendance';

  @override
  String get progressTarget => 'Objectif';

  @override
  String get progressNoTrendYet => 'No tendance yet';

  @override
  String get progressNoActivityYet => 'Aucune activité pour le moment';

  @override
  String get progressNoCheckInsYet => 'Aucun point de suivi pour le moment';

  @override
  String get progressWeightSignatureChip =>
      'Poids will become ton signature graphique';

  @override
  String get progressWeightStartTrendTitle =>
      'Commencer ton tendance avec one weigh-in';

  @override
  String get progressWeightStartTrendBody =>
      'This graphique is le centerpiece de ta progression story. journal ton first poids à débloquer élan, milestones, et a voir worth sharing.';

  @override
  String get progressWeightMomentum => 'Évolution du poids';

  @override
  String get progressWeightMilestones => 'Jalons';

  @override
  String get progressWeightShareReady => 'Partager-ready';

  @override
  String get progressWeightLogWeight => 'Journal poids';

  @override
  String get weightProgressUnlocksViewChip =>
      'Ton first weigh-in unlocks this voir';

  @override
  String get weightProgressStartsHereTitle =>
      'Ta progression story starts here';

  @override
  String get weightProgressStartsHereBody =>
      'Journal ton first poids à débloquer tendances, milestones, et dose-aware analyses in a voir worth sharing.';

  @override
  String get weightProgressTrendView => 'Tendance voir';

  @override
  String get weightProgressDoseOverlays => 'Superpositions de dose';

  @override
  String get weightProgressMilestones => 'Jalons';

  @override
  String get weightProgressLogWeight => 'Journal poids';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Add both a before et after photo first.';

  @override
  String get glowUpSavedToGallery => 'Saved à ton gallery';

  @override
  String get glowUpSaveToGallery => 'Enregistrer dans la galerie';

  @override
  String get glowUpYourProgress => 'Ta progression';

  @override
  String get glowUpWeightChange => 'Poids change';

  @override
  String get glowUpTime => 'Temps';

  @override
  String get glowUpShare => 'Partager';

  @override
  String get glowUpBefore => 'AVANT';

  @override
  String get glowUpAfter => 'APRÈS';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight en $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'jours';

  @override
  String get glowUpTimeUnitWeeksLabel => 'semaines';

  @override
  String get glowUpTimeUnitMonthsLabel => 'mois';

  @override
  String get glowUpTimeUnitYearsLabel => 'ans';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semaines',
      one: '$count semaine',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mois',
      one: '$count mois',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Hier';

  @override
  String get commonSelect => 'Sélectionner';

  @override
  String get doseReminderTitle => 'Dose rappel';

  @override
  String get doseReminderCustomDoseTitle => 'Dose personnalisée';

  @override
  String get doseReminderCustomDoseHint => 'Saisis la dose en mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Garder ton next dose ready on accueil.';

  @override
  String get doseReminderTime => 'Temps';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Turn this on à show le next dose on accueil.';

  @override
  String get doseReminderSaveReminder => 'Enregistrer rappel';

  @override
  String loggedOn(Object date) {
    return 'Enregistré le $date';
  }

  @override
  String get waterLogSmallGlass => 'Petit verre';

  @override
  String get waterLogGlass => 'Verre';

  @override
  String get waterLogBottle => 'Bouteille';

  @override
  String get waterLogLargeBottle => 'Grande bouteille';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Personnalisé';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dose';

  @override
  String get doseLogEditTitle => 'Modifier la dose';

  @override
  String get doseLogLogTitle => 'Journal dose';

  @override
  String get doseLogCustomDose => 'Dose personnalisée';

  @override
  String get doseLogCustomDoseBody => 'Adjust le dose in mg pour this journal.';

  @override
  String get doseLogUseThisDose => 'Utiliser cette dose';

  @override
  String get doseLogMedication => 'Médicament';

  @override
  String get doseLogInjectionSite => 'Site d’injection';

  @override
  String get doseLogNotes => 'Notes';

  @override
  String get doseLogSaveChanges => 'Enregistrer changes';

  @override
  String get doseLogAddDose => '+ journal dose';

  @override
  String get doseLogDeleteTitle => 'Supprimer this dose journal?';

  @override
  String get doseLogDeleteMessage => 'Cette action est irréversible.';

  @override
  String get doseLogDeleteLog => 'Supprimer journal';

  @override
  String get doseLogSaving => 'Enregistrement...';

  @override
  String get doseLogCouldNotSave =>
      'Could not enregistrer this dose journal yet.';

  @override
  String get doseLogCouldNotDelete =>
      'Could not supprimer this dose journal yet.';

  @override
  String get doseLogDeleted => 'Dose supprimée';

  @override
  String get doseLogAddedToDoseLog => 'Added à ton dose journal';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Quelque chose à retenir à propos de cette dose ?';

  @override
  String get doseLogDoseLabel => 'Dose';

  @override
  String get exerciseLogTitle => 'Exercice';

  @override
  String get exerciseLogEditTitle => 'Edit exercice';

  @override
  String get exerciseLogLogTitle => 'Journal exercice';

  @override
  String get exerciseLogActivityType => 'Type d’activité';

  @override
  String get exerciseLogCustomActivity => 'Activité personnalisée';

  @override
  String get exerciseLogTypeActivity => 'Type le activity';

  @override
  String get exerciseLogDuration => 'Durée';

  @override
  String get exerciseLogIntensity => 'Intensité';

  @override
  String get exerciseLogNotes => 'Notes';

  @override
  String get exerciseLogLight => 'Léger';

  @override
  String get exerciseLogModerate => 'Modéré';

  @override
  String get exerciseLogIntense => 'Intense';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min enregistrées';
  }

  @override
  String get exerciseLogSaveChanges => 'Enregistrer changes';

  @override
  String get exerciseLogAddExercise => '+ Add exercice journal';

  @override
  String get exerciseLogDeleteTitle => 'Supprimer this exercice journal?';

  @override
  String get exerciseLogDeleteMessage => 'Cette action est irréversible.';

  @override
  String get exerciseLogDeleteLog => 'Supprimer journal';

  @override
  String get exerciseLogSaving => 'Enregistrement...';

  @override
  String get exerciseLogCouldNotSave =>
      'Could not enregistrer this exercice journal yet.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Could not supprimer this exercice journal yet.';

  @override
  String get exerciseLogDeleted => 'Exercice deleted';

  @override
  String get exerciseLogAddedToExerciseLog => 'Added à ton exercice journal';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Quelque chose à retenir à propos de cette séance ?';

  @override
  String get exerciseLogWalking => 'Marche';

  @override
  String get exerciseLogRunning => 'Course';

  @override
  String get exerciseLogCycling => 'Vélo';

  @override
  String get exerciseLogStrength => 'Renforcement';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Natation';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Poids';

  @override
  String get weightLogEditTitle => 'Edit poids';

  @override
  String get weightLogLogTitle => 'Journal poids';

  @override
  String get weightLogSaveChanges => 'Enregistrer changes';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Add poids ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Supprimer this poids journal?';

  @override
  String get weightLogDeleteMessage => 'Cette action est irréversible.';

  @override
  String get weightLogDeleteLog => 'Supprimer journal';

  @override
  String get weightLogSaving => 'Enregistrement...';

  @override
  String get weightLogCouldNotSave =>
      'Could not enregistrer this poids journal yet.';

  @override
  String get weightLogCouldNotDelete =>
      'Could not supprimer this poids journal yet.';

  @override
  String get weightLogDeleted => 'Poids deleted';

  @override
  String get weightLogAddedToWeightLog => 'Added à ton poids journal';

  @override
  String get weightLogNoWeightForDay => 'No poids logged pour this day yet.';

  @override
  String get injectionSiteAbdomen => 'Abdomen';

  @override
  String get injectionSiteThigh => 'Cuisse';

  @override
  String get injectionSiteUpperArm => 'Bras';

  @override
  String get injectionSiteButtocks => 'Fesses';

  @override
  String get injectionSiteAbdomenUpperLeft => 'haut gauche de l’abdomen';

  @override
  String get injectionSiteAbdomenUpperRight => 'haut droit de l’abdomen';

  @override
  String get injectionSiteAbdomenLowerRight => 'bas droit de l’abdomen';

  @override
  String get injectionSiteAbdomenLowerLeft => 'bas gauche de l’abdomen';

  @override
  String get injectionSiteThighUpperLeft => 'haut gauche de la cuisse';

  @override
  String get injectionSiteThighUpperRight => 'haut droit de la cuisse';

  @override
  String get injectionSiteThighLowerRight => 'bas droit de la cuisse';

  @override
  String get injectionSiteThighLowerLeft => 'bas gauche de la cuisse';

  @override
  String get injectionSiteUpperArmLeft => 'bras gauche';

  @override
  String get injectionSiteUpperArmRight => 'bras droit';

  @override
  String get injectionSiteButtocksUpperLeft => 'haut gauche des fesses';

  @override
  String get injectionSiteButtocksUpperRight => 'haut droit des fesses';

  @override
  String get doseReminderFormat => 'Format';

  @override
  String get doseReminderInjection => 'Injection';

  @override
  String get doseReminderPill => 'Comprimé';

  @override
  String get doseReminderSite => 'Site';

  @override
  String get doseReminderDate => 'Date';

  @override
  String get supplementReminderTitle => 'Complément rappel';

  @override
  String get supplementReminderAddSupplement => 'Add complément';

  @override
  String get supplementReminderNoSupplementsYet => 'No compléments yet';

  @override
  String get supplementReminderAddFirstBody =>
      'Add ton first complément rappel à suivre ton quotidien intake.';

  @override
  String get supplementReminderSupplementFallback => 'Complément';

  @override
  String get supplementReminderEveryDay => 'Chaque jour';

  @override
  String get supplementReminderEveryXDaysLabel => 'Tous les X jours';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Tous les $interval jours';
  }

  @override
  String get supplementReminderNoDaysSet => 'Aucun jour défini';

  @override
  String get supplementReminderSupplementName => 'Complément name';

  @override
  String get supplementReminderTime => 'Temps';

  @override
  String get supplementReminderStartDate => 'Commencer date';

  @override
  String get supplementReminderRepeat => 'Répéter';

  @override
  String get supplementReminderDaysOfWeek => 'Days de week';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Sélectionne au moins un jour.';

  @override
  String get supplementReminderEvery => 'Chaque';

  @override
  String get supplementReminderDay => 'Day';

  @override
  String get supplementReminderDays => 'Days';

  @override
  String get supplementReminderAdd => 'Ajouter';

  @override
  String get symptomsLogTitle => 'Symptômes';

  @override
  String get symptomsLogEditTitle => 'Modifier les symptômes';

  @override
  String get symptomsLogLogTitle => 'Journal symptoms';

  @override
  String get symptomsLogSymptomsExperienced => 'Symptômes ressentis';

  @override
  String get symptomsLogNoSymptoms => 'Aucun symptôme';

  @override
  String get symptomsLogNoSymptomsToday => 'No symptoms aujourd’hui';

  @override
  String get symptomsLogOther => 'Autre...';

  @override
  String get symptomsLogSeverityLevel => 'Niveau de gravité';

  @override
  String get symptomsLogNotes => 'Notes';

  @override
  String get symptomsLogAnxiety => 'Anxiété';

  @override
  String get symptomsLogBelching => 'Rots';

  @override
  String get symptomsLogBloating => 'Ballonnements';

  @override
  String get symptomsLogConstipation => 'Constipation';

  @override
  String get symptomsLogDiarrhea => 'Diarrhée';

  @override
  String get symptomsLogFatigue => 'Fatigue';

  @override
  String get symptomsLogFoodNoise => 'Envies alimentaires';

  @override
  String get symptomsLogHairLoss => 'Chute de cheveux';

  @override
  String get symptomsLogHeartburn => 'Brûlures d’estomac';

  @override
  String get symptomsLogIndigestion => 'Indigestion';

  @override
  String get symptomsLogInjectionSiteReaction => 'Réaction au site d’injection';

  @override
  String get symptomsLogMetallicTaste => 'Goût métallique';

  @override
  String get symptomsLogHeadache => 'Maux de tête';

  @override
  String get symptomsLogMoodSwings => 'Variations d’humeur';

  @override
  String get symptomsLogNausea => 'Nausée';

  @override
  String get symptomsLogReflux => 'Reflux';

  @override
  String get symptomsLogStomachPain => 'Douleurs à l’estomac';

  @override
  String get symptomsLogSuppressedAppetite => 'Appétit coupé';

  @override
  String get symptomsLogVomiting => 'Vomissements';

  @override
  String get symptomsLogLogged => 'Symptôme enregistré';

  @override
  String get symptomsLogMild => 'Léger';

  @override
  String get symptomsLogModerate => 'Modéré';

  @override
  String get symptomsLogSevere => 'Sévère';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Anything worth remembering about how tu felt?';

  @override
  String get symptomsLogSaveChanges => 'Enregistrer changes';

  @override
  String get symptomsLogAddSymptoms => '+ Add symptoms journal';

  @override
  String get symptomsLogDeleteTitle => 'Supprimer this symptoms journal?';

  @override
  String get symptomsLogDeleteMessage => 'Cette action est irréversible.';

  @override
  String get symptomsLogDeleteLog => 'Supprimer journal';

  @override
  String get symptomsLogSaving => 'Enregistrement...';

  @override
  String get symptomsLogCouldNotSave =>
      'Could not enregistrer this symptoms journal yet.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Could not supprimer this symptoms journal yet.';

  @override
  String get symptomsLogDeleted => 'Symptôme supprimé';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Added à ton symptoms journal';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% de l’objectif quotidien';
  }

  @override
  String get commonDisclaimer =>
      'Glu est un outil de suivi, pas un dispositif médical. Il ne fournit pas de conseils médicaux, de diagnostic ou de traitement. Consultez toujours votre professionnel de santé concernant vos médicaments et vos décisions de santé.';
}
