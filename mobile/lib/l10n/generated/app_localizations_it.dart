// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Si sta avviando...';

  @override
  String get startupFailed => 'Avvio non riuscito';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonSaving => 'Salvataggio...';

  @override
  String get commonContinue => 'Continua';

  @override
  String get commonSkip => 'Salta';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonNotNow => 'Non ora';

  @override
  String get commonNow => 'Ora';

  @override
  String get commonTomorrow => 'Domani';

  @override
  String get noteTriggerAddNote => 'Aggiungi note';

  @override
  String get noteTriggerCancelNote => 'Annulla note';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'Tra $count giorni';
  }

  @override
  String get homeDoseReminderInOneWeek => 'Tra 1 settimana';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'Tra $count settimane';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'In ritardo di 1 giorno';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'In ritardo di $count giorni';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'In ritardo di 1 settimana';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'In ritardo di $count settimane';
  }

  @override
  String get bmiIndicatorYourBmi => 'Il tuo BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Il tuo BMI attuale';

  @override
  String get bmiIndicatorUnderweight => 'Sottopeso';

  @override
  String get bmiIndicatorNormal => 'Normale';

  @override
  String get bmiIndicatorOverweight => 'Sovrappeso';

  @override
  String get bmiIndicatorObesity => 'Obesità';

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
  String get logNoteIndicatorHasNote => 'Nota presente';

  @override
  String get paywallTitle => 'Sblocca Glu Pro';

  @override
  String get paywallSubtitle => 'Senza Pro, ecco cosa perdi:';

  @override
  String get paywallMonthlyTitle => 'Mensile';

  @override
  String get paywallMonthlySubtitle => 'Nessuna prova gratuita';

  @override
  String get paywallYearlyTitle => 'Annuale';

  @override
  String get paywallYearlySubtitle => 'Prova gratuita di 7 giorni';

  @override
  String get paywallNoCommitment => 'Nessun impegno';

  @override
  String get paywallCancelAnytime => 'Annulla anytime';

  @override
  String get paywallContinue => 'Continua';

  @override
  String get paywallRestore => 'Ripristina';

  @override
  String get paywallTerms => 'Termini di utilizzo';

  @override
  String get paywallPrivacy => 'Privacy';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Salva $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Could not apri link right now.';

  @override
  String get paywallAlreadySubscribed => 'Tu already have Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Benvenuto in Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'L’acquisto non è stato completato. Riprova.';

  @override
  String get paywallPurchaseFailed => 'L’acquisto non è riuscito. Riprova.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'L’acquisto non è riuscito: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Abbonamento ripristinato!';

  @override
  String get paywallRestoreNoSubscription =>
      'Nessun abbonamento attivo trovato.';

  @override
  String get paywallRestoreFailed => 'Ripristino non riuscito. Riprova.';

  @override
  String get paywallBenefitReminders => 'Dosi dimenticate senza promemoria';

  @override
  String get paywallBenefitShareProgress =>
      'Più difficile condividere i tuoi progressi';

  @override
  String get paywallBenefitSpotRegain =>
      'Segnali di ripresa del peso non notati';

  @override
  String get paywallBenefitInsights => 'I tuoi schemi quotidiani ti sfuggono';

  @override
  String get paywallBenefitWeeklyGoals => 'Perdi la tua struttura settimanale';

  @override
  String get paywallBenefitHealthyHabits =>
      'Le abitudini vacillano senza supporto';

  @override
  String get onboardingWelcomeTitle => 'Mantieni il peso off';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu helps Tu proteggi Il tuo progressi around treatment, obiettivi, e settimanale abitudini.';

  @override
  String get onboardingWelcomeBullet1 => 'Fits Il tuo treatment e obiettivi';

  @override
  String get onboardingWelcomeBullet2 => 'Simple e realistic support';

  @override
  String get onboardingWelcomeBullet3 =>
      'Easily individua early signs of peso regain';

  @override
  String get onboardingWelcomeBullet4 => 'Mantieni going without starting over';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Are Tu currently taking a peso loss pen or pill medication?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'We use questo to mostra guidance quel matches where Tu are right now.';

  @override
  String get onboardingMedicationStatusUsing => 'Sì, lo sto assumendo ora';

  @override
  String get onboardingMedicationStatusWeaningOff =>
      'Sì, lo sto riducendo gradualmente';

  @override
  String get onboardingMedicationStatusNotTaking => 'No, non lo sto assumendo';

  @override
  String get onboardingMedicationStatusStartingSoon => 'No, I’ll inizia soon';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'No, ho smesso di recente';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Come do Tu take Il tuo medication?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'We use questo to tailor instructions e promemoria to Il tuo medication format.';

  @override
  String get onboardingMedicationMethodInjection => 'Iniezione';

  @override
  String get onboardingMedicationMethodPill => 'Pillola';

  @override
  String get onboardingMedicationMethodUnknown => 'Non lo so ancora';

  @override
  String get onboardingMedicationNameQuestion =>
      'Which medication are Tu taking?';

  @override
  String get onboardingMedicationNameExplainer =>
      'We use questo to personalize dose tracking e medication-specific guidance.';

  @override
  String get onboardingCurrentDoseQuestion => 'Cosa’s Il tuo attuale dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'We use questo to tailor dose tracking e future progressi check-ins.';

  @override
  String get onboardingMedicationCustomDose => 'Personalizzata';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Cosa device do Tu use to take Il tuo medication?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'We use questo to make promemoria e tips match il way Tu take it.';

  @override
  String get onboardingDeviceSinglePen => 'Penna singola';

  @override
  String get onboardingDeviceAutoInjector => 'Autoiniettore';

  @override
  String get onboardingDeviceSyringeAndVial => 'Syringe e vial';

  @override
  String get onboardingOther => 'Altro';

  @override
  String get onboardingTypeYourDevice => 'Type Il tuo device';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Come often do Tu take Il tuo medication?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'We use questo to tempo promemoria e routine support around Il tuo schedule.';

  @override
  String get onboardingEveryDay => 'Ogni giorno';

  @override
  String get onboardingEvery7Days => 'Ogni 7 giorni';

  @override
  String get onboardingEvery14Days => 'Ogni 14 giorni';

  @override
  String get onboardingCustom => 'Personalizzata';

  @override
  String get onboardingDaysBetweenDoses => 'Giorni tra le dosi';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'Cosa’s Il tuo primary obiettivo right now?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'We use questo to focus Il tuo plan, promemoria, e progressi around cosa matters più to Tu.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'We use questo to shape Il tuo plan from il very beginning.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'We use questo to support Il tuo next phase e aiuta Tu resta on traccia.';

  @override
  String get onboardingGoalLoseWeight => 'Perdere peso';

  @override
  String get onboardingGoalMaintainWeight => 'Mantenere il peso';

  @override
  String get onboardingGoalManageDiabetes => 'Gestire il diabete';

  @override
  String get onboardingGoalManagePcos => 'Gestire la PCOS';

  @override
  String get onboardingGoalImproveHeartHealth =>
      'Migliorare la salute del cuore';

  @override
  String get onboardingAgeQuestion => 'Cosa’s Il tuo age?';

  @override
  String get onboardingAgeExplainer =>
      'We use questo to adjust guidance e health calculations più appropriately.';

  @override
  String get onboardingHeightQuestion => 'Cosa’s Il tuo height?';

  @override
  String get onboardingHeightExplainer =>
      'Usiamo questo insieme al tuo peso per calcolare cose come il BMI e gli intervalli sani.';

  @override
  String get onboardingWeightQuestion => 'Cosa’s Il tuo attuale peso?';

  @override
  String get onboardingWeightExplainer =>
      'We use questo as Il tuo starting point per progressi, obiettivi, e health estimates.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Quando did Tu stop il medication?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Quando did Tu inizia weaning off il medication?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Quando did Tu inizia il medication?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'We use questo to understand Il tuo recent treatment history e next phase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'We use questo to understand Il tuo transition phase e support il abitudini quel matter più now.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'We use questo to understand come long Tu’ve been on treatment e traccia change over tempo.';

  @override
  String get onboardingGoalWeightQuestion => 'Cosa’s Il tuo obiettivo peso?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Usiamo questo per inquadrare i progressi e mostrare un intervallo BMI obiettivo per te.';

  @override
  String get onboardingBenefitsQuestion => 'Cosa Glu will aiuta Tu do next';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu turns cosa Tu shared into promemoria, support, e structure quel fit Il tuo routine.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Here’s come Glu can aiuta Tu maintain Il tuo progressi';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Here’s come Glu can support Il tuo diabetes routine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Here’s come Glu can support Il tuo PCOS routine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Here’s come Glu can support Il tuo heart health';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Here’s come Glu can aiuta Tu lose peso';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'See come Glu helps Tu proteggi Il tuo attuale peso e catch regain early.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'See come Glu helps Tu mantieni pasti, peso, e routines steadier week to week.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'See come Glu helps Tu resta steadier around symptoms, peso, e routine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'See come Glu helps Tu resta costante con il abitudini quel support heart health.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'See come Glu helps Tu individua il schemi quel mantieni peso moving down.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Without structure, regain can costruisci quietly. Glu helps Tu catch it earlier e resta steady.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Without structure, pasti e peso schemi get noisy. Glu keeps il signals clearer.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Without structure, symptoms e routines can swing più. Glu helps Tu resta steadier.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Without structure, healthy abitudini drift. Glu helps Tu mantieni attività e peso on traccia.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Without structure, peso can stall or drift up. Glu helps mantieni progressi moving in il right direction.';

  @override
  String get onboardingBenefitsAxisWeight => 'Peso';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Pasti & peso';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptoms & peso';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Exercise & peso';

  @override
  String get onboardingNotificationsQuestion =>
      'Turn on promemoria quel support Il tuo obiettivo';

  @override
  String get onboardingNotificationsExplainer =>
      'We’ll use notifications to aiuta Tu resta costante, prepared, e on traccia.';

  @override
  String get onboardingNotificationsHeadline =>
      'Set Glu up to aiuta at il right moment.';

  @override
  String get onboardingNotificationsBody =>
      'Turn on notifications so Glu can reinforce il abitudini quel support Il tuo obiettivo.';

  @override
  String get onboardingNotificationsDaily =>
      'Timed promemoria quel match Il tuo quotidiano medication rhythm';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Longer-range promemoria so dose days do not sneak up on Tu';

  @override
  String get onboardingNotificationsCustom =>
      'Promemoria shaped around Il tuo custom schedule';

  @override
  String get onboardingNotificationsWeekly =>
      'Dose promemoria quel resta aligned con Il tuo settimanale rhythm';

  @override
  String get onboardingNotificationsSupportive =>
      'Supportive promemoria quel mantieni Il tuo routine visible quando motivation dips';

  @override
  String get onboardingNotificationsProgress =>
      'Timely nudges around progressi, abitudini, e il obiettivi Tu told us matter più';

  @override
  String get onboardingNotificationsHelpful =>
      'Utile prompts quel make Glu più useful in il moments Tu need it';

  @override
  String get onboardingDailyRoutineQuestion =>
      'Cosa’s Il tuo quotidiano routine?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'We use questo to make Il tuo plan feel realistic per Il tuo day-to-day life.';

  @override
  String get onboardingRoutineSedentary => 'Sedentario';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Mostly sitting, desk work, e very little intentional exercise.';

  @override
  String get onboardingRoutineLightlyActive => 'Leggermente attivo';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Camminate regolari, commissioni o allenamenti leggeri un paio di volte a settimana.';

  @override
  String get onboardingRoutineActive => 'Attivo';

  @override
  String get onboardingRoutineActiveDescription =>
      'Frequent movement or exercise, like quotidiano walks, gym, or active work.';

  @override
  String get onboardingRoutineVeryActive => 'Molto attivo';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard training, physically demanding work, or high attività più days.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Which symptoms are Tu più concerned about, if any?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'We use questo to prioritize tips e guidance around il symptoms Tu care about più.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'We use questo to focus on il symptoms Tu want to resta ahead of.';

  @override
  String get onboardingGenderQuestion => 'Come do Tu describe Il tuo gender?';

  @override
  String get onboardingGenderExplainer =>
      'We use questo per più relevant guidance e future personalization.';

  @override
  String get onboardingGenderFemale => 'Donna';

  @override
  String get onboardingGenderMale => 'Uomo';

  @override
  String get onboardingGenderPreferNotToSay => 'Preferisco non dirlo';

  @override
  String get onboardingTypeYourGender => 'Type Il tuo gender';

  @override
  String get onboardingPreferredNameQuestion => 'Cosa should we call Tu?';

  @override
  String get onboardingPreferredNameExplainer =>
      'We use questo to make Glu feel più personal quando we talk to Tu.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Impostazione up Il tuo plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'We’re turning cosa Tu shared into a plan Glu can support right away.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Locking in peso-maintenance targets...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Impostazione dei punti di attenzione per la ripresa...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Tuning promemoria around Il tuo routine...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Preparing a steadier settimanale plan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Defining pasto e peso schemi...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Impostazione del supporto all’idratazione...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Preparing consistency promemoria...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Building a clearer quotidiano structure...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Organizzazione del supporto ai sintomi...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Defining settimanale movement targets...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Impostazione hydration e routine anchors...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Preparazione di un piano più stabile...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'Impostazione degli obiettivi di attività...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Definizione del supporto all’idratazione...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Preparing settimanale abitudine promemoria...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Costruzione di una routine per la salute del cuore...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Definizione dei limiti calorici...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Impostazione acqua amounts...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Creazione di un piano più semplice da seguire...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Preparing Il tuo settimanale plan...';

  @override
  String get onboardingSetupSummaryHeadline => 'Il tuo Glu setup is ready.';

  @override
  String get onboardingSetupLoadingTitle => 'Building Il tuo setup';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu is ready to aiuta Tu proteggi Il tuo progressi con clearer structure e earlier regain signals.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu is ready to support steadier pasti, peso tracking, e abitudini quel matter day to day.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu is ready to support steadier routines around symptoms, treatment, e progressi.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu is ready to reinforce il abitudini quel support Il tuo long-term heart health.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu is ready to support il routines quel aiuta Tu mantieni il peso off.';

  @override
  String get onboardingSetupSummaryLabel => 'Riepilogo';

  @override
  String get onboardingSetupAdjustLater =>
      'Tu can adjust any of questo later in impostazioni.';

  @override
  String get onboardingSummaryGoal => 'Obiettivo';

  @override
  String get onboardingSummaryCurrentWeight => 'Attuale peso';

  @override
  String get onboardingSummaryMedication => 'Farmaco';

  @override
  String get onboardingSummaryCurrentDose => 'Dose attuale';

  @override
  String get onboardingSummaryCadence => 'Frequenza';

  @override
  String get onboardingSummaryStarted => 'Inizio';

  @override
  String get onboardingSummaryTargetWeight => 'Obiettivo peso';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'Obiettivo';

  @override
  String get onboardingFrequencyEveryDay => 'Ogni giorno';

  @override
  String get onboardingFrequencyEveryWeek => 'Ogni settimana';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Ogni 2 settimane';

  @override
  String get onboardingFrequencyCustomSchedule =>
      'Pianificazione personalizzata';

  @override
  String get onboardingTapOptionContinue => 'Tap an option to continua.';

  @override
  String get onboardingTypeGenderContinue => 'Type Il tuo gender to continua.';

  @override
  String get onboardingTypeDeviceContinue => 'Type Il tuo device to continua.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Type Il tuo medication to continua.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Enter days between doses to continua.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Choose a schedule to continua.';

  @override
  String get onboardingScrollChooseAge => 'Scroll to choose Il tuo age.';

  @override
  String get onboardingDragOrTapHeight =>
      'Drag or tap il ruler to choose Il tuo height.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Drag, tap, or use il step buttons to choose a peso.';

  @override
  String get onboardingPickDateAndWeight =>
      'Pick a date e choose a peso to continua.';

  @override
  String get onboardingSelectSymptoms =>
      'Select any symptoms Tu want Glu to focus on.';

  @override
  String get onboardingTypeName => 'Type il name Tu want Glu to use.';

  @override
  String get onboardingSaving => 'Salvataggio...';

  @override
  String get onboardingLetsBegin => 'Iniziamo';

  @override
  String get onboardingContinueWithGlu => 'Continua con Glu';

  @override
  String get onboardingKeepGoing => 'Mantieni going';

  @override
  String get onboardingTurnOnNotifications => 'Attiva le notifiche';

  @override
  String get onboardingFinish => 'Fine';

  @override
  String get onboardingTargetBmiTitle => 'Il tuo BMI obiettivo';

  @override
  String get onboardingChartToday => 'Oggi';

  @override
  String get onboardingChartOverTime => 'Over tempo';

  @override
  String get onboardingChartWithoutGlu => 'Senza Glu';

  @override
  String get onboardingChartWithGlu => 'Con Glu';

  @override
  String get onboardingReviewQuestion =>
      'People use Glu to resta steady e supported';

  @override
  String get onboardingReviewExplainer =>
      'A rapido rating helps più people find support quel feels questo simple.';

  @override
  String get onboardingReviewBody =>
      'People use Glu to feel più supported, più costante, e less alone in il process.';

  @override
  String get onboardingTypeYourMedication => 'Type Il tuo medication';

  @override
  String get onboardingSelectStartDate => 'Select inizia date';

  @override
  String get goalsSaveDialogTitle => 'Salva obiettivi?';

  @override
  String get goalsSaveDialogMessage =>
      'Tu have unsaved obiettivo changes. salva them before leaving questo tab?';

  @override
  String get commonLater => 'Più tardi';

  @override
  String get homeGreetingAnonymous => 'Ciao';

  @override
  String homeGreetingWithName(Object name) {
    return 'Ciao, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Registra oggi per vedere la tua analisi';

  @override
  String get homeInsightEmptyBody =>
      'Se registri qualcosa oggi, vedrai la tua analisi stasera.';

  @override
  String get homeInsightLogTodayTitle => 'Trasforma i registri in insight';

  @override
  String get homeInsightMoreLogsVariant1Title => 'Più log, insight migliori';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'I tuoi log stanno iniziando a mostrare uno schema.';

  @override
  String get homeInsightMoreLogsVariant2Title =>
      'La tua insight sta prendendo forma';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Qualche log in più potrebbe chiarire molto il quadro.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'A cosa alludono i log di oggi';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Potrebbe esserci già uno schema nascosto nella tua giornata.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Registra almeno una volta oggi per vedere un quadro più chiaro dei tuoi progressi.';

  @override
  String get homeInsightExpandedTitle => 'È stato utile?';

  @override
  String get homeInsightExpandedBody =>
      'Una valutazione rapida aiuta Glu a capire cosa conta di più per te.';

  @override
  String get homeInsightReasonHint =>
      'Cosa potrebbe essere migliore? (facoltativo)';

  @override
  String get homeInsightReasonSubmit => 'Invia';

  @override
  String get homeInsightLearningMessage => 'Imparerò da questo.';

  @override
  String get homeInsightChecking => 'Checking oggi’s analisi...';

  @override
  String get homeInsightGenerating => 'Caricamento dell’analisi di oggi...';

  @override
  String get homeInsightTryAgain => 'Riprova';

  @override
  String get homeSeeAllInsights => 'Vedi tutte le analisi';

  @override
  String get insightsProgressTitle => 'All analisi';

  @override
  String get insightsProgressEmptyState =>
      'Il tuo analisi will appear here once they are generated.';

  @override
  String get homeDoseReminderTitle => 'Dose promemoria';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Registro $label interaction goes here.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Calorie obiettivo required';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check needs a pasto obiettivo set to Calories to estimate Il tuo portion. Set one in obiettivi to get started.';

  @override
  String get homeSetGoal => 'Set obiettivo';

  @override
  String get homeYourProgress => 'Il tuo progressi';

  @override
  String get homeRemindersShowcaseTitle => 'Resta in carreggiata';

  @override
  String get homeRemindersShowcaseDescription =>
      'Imposta promemoria per tenere dosi e integratori in orario.';

  @override
  String get homePickNextDoseDate => 'Pick Il tuo next dose date';

  @override
  String get homeSetReminder => 'Set promemoria';

  @override
  String get homeSupplementReminders => 'Integratore promemoria';

  @override
  String get homeNoUpcomingSupplements => 'No upcoming integratori';

  @override
  String get homeNoMoreUpcomingSupplements => 'Nessun altro imminente';

  @override
  String get homeSetUpYourSupplements => 'Set up Il tuo integratori';

  @override
  String get homeSetUp => 'Configura';

  @override
  String get homeSupplementFallback => 'Integratore';

  @override
  String get doseReminderNotificationTitle => 'Ready per Il tuo dose?';

  @override
  String get doseReminderFallbackBody => 'Apri Glu to review Il tuo next dose.';

  @override
  String get supplementReminderNotificationTitle =>
      'Tempo per Il tuo integratore';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Questo mattina';

  @override
  String get supplementReminderThisAfternoon => 'Questo pomeriggio';

  @override
  String get supplementReminderTonight => 'Stasera';

  @override
  String get dailyReminderMorningTitle => 'Mattina check-in';

  @override
  String get dailyReminderMorningBodies =>
      'Mattina mission: give Glu a little dati to play con.\nKick off il day con a rapido registro e some bene slancio.\nRise e registro. Future Tu will appreciate it.\nInizia il day con a tiny aggiorna e a big head inizia.\nGive Glu a mattina clue e mantieni moving.\nA rapido registro now can make oggi way più interesting.\nLet’s make il mattina count con a fast check-in.';

  @override
  String get dailyReminderMiddayTitle => 'Mezzogiorno check-in';

  @override
  String get dailyReminderMiddayBodies =>
      'Mezzogiorno pit stop: drop a rapido registro e mantieni cruising.\nLunch break? Perfect tempo to give Glu an aggiorna.\nHalfway there. Toss Glu a rapido clue.\nA tiny mezzogiorno registro can mantieni il story going.\nCheck in now e mantieni il day rolling.\nGive Il tuo day a little nudge con a fast aggiorna.\nMantieni il energy up con a rapido mezzogiorno tap.';

  @override
  String get dailyReminderAfternoonTitle => 'Pomeriggio check-in';

  @override
  String get dailyReminderAfternoonBodies =>
      'Almost done. Give Glu one più breadcrumb.\nA rapido pomeriggio registro can make stasera’s analisi pop.\nWrap il day con a piccolo aggiorna e a big win.\nOne più registro before il day wraps up?\nAiuta Glu connect il dots con a rapido pomeriggio check-in.\nChiudi il loop con a tiny registro e mantieni il magic going.\nA final tap now can make stasera’s analisi way migliore.';

  @override
  String get homePortionCheckTitle => 'Controllo porzioni';

  @override
  String get homePortionCheckBody => 'Scopri quanto mangiare a ogni pasto';

  @override
  String get homeGlowUpTitle => 'Il tuo\nGlow up';

  @override
  String get homeGlowUpBody => 'Create Il tuo before-e-after story';

  @override
  String get homeDoctorReportTitle => 'Referto medico';

  @override
  String get homeDoctorReportBody =>
      'Condividi i tuoi progressi con il tuo medico';

  @override
  String get homeGoalsStatusTitle => 'Obiettivi di oggi';

  @override
  String get homeGoalsStatusViewAll => 'Vedi tutti';

  @override
  String get homeWaterTitle => 'Acqua';

  @override
  String get homeWeightTitle => 'Peso';

  @override
  String get homeExerciseTitle => 'Esercizio';

  @override
  String get homeMealsTitle => 'Pasti';

  @override
  String get homeCaloriesTitle => 'Calorie';

  @override
  String get homeProteinsTitle => 'Proteine';

  @override
  String get homeFibersTitle => 'Fibre';

  @override
  String get homeSymptomsTitle => 'Sintomi';

  @override
  String get homeMoodTitle => 'Umore';

  @override
  String get homeCravingsTitle => 'Voglie';

  @override
  String get homeDoseTitle => 'Dose';

  @override
  String get homeMedicationLevelTitle => 'Livello stimato del farmaco';

  @override
  String get homeMedicationLevelInfoTitle => 'Come leggere questo grafico';

  @override
  String get homeMedicationLevelInfoBody =>
      'Questo grafico stima quanto del tuo farmaco potrebbe essere ancora attivo in base alle dosi registrate e all\'emivita del farmaco.\n\nI punti più alti indicano generalmente una dose più recente o più grande. La linea scende nel tempo man mano che il farmaco viene eliminato dal tuo corpo.\n\nUsa questo come una visualizzazione di tendenza, non come una misurazione esatta o una raccomandazione medica.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Capito';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Registra le tue dosi in modo che Glu possa stimare quanto farmaco è ancora attivo nel tuo corpo.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'del picco recente';

  @override
  String get homeMedicationLevelActiveNow => 'Attivo ora';

  @override
  String get homeMedicationLevelHalfLife => 'Emivita';

  @override
  String get homeMedicationLevelLastDose => 'Ultima dose';

  @override
  String get homeStartHydration => 'Inizia hydration';

  @override
  String get homeLogFirstSession => 'Registro Il tuo first session';

  @override
  String get homeLogTodayWeight => 'Registro oggi’s peso';

  @override
  String get homeAtYourTarget => 'Tu are at Il tuo obiettivo';

  @override
  String get homeLogMealsToTrackCalories =>
      'Registro pasti to traccia calories';

  @override
  String get homeLogFirstMeal => 'Registro Il tuo first pasto';

  @override
  String get homeTrackProteinFromMeals => 'Traccia proteine from pasti';

  @override
  String get homeTrackFiberFromMeals => 'Traccia fibre from pasti';

  @override
  String get homeAllClear => 'Tutto chiaro';

  @override
  String get homeTrackSymptoms => 'Traccia symptoms';

  @override
  String get homeGreat => 'Ottimo';

  @override
  String get homeGood => 'Bene';

  @override
  String get homeBad => 'Male';

  @override
  String get homeOkay => 'Okay';

  @override
  String get homeLogHowYouFeel => 'Registro come Tu feel';

  @override
  String get homeLogACraving => 'Registra una voglia';

  @override
  String get homeLogTodaysDose => 'Registro oggi’s dose';

  @override
  String get homeTaken => 'Preso';

  @override
  String get homeStartHereTitle => 'Inizia here';

  @override
  String get homeStartHereBody =>
      'Inizia con questo card, then expand to others. As Glu learns più about Il tuo journey, it can mostra Tu migliore schemi e analisi over tempo.';

  @override
  String get waterLogTitle => 'Idratazione';

  @override
  String get waterLogEditTitle => 'Modifica idratazione';

  @override
  String get waterLogLogTitle => 'Registro acqua';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Aggiungi bevanda ($amount)';
  }

  @override
  String get waterLogSaving => 'Salvataggio...';

  @override
  String get waterLogCustomDrinkTitle => 'Bevanda personalizzata';

  @override
  String get waterLogCustomDrinkBody =>
      'Choose il amount Tu want to aggiungi right now.';

  @override
  String get waterLogUseThisAmount => 'Usa questa quantità';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount added to Il tuo hydration registro';
  }

  @override
  String get waterLogCouldNotSave =>
      'Could not salva questo acqua registro yet.';

  @override
  String get waterLogDeleteTitle => 'Elimina questo hydration registro?';

  @override
  String get waterLogDeleteMessage => 'Questa azione non può essere annullata.';

  @override
  String get waterLogCouldNotDelete =>
      'Could not elimina questo hydration registro yet.';

  @override
  String get waterLogDeleteLog => 'Elimina registro';

  @override
  String get waterLogDeleted => 'Idratazione eliminata';

  @override
  String get moodLogTitle => 'Umore';

  @override
  String get moodEditTitle => 'Modifica umore';

  @override
  String get moodHowYouFeel => 'Come Tu feel';

  @override
  String get moodBad => 'Male';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Bene';

  @override
  String get moodGreat => 'Ottimo';

  @override
  String get moodNotes => 'Note';

  @override
  String get moodAnythingWorthRemembering =>
      'Anything worth remembering about Il tuo mood?';

  @override
  String get moodCouldNotSave => 'Could not salva questo mood registro yet.';

  @override
  String get moodDeleteTitle => 'Elimina questo mood registro?';

  @override
  String get moodDeleteMessage => 'Questa azione non può essere annullata.';

  @override
  String get moodDeleteLog => 'Elimina registro';

  @override
  String get moodSaving => 'Salvataggio...';

  @override
  String get moodAddMoodLog => '+ aggiungi mood registro';

  @override
  String get moodLogged => 'Umore registrato';

  @override
  String get moodDeleted => 'Umore eliminato';

  @override
  String get moodCouldNotDelete =>
      'Could not elimina questo mood registro yet.';

  @override
  String get moodAddedToMoodLog => 'Added to Il tuo mood registro';

  @override
  String get cravingsLogTitle => 'Voglie';

  @override
  String get cravingsEditTitle => 'Modifica voglia';

  @override
  String get cravingsWhatsGoingOn => 'Cosa sta succedendo';

  @override
  String get cravingsTypeGeneral => 'Voglia di mangiare';

  @override
  String get cravingsTypeSweet => 'Qualcosa di dolce';

  @override
  String get cravingsTypeSalty => 'Qualcosa di salato';

  @override
  String get cravingsIntensityLabel => 'Intensità (facoltativo)';

  @override
  String get cravingsIntensityMild => 'Lieve';

  @override
  String get cravingsIntensityModerate => 'Moderata';

  @override
  String get cravingsIntensityStrong => 'Forte';

  @override
  String get cravingsOutcomeLabel => 'Cosa è successo (facoltativo)';

  @override
  String get cravingsOutcomeResisted => 'Ho resistito';

  @override
  String get cravingsOutcomeGaveIn => 'Ho ceduto';

  @override
  String get cravingsNotes => 'Note';

  @override
  String get cravingsAnythingWorthRemembering =>
      'C\'è qualcosa da ricordare su questa voglia?';

  @override
  String get cravingsCouldNotSave =>
      'Non è stato possibile salvare questa voglia.';

  @override
  String get cravingsDeleteTitle => 'Eliminare questa voglia?';

  @override
  String get cravingsDeleteMessage => 'Questa azione non può essere annullata.';

  @override
  String get cravingsDeleteLog => 'Elimina registrazione';

  @override
  String get cravingsSaving => 'Salvataggio...';

  @override
  String get cravingsAddLog => '+ Aggiungi voglia';

  @override
  String get cravingsLogged => 'Voglia registrata';

  @override
  String get cravingsDeleted => 'Voglia eliminata';

  @override
  String get cravingsCouldNotDelete =>
      'Non è stato possibile eliminare questa voglia.';

  @override
  String get cravingsAddedToLog => 'Aggiunta al tuo registro delle voglie';

  @override
  String get portionCheckTitle => 'Controllo porzioni';

  @override
  String get portionCheckAnalyzingMeal => 'Analyzing Il tuo pasto…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Impossibile analizzare questa foto';

  @override
  String get portionCheckTakeNewPhoto => 'Scatta una nuova foto';

  @override
  String get portionCheckSomethingWentWrong => 'Qualcosa è andato storto.';

  @override
  String get portionCheckYouHitDailyLimit =>
      'Tu\'ve hit Il tuo quotidiano limit';

  @override
  String get portionCheckYouCanEat => 'Tu can eat';

  @override
  String get portionCheckYouCanEatUpTo => 'Tu can eat up to';

  @override
  String get portionCheckTryLighterOption =>
      'Prova invece un’opzione più leggera oppure salta questo';

  @override
  String get portionCheckThisEntireMeal => 'Questo entire pasto';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% of questo pasto';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'To resta within Il tuo quotidiano obiettivi.';

  @override
  String get portionCheckNutritionBreakdown => 'Ripartizione nutrizionale';

  @override
  String get portionCheckTipsToBalanceMeal => 'Tips to balance Il tuo pasto';

  @override
  String get portionCheckTipsPool =>
      'Mangia lentamente - i segnali di sazietà impiegano circa 20 minuti ad arrivare.\nRiempi metà piatto di verdure.\nInserisci proteine in ogni pasto.\nBevi acqua prima dei pasti.\nPorziona gli snack in piccoli contenitori.\nAbbina i carboidrati a proteine o grassi per sentirti sazio più a lungo.\nScegli cibi integrali quando puoi.\nEvita di mangiare distratto dagli schermi.\nNon saltare i pasti se poi finisci per mangiare troppo.\nPianifica gli snack prima di avere fame.';

  @override
  String get portionCheckRetake => 'Rifai';

  @override
  String get portionCheckLogThisPortion => 'Registro questo portion';

  @override
  String get portionCheckCarbs => 'Carboidrati';

  @override
  String get portionCheckProteins => 'Proteine';

  @override
  String get portionCheckFats => 'Grassi';

  @override
  String get portionCheckFiber => 'Fibre';

  @override
  String get mealLogScreenTitle => 'Pasti';

  @override
  String get mealLogEditTitle => 'Edit pasto';

  @override
  String get mealLogLogTitle => 'Registro pasto';

  @override
  String get mealLogSaving => 'Salvataggio...';

  @override
  String get mealLogAddMealLog => '+ aggiungi pasto registro';

  @override
  String get mealLogCouldNotStartRecording => 'Could not inizia recording.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'La registrazione si è fermata a 60 secondi.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Impossibile analizzare questa registrazione.';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'Impossibile analizzare questo testo.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Impossibile analizzare questa foto.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Could not process questo pasto photo yet.';

  @override
  String get mealLogDiscardTitle => 'Discard questo pasto?';

  @override
  String get mealLogDiscardMessage =>
      'Tu reviewed a photo but didn\'t salva il entry. It won\'t be logged.';

  @override
  String get mealLogDiscard => 'Scarta';

  @override
  String get mealLogDeleteTitle => 'Elimina questo pasto registro?';

  @override
  String get mealLogDeleteMessage => 'Questa azione non può essere annullata.';

  @override
  String get mealLogDelete => 'Elimina';

  @override
  String get mealLogDeleteLog => 'Elimina registro';

  @override
  String get mealLogCouldNotSave =>
      'Could not salva questo pasto registro yet.';

  @override
  String get mealLogCouldNotDelete =>
      'Could not elimina questo pasto registro yet.';

  @override
  String get mealLogAnalyzing => 'Analisi in corso...';

  @override
  String get mealLogAnalyzeText => 'Analizza testo';

  @override
  String get mealLogSendRecording => 'Invia registrazione';

  @override
  String get mealLogMealDefaultName => 'Pasto';

  @override
  String get mealLogMealNameHint => 'Pasto name';

  @override
  String get mealLogCouldNotPrefillTitle => 'Couldn’t prefill questo pasto';

  @override
  String get mealLogHowMuchDidYouEat => 'Come much did Tu eat?';

  @override
  String get mealLogNotes => 'Note';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Anything worth remembering about questo pasto?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analyzing Il tuo pasto';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Turning Il tuo input into nutrition fields. Tu can review everything before salvataggio.';

  @override
  String get mealLogDescribeYourMealTitle => 'Describe Il tuo pasto';

  @override
  String get mealLogDescribeYourMealBody =>
      'Write cosa Tu ate e any amounts Tu know. We’ll turn it into nutrition fields.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Example: grilled chicken salad, olive oil dressing, 1 apple, sparkling acqua';

  @override
  String get mealLogCaptureYourMealTitle => 'Capture Il tuo pasto';

  @override
  String get mealLogCaptureYourMealBody =>
      'Take a photo e we’ll estimate il nutrition fields per Tu.';

  @override
  String get mealLogTakePhoto => 'Scatta foto';

  @override
  String get mealLogRecordingYourMealTitle => 'Recording Il tuo pasto';

  @override
  String get mealLogRecordingReadyTitle => 'Registrazione pronta';

  @override
  String get mealLogRecordMealDescriptionTitle => 'Record a pasto description';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tap stop quando Tu’re done. ${remaining}s left';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Send it below to analyze, or record again.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Speak naturally about cosa Tu ate e we’ll parse it into macros.';

  @override
  String get mealLogStopRecording => 'Ferma registrazione';

  @override
  String get mealLogRecordAgain => 'Registra di nuovo';

  @override
  String get mealLogStartRecording => 'Inizia recording';

  @override
  String get mealLogBreakfast => 'Colazione';

  @override
  String get mealLogLunch => 'Pranzo';

  @override
  String get mealLogSnack => 'Spuntino';

  @override
  String get mealLogDinner => 'Cena';

  @override
  String get mealLogKcalUnit => 'Kcal';

  @override
  String get mealLogToday => 'Oggi';

  @override
  String get mealLogYesterday => 'Ieri';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal registrate';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g di $macro registrati';
  }

  @override
  String get mealLogDeleted => 'Pasto deleted';

  @override
  String get mealLogAddedToMealLog => 'Added to Il tuo pasto registro';

  @override
  String get mealLogCarbs => 'Carboidrati';

  @override
  String get mealLogProteins => 'Proteine';

  @override
  String get mealLogFats => 'Grassi';

  @override
  String get mealLogFiber => 'Fibre';

  @override
  String get settingsLanguage => 'Lingua';

  @override
  String get settingsLanguageDialogTitle => 'Seleziona lingua';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsPreferences => 'Preferenze';

  @override
  String get settingsHealthGoal => 'Obiettivo di salute';

  @override
  String get settingsHealthGoalDialogTitle => 'Select health obiettivo';

  @override
  String get settingsHabitGoals => 'Obiettivi di abitudine';

  @override
  String get settingsDisabled => 'Disattivato';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count attivi';
  }

  @override
  String get settingsHeight => 'Altezza';

  @override
  String get settingsAge => 'Età';

  @override
  String get settingsGender => 'Genere';

  @override
  String get settingsMeasurementUnit => 'Unità di misura';

  @override
  String get settingsReminders => 'Promemoria';

  @override
  String get settingsDoseReminder => 'Dose promemoria';

  @override
  String get settingsSupplementReminder => 'Integratore promemoria';

  @override
  String get settingsDailyReminders => 'Quotidiano promemoria';

  @override
  String get settingsSubscription => 'Abbonamento';

  @override
  String get settingsSupport => 'Supporto';

  @override
  String get settingsSendFeedback => 'Invia feedback';

  @override
  String get feedbackSheetTitle => 'Invia feedback';

  @override
  String get feedbackSheetHint => 'Dicci cosa ne pensi…';

  @override
  String get feedbackSheetSend => 'Invia';

  @override
  String get feedbackSheetSuccess => 'Grazie per il tuo feedback!';

  @override
  String get feedbackSheetError => 'Invio non riuscito. Riprova.';

  @override
  String get settingsTermsOfService => 'Termini di servizio';

  @override
  String get settingsPrivacyPolicy => 'Informativa sulla privacy';

  @override
  String get settingsInternal => 'Interno';

  @override
  String get settingsSubscriptionOverride => 'Override abbonamento';

  @override
  String get settingsTodayInsightCard => 'Oggi analisi card';

  @override
  String get settingsResetOnboarding => 'Reimposta onboarding';

  @override
  String get settingsResetShowcases => 'Reimposta showcase';

  @override
  String get settingsResetUserData => 'Reimposta dati utente';

  @override
  String get settingsDeletingAccount => 'Eliminazione account...';

  @override
  String get settingsDisconnect => 'Disconnetti';

  @override
  String get settingsDeleteAccount => 'Elimina Account';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Disconnetti $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Disconnettere $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Tu will no longer be able to sign in con $provider on questo device unless Tu reconnect it later.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Elimina account?';

  @override
  String get settingsDeleteAccountBody =>
      'Questo will permanently remove Il tuo account e all of Il tuo dati. questo action cannot be undone.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Type elimina to confirm';

  @override
  String get settingsDeleteAccountError =>
      'Something went wrong while deleting Il tuo account. Please contact support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Riavvia l’app per vedere l’onboarding';

  @override
  String get settingsShowcasesReset => 'Showcase reimpostati';

  @override
  String get settingsResetUserDataTitle => 'Reimpostare i dati utente?';

  @override
  String get settingsResetUserDataBody =>
      'Questo will clear all logged records per pasti, acqua, exercise, peso, mood, symptoms, integratori, e doses.';

  @override
  String get settingsUserDataReset => 'Dati utente reimpostati';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Salvato, but quotidiano promemoria could not be scheduled right now.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Override abbonamento';

  @override
  String get settingsSubscriptionOverrideAuto => 'Auto';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Forza Free';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Forza Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Oggi analisi card';

  @override
  String get settingsTodayInsightCardAuto => 'Auto';

  @override
  String get settingsTodayInsightCardOn => 'Attivo';

  @override
  String get settingsTodayInsightCardOff => 'Disattivo';

  @override
  String get settingsYourName => 'Il tuo name';

  @override
  String get settingsSignOut => 'Esci';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'ft/in';

  @override
  String get settingsHeightFt => 'ft';

  @override
  String get settingsHeightIn => 'in';

  @override
  String get settingsGenderMale => 'Uomo';

  @override
  String get settingsGenderFemale => 'Donna';

  @override
  String get settingsGenderPreferNotToSay => 'Preferisco non dirlo';

  @override
  String get settingsGenderOther => 'Altro';

  @override
  String get settingsYourProfile => 'Il tuo profile';

  @override
  String get settingsNotSet => 'Non impostato';

  @override
  String settingsYears(Object value) {
    return '$value anni';
  }

  @override
  String get settingsOff => 'Off';

  @override
  String get settingsOn => 'On';

  @override
  String get settingsNoneSet => 'Nessuno impostato';

  @override
  String settingsSupplementCount(Object count) {
    return '$count integratore(s)';
  }

  @override
  String get commonToday => 'Oggi';

  @override
  String get mainShellHome => 'Home';

  @override
  String get mainShellLog => 'Registro';

  @override
  String get mainShellProgress => 'Progressi';

  @override
  String get mainShellSettings => 'Impostazioni';

  @override
  String get mainShellLogShowcaseTitle => 'Traccia ogni giorno ciò che conta';

  @override
  String get mainShellLogShowcaseDescription =>
      'Registra ogni giorno le attività che contano di più per te.';

  @override
  String get logMoodShowcaseTitle => 'Inizia con il tuo umore';

  @override
  String get logMoodShowcaseDescription =>
      'Registra subito il tuo umore e continua con il resto mentre vai avanti, così Glu potrà individuare abitudini e schemi con maggiore precisione.';

  @override
  String get mainShellProgressShowcaseTitle => 'Vedi i tuoi progressi';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Controlla schemi e tendenze per capire come cambiano nel tempo le tue abitudini e il tuo peso.';

  @override
  String get progressMenuShowcaseTitle => 'Esplora i tuoi dati';

  @override
  String get progressMenuShowcaseDescription =>
      'Visualizza tutti i grafici, leggi gli approfondimenti generati dall’IA o crea un referto per il medico da condividere con il tuo team sanitario.';

  @override
  String get settingsFeedbackShowcaseTitle =>
      'Ci piacerebbe ricevere il tuo feedback';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Tocca qui per condividere ciò che funziona, ciò che non funziona o eventuali idee che hai.';

  @override
  String get authCouldNotOpenLink => 'Could not apri link right now.';

  @override
  String get authWelcomeTitle => 'Benvenuto in Glu';

  @override
  String get authSubtitle => 'Secure sign-in per Il tuo wellness companion';

  @override
  String get authContinueWithGoogle => 'Continua con Google';

  @override
  String get authContinueWithApple => 'Continua con Apple';

  @override
  String get authEmailHint => 'Name@email.com';

  @override
  String get authSending => 'Invio...';

  @override
  String get authResendLink => 'Reinvia link';

  @override
  String get authUseDifferentEmail => 'Usa un’altra e-mail';

  @override
  String get habitGoalsTitle => 'Abitudine obiettivi';

  @override
  String get goalsProteins => 'Proteine';

  @override
  String get goalsFibers => 'Fibre';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g al giorno';
  }

  @override
  String get goalsWater => 'Acqua';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value L al giorno';
  }

  @override
  String get goalsExercise => 'Esercizio';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min al giorno';
  }

  @override
  String get goalsMeals => 'Pasti';

  @override
  String get goalsCalories => 'Calorie';

  @override
  String get goalsKcalUnit => 'Kcal';

  @override
  String get goalsPerWeekSuffix => 'Per week';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count pasti per day';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal al giorno';
  }

  @override
  String get goalsWeight => 'Peso';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Aggiungi a logged peso to calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'Tu are already at questo obiettivo';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/week to obiettivo';
  }

  @override
  String get goalsSetTargetForNextWeek =>
      'Imposta l’obiettivo per la prossima settimana.';

  @override
  String get progressWeightTitle => 'Peso';

  @override
  String get progressWeightLabel => 'Peso ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'IMC sano';

  @override
  String get progressTotal => 'Totale';

  @override
  String get progressPercent => 'Percentuale';

  @override
  String get progressWeeklyAvg => 'Settimanale avg';

  @override
  String get progressRangeAllTime => 'All tempo';

  @override
  String get progressRange1Month => '1 mese';

  @override
  String get progressRange3Months => '3 mesi';

  @override
  String get progressRange6Months => '6 mesi';

  @override
  String get progressLow => 'Basso';

  @override
  String get progressMed => 'Medio';

  @override
  String get progressHigh => 'Alto';

  @override
  String get progressSeverity => 'Gravità';

  @override
  String get progressBad => 'Male';

  @override
  String get progressOkay => 'Okay';

  @override
  String get progressGood => 'Bene';

  @override
  String get progressGreat => 'Ottimo';

  @override
  String get progressMostlyBad => 'Abbastanza male';

  @override
  String get progressMostlyOkay => 'Abbastanza bene';

  @override
  String get progressMostlyGood => 'Abbastanza bene';

  @override
  String get progressMostlyGreat => 'Molto bene';

  @override
  String get progressNoDose => 'Nessuna dose';

  @override
  String get progressLogged => 'Registrato';

  @override
  String get progressAllClear => 'Tutto chiaro';

  @override
  String get progressFreq => 'Freq.';

  @override
  String get progressAverage => 'Media';

  @override
  String get progressDaily => 'Quotidiano';

  @override
  String get progressWeekly => 'Settimanale';

  @override
  String get progressMinutes => 'Minuti';

  @override
  String get progressIntensity => 'Intensità';

  @override
  String get progressCalories => 'Calorie';

  @override
  String get progressByDose => 'Per dose';

  @override
  String get progressWeightProgressTitle => 'Peso progressi';

  @override
  String get progressWaterProgressTitle => 'Acqua progressi';

  @override
  String get progressExerciseProgressTitle => 'Exercise progressi';

  @override
  String get progressDoseProgressTitle => 'Dose progressi';

  @override
  String get progressMealsProgressTitle => 'Pasti progressi';

  @override
  String get progressSymptomsProgressTitle => 'Symptoms progressi';

  @override
  String get progressMoodProgressTitle => 'Mood progressi';

  @override
  String get progressCravingsProgressTitle => 'Andamento delle voglie';

  @override
  String get progressResisted => 'Resistite';

  @override
  String get progressCravingsResistedSubtitle =>
      'Percentuale di voglie registrate a cui hai resistito.';

  @override
  String get progressWeightChangeTitle => 'Peso change';

  @override
  String get progressTitle => 'Progressi';

  @override
  String get progressMenuViewAllInsights => 'Vedi tutte le analisi';

  @override
  String get progressMenuViewAllCharts => 'Vedi tutti i grafici';

  @override
  String get progressMenuCreateDoctorReport => 'Crea referto medico';

  @override
  String get progressReportGenerating => 'Generazione del referto…';

  @override
  String get progressReportError => 'Impossibile generare il referto. Riprova.';

  @override
  String get progressReportPendingRetry =>
      'Il tuo report potrebbe essere completato tra un momento. Riprova.';

  @override
  String get progressReportOpenError =>
      'Il tuo report è stato generato, ma non siamo riusciti ad aprirlo. Riprova.';

  @override
  String get progressReportOpenedInBrowser =>
      'Report pronto. Aperto nel tuo browser.';

  @override
  String get progressReportCopiedLink =>
      'Report pronto. La condivisione non era disponibile, quindi il link è stato copiato negli appunti.';

  @override
  String get progressAllProgressTitle => 'Tutti i progressi';

  @override
  String get progressWeightTrendExplanation =>
      'Scopri come il tuo peso cambia nel tempo.';

  @override
  String get progressNoWeightLogsYet => 'No peso registri yet';

  @override
  String get progressNoLogsYet => 'Nessun registro ancora';

  @override
  String get progressLogWeightToStartTrend =>
      'Registro peso to inizia tracking Il tuo tendenza.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Registra peso e dose per confrontare come il dosaggio si relaziona al cambiamento.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Ogni punto è colorato in base all’ultima dose usata prima di quella pesata.';

  @override
  String get progressNoHydrationYet => 'Nessuna idratazione ancora';

  @override
  String get progressNoMovementYet => 'Nessun movimento ancora';

  @override
  String get progressNoDoseLogsYet => 'Nessun registro di dose ancora';

  @override
  String get progressNoMealsLoggedYet => 'No pasti logged yet';

  @override
  String get progressNoSymptomsLoggedYet => 'Nessun sintomo registrato ancora';

  @override
  String get progressNoMoodLogsYet => 'Nessun umore registrato ancora';

  @override
  String get progressNoCravingsLoggedYet => 'Nessuna voglia registrata ancora';

  @override
  String get progressFutureTrendTitle => 'Tendenza futura';

  @override
  String get progressFutureTrendBody =>
      'Una splendida cronologia del tuo slancio';

  @override
  String get progressGoal => 'Obiettivo';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Il tuo latest logged peso is ready to traccia.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'About $gap $unit from Il tuo obiettivo.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText vs Il tuo previous registro.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText vs previous registro. $gap $unit from obiettivo.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Compared con Il tuo previous registro, il tendenza is now visible.';

  @override
  String get progressWaterTitle => 'Acqua';

  @override
  String get manageSubscriptionTitle => 'Gestisci abbonamento';

  @override
  String get manageSubscriptionProPlan => 'Piano Pro';

  @override
  String get manageSubscriptionFreePlan => 'Piano gratuito';

  @override
  String get manageSubscriptionActiveCopy => 'Il tuo subscription is active.';

  @override
  String get manageSubscriptionUpgradeCopy => 'Upgrade to sblocca Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Piano';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratis';

  @override
  String get manageSubscriptionProduct => 'Prodotto';

  @override
  String get manageSubscriptionRenewal => 'Rinnovo';

  @override
  String get manageSubscriptionStatus => 'Stato';

  @override
  String get manageSubscriptionStatusActive => 'Attivo';

  @override
  String get manageSubscriptionStatusInactive => 'Inattivo';

  @override
  String get manageSubscriptionManageButton => 'Gestisci abbonamento';

  @override
  String get manageSubscriptionUpgradeButton => 'Passa a Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Apri store subscription impostazioni';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Ripristina acquisti';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Si rinnova automaticamente';

  @override
  String get manageSubscriptionLifetime => 'A vita';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Si rinnova il $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Scade il $date';
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
  String get subscriptionDebugTitle => 'Abbonamenti Glu';

  @override
  String get subscriptionDebugMonthly => 'Mensile';

  @override
  String get subscriptionDebugYearly => 'Annuale';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Aggiorna info cliente';

  @override
  String get subscriptionDebugPresentPaywall => 'Mostra paywall';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Apri Customer Center';

  @override
  String get subscriptionDebugRestorePurchases => 'Ripristina acquisti';

  @override
  String get subscriptionDebugSyncPurchases => 'Sincronizza acquisti';

  @override
  String get subscriptionDebugRevenuecatStatus => 'Stato RevenueCat';

  @override
  String get subscriptionDebugConfigured => 'Configurato';

  @override
  String get subscriptionDebugBusy => 'Occupato';

  @override
  String get subscriptionDebugAppUserId => 'ID utente app';

  @override
  String get subscriptionDebugAnonymous => 'Anonymous';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API key disponibile';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro attivo';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Abbonamenti attivi';

  @override
  String get subscriptionDebugManagementUrl => 'URL di gestione';

  @override
  String get subscriptionDebugEntitlementProduct => 'Prodotto entitlement';

  @override
  String get subscriptionDebugWillRenew => 'Si rinnoverà';

  @override
  String get subscriptionDebugExpiration => 'Scadenza';

  @override
  String get subscriptionDebugLifetime => 'Lifetime';

  @override
  String get subscriptionDebugPackageFound => 'Pacchetto trovato';

  @override
  String get subscriptionDebugProductId => 'ID prodotto';

  @override
  String get subscriptionDebugTitleLabel => 'Titolo';

  @override
  String get subscriptionDebugPrice => 'Prezzo';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Acquista $title';
  }

  @override
  String get progressExerciseTitle => 'Esercizio';

  @override
  String get progressDoseTitle => 'Dose';

  @override
  String get progressMealsTitle => 'Pasti';

  @override
  String get progressSymptomsTitle => 'Sintomi';

  @override
  String get progressMoodTitle => 'Umore';

  @override
  String get progressCravingsTitle => 'Voglie';

  @override
  String get progressTrend => 'Tendenza';

  @override
  String get progressTarget => 'Obiettivo';

  @override
  String get progressNoTrendYet => 'No tendenza yet';

  @override
  String get progressNoActivityYet => 'Nessuna attività ancora';

  @override
  String get progressNoCheckInsYet => 'Nessun check-in ancora';

  @override
  String get progressWeightSignatureChip =>
      'Peso will become Il tuo signature chart';

  @override
  String get progressWeightStartTrendTitle =>
      'Inizia Il tuo tendenza con one weigh-in';

  @override
  String get progressWeightStartTrendBody =>
      'Questo chart is il centerpiece of Il tuo progressi story. registro Il tuo first peso to sblocca slancio, milestones, e a vedi worth sharing.';

  @override
  String get progressWeightMomentum => 'Andamento del peso';

  @override
  String get progressWeightMilestones => 'Traguardi';

  @override
  String get progressWeightShareReady => 'Condividi-ready';

  @override
  String get progressWeightLogWeight => 'Registro peso';

  @override
  String get weightProgressUnlocksViewChip =>
      'Il tuo first weigh-in unlocks questo vedi';

  @override
  String get weightProgressStartsHereTitle =>
      'Il tuo progressi story starts here';

  @override
  String get weightProgressStartsHereBody =>
      'Registro Il tuo first peso to sblocca tendenze, milestones, e dose-aware analisi in a vedi worth sharing.';

  @override
  String get weightProgressTrendView => 'Tendenza vedi';

  @override
  String get weightProgressDoseOverlays => 'Sovrapposizioni della dose';

  @override
  String get weightProgressMilestones => 'Traguardi';

  @override
  String get weightProgressLogWeight => 'Registro peso';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Aggiungi both a before e after photo first.';

  @override
  String get glowUpSavedToGallery => 'Salvato to Il tuo gallery';

  @override
  String get glowUpSaveToGallery => 'Salva nella galleria';

  @override
  String get glowUpYourProgress => 'Il tuo progressi';

  @override
  String get glowUpWeightChange => 'Peso change';

  @override
  String get glowUpTime => 'Tempo';

  @override
  String get glowUpShare => 'Condividi';

  @override
  String get glowUpBefore => 'PRIMA';

  @override
  String get glowUpAfter => 'DOPO';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight in $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'giorni';

  @override
  String get glowUpTimeUnitWeeksLabel => 'settimane';

  @override
  String get glowUpTimeUnitMonthsLabel => 'mesi';

  @override
  String get glowUpTimeUnitYearsLabel => 'anni';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count giorni',
      one: '$count giorno',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count settimane',
      one: '$count settimana',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mesi',
      one: '$count mese',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anni',
      one: '$count anno',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Ieri';

  @override
  String get commonSelect => 'Seleziona';

  @override
  String get doseReminderTitle => 'Dose promemoria';

  @override
  String get doseReminderCustomDoseTitle => 'Dose personalizzata';

  @override
  String get doseReminderCustomDoseHint => 'Inserisci la dose in mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Mantieni Il tuo next dose ready on home.';

  @override
  String get doseReminderTime => 'Tempo';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Turn questo on to mostra il next dose on home.';

  @override
  String get doseReminderSaveReminder => 'Salva promemoria';

  @override
  String loggedOn(Object date) {
    return 'Registrato il $date';
  }

  @override
  String get waterLogSmallGlass => 'Bicchiere piccolo';

  @override
  String get waterLogGlass => 'Bicchiere';

  @override
  String get waterLogBottle => 'Bottiglia';

  @override
  String get waterLogLargeBottle => 'Bottiglia grande';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Personalizzato';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dose';

  @override
  String get doseLogEditTitle => 'Modifica dose';

  @override
  String get doseLogLogTitle => 'Registro dose';

  @override
  String get doseLogCustomDose => 'Dose personalizzata';

  @override
  String get doseLogCustomDoseBody =>
      'Adjust il dose in mg per questo registro.';

  @override
  String get doseLogUseThisDose => 'Usa questa dose';

  @override
  String get doseLogMedication => 'Farmaco';

  @override
  String get doseLogInjectionSite => 'Sito di iniezione';

  @override
  String get doseLogNotes => 'Note';

  @override
  String get doseLogSaveChanges => 'Salva changes';

  @override
  String get doseLogAddDose => '+ registro dose';

  @override
  String get doseLogDeleteTitle => 'Elimina questo dose registro?';

  @override
  String get doseLogDeleteMessage => 'Questa azione non può essere annullata.';

  @override
  String get doseLogDeleteLog => 'Elimina registro';

  @override
  String get doseLogSaving => 'Salvataggio...';

  @override
  String get doseLogCouldNotSave => 'Could not salva questo dose registro yet.';

  @override
  String get doseLogCouldNotDelete =>
      'Could not elimina questo dose registro yet.';

  @override
  String get doseLogDeleted => 'Dose eliminata';

  @override
  String get doseLogAddedToDoseLog => 'Added to Il tuo dose registro';

  @override
  String get doseLogAnythingWorthRemembering =>
      'C’è qualcosa da ricordare su questa dose?';

  @override
  String get doseLogDoseLabel => 'Dose';

  @override
  String get exerciseLogTitle => 'Esercizio';

  @override
  String get exerciseLogEditTitle => 'Edit exercise';

  @override
  String get exerciseLogLogTitle => 'Registro exercise';

  @override
  String get exerciseLogActivityType => 'Tipo di attività';

  @override
  String get exerciseLogCustomActivity => 'Attività personalizzata';

  @override
  String get exerciseLogTypeActivity => 'Type il attività';

  @override
  String get exerciseLogDuration => 'Durata';

  @override
  String get exerciseLogIntensity => 'Intensità';

  @override
  String get exerciseLogNotes => 'Note';

  @override
  String get exerciseLogLight => 'Leggero';

  @override
  String get exerciseLogModerate => 'Moderato';

  @override
  String get exerciseLogIntense => 'Intenso';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min registrati';
  }

  @override
  String get exerciseLogSaveChanges => 'Salva changes';

  @override
  String get exerciseLogAddExercise => '+ aggiungi exercise registro';

  @override
  String get exerciseLogDeleteTitle => 'Elimina questo exercise registro?';

  @override
  String get exerciseLogDeleteMessage =>
      'Questa azione non può essere annullata.';

  @override
  String get exerciseLogDeleteLog => 'Elimina registro';

  @override
  String get exerciseLogSaving => 'Salvataggio...';

  @override
  String get exerciseLogCouldNotSave =>
      'Could not salva questo exercise registro yet.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Could not elimina questo exercise registro yet.';

  @override
  String get exerciseLogDeleted => 'Attività eliminata';

  @override
  String get exerciseLogAddedToExerciseLog =>
      'Added to Il tuo exercise registro';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'C’è qualcosa da ricordare su questa sessione?';

  @override
  String get exerciseLogWalking => 'Camminata';

  @override
  String get exerciseLogRunning => 'Corsa';

  @override
  String get exerciseLogCycling => 'Bicicletta';

  @override
  String get exerciseLogStrength => 'Forza';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Nuoto';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Peso';

  @override
  String get weightLogEditTitle => 'Edit peso';

  @override
  String get weightLogLogTitle => 'Registro peso';

  @override
  String get weightLogSaveChanges => 'Salva changes';

  @override
  String weightLogAddWeight(Object label) {
    return '+ aggiungi peso ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Elimina questo peso registro?';

  @override
  String get weightLogDeleteMessage => 'Questo action cannot be undone.';

  @override
  String get weightLogDeleteLog => 'Elimina registro';

  @override
  String get weightLogSaving => 'Salvataggio...';

  @override
  String get weightLogCouldNotSave =>
      'Could not salva questo peso registro yet.';

  @override
  String get weightLogCouldNotDelete =>
      'Could not elimina questo peso registro yet.';

  @override
  String get weightLogDeleted => 'Peso deleted';

  @override
  String get weightLogAddedToWeightLog => 'Added to Il tuo peso registro';

  @override
  String get weightLogNoWeightForDay => 'No peso logged per questo day yet.';

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
  String get doseReminderFormat => 'Formato';

  @override
  String get doseReminderInjection => 'Iniezione';

  @override
  String get doseReminderPill => 'Pillola';

  @override
  String get doseReminderSite => 'Sito';

  @override
  String get doseReminderDate => 'Data';

  @override
  String get supplementReminderTitle => 'Integratore promemoria';

  @override
  String get supplementReminderAddSupplement => 'Aggiungi integratore';

  @override
  String get supplementReminderNoSupplementsYet => 'No integratori yet';

  @override
  String get supplementReminderAddFirstBody =>
      'Aggiungi Il tuo first integratore promemoria to traccia Il tuo quotidiano intake.';

  @override
  String get supplementReminderSupplementFallback => 'Integratore';

  @override
  String get supplementReminderEveryDay => 'Ogni day';

  @override
  String get supplementReminderEveryXDaysLabel => 'Ogni X days';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Ogni $interval days';
  }

  @override
  String get supplementReminderNoDaysSet => 'Nessun giorno impostato';

  @override
  String get supplementReminderSupplementName => 'Integratore name';

  @override
  String get supplementReminderTime => 'Tempo';

  @override
  String get supplementReminderStartDate => 'Inizia date';

  @override
  String get supplementReminderRepeat => 'Ripeti';

  @override
  String get supplementReminderDaysOfWeek => 'Giorni della settimana';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Seleziona almeno un giorno.';

  @override
  String get supplementReminderEvery => 'Ogni';

  @override
  String get supplementReminderDay => 'Day';

  @override
  String get supplementReminderDays => 'Days';

  @override
  String get supplementReminderAdd => 'Aggiungi';

  @override
  String get symptomsLogTitle => 'Sintomi';

  @override
  String get symptomsLogEditTitle => 'Modifica sintomi';

  @override
  String get symptomsLogLogTitle => 'Registro symptoms';

  @override
  String get symptomsLogSymptomsExperienced => 'Sintomi avvertiti';

  @override
  String get symptomsLogNoSymptoms => 'Nessun sintomo';

  @override
  String get symptomsLogNoSymptomsToday => 'No symptoms oggi';

  @override
  String get symptomsLogOther => 'Altro...';

  @override
  String get symptomsLogSeverityLevel => 'Livello di gravità';

  @override
  String get symptomsLogNotes => 'Note';

  @override
  String get symptomsLogAnxiety => 'Ansia';

  @override
  String get symptomsLogBelching => 'Rutti';

  @override
  String get symptomsLogBloating => 'Gonfiore';

  @override
  String get symptomsLogConstipation => 'Stitichezza';

  @override
  String get symptomsLogDiarrhea => 'Diarrea';

  @override
  String get symptomsLogFatigue => 'Stanchezza';

  @override
  String get symptomsLogFoodNoise => 'Fame mentale';

  @override
  String get symptomsLogHairLoss => 'Perdita di capelli';

  @override
  String get symptomsLogHeartburn => 'Bruciore di stomaco';

  @override
  String get symptomsLogIndigestion => 'Indigestione';

  @override
  String get symptomsLogInjectionSiteReaction =>
      'Reazione nel sito di iniezione';

  @override
  String get symptomsLogMetallicTaste => 'Sapore metallico';

  @override
  String get symptomsLogHeadache => 'Mal di testa';

  @override
  String get symptomsLogMoodSwings => 'Sbalzi d’umore';

  @override
  String get symptomsLogNausea => 'Nausea';

  @override
  String get symptomsLogReflux => 'Reflusso';

  @override
  String get symptomsLogStomachPain => 'Mal di stomaco';

  @override
  String get symptomsLogSuppressedAppetite => 'Appetito ridotto';

  @override
  String get symptomsLogVomiting => 'Vomito';

  @override
  String get symptomsLogLogged => 'Sintomo registrato';

  @override
  String get symptomsLogMild => 'Lieve';

  @override
  String get symptomsLogModerate => 'Moderato';

  @override
  String get symptomsLogSevere => 'Severo';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Anything worth remembering about come Tu felt?';

  @override
  String get symptomsLogSaveChanges => 'Salva changes';

  @override
  String get symptomsLogAddSymptoms => '+ aggiungi symptoms registro';

  @override
  String get symptomsLogDeleteTitle => 'Elimina questo symptoms registro?';

  @override
  String get symptomsLogDeleteMessage =>
      'Questa azione non può essere annullata.';

  @override
  String get symptomsLogDeleteLog => 'Elimina registro';

  @override
  String get symptomsLogSaving => 'Salvataggio...';

  @override
  String get symptomsLogCouldNotSave =>
      'Could not salva questo symptoms registro yet.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Could not elimina questo symptoms registro yet.';

  @override
  String get symptomsLogDeleted => 'Sintomo eliminato';

  @override
  String get symptomsLogAddedToSymptomsLog =>
      'Added to Il tuo symptoms registro';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% dell’obiettivo giornaliero';
  }

  @override
  String get commonDisclaimer =>
      'Glu è uno strumento di monitoraggio, non un dispositivo medico. Non fornisce consulenza medica, diagnosi o trattamento. Consulta sempre il tuo medico riguardo ai tuoi farmaci e alle tue decisioni sulla salute.';
}
