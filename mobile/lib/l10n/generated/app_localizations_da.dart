// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Vågner op...';

  @override
  String get startupFailed => 'Start mislykkedes';

  @override
  String get commonCancel => 'Annuller';

  @override
  String get commonSave => 'Gem';

  @override
  String get commonSaving => 'Gemmer...';

  @override
  String get commonContinue => 'Fortsæt';

  @override
  String get commonSkip => 'Spring over';

  @override
  String get commonDelete => 'Slet';

  @override
  String get commonNotNow => 'Ikke nu';

  @override
  String get commonNow => 'Nu';

  @override
  String get commonTomorrow => 'I morgen';

  @override
  String get noteTriggerAddNote => 'Tilføj note';

  @override
  String get noteTriggerCancelNote => 'Annuller note';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'I $count dage';
  }

  @override
  String get homeDoseReminderInOneWeek => 'I 1 uge';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'I $count uger';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Due 1 dag ago';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Due $count dage ago';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Due 1 uge ago';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Due $count uger ago';
  }

  @override
  String get bmiIndicatorYourBmi => 'Din BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Din nuværende BMI';

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
  String get heightRulerInUnit => 'i';

  @override
  String get heightRulerFtInUnit => 'ft/i';

  @override
  String get weightDialKgUnit => 'kg';

  @override
  String get weightDialLbUnit => 'lb';

  @override
  String get logNoteIndicatorHasNote => 'Has note';

  @override
  String get paywallTitle => 'Unlock Glu Pro';

  @override
  String get paywallSubtitle => 'Uden Pro mister du dette:';

  @override
  String get paywallMonthlyTitle => 'Månedlig';

  @override
  String get paywallMonthlySubtitle => 'Nej trial';

  @override
  String get paywallYearlyTitle => 'Årlig';

  @override
  String get paywallYearlySubtitle => '7-dag gratis trial';

  @override
  String get paywallNoCommitment => 'Nej commitment';

  @override
  String get paywallCancelAnytime => 'Annuller anytime';

  @override
  String get paywallContinue => 'Fortsæt';

  @override
  String get paywallRestore => 'Gendan';

  @override
  String get paywallTerms => 'Vilkår';

  @override
  String get paywallPrivacy => 'Privatliv';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Gem $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Kunne ikke åbne linket lige nu.';

  @override
  String get paywallAlreadySubscribed => 'Du already have Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Welcome til Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'Køb did not complete. Please try again.';

  @override
  String get paywallPurchaseFailed => 'Køb failed. Please try again.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Køb failed: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Abonnement restored!';

  @override
  String get paywallRestoreNoSubscription => 'Nej aktiv abonnement found.';

  @override
  String get paywallRestoreFailed => 'Gendan failed. Please try again.';

  @override
  String get paywallBenefitReminders => 'Gå glip af doser uden påmindelser';

  @override
  String get paywallBenefitShareProgress => 'Sværere at dele dine fremskridt';

  @override
  String get paywallBenefitSpotRegain => 'Overse tegn på vægtøgning';

  @override
  String get paywallBenefitInsights => 'Gå glip af dine daglige mønstre';

  @override
  String get paywallBenefitWeeklyGoals => 'Mist din ugentlige struktur';

  @override
  String get paywallBenefitHealthyHabits => 'Vaner glider uden støtte';

  @override
  String get onboardingWelcomeTitle => 'Hold den vægt fra';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu hjælper du protect din fremskridt around treatment, mål, og ugentlig vaner.';

  @override
  String get onboardingWelcomeBullet1 => 'Fits din treatment og mål';

  @override
  String get onboardingWelcomeBullet2 => 'Simple og realistic støtte';

  @override
  String get onboardingWelcomeBullet3 =>
      'Easily spot tidligt signs af vægt regain';

  @override
  String get onboardingWelcomeBullet4 => 'Hold going uden starter over';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Tager du i øjeblikket en medicin til vægttab i pen eller pilleform?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Vi bruger dette til at vise vejledning, der passer til, hvor du er lige nu.';

  @override
  String get onboardingMedicationStatusUsing => 'Ja, Jeg er taking it nu';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Ja, Jeg er weaning fra';

  @override
  String get onboardingMedicationStatusNotTaking => 'Nej, Jeg er not taking it';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'Nej, Jeg vil start soon';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Nej, I recently stopped';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Hvordan tager du din medicin?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Vi bruger dette til at tilpasse instruktioner og påmindelser til din medicinform.';

  @override
  String get onboardingMedicationMethodInjection => 'Injection';

  @override
  String get onboardingMedicationMethodPill => 'Pill';

  @override
  String get onboardingMedicationMethodUnknown => 'I don’t know yet';

  @override
  String get onboardingMedicationNameQuestion => 'Hvilken medicin tager du?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Vi bruger dette til at gøre dosisregistrering og medicinspecifik vejledning personlig.';

  @override
  String get onboardingCurrentDoseQuestion => 'Hvad er din current dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Vi bruger dette til at tilpasse dosisregistrering og fremtidige fremskridtstjek.';

  @override
  String get onboardingMedicationCustomDose => 'Custom';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Hvilken enhed bruger du til at tage din medicin?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Vi bruger dette til at få påmindelser og tips til at passe til den måde, du tager det på.';

  @override
  String get onboardingDeviceSinglePen => 'Single pen';

  @override
  String get onboardingDeviceAutoInjector => 'Auto-injector';

  @override
  String get onboardingDeviceSyringeAndVial => 'Syringe og vial';

  @override
  String get onboardingOther => 'Other';

  @override
  String get onboardingTypeYourDevice => 'Skriv din device';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Hvor ofte tager du din medicin?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Vi bruger dette til at time påmindelser og rutinestøtte omkring din tidsplan.';

  @override
  String get onboardingEveryDay => 'Every dag';

  @override
  String get onboardingEvery7Days => 'Every 7 dage';

  @override
  String get onboardingEvery14Days => 'Every 14 dage';

  @override
  String get onboardingCustom => 'Custom';

  @override
  String get onboardingDaysBetweenDoses => 'Dage between doser';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'Hvad er dit primære mål lige nu?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Vi bruger dette til at fokusere din plan, påmindelser og fremskridt omkring det, der betyder mest for dig.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Vi bruger dette til at forme din plan fra begyndelsen.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Vi bruger dette til at støtte din næste fase og hjælpe dig med at holde kursen.';

  @override
  String get onboardingGoalLoseWeight => 'Tabe sig';

  @override
  String get onboardingGoalMaintainWeight => 'Bevare min vægt';

  @override
  String get onboardingGoalManageDiabetes => 'Håndtere min diabetes';

  @override
  String get onboardingGoalManagePcos => 'Håndtere min PCOS';

  @override
  String get onboardingGoalImproveHeartHealth => 'Forbedre min hjertesundhed';

  @override
  String get onboardingAgeQuestion => 'Hvad er din age?';

  @override
  String get onboardingAgeExplainer =>
      'Vi bruger dette til at justere vejledning og sundhedsberegninger mere passende.';

  @override
  String get onboardingHeightQuestion => 'Hvad er din height?';

  @override
  String get onboardingHeightExplainer =>
      'Vi bruge denne med din vægt til calculate things like BMI og healthy ranges.';

  @override
  String get onboardingWeightQuestion => 'Hvad er din nuværende vægt?';

  @override
  String get onboardingWeightExplainer =>
      'Vi bruger dette som dit udgangspunkt for fremskridt, mål og sundhedsestimering.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Hvornår stoppede du med medicinen?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Hvornår begyndte du at trappe ned?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Hvornår begyndte du med medicinen?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Vi bruger dette til at forstå din nylige behandlingshistorik og næste fase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Vi bruger dette til at forstå din overgangsfase og støtte de vaner, der betyder mest lige nu.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Vi bruger dette til at forstå, hvor længe du har været i behandling, og følge ændringer over tid.';

  @override
  String get onboardingGoalWeightQuestion => 'Hvad er din målvægt?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Vi bruger dette til at sætte rammerne for fremskridt og vise et mål-BMI-interval for dig.';

  @override
  String get onboardingBenefitsQuestion => 'What Glu will hjælpe du do næste';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu omsætter det, du delte, til påmindelser, støtte og struktur, der passer til din rutine.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Sådan kan Glu hjælpe dig med at maintain your progress';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Sådan kan Glu støtte din diabetes routine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Sådan kan Glu støtte din PCOS routine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Sådan kan Glu støtte din heart health';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Sådan kan Glu hjælpe dig med at tabe dig';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Se, hvordan Glu hjælper dig med at beskytte din nuværende vægt og opdage tilbagegang tidligt.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Se, hvordan Glu hjælper dig med at holde måltider, vægt og rutiner mere stabile uge for uge.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Se, hvordan Glu hjælper dig med at være mere stabil omkring symptomer, vægt og rutine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Se, hvordan Glu hjælper dig med at holde de vaner, der støtter hjertesundhed.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Se, hvordan Glu hjælper dig med at spotte de mønstre, der får vægten til at bevæge sig nedad.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Uden struktur kan tilbagegang vokse i stilhed. Glu hjælper dig med at opdage det tidligere og holde dig stabil.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Uden struktur bliver måltider og vægtmønstre mere uklare. Glu gør signalerne tydeligere.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Uden struktur kan symptomer og rutiner svinge mere. Glu hjælper dig med at være mere stabil.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Uden struktur glider sunde vaner. Glu hjælper dig med at holde aktivitet og vægt på sporet.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Uden struktur kan vægten stagnere eller stige. Glu hjælper med at holde fremskridtet i den rigtige retning.';

  @override
  String get onboardingBenefitsAxisWeight => 'Vægt';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Måltider & vægt';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptomer & vægt';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Motion & vægt';

  @override
  String get onboardingNotificationsQuestion =>
      'Slå påmindelser til, der støtter dit mål';

  @override
  String get onboardingNotificationsExplainer =>
      'Vi bruger notifikationer til at hjælpe dig med at holde dig konsekvent, forberedt og på sporet.';

  @override
  String get onboardingNotificationsHeadline =>
      'Sæt Glu op til at hjælpe på det rigtige tidspunkt.';

  @override
  String get onboardingNotificationsBody =>
      'Slå notifikationer til, så Glu kan forstærke de vaner, der støtter dit mål.';

  @override
  String get onboardingNotificationsDaily =>
      'Tidsstyrede påmindelser, der passer til din daglige medicinrytme';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Længerevarende påmindelser, så doseringsdage ikke kommer bag på dig';

  @override
  String get onboardingNotificationsCustom =>
      'Påmindelser formet omkring din brugerdefinerede tidsplan';

  @override
  String get onboardingNotificationsWeekly =>
      'Dosispåmindelser, der følger din ugentlige rytme';

  @override
  String get onboardingNotificationsSupportive =>
      'Støttende påmindelser, der holder din rutine synlig, når motivationen daler';

  @override
  String get onboardingNotificationsProgress =>
      'Tidsrigtige skub omkring fremskridt, vaner og de mål, du sagde betød mest';

  @override
  String get onboardingNotificationsHelpful =>
      'Nyttige prompts, der gør Glu mere anvendelig i de øjeblikke, du har brug for det';

  @override
  String get onboardingDailyRoutineQuestion =>
      'Hvordan ser din daglige rutine ud?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Vi bruger dette til at gøre din plan mere realistisk til din hverdag.';

  @override
  String get onboardingRoutineSedentary => 'Sedentary';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'For det meste siddende, kontorarbejde og meget lidt bevidst motion.';

  @override
  String get onboardingRoutineLightlyActive => 'Lightly aktiv';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regelmæssige gåture, ærinder eller let træning et par gange om ugen.';

  @override
  String get onboardingRoutineActive => 'Aktiv';

  @override
  String get onboardingRoutineActiveDescription =>
      'Hyppig bevægelse eller motion, som daglige gåture, fitness eller aktivt arbejde.';

  @override
  String get onboardingRoutineVeryActive => 'Very aktiv';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hård træning, fysisk krævende arbejde eller høj aktivitet de fleste dage.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Hvilke symptomer er du mest bekymret for, hvis nogen?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Vi bruger dette til at prioritere tips og vejledning om de symptomer, du bekymrer dig mest om.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Vi bruger dette til at fokusere på de symptomer, du vil være på forkant med.';

  @override
  String get onboardingGenderQuestion => 'Hvordan beskriver du dit køn?';

  @override
  String get onboardingGenderExplainer =>
      'Vi bruger dette til mere relevant vejledning og fremtidig personalisering.';

  @override
  String get onboardingGenderFemale => 'Female';

  @override
  String get onboardingGenderMale => 'Male';

  @override
  String get onboardingGenderPreferNotToSay => 'Prefer not til say';

  @override
  String get onboardingTypeYourGender => 'Skriv dit køn';

  @override
  String get onboardingPreferredNameQuestion => 'Hvad skal vi kalde dig?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Vi bruger dette til at gøre Glu mere personligt, når vi taler med dig.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Opsætter din plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Vi omsætter det, du delte, til en plan, som Glu kan støtte med det samme.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Låser vægtvedligeholdelsesmål...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Sætter tilbagegangspunkter op...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Justerer påmindelser omkring din rutine...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Forbereder en mere stabil ugentlig plan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Definerer mønstre for måltider og vægt...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Sætter hydreringstøtte op...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Forbereder konsistenspåmindelser...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Bygger en tydeligere daglig struktur...';

  @override
  String get onboardingSetupSummaryPcosStep1 => 'Organiserer symptomstøtte...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Definerer ugentlige bevægelsesmål...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Sætter hydrering og rutineankre op...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Forbereder en mere stabil plan...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'Sætter aktivitetsmål...';

  @override
  String get onboardingSetupSummaryHeartStep2 => 'Definerer hydreringstøtte...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Forbereder ugentlige vanepåmindelser...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Bygger en hjertesund rutine...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Definerer kalorierammer...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Sætter vandmængder op...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 => 'Bygger motionsmål...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Forbereder din ugentlige plan...';

  @override
  String get onboardingSetupSummaryHeadline => 'Din Glu-opsætning er klar.';

  @override
  String get onboardingSetupLoadingTitle => 'Bygger din opsætning';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu er klar til at hjælpe dig med at beskytte dine fremskridt med tydeligere struktur og tidligere signaler om tilbagegang.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu er klar til at støtte mere stabile måltider, vægtregistrering og vaner, der betyder noget i hverdagen.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu er klar til at støtte mere stabile rutiner omkring symptomer, behandling og fremskridt.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu er klar til at forstærke de vaner, der støtter din langsigtede hjertesundhed.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu er klar til at støtte de rutiner, der hjælper dig med at holde vægten.';

  @override
  String get onboardingSetupSummaryLabel => 'Oversigt';

  @override
  String get onboardingSetupAdjustLater =>
      'Du can adjust any af denne senere i Indstillinger.';

  @override
  String get onboardingSummaryGoal => 'Mål';

  @override
  String get onboardingSummaryCurrentWeight => 'Nuværende vægt';

  @override
  String get onboardingSummaryMedication => 'Medicin';

  @override
  String get onboardingSummaryCurrentDose => 'Nuværende dosis';

  @override
  String get onboardingSummaryCadence => 'Cadence';

  @override
  String get onboardingSummaryStarted => 'Startet';

  @override
  String get onboardingSummaryTargetWeight => 'Target vægt';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'Fokus';

  @override
  String get onboardingFrequencyEveryDay => 'Every dag';

  @override
  String get onboardingFrequencyEveryWeek => 'Every uge';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Every 2 uger';

  @override
  String get onboardingFrequencyCustomSchedule => 'Custom schedule';

  @override
  String get onboardingTapOptionContinue =>
      'Tryk på en mulighed for at fortsætte.';

  @override
  String get onboardingTypeGenderContinue =>
      'Skriv din gender for at fortsætte.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Skriv din device for at fortsætte.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Skriv din medicin for at fortsætte.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Indtast dage mellem doser for at fortsætte.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Vælg en tidsplan for at fortsætte.';

  @override
  String get onboardingScrollChooseAge => 'Rul for at vælge din alder.';

  @override
  String get onboardingDragOrTapHeight =>
      'Træk eller tryk på linjalen for at vælge din højde.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Træk, tryk eller brug trin-knapperne for at vælge en vægt.';

  @override
  String get onboardingPickDateAndWeight =>
      'Vælg en dato og en vægt for at fortsætte.';

  @override
  String get onboardingSelectSymptoms =>
      'Vælg de symptomer, du vil have Glu til at fokusere på.';

  @override
  String get onboardingTypeName =>
      'Skriv det navn, du vil have Glu til at bruge.';

  @override
  String get onboardingSaving => 'Gemmer...';

  @override
  String get onboardingLetsBegin => 'Let’s begin';

  @override
  String get onboardingContinueWithGlu => 'Fortsæt med Glu';

  @override
  String get onboardingKeepGoing => 'Hold going';

  @override
  String get onboardingTurnOnNotifications => 'Slå til notifications';

  @override
  String get onboardingFinish => 'Afslut';

  @override
  String get onboardingTargetBmiTitle => 'Din target BMI';

  @override
  String get onboardingChartToday => 'I dag';

  @override
  String get onboardingChartOverTime => 'Over tid';

  @override
  String get onboardingChartWithoutGlu => 'Uden Glu';

  @override
  String get onboardingChartWithGlu => 'Med Glu';

  @override
  String get onboardingReviewQuestion =>
      'Folk bruger Glu til at stay steady and supported';

  @override
  String get onboardingReviewExplainer =>
      'En hurtig vurdering hjælper flere med ved finde støtte, der føles så enkel.';

  @override
  String get onboardingReviewBody =>
      'Folk bruger Glu til at feel more supported, more consistent, and less alone in the process.';

  @override
  String get onboardingTypeYourMedication => 'Skriv din medicin';

  @override
  String get onboardingSelectStartDate => 'Vælg startdato';

  @override
  String get goalsSaveDialogTitle => 'Gem mål?';

  @override
  String get goalsSaveDialogMessage =>
      'Du har ugemte ændringer til målene. Vil du gemme dem, før du forlader fanen?';

  @override
  String get commonLater => 'Senere';

  @override
  String get homeGreetingAnonymous => 'Hej';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hej, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Registrer i dag for at se analysen';

  @override
  String get homeInsightEmptyBody =>
      'Registrer noget i dag, så ser du din analyse i aften.';

  @override
  String get homeInsightLogTodayTitle => 'Tryk for at se din indsigt';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Tryk for at se dagens indsigt';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Dine logninger begynder at vise et mønster — tryk for at se det.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Tryk for at se din indsigt';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Et par logninger mere kan gøre billedet meget klarere — tryk når som helst.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Tryk for at afdække dagens indsigt';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Der kan allerede gemme sig et mønster i din dag — tryk for at se.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Log noget i dag, og tryk så for at se, hvad det afslører.';

  @override
  String get homeInsightExpandedTitle => 'Var det nyttigt?';

  @override
  String get homeInsightExpandedBody =>
      'En hurtig vurdering hjælper Glu med at lære, hvad der betyder mest for dig.';

  @override
  String get homeInsightReasonHint => 'Hvad kunne være bedre? (valgfrit)';

  @override
  String get homeInsightReasonSubmit => 'Send';

  @override
  String get homeInsightLearningMessage => 'Jeg lærer af det her.';

  @override
  String get homeInsightChecking => 'Tjekker dagens analyse...';

  @override
  String get homeInsightGenerating => 'Indlæser dagens analyse...';

  @override
  String get homeInsightTryAgain => 'Prøv igen';

  @override
  String get homeSeeAllInsights => 'Se alle analyser';

  @override
  String get insightsProgressTitle => 'Alle analyser';

  @override
  String get insightsProgressEmptyState =>
      'Dine analyser vises her, når de er blevet genereret.';

  @override
  String get homeDoseReminderTitle => 'Dosispåmindelse';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Log $label-interaktion går her.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Kalorimål kræves';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portionskontrol har brug for, at madmålet er sat til kalorier, for at kunne vurdere din portion. Sæt et mål i Mål for at komme i gang.';

  @override
  String get homeSetGoal => 'Sæt mål';

  @override
  String get homeYourProgress => 'Dine fremskridt';

  @override
  String get homeRemindersShowcaseTitle => 'Hold dig på sporet';

  @override
  String get homeRemindersShowcaseDescription =>
      'Sæt påmindelser op, så doser og kosttilskud bliver taget til tiden.';

  @override
  String get homePickNextDoseDate => 'Vælg datoen for din næste dosis';

  @override
  String get homeSetReminder => 'Opret påmindelse';

  @override
  String get homeSupplementReminders => 'Kosttilskudspåmindelser';

  @override
  String get homeNoUpcomingSupplements => 'Ingen kommende kosttilskud';

  @override
  String get homeNoMoreUpcomingSupplements => 'Ikke flere kommende';

  @override
  String get homeSetUpYourSupplements => 'Opsæt dine kosttilskud';

  @override
  String get homeSetUp => 'Opsæt';

  @override
  String get homeSupplementFallback => 'Kosttilskud';

  @override
  String get doseReminderNotificationTitle => 'Klar til din dosis?';

  @override
  String get doseReminderFallbackBody =>
      'Åbn Glu for at gennemgå din næste dosis.';

  @override
  String get supplementReminderNotificationTitle => 'Tid til dit kosttilskud';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'I morges';

  @override
  String get supplementReminderThisAfternoon => 'I eftermiddag';

  @override
  String get supplementReminderTonight => 'I aften';

  @override
  String get dailyReminderMorningTitle => 'Morgencheck-in';

  @override
  String get dailyReminderMorningBodies =>
      'Morgenmission: giv Glu lidt data at arbejde med.\nStart dagen med en hurtig registrering og lidt momentum.\nStå op og registrer. Dit fremtidige jeg vil takke dig.\nStart dagen med en lille opdatering og et godt forspring.\nGiv Glu et morgenhint, og kom videre.\nEn hurtig registrering nu kan gøre i dag meget mere interessant.\nLad os få morgenen til at tælle med et hurtigt check-in.';

  @override
  String get dailyReminderMiddayTitle => 'Middagstjek';

  @override
  String get dailyReminderMiddayBodies =>
      'Middagsstop: læg en hurtig registrering ind, og kør videre.\nFrokostpause? Perfekt tidspunkt til at give Glu en opdatering.\nHalvvejs. Giv Glu et hurtigt hint.\nEn lille middagsregistrering kan holde historien i gang.\nTjek ind nu, og hold dagen kørende.\nGiv dagen et lille skub med en hurtig opdatering.\nHold energien oppe med et hurtigt middagstjek.';

  @override
  String get dailyReminderAfternoonTitle => 'Eftermiddagstjek';

  @override
  String get dailyReminderAfternoonBodies =>
      'Snart i mål. Giv Glu endnu et spor.\nEn hurtig eftermiddagsregistrering kan få aftenens analyse til at skinne.\nAfrund dagen med en lille opdatering og en stor gevinst.\nEn registrering mere før dagen slutter?\nHjælp Glu med at forbinde prikkerne med et hurtigt eftermiddagstjek.\nLuk dagen med en lille registrering og hold magien i gang.\nEt sidste tryk nu kan gøre aftenens analyse meget bedre.';

  @override
  String get homePortionCheckTitle => 'Portionskontrol';

  @override
  String get homePortionCheckBody =>
      'Se hvor meget du skal spise til hvert måltid';

  @override
  String get homeGlowUpTitle => 'Din\nGlow up';

  @override
  String get homeGlowUpBody => 'Lav din før-og-efter-historie';

  @override
  String get homeDoctorReportTitle => 'Lægerapport';

  @override
  String get homeDoctorReportBody => 'Del dine fremskridt med din læge';

  @override
  String get doctorReportViewerRenderError =>
      'Kunne ikke vise rapporten. Prøv igen.';

  @override
  String get doctorReportViewerShare => 'Del';

  @override
  String get homeGoalsStatusTitle => 'Dagens mål';

  @override
  String get homeGoalsStatusViewAll => 'Se alle';

  @override
  String get homeWaterTitle => 'Vand';

  @override
  String get homeWeightTitle => 'Vægt';

  @override
  String get homeExerciseTitle => 'Motion';

  @override
  String get homeMealsTitle => 'Måltider';

  @override
  String get homeCaloriesTitle => 'Kalorier';

  @override
  String get homeProteinsTitle => 'Proteiner';

  @override
  String get homeFibersTitle => 'Fibre';

  @override
  String get homeSymptomsTitle => 'Symptomer';

  @override
  String get homeMoodTitle => 'Humør';

  @override
  String get homeCravingsTitle => 'Trang';

  @override
  String get homeDoseTitle => 'Dosis';

  @override
  String get homeMedicationLevelTitle => 'Estimeret medicinniveau';

  @override
  String get homeMedicationLevelInfoTitle => 'Sådan læser du denne graf';

  @override
  String get homeMedicationLevelInfoBody =>
      'Denne graf estimerer, hvor meget af din medicin der stadig kan være aktivt baseret på de doser, du har registreret, og medicinens halveringstid.\n\nHøjere punkter betyder normalt en nyere eller større dosis. Linjen falder over tid, efterhånden som medicinen forsvinder fra din krop.\n\nBrug dette som en tendensvisning, ikke som en præcis måling eller medicinsk anbefaling.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Forstået';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Registrer dine doser, så Glu kan estimere, hvor meget medicin der stadig er aktivt i din krop.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'af seneste top';

  @override
  String get homeMedicationLevelActiveNow => 'Aktivt nu';

  @override
  String get homeMedicationLevelHalfLife => 'Halveringstid';

  @override
  String get homeMedicationLevelLastDose => 'Seneste dosis';

  @override
  String get homeStartHydration => 'Start hydrering';

  @override
  String get homeLogFirstSession => 'Registrer din første session';

  @override
  String get homeLogTodayWeight => 'Registrer dagens vægt';

  @override
  String get homeAtYourTarget => 'Du er ved dit mål';

  @override
  String get homeLogMealsToTrackCalories =>
      'Registrer måltider for at følge kalorier';

  @override
  String get homeLogFirstMeal => 'Registrer dit første måltid';

  @override
  String get homeTrackProteinFromMeals => 'Følg protein fra måltider';

  @override
  String get homeTrackFiberFromMeals => 'Følg fibre fra måltider';

  @override
  String get homeAllClear => 'Alt er i orden';

  @override
  String get homeTrackSymptoms => 'Følg symptomer';

  @override
  String get homeGreat => 'Godt';

  @override
  String get homeGood => 'Fint';

  @override
  String get homeBad => 'Dårligt';

  @override
  String get homeOkay => 'Okay';

  @override
  String get homeLogHowYouFeel => 'Registrer hvordan du har det';

  @override
  String get homeLogACraving => 'Registrer en trang';

  @override
  String get homeLogTodaysDose => 'Registrer dagens dosis';

  @override
  String get homeTaken => 'Taget';

  @override
  String get homeStartHereTitle => 'Start her';

  @override
  String get homeStartHereBody =>
      'Start med dette kort, og udvid derefter til de andre. Jo mere du registrerer, jo bedre kan Glu vise mønstre og analyser over tid.';

  @override
  String get waterLogTitle => 'Hydrering';

  @override
  String get waterLogEditTitle => 'Rediger hydrering';

  @override
  String get waterLogLogTitle => 'Registrer vand';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Tilføj drik ($amount)';
  }

  @override
  String get waterLogSaving => 'Gemmer...';

  @override
  String get waterLogCustomDrinkTitle => 'Brugerdefineret drik';

  @override
  String get waterLogCustomDrinkBody => 'Vælg den mængde, du vil tilføje nu.';

  @override
  String get waterLogUseThisAmount => 'Brug denne mængde';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount føjet til din hydrationslog';
  }

  @override
  String get waterLogCouldNotSave =>
      'Kunne endnu ikke gemme denne vandregistrering.';

  @override
  String get waterLogDeleteTitle => 'Slet denne hydrationsregistrering?';

  @override
  String get waterLogDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get waterLogCouldNotDelete =>
      'Kunne endnu ikke slette denne vandregistrering.';

  @override
  String get waterLogDeleteLog => 'Slet registrering';

  @override
  String get waterLogDeleted => 'Hydrering slettet';

  @override
  String get moodLogTitle => 'Humør';

  @override
  String get moodEditTitle => 'Rediger humør';

  @override
  String get moodHowYouFeel => 'Hvordan du har det';

  @override
  String get moodBad => 'Dårligt';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Godt';

  @override
  String get moodGreat => 'Rigtig godt';

  @override
  String get moodNotes => 'Noter';

  @override
  String get moodAnythingWorthRemembering =>
      'Er der noget værd at huske om dit humør?';

  @override
  String get moodCouldNotSave =>
      'Kunne endnu ikke gemme denne humørregistrering.';

  @override
  String get moodDeleteTitle => 'Slet denne humørregistrering?';

  @override
  String get moodDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get moodDeleteLog => 'Slet registrering';

  @override
  String get moodSaving => 'Gemmer...';

  @override
  String get moodAddMoodLog => '+ Tilføj humørregistrering';

  @override
  String get moodLogged => 'Humør registreret';

  @override
  String get moodDeleted => 'Humør slettet';

  @override
  String get moodCouldNotDelete =>
      'Kunne endnu ikke slette denne humørregistrering.';

  @override
  String get moodAddedToMoodLog => 'Tilføjet til din humørlog';

  @override
  String get cravingsLogTitle => 'Trang';

  @override
  String get cravingsEditTitle => 'Rediger trang';

  @override
  String get cravingsWhatsGoingOn => 'Hvad sker der';

  @override
  String get cravingsTypeGeneral => 'Lyst til at spise';

  @override
  String get cravingsTypeSweet => 'Noget sødt';

  @override
  String get cravingsTypeSalty => 'Noget salt';

  @override
  String get cravingsIntensityLabel => 'Styrke (valgfrit)';

  @override
  String get cravingsIntensityMild => 'Mild';

  @override
  String get cravingsIntensityModerate => 'Moderat';

  @override
  String get cravingsIntensityStrong => 'Stærk';

  @override
  String get cravingsOutcomeLabel => 'Hvad skete der (valgfrit)';

  @override
  String get cravingsOutcomeResisted => 'Modstod';

  @override
  String get cravingsOutcomeGaveIn => 'Gav efter';

  @override
  String get cravingsNotes => 'Noter';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Er der noget værd at huske om denne trang?';

  @override
  String get cravingsCouldNotSave =>
      'Kunne endnu ikke gemme denne trangregistrering.';

  @override
  String get cravingsDeleteTitle => 'Slet denne trangregistrering?';

  @override
  String get cravingsDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get cravingsDeleteLog => 'Slet registrering';

  @override
  String get cravingsSaving => 'Gemmer...';

  @override
  String get cravingsAddLog => '+ Tilføj trangregistrering';

  @override
  String get cravingsLogged => 'Trang registreret';

  @override
  String get cravingsDeleted => 'Trang slettet';

  @override
  String get cravingsCouldNotDelete =>
      'Kunne endnu ikke slette denne trangregistrering.';

  @override
  String get cravingsAddedToLog => 'Tilføjet til din trang-log';

  @override
  String get portionCheckTitle => 'Portionskontrol';

  @override
  String get portionCheckAnalyzingMeal => 'Analyserer dit måltid…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Kunne ikke analysere dette foto';

  @override
  String get portionCheckTakeNewPhoto => 'Tag et nyt foto';

  @override
  String get portionCheckSomethingWentWrong => 'Noget gik galt.';

  @override
  String get portionCheckYouHitDailyLimit => 'Du har nået din daglige grænse';

  @override
  String get portionCheckYouCanEat => 'Du kan spise';

  @override
  String get portionCheckYouCanEatUpTo => 'Du kan spise op til';

  @override
  String get portionCheckTryLighterOption =>
      'Prøv en lettere mulighed i stedet, eller spring den over';

  @override
  String get portionCheckThisEntireMeal => 'hele dette måltid';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% af dette måltid';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'for at holde dig inden for dine daglige mål.';

  @override
  String get portionCheckNutritionBreakdown => 'Næringsfordeling';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Tips til at balancere dit måltid';

  @override
  String get portionCheckTipsPool =>
      'Spis langsomt - mætheden når først frem efter cirka 20 minutter.\nFyld halvdelen af tallerkenen med grøntsager.\nFå protein med i hvert måltid.\nDrik vand før måltider.\nPortionér snacks i små beholdere.\nKombinér kulhydrater med protein eller fedt for at holde dig mæt længere.\nVælg helst hele og uforarbejdede fødevarer, når det er muligt.\nUndgå at spise, mens du er distraheret af skærme.\nSpring ikke måltider over, hvis det får dig til at overspise senere.\nPlanlæg dine snacks, før du bliver sulten.';

  @override
  String get portionCheckRetake => 'Tag igen';

  @override
  String get portionCheckLogThisPortion => 'Registrer denne portion';

  @override
  String get portionCheckCarbs => 'Kulhydrater';

  @override
  String get portionCheckProteins => 'Proteiner';

  @override
  String get portionCheckFats => 'Fedt';

  @override
  String get portionCheckFiber => 'Fibre';

  @override
  String get mealLogScreenTitle => 'Måltider';

  @override
  String get mealLogEditTitle => 'Rediger måltid';

  @override
  String get mealLogLogTitle => 'Registrer måltid';

  @override
  String get mealLogSaving => 'Gemmer...';

  @override
  String get mealLogAddMealLog => '+ Tilføj måltidsregistrering';

  @override
  String get mealLogCouldNotStartRecording => 'Kunne ikke starte optagelsen.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'Optagelsen stoppede ved 60 sekunder.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Kunne ikke analysere denne optagelse.';

  @override
  String get mealLogCouldNotAnalyzeText => 'Kunne ikke analysere denne tekst.';

  @override
  String get mealLogCouldNotAnalyzePhoto => 'Kunne ikke analysere dette foto.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Kunne endnu ikke behandle dette madfoto.';

  @override
  String get mealLogDiscardTitle => 'Vil du kassere dette måltid?';

  @override
  String get mealLogDiscardMessage =>
      'Du gennemgik et foto, men gemte ikke posten. Det bliver ikke registreret.';

  @override
  String get mealLogDiscard => 'Kassér';

  @override
  String get mealLogDeleteTitle => 'Vil du slette denne måltidsregistrering?';

  @override
  String get mealLogDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get mealLogDelete => 'Slet';

  @override
  String get mealLogDeleteLog => 'Slet registrering';

  @override
  String get mealLogCouldNotSave =>
      'Kunne endnu ikke gemme denne måltidsregistrering.';

  @override
  String get mealLogCouldNotDelete =>
      'Kunne endnu ikke slette denne måltidsregistrering.';

  @override
  String get mealLogAnalyzing => 'Analyserer...';

  @override
  String get mealLogAnalyzeText => 'Analyser tekst';

  @override
  String get mealLogSendRecording => 'Send optagelse';

  @override
  String get mealLogMealDefaultName => 'Måltid';

  @override
  String get mealLogMealNameHint => 'Navn på måltid';

  @override
  String get mealLogCouldNotPrefillTitle =>
      'Kunne ikke udfylde dette måltid automatisk';

  @override
  String get mealLogHowMuchDidYouEat => 'Hvor meget spiste du?';

  @override
  String get mealLogNotes => 'Noter';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Er der noget værd at huske om dette måltid?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analyserer dit måltid';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Vi omdanner din indtastning til ernæringsfelter. Du kan gennemgå alt før du gemmer.';

  @override
  String get mealLogDescribeYourMealTitle => 'Beskriv dit måltid';

  @override
  String get mealLogDescribeYourMealBody =>
      'Skriv hvad du spiste, og hvor meget du ved. Vi omdanner det til ernæringsfelter.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Eksempel: grillet kyllingesalat, olivenoliedressing, 1 æble, danskvand';

  @override
  String get mealLogCaptureYourMealTitle => 'Tag et billede af dit måltid';

  @override
  String get mealLogCaptureYourMealBody =>
      'Tag et foto, så estimerer vi ernæringsfelterne for dig.';

  @override
  String get mealLogTakePhoto => 'Tag foto';

  @override
  String get mealLogRecordingYourMealTitle => 'Optager dit måltid';

  @override
  String get mealLogRecordingReadyTitle => 'Optagelse klar';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Optag en beskrivelse af måltidet';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tryk stop, når du er færdig. ${remaining}s tilbage';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Send det nedenfor for at analysere det, eller optag igen.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Fortæl naturligt om, hvad du spiste, så omdanner vi det til makroer.';

  @override
  String get mealLogStopRecording => 'Stop optagelse';

  @override
  String get mealLogRecordAgain => 'Optag igen';

  @override
  String get mealLogStartRecording => 'Start optagelse';

  @override
  String get mealLogBreakfast => 'Morgenmad';

  @override
  String get mealLogLunch => 'Frokost';

  @override
  String get mealLogSnack => 'Mellemmåltid';

  @override
  String get mealLogDinner => 'Aftensmad';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'I dag';

  @override
  String get mealLogYesterday => 'I går';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal registreret';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro registreret';
  }

  @override
  String get mealLogDeleted => 'Måltid slettet';

  @override
  String get mealLogAddedToMealLog => 'Tilføjet til din måltidslog';

  @override
  String get mealLogCarbs => 'Kulhydrater';

  @override
  String get mealLogProteins => 'Proteiner';

  @override
  String get mealLogFats => 'Fedt';

  @override
  String get mealLogFiber => 'Fiber';

  @override
  String get settingsLanguage => 'Sprog';

  @override
  String get settingsLanguageDialogTitle => 'Vælg sprog';

  @override
  String get settingsTitle => 'Indstillinger';

  @override
  String get settingsPreferences => 'Præferencer';

  @override
  String get settingsHealthGoal => 'Sundhedsmål';

  @override
  String get settingsHealthGoalDialogTitle => 'Vælg sundhedsmål';

  @override
  String get settingsHabitGoals => 'Vane-mål';

  @override
  String get settingsDisabled => 'Deaktiveret';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count aktive';
  }

  @override
  String get settingsHeight => 'Højde';

  @override
  String get settingsAge => 'Alder';

  @override
  String get settingsGender => 'Køn';

  @override
  String get settingsMeasurementUnit => 'Måleenhed';

  @override
  String get settingsReminders => 'Påmindelser';

  @override
  String get settingsDoseReminder => 'Dosispåmindelse';

  @override
  String get settingsSupplementReminder => 'Kosttilskudspåmindelse';

  @override
  String get settingsDailyReminders => 'Daglige påmindelser';

  @override
  String get settingsSubscription => 'Abonnement';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsSendFeedback => 'Send feedback';

  @override
  String get feedbackSheetTitle => 'Send feedback';

  @override
  String get feedbackSheetHint => 'Fortæl os, hvad du synes…';

  @override
  String get feedbackSheetSend => 'Send';

  @override
  String get feedbackSheetSuccess => 'Tak for din feedback!';

  @override
  String get feedbackSheetError => 'Kunne ikke sende. Prøv igen.';

  @override
  String get settingsTermsOfService => 'Servicevilkår';

  @override
  String get settingsPrivacyPolicy => 'Privatlivspolitik';

  @override
  String get settingsInternal => 'Internt';

  @override
  String get settingsSubscriptionOverride => 'Abonnementsoverskrivning';

  @override
  String get settingsTodayInsightCard => 'Dagens analysekort';

  @override
  String get settingsResetOnboarding => 'Nulstil onboarding';

  @override
  String get settingsResetShowcases => 'Nulstil showcases';

  @override
  String get settingsResetUserData => 'Nulstil brugerdata';

  @override
  String get settingsDeletingAccount => 'Sletter konto...';

  @override
  String get settingsDisconnect => 'Afslut forbindelse';

  @override
  String get settingsDeleteAccount => 'Slet konto';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Afslut forbindelse til $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Afslut forbindelse til $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Du vil ikke længere kunne logge ind med $provider på denne enhed, medmindre du forbinder den igen senere.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Slet konto?';

  @override
  String get settingsDeleteAccountBody =>
      'Dette fjerner permanent din konto og alle dine data. Denne handling kan ikke fortrydes.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Skriv DELETE for at bekræfte';

  @override
  String get settingsDeleteAccountError =>
      'Der gik noget galt under sletning af din konto. Kontakt support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Genstart appen for at se onboarding';

  @override
  String get settingsShowcasesReset => 'Showcases nulstillet';

  @override
  String get settingsResetUserDataTitle => 'Nulstil brugerdata?';

  @override
  String get settingsResetUserDataBody =>
      'Dette rydder alle registrerede måltider, vand, motion, vægt, humør, symptomer, kosttilskud og doser.';

  @override
  String get settingsUserDataReset => 'Brugerdata nulstillet';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Gemt, men de daglige påmindelser kunne ikke planlægges lige nu.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Abonnementsoverskrivning';

  @override
  String get settingsSubscriptionOverrideAuto => 'Automatisk';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Tving gratis';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Tving Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Dagens analysekort';

  @override
  String get settingsTodayInsightCardAuto => 'Automatisk';

  @override
  String get settingsTodayInsightCardOn => 'Til';

  @override
  String get settingsTodayInsightCardOff => 'Fra';

  @override
  String get settingsYourName => 'Dit navn';

  @override
  String get settingsSignOut => 'Log ud';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'fod/tommer';

  @override
  String get settingsHeightFt => 'fod';

  @override
  String get settingsHeightIn => 'tommer';

  @override
  String get settingsGenderMale => 'Mand';

  @override
  String get settingsGenderFemale => 'Kvinde';

  @override
  String get settingsGenderPreferNotToSay => 'Foretrækker ikke at sige det';

  @override
  String get settingsGenderOther => 'Andet';

  @override
  String get settingsYourProfile => 'Din profil';

  @override
  String get settingsNotSet => 'Ikke angivet';

  @override
  String settingsYears(Object value) {
    return '$value år';
  }

  @override
  String get settingsOff => 'Fra';

  @override
  String get settingsOn => 'Til';

  @override
  String get settingsNoneSet => 'Intet angivet';

  @override
  String settingsSupplementCount(Object count) {
    return '$count kosttilskud';
  }

  @override
  String get commonToday => 'I dag';

  @override
  String get mainShellHome => 'Hjem';

  @override
  String get mainShellLog => 'Log';

  @override
  String get mainShellProgress => 'Fremskridt';

  @override
  String get mainShellSettings => 'Indstillinger';

  @override
  String get mainShellLogShowcaseTitle =>
      'Registrer det, der betyder noget hver dag';

  @override
  String get mainShellLogShowcaseDescription =>
      'Registrer de aktiviteter, der betyder mest for dig, hver dag.';

  @override
  String get logMoodShowcaseTitle => 'Start med dit humør';

  @override
  String get logMoodShowcaseDescription =>
      'Registrer dit humør nu, og fortsæt med resten undervejs, så Glu kan spotte vaner og mønstre mere præcist.';

  @override
  String get mainShellProgressShowcaseTitle => 'Se dine fremskridt';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Tjek dine mønstre og tendenser for at forstå, hvordan dine vaner og din vægt ændrer sig over tid.';

  @override
  String get progressMenuShowcaseTitle => 'Udforsk dine data';

  @override
  String get progressMenuShowcaseDescription =>
      'Se alle grafer, læs AI-genererede indsigter, eller opret en lægerapport til at dele med dit behandlingsteam.';

  @override
  String get settingsFeedbackShowcaseTitle => 'Vi vil gerne høre fra dig';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Tryk her for at dele, hvad der virker, hvad der ikke gør det, eller idéer du har.';

  @override
  String get authCouldNotOpenLink => 'Kunne ikke åbne linket lige nu.';

  @override
  String get authWelcomeTitle => 'Welcome til Glu';

  @override
  String get authSubtitle => 'Secure sign-i for din wellness companion';

  @override
  String get authContinueWithGoogle => 'Fortsæt med Google';

  @override
  String get authContinueWithApple => 'Fortsæt med Apple';

  @override
  String get authEmailHint => 'navn@email.com';

  @override
  String get authSending => 'Sending...';

  @override
  String get authResendLink => 'Resend link';

  @override
  String get authUseDifferentEmail => 'Bruge en different email';

  @override
  String get habitGoalsTitle => 'Vane-mål';

  @override
  String get goalsProteins => 'Proteiner';

  @override
  String get goalsFibers => 'Fibers';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g per dag';
  }

  @override
  String get goalsWater => 'Vand';

  @override
  String goalsLitersPerDay(Object value) {
    return '${value}L per dag';
  }

  @override
  String get goalsExercise => 'Motion';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min per dag';
  }

  @override
  String get goalsMeals => 'Måltider';

  @override
  String get goalsCalories => 'Kalorier';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'per uge';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count måltider per dag';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal per dag';
  }

  @override
  String get goalsWeight => 'Vægt';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Tilføj en registrerged vægt til calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'Du are already ved denne target';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/uge til target';
  }

  @override
  String get goalsSetTargetForNextWeek => 'Sæt den target for næste uge.';

  @override
  String get progressWeightTitle => 'Vægt';

  @override
  String get progressWeightLabel => 'Vægt ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Sund BMI';

  @override
  String get progressTotal => 'Total';

  @override
  String get progressPercent => 'Procent';

  @override
  String get progressWeeklyAvg => 'Ugentligt gennemsnit';

  @override
  String get progressRangeAllTime => 'Hele tiden';

  @override
  String get progressRange1Month => '1 måned';

  @override
  String get progressRange3Months => '3 måneder';

  @override
  String get progressRange6Months => '6 måneder';

  @override
  String get progressLow => 'Lav';

  @override
  String get progressMed => 'Middel';

  @override
  String get progressHigh => 'Høj';

  @override
  String get progressSeverity => 'Alvorlighed';

  @override
  String get progressBad => 'Dårlig';

  @override
  String get progressOkay => 'Okay';

  @override
  String get progressGood => 'God';

  @override
  String get progressGreat => 'Rigtig god';

  @override
  String get progressMostlyBad => 'For det meste dårlig';

  @override
  String get progressMostlyOkay => 'For det meste okay';

  @override
  String get progressMostlyGood => 'For det meste god';

  @override
  String get progressMostlyGreat => 'For det meste rigtig god';

  @override
  String get progressNoDose => 'Ingen dosis';

  @override
  String get progressLogged => 'Registreret';

  @override
  String get progressAllClear => 'Alt i orden';

  @override
  String get progressFreq => 'Frekvens';

  @override
  String get progressAverage => 'Gennemsnit';

  @override
  String get progressDaily => 'Dagligt';

  @override
  String get progressWeekly => 'Ugentligt';

  @override
  String get progressMinutes => 'Minutter';

  @override
  String get progressIntensity => 'Intensitet';

  @override
  String get progressCalories => 'Kalorier';

  @override
  String get progressByDose => 'Efter dosis';

  @override
  String get progressWeightProgressTitle => 'Vægtfremskridt';

  @override
  String get progressWaterProgressTitle => 'Vandfremskridt';

  @override
  String get progressExerciseProgressTitle => 'Motionsfremskridt';

  @override
  String get progressDoseProgressTitle => 'Dosisfremskridt';

  @override
  String get progressMealsProgressTitle => 'Måltidsfremskridt';

  @override
  String get progressSymptomsProgressTitle => 'Symptomfremskridt';

  @override
  String get progressMoodProgressTitle => 'Humørfremskridt';

  @override
  String get progressCravingsProgressTitle => 'Trangfremskridt';

  @override
  String get progressResisted => 'Modstod';

  @override
  String get progressCravingsResistedSubtitle =>
      'Andel af registrerede trange, du modstod.';

  @override
  String get progressWeightChangeTitle => 'Vægtændring';

  @override
  String get progressTitle => 'Fremskridt';

  @override
  String get progressMenuViewAllInsights => 'Se alle analyser';

  @override
  String get progressMenuViewAllCharts => 'Se alle diagrammer';

  @override
  String get progressMenuCreateDoctorReport => 'Opret lægerapport';

  @override
  String get progressReportGenerating => 'Genererer din rapport…';

  @override
  String get progressReportError => 'Kunne ikke generere rapporten. Prøv igen.';

  @override
  String get progressReportPendingRetry =>
      'Din rapport kan stadig blive færdig om et øjeblik. Prøv igen.';

  @override
  String get progressReportOpenError =>
      'Din rapport blev oprettet, men vi kunne ikke åbne den. Prøv igen.';

  @override
  String get progressAllProgressTitle => 'Alt fremskridt';

  @override
  String get progressWeightTrendExplanation =>
      'Se hvordan din vægt ændrer sig over tid.';

  @override
  String get progressNoWeightLogsYet => 'Ingen vægtregistreringer endnu';

  @override
  String get progressNoLogsYet => 'Ingen registreringer endnu';

  @override
  String get progressLogWeightToStartTrend =>
      'Registrer vægt for at begynde at følge din tendens.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Registrer vægt og dosis for at sammenligne, hvordan dosen hænger sammen med ændringen.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Hvert punkt farves efter den seneste dosis før vejningen.';

  @override
  String get progressNoHydrationYet => 'Ingen hydrering endnu';

  @override
  String get progressNoMovementYet => 'Ingen aktivitet endnu';

  @override
  String get progressNoDoseLogsYet => 'Ingen dosisregistreringer endnu';

  @override
  String get progressNoMealsLoggedYet => 'Ingen registrerede måltider endnu';

  @override
  String get progressNoSymptomsLoggedYet =>
      'Ingen registrerede symptomer endnu';

  @override
  String get progressNoMoodLogsYet => 'Ingen humørregistreringer endnu';

  @override
  String get progressNoCravingsLoggedYet => 'Ingen trangregistreringer endnu';

  @override
  String get progressFutureTrendTitle => 'Fremtidig tendens';

  @override
  String get progressFutureTrendBody => 'En smuk tidslinje over dit momentum';

  @override
  String get progressGoal => 'Mål';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Din senest registrerede vægt er klar til at blive fulgt.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Omkring $gap $unit fra dit mål.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText i forhold til din tidligere registrering.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText i forhold til den tidligere registrering. $gap $unit fra målet.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Sammenlignet med din tidligere registrering er tendensen nu synlig.';

  @override
  String get progressWaterTitle => 'Vand';

  @override
  String get manageSubscriptionTitle => 'Administrer abonnement';

  @override
  String get manageSubscriptionProPlan => 'Pro-plan';

  @override
  String get manageSubscriptionFreePlan => 'Gratis plan';

  @override
  String get manageSubscriptionActiveCopy => 'Dit abonnement er aktivt.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Opgrader for at låse Glu Pro op.';

  @override
  String get manageSubscriptionPlan => 'Plan';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratis';

  @override
  String get manageSubscriptionProduct => 'Produkt';

  @override
  String get manageSubscriptionRenewal => 'Fornyelse';

  @override
  String get manageSubscriptionStatus => 'Status';

  @override
  String get manageSubscriptionStatusActive => 'Aktiv';

  @override
  String get manageSubscriptionStatusInactive => 'Ikke aktiv';

  @override
  String get manageSubscriptionManageButton => 'Administrer abonnement';

  @override
  String get manageSubscriptionUpgradeButton => 'Opgrader til Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Åbn butikkens abonnementsindstillinger';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Gendan køb';

  @override
  String get manageSubscriptionRenewsAutomatically => 'Fornyes automatisk';

  @override
  String get manageSubscriptionLifetime => 'Livstid';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Fornyes den $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Udløber den $date';
  }

  @override
  String get supplementReminderDayMon => 'Ma';

  @override
  String get supplementReminderDayTue => 'Ti';

  @override
  String get supplementReminderDayWed => 'On';

  @override
  String get supplementReminderDayThu => 'To';

  @override
  String get supplementReminderDayFri => 'Fr';

  @override
  String get supplementReminderDaySat => 'Lø';

  @override
  String get supplementReminderDaySun => 'Sø';

  @override
  String supplementReminderInDays(Object count) {
    return 'Om $count dage';
  }

  @override
  String get supplementReminderInOneWeek => 'Om 1 uge';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Om $count uger';
  }

  @override
  String get subscriptionDebugTitle => 'Glu-abonnementer';

  @override
  String get subscriptionDebugMonthly => 'Månedlig';

  @override
  String get subscriptionDebugYearly => 'Årlig';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Opdater kundeinfo';

  @override
  String get subscriptionDebugPresentPaywall => 'Vis betalingsmur';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Åbn kundecenter';

  @override
  String get subscriptionDebugRestorePurchases => 'Gendan køb';

  @override
  String get subscriptionDebugSyncPurchases => 'Synkroniser køb';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat-status';

  @override
  String get subscriptionDebugConfigured => 'Konfigureret';

  @override
  String get subscriptionDebugBusy => 'Optaget';

  @override
  String get subscriptionDebugAppUserId => 'App-bruger-ID';

  @override
  String get subscriptionDebugAnonymous => 'anonym';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-nøgle tilgængelig';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro aktiv';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Aktive abonnementer';

  @override
  String get subscriptionDebugManagementUrl => 'Administrations-URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Rettighedsprodukt';

  @override
  String get subscriptionDebugWillRenew => 'Fornys';

  @override
  String get subscriptionDebugExpiration => 'Udløb';

  @override
  String get subscriptionDebugLifetime => 'livstid';

  @override
  String get subscriptionDebugPackageFound => 'Pakke fundet';

  @override
  String get subscriptionDebugProductId => 'Produkt-ID';

  @override
  String get subscriptionDebugTitleLabel => 'Titel';

  @override
  String get subscriptionDebugPrice => 'Pris';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Køb $title';
  }

  @override
  String get progressExerciseTitle => 'Motion';

  @override
  String get progressDoseTitle => 'Dosis';

  @override
  String get progressMealsTitle => 'Måltider';

  @override
  String get progressSymptomsTitle => 'Symptomer';

  @override
  String get progressMoodTitle => 'Humør';

  @override
  String get progressCravingsTitle => 'Trang';

  @override
  String get progressTrend => 'Tendens';

  @override
  String get progressTarget => 'Mål';

  @override
  String get progressNoTrendYet => 'Ingen tendens endnu';

  @override
  String get progressNoActivityYet => 'Ingen aktivitet endnu';

  @override
  String get progressNoCheckInsYet => 'Ingen check-ins endnu';

  @override
  String get progressWeightSignatureChip => 'Vægt bliver dit signaturdiagram';

  @override
  String get progressWeightStartTrendTitle =>
      'Start din tendens med den første vejning';

  @override
  String get progressWeightStartTrendBody =>
      'Dette diagram er kernen i din fremskridtsfortælling. Registrer din første vægt for at låse op for momentum, milepæle og en visning, der er værd at dele.';

  @override
  String get progressWeightMomentum => 'Momentum';

  @override
  String get progressWeightMilestones => 'Milepæle';

  @override
  String get progressWeightShareReady => 'Klar til at dele';

  @override
  String get progressWeightLogWeight => 'Registrer vægt';

  @override
  String get weightProgressUnlocksViewChip =>
      'Din første vejning låser denne visning op';

  @override
  String get weightProgressStartsHereTitle =>
      'Din fremskridtshistorie starter her';

  @override
  String get weightProgressStartsHereBody =>
      'Registrer din første vægt for at låse op for tendenser, milepæle og dosisbevidste analyser i en visning, der er værd at dele.';

  @override
  String get weightProgressTrendView => 'Tendensvisning';

  @override
  String get weightProgressDoseOverlays => 'Dosislag';

  @override
  String get weightProgressMilestones => 'Milepæle';

  @override
  String get weightProgressLogWeight => 'Registrer vægt';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Tilføj først både et før- og efterfoto.';

  @override
  String get glowUpSavedToGallery => 'Gemt i dit galleri';

  @override
  String get glowUpSaveToGallery => 'Gem i galleri';

  @override
  String get glowUpYourProgress => 'Dine fremskridt';

  @override
  String get glowUpWeightChange => 'Vægtændring';

  @override
  String get glowUpTime => 'Tid';

  @override
  String get glowUpShare => 'Del';

  @override
  String get glowUpBefore => 'FØR';

  @override
  String get glowUpAfter => 'EFTER';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight på $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'dage';

  @override
  String get glowUpTimeUnitWeeksLabel => 'uger';

  @override
  String get glowUpTimeUnitMonthsLabel => 'måneder';

  @override
  String get glowUpTimeUnitYearsLabel => 'år';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dage',
      one: '$count dag',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uger',
      one: '$count uge',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count måneder',
      one: '$count måned',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count år',
      one: '$count år',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'I går';

  @override
  String get commonSelect => 'Vælg';

  @override
  String get doseReminderTitle => 'Dosispåmindelse';

  @override
  String get doseReminderCustomDoseTitle => 'Brugerdefineret dosis';

  @override
  String get doseReminderCustomDoseHint => 'Skriv dosis i mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Hold din næste dosis klar på hjem-skærmen.';

  @override
  String get doseReminderTime => 'Tidspunkt';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Slå dette til for at vise næste dosis på hjem-skærmen.';

  @override
  String get doseReminderSaveReminder => 'Gem påmindelse';

  @override
  String loggedOn(Object date) {
    return 'registrerged til $date';
  }

  @override
  String get waterLogSmallGlass => 'Lille glas';

  @override
  String get waterLogGlass => 'Glas';

  @override
  String get waterLogBottle => 'Flaske';

  @override
  String get waterLogLargeBottle => 'Stor flaske';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Brugerdefineret';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dosis';

  @override
  String get doseLogEditTitle => 'Rediger dosis';

  @override
  String get doseLogLogTitle => 'Registrer dosis';

  @override
  String get doseLogCustomDose => 'Brugerdefineret dosis';

  @override
  String get doseLogCustomDoseBody =>
      'Juster dosis i mg for denne registrering.';

  @override
  String get doseLogUseThisDose => 'Brug denne dosis';

  @override
  String get doseLogMedication => 'Medicin';

  @override
  String get doseLogInjectionSite => 'Sted';

  @override
  String get doseLogNotes => 'Noter';

  @override
  String get doseLogSaveChanges => 'Gem ændringer';

  @override
  String get doseLogAddDose => '+ Registrer dosis';

  @override
  String get doseLogDeleteTitle => 'Slet denne dosisregistrering?';

  @override
  String get doseLogDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get doseLogDeleteLog => 'Slet registrering';

  @override
  String get doseLogSaving => 'Gemmer...';

  @override
  String get doseLogCouldNotSave =>
      'Kunne endnu ikke gemme denne dosisregistrering.';

  @override
  String get doseLogCouldNotDelete =>
      'Kunne endnu ikke slette denne dosisregistrering.';

  @override
  String get doseLogDeleted => 'Dosis slettet';

  @override
  String get doseLogAddedToDoseLog => 'Tilføjet til din dosislog';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Er der noget værd at huske om denne dosis?';

  @override
  String get doseLogDoseLabel => 'Dosis';

  @override
  String get exerciseLogTitle => 'Motion';

  @override
  String get exerciseLogEditTitle => 'Rediger motion';

  @override
  String get exerciseLogLogTitle => 'Registrer motion';

  @override
  String get exerciseLogActivityType => 'Aktivitetstype';

  @override
  String get exerciseLogCustomActivity => 'Brugerdefineret aktivitet';

  @override
  String get exerciseLogTypeActivity => 'Skriv aktiviteten';

  @override
  String get exerciseLogDuration => 'Varighed';

  @override
  String get exerciseLogIntensity => 'Intensitet';

  @override
  String get exerciseLogNotes => 'Noter';

  @override
  String get exerciseLogLight => 'Let';

  @override
  String get exerciseLogModerate => 'Moderat';

  @override
  String get exerciseLogIntense => 'Intens';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min registreret';
  }

  @override
  String get exerciseLogSaveChanges => 'Gem ændringer';

  @override
  String get exerciseLogAddExercise => '+ Tilføj motionsregistrering';

  @override
  String get exerciseLogDeleteTitle => 'Slet denne motionsregistrering?';

  @override
  String get exerciseLogDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get exerciseLogDeleteLog => 'Slet registrering';

  @override
  String get exerciseLogSaving => 'Gemmer...';

  @override
  String get exerciseLogCouldNotSave =>
      'Kunne endnu ikke gemme denne motionsregistrering.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Kunne endnu ikke slette denne motionsregistrering.';

  @override
  String get exerciseLogDeleted => 'Motion slettet';

  @override
  String get exerciseLogAddedToExerciseLog => 'Tilføjet til din motionslog';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Er der noget værd at huske om denne session?';

  @override
  String get exerciseLogWalking => 'Gåtur';

  @override
  String get exerciseLogRunning => 'Løb';

  @override
  String get exerciseLogCycling => 'Cykling';

  @override
  String get exerciseLogStrength => 'Styrketræning';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Svømning';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Vægt';

  @override
  String get weightLogEditTitle => 'Rediger vægt';

  @override
  String get weightLogLogTitle => 'Registrer vægt';

  @override
  String get weightLogSaveChanges => 'Gem ændringer';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Tilføj vægt ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Slet denne vægtregistrering?';

  @override
  String get weightLogDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get weightLogDeleteLog => 'Slet registrering';

  @override
  String get weightLogSaving => 'Gemmer...';

  @override
  String get weightLogCouldNotSave =>
      'Kunne endnu ikke gemme denne vægtregistrering.';

  @override
  String get weightLogCouldNotDelete =>
      'Kunne endnu ikke slette denne vægtregistrering.';

  @override
  String get weightLogDeleted => 'Vægt slettet';

  @override
  String get weightLogAddedToWeightLog => 'Tilføjet til din vægtlog';

  @override
  String get weightLogNoWeightForDay =>
      'Der er endnu ikke registreret nogen vægt for denne dag.';

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
  String get doseReminderInjection => 'Injektion';

  @override
  String get doseReminderPill => 'Pille';

  @override
  String get doseReminderSite => 'Sted';

  @override
  String get doseReminderDate => 'Dato';

  @override
  String get supplementReminderTitle => 'Kosttilskudspåmindelse';

  @override
  String get supplementReminderAddSupplement => 'Tilføj kosttilskud';

  @override
  String get supplementReminderNoSupplementsYet => 'Ingen kosttilskud endnu';

  @override
  String get supplementReminderAddFirstBody =>
      'Tilføj din første kosttilskudspåmindelse for at holde styr på dit daglige indtag.';

  @override
  String get supplementReminderSupplementFallback => 'Kosttilskud';

  @override
  String get supplementReminderEveryDay => 'Hver dag';

  @override
  String get supplementReminderEveryXDaysLabel => 'Hver X dag';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Hver $interval dag';
  }

  @override
  String get supplementReminderNoDaysSet => 'Ingen dage valgt';

  @override
  String get supplementReminderSupplementName => 'Navn på kosttilskud';

  @override
  String get supplementReminderTime => 'Tidspunkt';

  @override
  String get supplementReminderStartDate => 'Startdato';

  @override
  String get supplementReminderRepeat => 'Gentag';

  @override
  String get supplementReminderDaysOfWeek => 'Ugedage';

  @override
  String get supplementReminderSelectAtLeastOneDay => 'Vælg mindst én dag.';

  @override
  String get supplementReminderEvery => 'Hver';

  @override
  String get supplementReminderDay => 'dag';

  @override
  String get supplementReminderDays => 'dage';

  @override
  String get supplementReminderAdd => 'Tilføj';

  @override
  String get symptomsLogTitle => 'Symptomer';

  @override
  String get symptomsLogEditTitle => 'Rediger symptomer';

  @override
  String get symptomsLogLogTitle => 'Registrer symptomer';

  @override
  String get symptomsLogSymptomsExperienced => 'Oplevede symptomer';

  @override
  String get symptomsLogNoSymptoms => 'Ingen symptomer';

  @override
  String get symptomsLogNoSymptomsToday => 'Ingen symptomer i dag';

  @override
  String get symptomsLogOther => 'Andet...';

  @override
  String get symptomsLogSeverityLevel => 'Sværhedsgrad';

  @override
  String get symptomsLogNotes => 'Noter';

  @override
  String get symptomsLogAnxiety => 'Angst';

  @override
  String get symptomsLogBelching => 'Bøvsen';

  @override
  String get symptomsLogBloating => 'Oppustethed';

  @override
  String get symptomsLogConstipation => 'Forstoppelse';

  @override
  String get symptomsLogDiarrhea => 'Diarré';

  @override
  String get symptomsLogFatigue => 'Træthed';

  @override
  String get symptomsLogFoodNoise => 'Madstøj';

  @override
  String get symptomsLogHairLoss => 'Hårtab';

  @override
  String get symptomsLogHeartburn => 'Halsbrand';

  @override
  String get symptomsLogIndigestion => 'Fordøjelsesbesvær';

  @override
  String get symptomsLogInjectionSiteReaction => 'Reaktion ved injektionssted';

  @override
  String get symptomsLogMetallicTaste => 'Metalsmag';

  @override
  String get symptomsLogHeadache => 'Hovedpine';

  @override
  String get symptomsLogMoodSwings => 'Humørsvingninger';

  @override
  String get symptomsLogNausea => 'Kvalme';

  @override
  String get symptomsLogReflux => 'Refluks';

  @override
  String get symptomsLogStomachPain => 'Mavesmerter';

  @override
  String get symptomsLogSuppressedAppetite => 'Nedsat appetit';

  @override
  String get symptomsLogVomiting => 'Opkast';

  @override
  String get symptomsLogLogged => 'Symptomer registreret';

  @override
  String get symptomsLogMild => 'Mild';

  @override
  String get symptomsLogModerate => 'Moderat';

  @override
  String get symptomsLogSevere => 'Svær';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Er der noget værd at huske om, hvordan du havde det?';

  @override
  String get symptomsLogSaveChanges => 'Gem ændringer';

  @override
  String get symptomsLogAddSymptoms => '+ Tilføj symptomregistrering';

  @override
  String get symptomsLogDeleteTitle => 'Slet denne symptomregistrering?';

  @override
  String get symptomsLogDeleteMessage => 'Denne handling kan ikke fortrydes.';

  @override
  String get symptomsLogDeleteLog => 'Slet registrering';

  @override
  String get symptomsLogSaving => 'Gemmer...';

  @override
  String get symptomsLogCouldNotSave =>
      'Kunne endnu ikke gemme denne symptomregistrering.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Kunne endnu ikke slette denne symptomregistrering.';

  @override
  String get symptomsLogDeleted => 'Symptomer slettet';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Tilføjet til din symptomlog';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% af det daglige mål';
  }

  @override
  String get commonDisclaimer =>
      'Glu er et trackingværktøj, ikke et medicinsk udstyr. Det giver ikke medicinsk rådgivning, diagnose eller behandling. Tal altid med din læge om din medicin og dine sundhedsbeslutninger.';
}
