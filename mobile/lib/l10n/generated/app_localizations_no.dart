// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Starter opp...';

  @override
  String get startupFailed => 'Oppstart mislyktes';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonSave => 'Lagre';

  @override
  String get commonSaving => 'Lagrer...';

  @override
  String get commonContinue => 'Fortsett';

  @override
  String get commonSkip => 'Hopp over';

  @override
  String get commonDelete => 'Slett';

  @override
  String get commonNotNow => 'Ikke nå';

  @override
  String get commonNow => 'Nå';

  @override
  String get commonTomorrow => 'I morgen';

  @override
  String get noteTriggerAddNote => 'Legg til notat';

  @override
  String get noteTriggerCancelNote => 'Avbryt notat';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'Om $count dager';
  }

  @override
  String get homeDoseReminderInOneWeek => 'Om 1 uke';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'Om $count uker';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Forfalt for 1 dag siden';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Forfalt for $count dager siden';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Forfalt for 1 uke siden';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Forfalt for $count uker siden';
  }

  @override
  String get bmiIndicatorYourBmi => 'Din BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Din nåværende BMI';

  @override
  String get bmiIndicatorUnderweight => 'Undervektig';

  @override
  String get bmiIndicatorNormal => 'Normal';

  @override
  String get bmiIndicatorOverweight => 'Overvektig';

  @override
  String get bmiIndicatorObesity => 'Fedme';

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
  String get logNoteIndicatorHasNote => 'Har notat';

  @override
  String get paywallTitle => 'Lås opp Glu Pro';

  @override
  String get paywallSubtitle => 'Uten Pro mister du dette:';

  @override
  String get paywallMonthlyTitle => 'Månedlig';

  @override
  String get paywallMonthlySubtitle => 'Faktureres hver måned';

  @override
  String get paywallYearlyTitle => 'Årlig';

  @override
  String get paywallYearlySubtitle => 'Best verdi';

  @override
  String get paywallNoCommitment => 'Ingen binding';

  @override
  String get paywallCancelAnytime => 'Avbryt når som helst';

  @override
  String get paywallContinue => 'Fortsett';

  @override
  String get paywallRestore => 'Gjenopprett kjøp';

  @override
  String get paywallTerms => 'Vilkår';

  @override
  String get paywallPrivacy => 'Personvern';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Lagre $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Kunne ikke åpne lenken nå.';

  @override
  String get paywallAlreadySubscribed => 'Du har allerede Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Velkommen til Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'Kjøpet ble ikke fullført. Prøv igjen.';

  @override
  String get paywallPurchaseFailed => 'Kjøpet mislyktes. Prøv igjen.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Kjøp mislyktes: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Abonnementet er gjenopprettet!';

  @override
  String get paywallRestoreNoSubscription => 'Ingen aktivt abonnement funnet.';

  @override
  String get paywallRestoreFailed => 'Gjenoppretting mislyktes. Prøv igjen.';

  @override
  String get paywallBenefitReminders => 'Gå glipp av doser uten påminnelser';

  @override
  String get paywallBenefitShareProgress =>
      'Vanskeligere å dele fremgangen din';

  @override
  String get paywallBenefitSpotRegain => 'Tegn på vektoppgang går ubemerket';

  @override
  String get paywallBenefitInsights => 'Går glipp av dine daglige mønstre';

  @override
  String get paywallBenefitWeeklyGoals => 'Mister din ukentlige struktur';

  @override
  String get paywallBenefitHealthyHabits => 'Vaner glir unna uten støtte';

  @override
  String get onboardingWelcomeTitle => 'Hold vekten nede på en smart måte';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu hjelper deg å følge fremgangen din rundt behandling, mål og ukentlige vaner.';

  @override
  String get onboardingWelcomeBullet1 => 'Passer behandlingen og målene dine';

  @override
  String get onboardingWelcomeBullet2 => 'Enkel og realistisk støtte';

  @override
  String get onboardingWelcomeBullet3 => 'Oppdag tidlige tegn på vektoppgang';

  @override
  String get onboardingWelcomeBullet4 => 'Fortsett uten å starte på nytt';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Bruker du for tiden en penn- eller pillemedisin for vektnedgang?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Vi bruker dette for å vise veiledning som passer der du er nå.';

  @override
  String get onboardingMedicationStatusUsing => 'Ja, jeg bruker det nå';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Ja, jeg trapper ned';

  @override
  String get onboardingMedicationStatusNotTaking => 'Nei, jeg bruker det ikke';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'Nei, jeg skal starte snart';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Nei, jeg sluttet nylig';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Hvordan tar du medisinen din?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Vi bruker dette for å tilpasse instruksjoner og påminnelser til medisinformen din.';

  @override
  String get onboardingMedicationMethodInjection => 'Injeksjon';

  @override
  String get onboardingMedicationMethodPill => 'Pille';

  @override
  String get onboardingMedicationMethodUnknown => 'Jeg vet ikke ennå';

  @override
  String get onboardingMedicationNameQuestion => 'Hvilken medisin bruker du?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Vi bruker dette for å personalisere doseoppfølging og medisinspecifikk veiledning.';

  @override
  String get onboardingCurrentDoseQuestion => 'Hva er din nåværende dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Vi bruker dette for å tilpasse doseoppfølging og fremtidige fremgangssjekker.';

  @override
  String get onboardingMedicationCustomDose => 'Tilpasset';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Hvilket hjelpemiddel bruker du for å ta medisinen din?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Vi bruker dette for å gjøre påminnelser og tips tilpasset måten du tar det på.';

  @override
  String get onboardingDeviceSinglePen => 'Én penn';

  @override
  String get onboardingDeviceAutoInjector => 'Autoinjektor';

  @override
  String get onboardingDeviceSyringeAndVial => 'Sprøyte og hetteglass';

  @override
  String get onboardingOther => 'Annet';

  @override
  String get onboardingTypeYourDevice => 'Skriv inn hjelpemiddelet ditt';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Hvor ofte tar du medisinen din?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Vi bruker dette for å time påminnelser og rutinehjelp etter planen din.';

  @override
  String get onboardingEveryDay => 'Hver dag';

  @override
  String get onboardingEvery7Days => 'Hver 7. dag';

  @override
  String get onboardingEvery14Days => 'Hver 14. dag';

  @override
  String get onboardingCustom => 'Tilpasset';

  @override
  String get onboardingDaysBetweenDoses => 'Dager mellom dosene';

  @override
  String get onboardingPrimaryGoalQuestion => 'Hva er hovedmålet ditt nå?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Vi bruker dette for å fokusere planen, påminnelsene og fremgangen din rundt det som betyr mest for deg.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Vi bruker dette for å forme planen din fra starten av.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Vi bruker dette for å støtte neste fase og hjelpe deg å holde deg på sporet.';

  @override
  String get onboardingGoalLoseWeight => 'Gå ned i vekt';

  @override
  String get onboardingGoalMaintainWeight => 'Holde vekten';

  @override
  String get onboardingGoalManageDiabetes => 'Håndtere diabetesen min';

  @override
  String get onboardingGoalManagePcos => 'Håndtere PCOS-en min';

  @override
  String get onboardingGoalImproveHeartHealth => 'Forbedre hjertehelsen min';

  @override
  String get onboardingAgeQuestion => 'Hvor gammel er du?';

  @override
  String get onboardingAgeExplainer =>
      'Vi bruker dette for å tilpasse veiledning og helseberegninger mer presist.';

  @override
  String get onboardingHeightQuestion => 'Hvor høy er du?';

  @override
  String get onboardingHeightExplainer =>
      'Vi bruker dette sammen med vekten din for å beregne ting som BMI og sunne intervaller.';

  @override
  String get onboardingWeightQuestion => 'Hva er din nåværende vekt?';

  @override
  String get onboardingWeightExplainer =>
      'Vi bruker dette som utgangspunkt for fremgang, mål og helsesanslag.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Når sluttet du med medisinen?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Når begynte du å trappe ned medisinen?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Når begynte du med medisinen?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Vi bruker dette for å forstå den siste behandlingshistorikken og neste fase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Vi bruker dette for å forstå overgangsfasen din og støtte vanene som betyr mest nå.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Vi bruker dette for å forstå hvor lenge du har vært i behandling og følge endringer over tid.';

  @override
  String get onboardingGoalWeightQuestion => 'Hva er målvekten din?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Vi bruker dette for å sette fremgangen i kontekst og vise et mål-BMI-intervall for deg.';

  @override
  String get onboardingBenefitsQuestion => 'Hva Glu vil hjelpe deg med videre';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu gjør det du delte om til påminnelser, støtte og struktur som passer rutinen din.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Slik kan Glu hjelpe deg å opprettholde fremgangen din';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Slik kan Glu støtte diabetesrutinene dine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Slik kan Glu støtte PCOS-rutinene dine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Slik kan Glu støtte hjertehelsen din';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Slik kan Glu hjelpe deg å gå ned i vekt';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Se hvordan Glu hjelper deg å beskytte nåværende vekt og oppdage vektoppgang tidlig.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Se hvordan Glu hjelper deg å holde måltider, vekt og rutiner mer stabile fra uke til uke.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Se hvordan Glu hjelper deg å holde deg mer stabil rundt symptomer, vekt og rutine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Se hvordan Glu hjelper deg å være konsekvent med vanene som støtter hjertehelsen.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Se hvordan Glu hjelper deg å oppdage mønstrene som får vekten til å gå ned.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Uten struktur kan vektoppgang bygge seg opp i det stille. Glu hjelper deg å oppdage det tidligere og holde deg stabil.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Uten struktur blir mønstrene i måltider og vekt utydelige. Glu holder signalene klarere.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Uten struktur kan symptomer og rutiner svinge mer. Glu hjelper deg å holde deg mer stabil.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Uten struktur sklir sunne vaner ut. Glu hjelper deg å holde aktivitet og vekt på sporet.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Uten struktur kan vekten stagnere eller gå opp igjen. Glu hjelper fremgangen å fortsette i riktig retning.';

  @override
  String get onboardingBenefitsAxisWeight => 'Vekt';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Måltider og vekt';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptomer og vekt';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Trening og vekt';

  @override
  String get onboardingNotificationsQuestion =>
      'Slå på påminnelser som støtter målet ditt';

  @override
  String get onboardingNotificationsExplainer =>
      'Vi bruker varsler for å hjelpe deg å være konsekvent, forberedt og på sporet.';

  @override
  String get onboardingNotificationsHeadline =>
      'Sett opp Glu til å hjelpe på riktig tidspunkt.';

  @override
  String get onboardingNotificationsBody =>
      'Slå på varsler så Glu kan forsterke vanene som støtter målet ditt.';

  @override
  String get onboardingNotificationsDaily =>
      'Tidsbestemte påminnelser som passer din daglige medisinrytme';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Påminnelser lenger frem i tid, så dosedagene ikke kommer overraskende.';

  @override
  String get onboardingNotificationsCustom =>
      'Påminnelser tilpasset din egen timeplan';

  @override
  String get onboardingNotificationsWeekly =>
      'Dosepåminnelser som følger den ukentlige rytmen din';

  @override
  String get onboardingNotificationsSupportive =>
      'Støttende påminnelser som holder rutinen synlig når motivasjonen daler';

  @override
  String get onboardingNotificationsProgress =>
      'Tidsriktige dytt rundt fremgang, vaner og målene du sa betyr mest';

  @override
  String get onboardingNotificationsHelpful =>
      'Nyttige påminnelser som gjør Glu mer nyttig i øyeblikkene du trenger det';

  @override
  String get onboardingDailyRoutineQuestion =>
      'Hvordan ser den daglige rutinen din ut?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Vi bruker dette for å gjøre planen din realistisk i hverdagen.';

  @override
  String get onboardingRoutineSedentary => 'Stillesittende';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'For det meste stillesittende, kontorarbeid og veldig lite bevisst trening.';

  @override
  String get onboardingRoutineLightlyActive => 'Litt aktiv';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regelmessig gange, ærender eller lette økter noen ganger i uken.';

  @override
  String get onboardingRoutineActive => 'Aktiv';

  @override
  String get onboardingRoutineActiveDescription =>
      'Hyppig bevegelse eller trening, som daglige turer, trening eller aktivt arbeid.';

  @override
  String get onboardingRoutineVeryActive => 'Veldig aktiv';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard trening, fysisk krevende arbeid eller høy aktivitet de fleste dager.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Hvilke symptomer er du mest bekymret for, hvis noen?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Vi bruker dette for å prioritere tips og veiledning rundt symptomene du bryr deg mest om.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Vi bruker dette for å fokusere på symptomene du vil ligge i forkant av.';

  @override
  String get onboardingGenderQuestion => 'Hvordan beskriver du kjønnet ditt?';

  @override
  String get onboardingGenderExplainer =>
      'Vi bruker dette for mer relevant veiledning og fremtidig personalisering.';

  @override
  String get onboardingGenderFemale => 'Kvinne';

  @override
  String get onboardingGenderMale => 'Mann';

  @override
  String get onboardingGenderPreferNotToSay => 'Foretrekker å ikke si';

  @override
  String get onboardingTypeYourGender => 'Skriv inn kjønnet ditt';

  @override
  String get onboardingPreferredNameQuestion => 'Hva skal vi kalle deg?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Vi bruker dette for å gjøre Glu mer personlig når vi snakker med deg.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Setter opp planen din';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Vi gjør det du delte om til en plan Glu kan støtte med en gang.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Låser inn mål for vektvedlikehold...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Setter opp varsler for vektoppgang...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Finjusterer påminnelser rundt rutinen din...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Forbereder en mer stabil ukentlig plan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Definerer mønstre for måltider og vekt...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 => 'Setter opp væskestøtte...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Forbereder konsekvenspåminnelser...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Bygger en tydeligere dagsstruktur...';

  @override
  String get onboardingSetupSummaryPcosStep1 => 'Organiserer symptomstøtte...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Definerer ukentlige bevegelsesmål...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Setter opp drikke- og rutineankre...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Forbereder en mer stabil plan...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'Setter aktivitetsmål...';

  @override
  String get onboardingSetupSummaryHeartStep2 => 'Definerer væskestøtte...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Forbereder ukentlige vane-påminnelser...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Bygger en rutine for hjertehelse...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Definerer kalori-rammer...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 => 'Setter vannmengder...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 => 'Bygger bevegelsesmål...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Forbereder den ukentlige planen din...';

  @override
  String get onboardingSetupSummaryHeadline => 'Glu-oppsettet ditt er klart.';

  @override
  String get onboardingSetupLoadingTitle => 'Bygger oppsettet ditt';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu er klar til å hjelpe deg å beskytte fremgangen din med tydeligere struktur og tidligere signaler om vektoppgang.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu er klar til å støtte mer stabile måltider, vektoppfølging og vaner som betyr noe i hverdagen.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu er klar til å støtte mer stabile rutiner rundt symptomer, behandling og fremgang.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu er klar til å forsterke vanene som støtter den langsiktige hjertehelsen din.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu er klar til å støtte rutinene som hjelper deg å holde vekten nede.';

  @override
  String get onboardingSetupSummaryLabel => 'Sammendrag';

  @override
  String get onboardingSetupAdjustLater =>
      'Du kan justere alt dette senere i Innstillinger.';

  @override
  String get onboardingSummaryGoal => 'Mål';

  @override
  String get onboardingSummaryCurrentWeight => 'Nåværende vekt';

  @override
  String get onboardingSummaryMedication => 'Medisin';

  @override
  String get onboardingSummaryCurrentDose => 'Nåværende dose';

  @override
  String get onboardingSummaryCadence => 'Frekvens';

  @override
  String get onboardingSummaryStarted => 'Startet';

  @override
  String get onboardingSummaryTargetWeight => 'Målvekt';

  @override
  String get onboardingSummaryRoutine => 'Rutine';

  @override
  String get onboardingSummaryFocus => 'Fokus';

  @override
  String get onboardingFrequencyEveryDay => 'Hver dag';

  @override
  String get onboardingFrequencyEveryWeek => 'Hver uke';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Hver 2. uke';

  @override
  String get onboardingFrequencyCustomSchedule => 'Tilpasset plan';

  @override
  String get onboardingTapOptionContinue =>
      'Trykk på et alternativ for å fortsette.';

  @override
  String get onboardingTypeGenderContinue => 'Skriv inn kjønn for å fortsette.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Skriv inn hjelpemiddelet ditt for å fortsette.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Skriv inn medisinen din for å fortsette.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Skriv inn dager mellom doser for å fortsette.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Velg en tidsplan for å fortsette.';

  @override
  String get onboardingScrollChooseAge => 'Scroll for å velge alderen din.';

  @override
  String get onboardingDragOrTapHeight =>
      'Dra eller trykk på linjalen for å velge høyden din.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Dra, trykk eller bruk trinnknappene for å velge en vekt.';

  @override
  String get onboardingPickDateAndWeight =>
      'Velg en dato og en vekt for å fortsette.';

  @override
  String get onboardingSelectSymptoms =>
      'Velg symptomer du vil at Glu skal fokusere på.';

  @override
  String get onboardingTypeName => 'Skriv inn navnet du vil at Glu skal bruke.';

  @override
  String get onboardingSaving => 'Lagrer...';

  @override
  String get onboardingLetsBegin => 'La oss begynne';

  @override
  String get onboardingContinueWithGlu => 'Fortsett med Glu';

  @override
  String get onboardingKeepGoing => 'Fortsett';

  @override
  String get onboardingTurnOnNotifications => 'Slå på varsler';

  @override
  String get onboardingFinish => 'Fullfør';

  @override
  String get onboardingTargetBmiTitle => 'Ditt mål-BMI';

  @override
  String get onboardingChartToday => 'I dag';

  @override
  String get onboardingChartOverTime => 'Over tid';

  @override
  String get onboardingChartWithoutGlu => 'Uten Glu';

  @override
  String get onboardingChartWithGlu => 'Med Glu';

  @override
  String get onboardingReviewQuestion =>
      'Folk bruker Glu for å holde seg stabile og støttet';

  @override
  String get onboardingReviewExplainer =>
      'En rask vurdering hjelper flere å finne støtte som føles like enkel.';

  @override
  String get onboardingReviewBody =>
      'Folk bruker Glu for å føle seg mer støttet, mer konsekvente og mindre alene i prosessen.';

  @override
  String get onboardingTypeYourMedication => 'Skriv inn medisinen din';

  @override
  String get onboardingSelectStartDate => 'Velg startdato';

  @override
  String get goalsSaveDialogTitle => 'Lagre mål?';

  @override
  String get goalsSaveDialogMessage =>
      'Du har ulagrede målendringer. Vil du lagre dem før du forlater denne fanen?';

  @override
  String get commonLater => 'Senere';

  @override
  String get homeGreetingAnonymous => 'Hei';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hei, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Logg i dag for å få innsikten din';

  @override
  String get homeInsightEmptyBody =>
      'Logg noe i dag, så ser du innsikten din i kveld.';

  @override
  String get homeInsightLogTodayTitle => 'Trykk for å se innsikten din';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Trykk for å se dagens innsikt';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Loggene dine begynner å vise et mønster — trykk for å se det.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Trykk for å se innsikten din';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Noen få logger til kan gjøre bildet mye klarere — trykk når som helst.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Trykk for å avdekke dagens innsikt';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Det kan allerede ligge et mønster skjult i dagen din — trykk for å se.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Logg noe i dag, og trykk deretter for å se hva det avslører.';

  @override
  String get homeInsightExpandedTitle => 'Var dette nyttig?';

  @override
  String get homeInsightExpandedBody =>
      'En rask vurdering hjelper Glu å lære hva som betyr mest for deg.';

  @override
  String get homeInsightReasonHint => 'Hva kunne vært bedre? (valgfritt)';

  @override
  String get homeInsightReasonSubmit => 'Send inn';

  @override
  String get homeInsightLearningMessage => 'Jeg lærer av dette.';

  @override
  String get homeInsightChecking => 'Sjekker dagens innsikt...';

  @override
  String get homeInsightGenerating => 'Laster dagens innsikt...';

  @override
  String get homeInsightTryAgain => 'Prøv igjen';

  @override
  String get homeSeeAllInsights => 'Vis alle innsikter';

  @override
  String get insightsProgressTitle => 'Alle innsikter';

  @override
  String get insightsProgressEmptyState =>
      'Innsiktene dine vises her når de er generert.';

  @override
  String get homeDoseReminderTitle => 'Dosepåminnelse';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Logg $label-interaksjon her.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Kalorimål kreves';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Porsjonssjekk trenger et måltidsmål satt til kalorier for å anslå porsjonen din. Sett opp ett i Mål for å komme i gang.';

  @override
  String get homeSetGoal => 'Sett mål';

  @override
  String get homeYourProgress => 'Din fremgang';

  @override
  String get homeRemindersShowcaseTitle => 'Hold deg på sporet';

  @override
  String get homeRemindersShowcaseDescription =>
      'Sett opp påminnelser for å holde doser og kosttilskudd i tide.';

  @override
  String get homePickNextDoseDate => 'Velg dato for neste dose';

  @override
  String get homeSetReminder => 'Sett påminnelse';

  @override
  String get homeSupplementReminders => 'Kosttilskuddpåminnelser';

  @override
  String get homeNoUpcomingSupplements => 'Ingen flere kommende';

  @override
  String get homeNoMoreUpcomingSupplements => 'Ingen flere kommende';

  @override
  String get homeSetUpYourSupplements => 'Sett opp kosttilskuddene dine';

  @override
  String get homeSetUp => 'Sett opp';

  @override
  String get homeSupplementFallback => 'Kosttilskudd';

  @override
  String get doseReminderNotificationTitle => 'Klar for dosen din?';

  @override
  String get doseReminderFallbackBody => 'Åpne Glu for å se neste dose.';

  @override
  String get supplementReminderNotificationTitle =>
      'Tid for kosttilskuddet ditt';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'I morges';

  @override
  String get supplementReminderThisAfternoon => 'I ettermiddag';

  @override
  String get supplementReminderTonight => 'I kveld';

  @override
  String get dailyReminderMorningTitle => 'Morgenpåminnelse';

  @override
  String get dailyReminderMorningBodies =>
      'Morgenoppdrag: gi Glu litt data å jobbe med.\nStart dagen med en rask logg og god fart.\nStå opp og logg. Fremtidige deg vil sette pris på det.\nStart dagen med en liten oppdatering og et stort forsprang.\nGi Glu et morgenhint og fortsett fremover.\nEn rask logg nå kan gjøre dagen mye mer interessant.\nLa oss få morgenen til å telle med en rask innsjekk.';

  @override
  String get dailyReminderMiddayTitle => 'Middagspåminnelse';

  @override
  String get dailyReminderMiddayBodies =>
      'Middagspause: legg inn en rask logg og fortsett i rolig tempo.\nLunsjpause? Perfekt tidspunkt å gi Glu en oppdatering.\nHalvveis. Gi Glu et raskt hint.\nEn liten logg midt på dagen kan holde historien i gang.\nSjekk inn nå og la dagen rulle videre.\nGi dagen et lite dytt med en rask oppdatering.\nHold energien oppe med et raskt trykk midt på dagen.';

  @override
  String get dailyReminderAfternoonTitle => 'Ettermiddagspåminnelse';

  @override
  String get dailyReminderAfternoonBodies =>
      'Nesten ferdig. Gi Glu en siste brødsmule.\nEn rask logg på ettermiddagen kan gjøre kveldens innsikt ekstra tydelig.\nAvslutt dagen med en liten oppdatering og en stor gevinst.\nÉn logg til før dagen er over?\nHjelp Glu å knytte prikkene sammen med en rask ettermiddagsinnsjekk.\nLukk loopen med en liten logg og hold magien i gang.\nEt siste trykk nå kan gjøre kveldens innsikt mye bedre.';

  @override
  String get homePortionCheckTitle => 'Porsjonssjekk';

  @override
  String get homePortionCheckBody =>
      'Finn ut hvor mye du skal spise til hvert måltid';

  @override
  String get homeGlowUpTitle => 'Din\nforvandling';

  @override
  String get homeGlowUpBody => 'Lag din før-og-etter-historie';

  @override
  String get homeDoctorReportTitle => 'Legerapport';

  @override
  String get homeDoctorReportBody => 'Del fremgangen din med legen din';

  @override
  String get doctorReportViewerRenderError =>
      'Kunne ikke vise rapporten. Prøv igjen.';

  @override
  String get doctorReportViewerShare => 'Del';

  @override
  String get homeGoalsStatusTitle => 'Dagens mål';

  @override
  String get homeGoalsStatusViewAll => 'Vis alle';

  @override
  String get homeWaterTitle => 'Vann';

  @override
  String get homeWeightTitle => 'Vekt';

  @override
  String get homeExerciseTitle => 'Bevegelse';

  @override
  String get homeMealsTitle => 'Måltider';

  @override
  String get homeCaloriesTitle => 'Kalorier';

  @override
  String get homeProteinsTitle => 'Proteiner';

  @override
  String get homeFibersTitle => 'Fiber';

  @override
  String get homeSymptomsTitle => 'Symptomer';

  @override
  String get homeMoodTitle => 'Humør';

  @override
  String get homeCravingsTitle => 'Sug';

  @override
  String get homeDoseTitle => 'Dose';

  @override
  String get homeMedicationLevelTitle => 'Estimert medisinnivå';

  @override
  String get homeMedicationLevelInfoTitle => 'Slik leser du denne grafen';

  @override
  String get homeMedicationLevelInfoBody =>
      'Denne grafen estimerer hvor mye av medisinen din som fortsatt kan være aktiv, basert på dosene du har registrert og medisinens halveringstid.\n\nHøyere punkter betyr vanligvis en nyere eller større dose. Linjen synker over tid etter hvert som medisinen forsvinner fra kroppen din.\n\nBruk dette som en trendvisning, ikke som en nøyaktig måling eller medisinsk anbefaling.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Skjønner';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Registrer dosene dine slik at Glu kan estimere hvor mye medisin som fortsatt er aktiv i kroppen din.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'av siste topp';

  @override
  String get homeMedicationLevelActiveNow => 'Aktiv nå';

  @override
  String get homeMedicationLevelHalfLife => 'Halveringstid';

  @override
  String get homeMedicationLevelLastDose => 'Siste dose';

  @override
  String get homeStartHydration => 'Start med vann';

  @override
  String get homeLogFirstSession => 'Logg din første økt';

  @override
  String get homeLogTodayWeight => 'Logg vekten din i dag';

  @override
  String get homeAtYourTarget => 'Du er på målet ditt';

  @override
  String get homeLogMealsToTrackCalories =>
      'Logg måltider for å følge kaloriene';

  @override
  String get homeLogFirstMeal => 'Logg ditt første måltid';

  @override
  String get homeTrackProteinFromMeals => 'Følg proteiner fra måltidene';

  @override
  String get homeTrackFiberFromMeals => 'Følg fiber fra måltidene';

  @override
  String get homeAllClear => 'Alt klart';

  @override
  String get homeTrackSymptoms => 'Følg symptomer';

  @override
  String get homeGreat => 'Flott';

  @override
  String get homeGood => 'Bra';

  @override
  String get homeBad => 'Dårlig';

  @override
  String get homeOkay => 'Ok';

  @override
  String get homeLogHowYouFeel => 'Logg hvordan du føler deg';

  @override
  String get homeLogACraving => 'Logg et sug';

  @override
  String get homeLogTodaysDose => 'Logg dagens dose';

  @override
  String get homeTaken => 'Tatt';

  @override
  String get homeStartHereTitle => 'Start her';

  @override
  String get homeStartHereBody =>
      'Start med dette kortet, og utvid deretter til de andre. Etter hvert som Glu lærer mer om reisen din, kan det vise bedre mønstre og innsikter over tid.';

  @override
  String get waterLogTitle => 'Vannlogg';

  @override
  String get waterLogEditTitle => 'Rediger vann';

  @override
  String get waterLogLogTitle => 'Logg vann';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Legg til vann';
  }

  @override
  String get waterLogSaving => 'Lagrer...';

  @override
  String get waterLogCustomDrinkTitle => 'Egendefinert drikk';

  @override
  String get waterLogCustomDrinkBody => 'Velg mengden du vil legge til nå.';

  @override
  String get waterLogUseThisAmount => 'Bruk denne mengden';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount lagt til i vannloggen din';
  }

  @override
  String get waterLogCouldNotSave => 'Kunne ikke lagre denne vannloggen ennå.';

  @override
  String get waterLogDeleteTitle => 'Slette denne vannloggen?';

  @override
  String get waterLogDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get waterLogCouldNotDelete =>
      'Kunne ikke slette denne vannloggen ennå.';

  @override
  String get waterLogDeleteLog => 'Slett logg';

  @override
  String get waterLogDeleted => 'Vann slettet';

  @override
  String get moodLogTitle => 'Humør';

  @override
  String get moodEditTitle => 'Rediger humør';

  @override
  String get moodHowYouFeel => 'Hvordan du føler deg';

  @override
  String get moodBad => 'Dårlig';

  @override
  String get moodOkay => 'Ok';

  @override
  String get moodGood => 'Bra';

  @override
  String get moodGreat => 'Flott';

  @override
  String get moodNotes => 'Notater';

  @override
  String get moodAnythingWorthRemembering =>
      'Er det noe verdt å huske om humøret ditt?';

  @override
  String get moodCouldNotSave => 'Kunne ikke lagre denne humørloggen ennå.';

  @override
  String get moodDeleteTitle => 'Slette denne humørloggen?';

  @override
  String get moodDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get moodDeleteLog => 'Slett logg';

  @override
  String get moodSaving => 'Lagrer...';

  @override
  String get moodAddMoodLog => '+ Legg til humørlogg';

  @override
  String get moodLogged => 'Humør logget';

  @override
  String get moodDeleted => 'Humør slettet';

  @override
  String get moodCouldNotDelete => 'Kunne ikke slette denne humørloggen ennå.';

  @override
  String get moodAddedToMoodLog => 'Lagt til i humørloggen din';

  @override
  String get cravingsLogTitle => 'Sug';

  @override
  String get cravingsEditTitle => 'Rediger sug';

  @override
  String get cravingsWhatsGoingOn => 'Hva skjer';

  @override
  String get cravingsTypeGeneral => 'Lyst til å spise';

  @override
  String get cravingsTypeSweet => 'Noe søtt';

  @override
  String get cravingsTypeSalty => 'Noe salt';

  @override
  String get cravingsIntensityLabel => 'Styrke (valgfritt)';

  @override
  String get cravingsIntensityMild => 'Mild';

  @override
  String get cravingsIntensityModerate => 'Moderat';

  @override
  String get cravingsIntensityStrong => 'Sterk';

  @override
  String get cravingsOutcomeLabel => 'Hva skjedde (valgfritt)';

  @override
  String get cravingsOutcomeResisted => 'Stod imot';

  @override
  String get cravingsOutcomeGaveIn => 'Ga etter';

  @override
  String get cravingsNotes => 'Notater';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Er det noe verdt å huske om dette suget?';

  @override
  String get cravingsCouldNotSave => 'Kunne ikke lagre denne sugloggen ennå.';

  @override
  String get cravingsDeleteTitle => 'Slette denne sugloggen?';

  @override
  String get cravingsDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get cravingsDeleteLog => 'Slett logg';

  @override
  String get cravingsSaving => 'Lagrer...';

  @override
  String get cravingsAddLog => '+ Legg til sug';

  @override
  String get cravingsLogged => 'Sug logget';

  @override
  String get cravingsDeleted => 'Sug slettet';

  @override
  String get cravingsCouldNotDelete =>
      'Kunne ikke slette denne sugloggen ennå.';

  @override
  String get cravingsAddedToLog => 'Lagt til i sugloggen din';

  @override
  String get portionCheckTitle => 'Porsjonssjekk';

  @override
  String get portionCheckAnalyzingMeal => 'Analyserer måltidet ditt…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Kunne ikke analysere dette bildet.';

  @override
  String get portionCheckTakeNewPhoto => 'Ta nytt bilde';

  @override
  String get portionCheckSomethingWentWrong => 'Noe gikk galt.';

  @override
  String get portionCheckYouHitDailyLimit => 'Du har nådd dagsgrensen din';

  @override
  String get portionCheckYouCanEat => 'Du kan spise';

  @override
  String get portionCheckYouCanEatUpTo => 'Du kan spise opptil';

  @override
  String get portionCheckTryLighterOption => 'Prøv et lettere alternativ';

  @override
  String get portionCheckThisEntireMeal => 'hele dette måltidet';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% av dette måltidet';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'for å holde deg innenfor de daglige målene dine.';

  @override
  String get portionCheckNutritionBreakdown => 'Næringsfordeling';

  @override
  String get portionCheckTipsToBalanceMeal => 'Tips for å balansere måltidet';

  @override
  String get portionCheckTipsPool =>
      'Spis sakte – metthetssignaler bruker rundt 20 minutter på å ta igjen.\nFyll halve tallerkenen med grønnsaker.\nHa protein i hvert måltid.\nDrikk vann før måltider.\nPorsjoner snacks i små beholdere på forhånd.\nKombiner karbohydrater med protein eller fett for å holde deg mett lenger.\nVelg helst hele og lite bearbeidede matvarer.\nUnngå å spise mens du er distrahert av skjermer.\nDropp ikke måltider hvis det gjør at du overspiser senere.\nPlanlegg snacksene før du blir sulten.';

  @override
  String get portionCheckRetake => 'Ta på nytt';

  @override
  String get portionCheckLogThisPortion => 'Logg denne porsjonen';

  @override
  String get portionCheckCarbs => 'Karbohydrater';

  @override
  String get portionCheckProteins => 'Proteiner';

  @override
  String get portionCheckFats => 'Fett';

  @override
  String get portionCheckFiber => 'Fiber';

  @override
  String get mealLogScreenTitle => 'Måltid';

  @override
  String get mealLogEditTitle => 'Rediger måltid';

  @override
  String get mealLogLogTitle => 'Logg måltid';

  @override
  String get mealLogSaving => 'Lagrer...';

  @override
  String get mealLogAddMealLog => '+ Legg til måltidslogg';

  @override
  String get mealLogCouldNotStartRecording => 'Kunne ikke starte opptak.';

  @override
  String get mealLogRecordingStoppedAtLimit => 'Opptaket stoppet ved grensen.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Kunne ikke analysere dette opptaket.';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'Kunne ikke analysere denne teksten.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Kunne ikke analysere dette bildet.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Kunne ikke behandle dette måltidsbildet ennå.';

  @override
  String get mealLogDiscardTitle => 'Forkaste dette måltidet?';

  @override
  String get mealLogDiscardMessage =>
      'Du så på et bilde, men lagret ikke oppføringen. Den blir ikke logget.';

  @override
  String get mealLogDiscard => 'Forkast';

  @override
  String get mealLogDeleteTitle => 'Slette denne måltidsloggen?';

  @override
  String get mealLogDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get mealLogDelete => 'Slett';

  @override
  String get mealLogDeleteLog => 'Slett logg';

  @override
  String get mealLogCouldNotSave =>
      'Kunne ikke lagre denne måltidsloggen ennå.';

  @override
  String get mealLogCouldNotDelete =>
      'Kunne ikke slette denne måltidsloggen ennå.';

  @override
  String get mealLogAnalyzing => 'Analyserer...';

  @override
  String get mealLogAnalyzeText => 'Analyser tekst';

  @override
  String get mealLogSendRecording => 'Send opptak';

  @override
  String get mealLogMealDefaultName => 'Måltid';

  @override
  String get mealLogMealNameHint => 'Navn på måltid';

  @override
  String get mealLogCouldNotPrefillTitle =>
      'Kunne ikke fylle ut dette måltidet på forhånd';

  @override
  String get mealLogHowMuchDidYouEat => 'Hvor mye spiste du?';

  @override
  String get mealLogNotes => 'Notater';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Er det noe verdt å huske om dette måltidet?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analyserer måltidet ditt';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Vi gjør om inndataene dine til næringsfelter. Du kan se gjennom alt før du lagrer.';

  @override
  String get mealLogDescribeYourMealTitle => 'Beskriv måltidet ditt';

  @override
  String get mealLogDescribeYourMealBody =>
      'Skriv hva du spiste og eventuelle mengder du kjenner til. Vi gjør det om til næringsfelter.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Eksempel: grillet kyllingsalat, oljedressing, 1 eple, kullsyrevann';

  @override
  String get mealLogCaptureYourMealTitle => 'Ta bilde av måltidet';

  @override
  String get mealLogCaptureYourMealBody =>
      'Ta et bilde, så anslår vi næringsfeltene for deg.';

  @override
  String get mealLogTakePhoto => 'Ta bilde';

  @override
  String get mealLogRecordingYourMealTitle => 'Tar opp måltidet ditt';

  @override
  String get mealLogRecordingReadyTitle => 'Opptaket er klart';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Ta opp en måltidsbeskrivelse';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Trykk stopp når du er ferdig.';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Du kan nå snakke eller stoppe når du er klar.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Snakk naturlig om hva du spiste, så tolker vi det til makroer.';

  @override
  String get mealLogStopRecording => 'Stopp opptak';

  @override
  String get mealLogRecordAgain => 'Ta opp på nytt';

  @override
  String get mealLogStartRecording => 'Start opptak';

  @override
  String get mealLogBreakfast => 'Frokost';

  @override
  String get mealLogLunch => 'Lunsj';

  @override
  String get mealLogSnack => 'Snack';

  @override
  String get mealLogDinner => 'Middag';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'I dag';

  @override
  String get mealLogYesterday => 'I går';

  @override
  String mealLogKcal(Object count) {
    return 'kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal logget';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro logget';
  }

  @override
  String get mealLogDeleted => 'Måltid slettet';

  @override
  String get mealLogAddedToMealLog => 'Lagt til i måltidsloggen din';

  @override
  String get mealLogCarbs => 'Karbohydrater';

  @override
  String get mealLogProteins => 'Proteiner';

  @override
  String get mealLogFats => 'Fett';

  @override
  String get mealLogFiber => 'Fiber';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageDialogTitle => 'Velg språk';

  @override
  String get settingsTitle => 'Innstillinger';

  @override
  String get settingsPreferences => 'Preferanser';

  @override
  String get settingsHealthGoal => 'Helsemål';

  @override
  String get settingsHealthGoalDialogTitle => 'Velg helsemål';

  @override
  String get settingsHabitGoals => 'Vanemål';

  @override
  String get settingsDisabled => 'Disabled';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count active';
  }

  @override
  String get settingsHeight => 'Høyde';

  @override
  String get settingsAge => 'Alder';

  @override
  String get settingsGender => 'Kjønn';

  @override
  String get settingsMeasurementUnit => 'Måleenhet';

  @override
  String get settingsReminders => 'Påminnelser';

  @override
  String get settingsDoseReminder => 'Dosepåminnelse';

  @override
  String get settingsSupplementReminder => 'Kosttilskuddpåminnelse';

  @override
  String get settingsDailyReminders => 'Daglige påminnelser';

  @override
  String get settingsSubscription => 'Abonnement';

  @override
  String get settingsSupport => 'Støtte';

  @override
  String get settingsSendFeedback => 'Send tilbakemelding';

  @override
  String get feedbackSheetTitle => 'Send tilbakemelding';

  @override
  String get feedbackSheetHint => 'Fortell oss hva du synes…';

  @override
  String get feedbackSheetSend => 'Send';

  @override
  String get feedbackSheetSuccess => 'Takk for tilbakemeldingen din!';

  @override
  String get feedbackSheetError => 'Kunne ikke sende. Prøv igjen.';

  @override
  String get settingsTermsOfService => 'Bruksvilkår';

  @override
  String get settingsPrivacyPolicy => 'Personvernregler';

  @override
  String get settingsInternal => 'Intern';

  @override
  String get settingsSubscriptionOverride => 'Abonnements-overstyring';

  @override
  String get settingsTodayInsightCard => 'Dagens innsiktskort';

  @override
  String get settingsResetOnboarding => 'Tilbakestill onboarding';

  @override
  String get settingsResetShowcases => 'Tilbakestill showcase';

  @override
  String get settingsResetUserData => 'Tilbakestill brukerdata';

  @override
  String get settingsDeletingAccount => 'Sletter konto...';

  @override
  String get settingsDisconnect => 'Koble fra';

  @override
  String get settingsDeleteAccount => 'Slett konto';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Koble fra $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Koble fra $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Du vil ikke lenger kunne logge inn med $provider på denne enheten med mindre du kobler det til igjen senere.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Slette konto?';

  @override
  String get settingsDeleteAccountBody =>
      'Dette vil permanent fjerne kontoen din og alle dataene dine. Denne handlingen kan ikke angres.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Skriv DELETE for å bekrefte';

  @override
  String get settingsDeleteAccountError =>
      'Noe gikk galt under sletting av kontoen din. Kontakt support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Start appen på nytt for å se onboarding';

  @override
  String get settingsShowcasesReset => 'Showcases tilbakestilt';

  @override
  String get settingsResetUserDataTitle => 'Tilbakestille brukerdata?';

  @override
  String get settingsResetUserDataBody =>
      'Dette vil slette alle loggede poster for måltider, vann, trening, vekt, humør, symptomer, kosttilskudd og doser.';

  @override
  String get settingsUserDataReset => 'Brukerdata tilbakestilt';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Lagret, men daglige påminnelser kunne ikke planlegges akkurat nå.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Abonnements-overstyring';

  @override
  String get settingsSubscriptionOverrideAuto => 'Auto';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Tving gratis';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Tving Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Dagens innsiktskort';

  @override
  String get settingsTodayInsightCardAuto => 'Auto';

  @override
  String get settingsTodayInsightCardOn => 'På';

  @override
  String get settingsTodayInsightCardOff => 'Av';

  @override
  String get settingsYourName => 'Navnet ditt';

  @override
  String get settingsSignOut => 'Logg ut';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'ft/in';

  @override
  String get settingsHeightFt => 'ft';

  @override
  String get settingsHeightIn => 'in';

  @override
  String get settingsGenderMale => 'Mann';

  @override
  String get settingsGenderFemale => 'Kvinne';

  @override
  String get settingsGenderPreferNotToSay => 'Foretrekker å ikke si';

  @override
  String get settingsGenderOther => 'Annet';

  @override
  String get settingsYourProfile => 'Profilen din';

  @override
  String get settingsNotSet => 'Ikke satt';

  @override
  String settingsYears(Object value) {
    return '$value år';
  }

  @override
  String get settingsOff => 'Av';

  @override
  String get settingsOn => 'På';

  @override
  String get settingsNoneSet => 'Ingen satt';

  @override
  String settingsSupplementCount(Object count) {
    return '$count kosttilskudd';
  }

  @override
  String get commonToday => 'I dag';

  @override
  String get mainShellHome => 'Hjem';

  @override
  String get mainShellLog => 'Logg';

  @override
  String get mainShellProgress => 'Fremgang';

  @override
  String get mainShellSettings => 'Innstillinger';

  @override
  String get mainShellLogShowcaseTitle => 'Logg';

  @override
  String get mainShellLogShowcaseDescription =>
      'Logg aktivitetene som betyr mest for deg, hver dag.';

  @override
  String get logMoodShowcaseTitle => 'Start med humøret ditt';

  @override
  String get logMoodShowcaseDescription =>
      'Logg humøret ditt nå, og fortsett å logge resten etter hvert, så Glu kan oppdage vaner og mønstre mer nøyaktig.';

  @override
  String get mainShellProgressShowcaseTitle => 'Se fremgangen din';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Sjekk mønstre og trender for å forstå hvordan vanene og vekten din endrer seg over tid.';

  @override
  String get progressMenuShowcaseTitle => 'Utforsk dataene dine';

  @override
  String get progressMenuShowcaseDescription =>
      'Se alle grafer, les AI-genererte innsikter, eller lag en legerapport du kan dele med behandlingsteamet ditt.';

  @override
  String get settingsFeedbackShowcaseTitle => 'Vi vil gjerne høre fra deg';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Trykk her for å dele det som fungerer, det som ikke gjør det, eller ideer du har.';

  @override
  String get authCouldNotOpenLink => 'Kunne ikke åpne lenken nå.';

  @override
  String get authWelcomeTitle => 'Velkommen til Glu';

  @override
  String get authSubtitle => 'Sikker innlogging for velværeassistenten din';

  @override
  String get authContinueWithGoogle => 'Fortsett med Google';

  @override
  String get authContinueWithApple => 'Fortsett med Apple';

  @override
  String get authEmailHint => 'navn@epost.no';

  @override
  String get authSending => 'Sender...';

  @override
  String get authResendLink => 'Send lenken på nytt';

  @override
  String get authUseDifferentEmail => 'Bruk en annen e-post';

  @override
  String get habitGoalsTitle => 'Vanemål';

  @override
  String get goalsProteins => 'Proteiner';

  @override
  String get goalsFibers => 'Fiber';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g per dag';
  }

  @override
  String get goalsWater => 'Vann';

  @override
  String goalsLitersPerDay(Object value) {
    return '${value}L per dag';
  }

  @override
  String get goalsExercise => 'Trening';

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
  String get goalsPerWeekSuffix => 'per uke';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count måltider per dag';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal per dag';
  }

  @override
  String get goalsWeight => 'Vekt';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Logg en vekt for å beregne tempoet';

  @override
  String get goalsAlreadyAtThisTarget => 'Du er allerede på dette målet';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/uke til mål';
  }

  @override
  String get goalsSetTargetForNextWeek => 'Sett målet for neste uke.';

  @override
  String get progressWeightTitle => 'Vekt';

  @override
  String get progressWeightLabel => 'Vekt ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Sunn BMI';

  @override
  String get progressTotal => 'Total';

  @override
  String get progressPercent => 'Prosent';

  @override
  String get progressWeeklyAvg => 'Ukentlig snitt';

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
  String get progressMed => 'Middels';

  @override
  String get progressHigh => 'Høy';

  @override
  String get progressSeverity => 'Alvorlighet';

  @override
  String get progressBad => 'Dårlig';

  @override
  String get progressOkay => 'Ok';

  @override
  String get progressGood => 'Bra';

  @override
  String get progressGreat => 'Flott';

  @override
  String get progressMostlyBad => 'For det meste dårlig';

  @override
  String get progressMostlyOkay => 'For det meste ok';

  @override
  String get progressMostlyGood => 'For det meste bra';

  @override
  String get progressMostlyGreat => 'For det meste flott';

  @override
  String get progressNoDose => 'Ingen dose';

  @override
  String get progressLogged => 'Logget';

  @override
  String get progressAllClear => 'Alt klart';

  @override
  String get progressFreq => 'Frekvens';

  @override
  String get progressAverage => 'Gjennomsnitt';

  @override
  String get progressDaily => 'Daglig';

  @override
  String get progressWeekly => 'Ukentlig';

  @override
  String get progressMinutes => 'Minutter';

  @override
  String get progressIntensity => 'Intensitet';

  @override
  String get progressCalories => 'Kalorier';

  @override
  String get progressByDose => 'Etter dose';

  @override
  String get progressWeightProgressTitle => 'Vektfremgang';

  @override
  String get progressWaterProgressTitle => 'Vannfremgang';

  @override
  String get progressExerciseProgressTitle => 'Treningsfremgang';

  @override
  String get progressDoseProgressTitle => 'Dosefremgang';

  @override
  String get progressMealsProgressTitle => 'Måltidsfremgang';

  @override
  String get progressSymptomsProgressTitle => 'Symptomfremgang';

  @override
  String get progressMoodProgressTitle => 'Humørfremgang';

  @override
  String get progressCravingsProgressTitle => 'Sugfremgang';

  @override
  String get progressResisted => 'Stod imot';

  @override
  String get progressCravingsResistedSubtitle =>
      'Andel registrerte sug du stod imot.';

  @override
  String get progressWeightChangeTitle => 'Vektendring';

  @override
  String get progressTitle => 'Fremgang';

  @override
  String get progressMenuViewAllInsights => 'Vis alle innsikter';

  @override
  String get progressMenuViewAllCharts => 'Vis alle grafer';

  @override
  String get progressMenuCreateDoctorReport => 'Lag legerapport';

  @override
  String get progressReportGenerating => 'Genererer rapporten din…';

  @override
  String get progressReportError =>
      'Kunne ikke generere rapporten. Prøv igjen.';

  @override
  String get progressReportPendingRetry =>
      'Rapporten din kan fortsatt bli ferdig om et øyeblikk. Prøv igjen.';

  @override
  String get progressReportOpenError =>
      'Rapporten din ble generert, men vi kunne ikke åpne den. Prøv igjen.';

  @override
  String get progressAllProgressTitle => 'All fremgang';

  @override
  String get progressWeightTrendExplanation =>
      'Se hvordan vekten din endrer seg over tid.';

  @override
  String get progressNoWeightLogsYet => 'Ingen vektlogger ennå';

  @override
  String get progressNoLogsYet => 'Ingen logger ennå';

  @override
  String get progressLogWeightToStartTrend =>
      'Logg vekt for å begynne å følge trenden din.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Logg vekt og dose for å sammenligne hvordan dosering henger sammen med endring.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Hvert punkt er farget etter den siste dosen som ble brukt før den veiingen.';

  @override
  String get progressNoHydrationYet => 'Ingen hydrering ennå';

  @override
  String get progressNoMovementYet => 'Ingen bevegelse ennå';

  @override
  String get progressNoDoseLogsYet => 'Ingen doselogger ennå';

  @override
  String get progressNoMealsLoggedYet => 'Ingen måltider logget ennå';

  @override
  String get progressNoSymptomsLoggedYet => 'Ingen symptomer logget ennå';

  @override
  String get progressNoMoodLogsYet => 'Ingen humørlogger ennå';

  @override
  String get progressNoCravingsLoggedYet => 'Ingen sug logget ennå';

  @override
  String get progressFutureTrendTitle => 'Fremtidig trend';

  @override
  String get progressFutureTrendBody =>
      'En vakker tidslinje over momentet ditt';

  @override
  String get progressGoal => 'Mål';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Den sist loggede vekten din er klar til å følges.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Omtrent $gap $unit fra målet ditt.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText vs forrige logg.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText vs forrige logg. $gap $unit fra målet.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Sammenlignet med forrige logg er trenden nå synlig.';

  @override
  String get progressWaterTitle => 'Vann';

  @override
  String get manageSubscriptionTitle => 'Administrer abonnement';

  @override
  String get manageSubscriptionProPlan => 'Pro-plan';

  @override
  String get manageSubscriptionFreePlan => 'Gratis plan';

  @override
  String get manageSubscriptionActiveCopy => 'Abonnementet ditt er aktivt.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Oppgrader for å låse opp Glu Pro.';

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
  String get manageSubscriptionUpgradeButton => 'Oppgrader til Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Åpne butikkens abonnementsinnstillinger';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Gjenopprett kjøp';

  @override
  String get manageSubscriptionRenewsAutomatically => 'Fornyes automatisk';

  @override
  String get manageSubscriptionLifetime => 'Livstid';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Fornyes $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Utløper $date';
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
    return 'Om $count dager';
  }

  @override
  String get supplementReminderInOneWeek => 'Om 1 uke';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Om $count uker';
  }

  @override
  String get subscriptionDebugTitle => 'Glu-abonnementsdebug';

  @override
  String get subscriptionDebugMonthly => 'Månedlig';

  @override
  String get subscriptionDebugYearly => 'Årlig';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Oppdater kundedata';

  @override
  String get subscriptionDebugPresentPaywall => 'Vis betalingsmur';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Åpne kundesenter';

  @override
  String get subscriptionDebugRestorePurchases => 'Gjenopprett kjøp';

  @override
  String get subscriptionDebugSyncPurchases => 'Synkroniser kjøp';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat-status';

  @override
  String get subscriptionDebugConfigured => 'Konfigurert';

  @override
  String get subscriptionDebugBusy => 'Opptatt';

  @override
  String get subscriptionDebugAppUserId => 'App-bruker-ID';

  @override
  String get subscriptionDebugAnonymous => 'Anonym';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-nøkkel tilgjengelig';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro aktiv';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Aktive abonnementer';

  @override
  String get subscriptionDebugManagementUrl => 'Administrasjons-URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Entitlement-produkt';

  @override
  String get subscriptionDebugWillRenew => 'Fornyes';

  @override
  String get subscriptionDebugExpiration => 'Utløp';

  @override
  String get subscriptionDebugLifetime => 'Livstid';

  @override
  String get subscriptionDebugPackageFound => 'Pakke funnet';

  @override
  String get subscriptionDebugProductId => 'Produkt-ID';

  @override
  String get subscriptionDebugTitleLabel => 'Tittel';

  @override
  String get subscriptionDebugPrice => 'Pris';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Kjøp $title';
  }

  @override
  String get progressExerciseTitle => 'Trening';

  @override
  String get progressDoseTitle => 'Dose';

  @override
  String get progressMealsTitle => 'Måltider';

  @override
  String get progressSymptomsTitle => 'Symptomer';

  @override
  String get progressMoodTitle => 'Humør';

  @override
  String get progressCravingsTitle => 'Sug';

  @override
  String get progressTrend => 'Tendens';

  @override
  String get progressTarget => 'Mål';

  @override
  String get progressNoTrendYet => 'Ingen tendens ennå';

  @override
  String get progressNoActivityYet => 'Ingen aktivitet ennå';

  @override
  String get progressNoCheckInsYet => 'Ingen innsjekker ennå';

  @override
  String get progressWeightSignatureChip => 'Vekten blir din signaturgraf';

  @override
  String get progressWeightStartTrendTitle =>
      'Start tendensen din med én veiing';

  @override
  String get progressWeightStartTrendBody =>
      'Denne grafen er midtpunktet i historien om fremgangen din. Logg din første vekt for å låse opp momentum, milepæler og en visning verdt å dele.';

  @override
  String get progressWeightMomentum => 'Momentum';

  @override
  String get progressWeightMilestones => 'Milepæler';

  @override
  String get progressWeightShareReady => 'Klar til deling';

  @override
  String get progressWeightLogWeight => 'Logg vekt';

  @override
  String get weightProgressUnlocksViewChip =>
      'Din første veiing låser opp denne visningen';

  @override
  String get weightProgressStartsHereTitle =>
      'Historien om fremgangen din starter her';

  @override
  String get weightProgressStartsHereBody =>
      'Logg din første vekt for å låse opp trender, milepæler og dosebevisste innsikter i en visning verdt å dele.';

  @override
  String get weightProgressTrendView => 'Trendvisning';

  @override
  String get weightProgressDoseOverlays => 'Doseoverlegg';

  @override
  String get weightProgressMilestones => 'Milepæler';

  @override
  String get weightProgressLogWeight => 'Logg vekt';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Legg til både et før- og etterbilde først.';

  @override
  String get glowUpSavedToGallery => 'Lagret i galleriet ditt';

  @override
  String get glowUpSaveToGallery => 'Lagre i galleriet';

  @override
  String get glowUpYourProgress => 'Fremgangen din';

  @override
  String get glowUpWeightChange => 'Vektendring';

  @override
  String get glowUpTime => 'Tid';

  @override
  String get glowUpShare => 'Del';

  @override
  String get glowUpBefore => 'FØR';

  @override
  String get glowUpAfter => 'ETTER';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight i løpet av $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'dager';

  @override
  String get glowUpTimeUnitWeeksLabel => 'uker';

  @override
  String get glowUpTimeUnitMonthsLabel => 'måneder';

  @override
  String get glowUpTimeUnitYearsLabel => 'år';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dager',
      one: '$count dag',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count uker',
      one: '$count uke',
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
  String get commonSelect => 'Velg';

  @override
  String get doseReminderTitle => 'Dosepåminnelse';

  @override
  String get doseReminderCustomDoseTitle => 'Tilpasset dose';

  @override
  String get doseReminderCustomDoseHint => 'Skriv inn dose i mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Ha neste dose klar på hjemskjermen.';

  @override
  String get doseReminderTime => 'Tid';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Slå dette på for å vise neste dose på hjemskjermen.';

  @override
  String get doseReminderSaveReminder => 'Lagre påminnelse';

  @override
  String loggedOn(Object date) {
    return 'Logget $date';
  }

  @override
  String get waterLogSmallGlass => 'Lite glass';

  @override
  String get waterLogGlass => 'Glass';

  @override
  String get waterLogBottle => 'Flaske';

  @override
  String get waterLogLargeBottle => 'Stor flaske';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Tilpasset';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dose';

  @override
  String get doseLogEditTitle => 'Rediger dose';

  @override
  String get doseLogLogTitle => 'Logg dose';

  @override
  String get doseLogCustomDose => 'Tilpasset dose';

  @override
  String get doseLogCustomDoseBody => 'Juster dosen i mg for denne loggen.';

  @override
  String get doseLogUseThisDose => 'Bruk denne dosen';

  @override
  String get doseLogMedication => 'Medisin';

  @override
  String get doseLogInjectionSite => 'Sted';

  @override
  String get doseLogNotes => 'Notater';

  @override
  String get doseLogSaveChanges => 'Lagre endringer';

  @override
  String get doseLogAddDose => '+ Logg dose';

  @override
  String get doseLogDeleteTitle => 'Slette denne doseloggen?';

  @override
  String get doseLogDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get doseLogDeleteLog => 'Slett logg';

  @override
  String get doseLogSaving => 'Lagrer...';

  @override
  String get doseLogCouldNotSave => 'Kunne ikke lagre denne doseloggen ennå.';

  @override
  String get doseLogCouldNotDelete =>
      'Kunne ikke slette denne doseloggen ennå.';

  @override
  String get doseLogDeleted => 'Dose slettet';

  @override
  String get doseLogAddedToDoseLog => 'Lagt til i doseloggen din';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Er det noe verdt å huske om denne dosen?';

  @override
  String get doseLogDoseLabel => 'Dose';

  @override
  String get exerciseLogTitle => 'Trening';

  @override
  String get exerciseLogEditTitle => 'Rediger trening';

  @override
  String get exerciseLogLogTitle => 'Logg trening';

  @override
  String get exerciseLogActivityType => 'Aktivitetstype';

  @override
  String get exerciseLogCustomActivity => 'Tilpasset aktivitet';

  @override
  String get exerciseLogTypeActivity => 'Skriv inn aktiviteten';

  @override
  String get exerciseLogDuration => 'Varighet';

  @override
  String get exerciseLogIntensity => 'Intensitet';

  @override
  String get exerciseLogNotes => 'Notater';

  @override
  String get exerciseLogLight => 'Lett';

  @override
  String get exerciseLogModerate => 'Moderat';

  @override
  String get exerciseLogIntense => 'Intensiv';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min logget';
  }

  @override
  String get exerciseLogSaveChanges => 'Lagre endringer';

  @override
  String get exerciseLogAddExercise => '+ Legg til treningslogg';

  @override
  String get exerciseLogDeleteTitle => 'Slette denne treningsloggen?';

  @override
  String get exerciseLogDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get exerciseLogDeleteLog => 'Slett logg';

  @override
  String get exerciseLogSaving => 'Lagrer...';

  @override
  String get exerciseLogCouldNotSave =>
      'Kunne ikke lagre denne treningsloggen ennå.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Kunne ikke slette denne treningsloggen ennå.';

  @override
  String get exerciseLogDeleted => 'Trening slettet';

  @override
  String get exerciseLogAddedToExerciseLog => 'Lagt til i treningsloggen din';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Er det noe verdt å huske om denne økten?';

  @override
  String get exerciseLogWalking => 'Gange';

  @override
  String get exerciseLogRunning => 'Løping';

  @override
  String get exerciseLogCycling => 'Sykling';

  @override
  String get exerciseLogStrength => 'Styrke';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Svømming';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Vekt';

  @override
  String get weightLogEditTitle => 'Rediger vekt';

  @override
  String get weightLogLogTitle => 'Logg vekt';

  @override
  String get weightLogSaveChanges => 'Lagre endringer';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Legg til vekt ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Slette denne vektloggen?';

  @override
  String get weightLogDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get weightLogDeleteLog => 'Slett logg';

  @override
  String get weightLogSaving => 'Lagrer...';

  @override
  String get weightLogCouldNotSave => 'Kunne ikke lagre denne vektloggen ennå.';

  @override
  String get weightLogCouldNotDelete =>
      'Kunne ikke slette denne vektloggen ennå.';

  @override
  String get weightLogDeleted => 'Vekt slettet';

  @override
  String get weightLogAddedToWeightLog => 'Lagt til i vektloggen din';

  @override
  String get weightLogNoWeightForDay =>
      'Ingen vekt logget for denne dagen ennå.';

  @override
  String get injectionSiteAbdomen => 'Abdomen';

  @override
  String get injectionSiteThigh => 'Lår';

  @override
  String get injectionSiteUpperArm => 'Overarm';

  @override
  String get injectionSiteButtocks => 'Sete';

  @override
  String get injectionSiteAbdomenUpperLeft => 'Mage, øvre venstre';

  @override
  String get injectionSiteAbdomenUpperRight => 'Mage, øvre høyre';

  @override
  String get injectionSiteAbdomenLowerRight => 'Mage, nedre høyre';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Mage, nedre venstre';

  @override
  String get injectionSiteThighUpperLeft => 'Lår, øvre venstre';

  @override
  String get injectionSiteThighUpperRight => 'Lår, øvre høyre';

  @override
  String get injectionSiteThighLowerRight => 'Lår, nedre høyre';

  @override
  String get injectionSiteThighLowerLeft => 'Lår, nedre venstre';

  @override
  String get injectionSiteUpperArmLeft => 'Overarm, venstre';

  @override
  String get injectionSiteUpperArmRight => 'Overarm, høyre';

  @override
  String get injectionSiteButtocksUpperLeft => 'Sete, øvre venstre';

  @override
  String get injectionSiteButtocksUpperRight => 'Sete, øvre høyre';

  @override
  String get doseReminderFormat => 'Format';

  @override
  String get doseReminderInjection => 'Injeksjon';

  @override
  String get doseReminderPill => 'Pille';

  @override
  String get doseReminderSite => 'Sted';

  @override
  String get doseReminderDate => 'Dato';

  @override
  String get supplementReminderTitle => 'Kosttilskuddpåminnelse';

  @override
  String get supplementReminderAddSupplement => 'Legg til kosttilskudd';

  @override
  String get supplementReminderNoSupplementsYet => 'Ingen kosttilskudd ennå';

  @override
  String get supplementReminderAddFirstBody =>
      'Legg til din første kosttilskuddpåminnelse for å følge det daglige inntaket ditt.';

  @override
  String get supplementReminderSupplementFallback => 'Kosttilskudd';

  @override
  String get supplementReminderEveryDay => 'Hver dag';

  @override
  String get supplementReminderEveryXDaysLabel => 'Hver X dager';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Hver $interval dager';
  }

  @override
  String get supplementReminderNoDaysSet => 'Ingen dager satt';

  @override
  String get supplementReminderSupplementName => 'Navn på kosttilskudd';

  @override
  String get supplementReminderTime => 'Tid';

  @override
  String get supplementReminderStartDate => 'Startdato';

  @override
  String get supplementReminderRepeat => 'Gjenta';

  @override
  String get supplementReminderDaysOfWeek => 'Ukedager';

  @override
  String get supplementReminderSelectAtLeastOneDay => 'Velg minst én dag.';

  @override
  String get supplementReminderEvery => 'Hver';

  @override
  String get supplementReminderDay => 'dag';

  @override
  String get supplementReminderDays => 'dager';

  @override
  String get supplementReminderAdd => 'Legg til';

  @override
  String get symptomsLogTitle => 'Symptomer';

  @override
  String get symptomsLogEditTitle => 'Rediger symptomer';

  @override
  String get symptomsLogLogTitle => 'Logg symptomer';

  @override
  String get symptomsLogSymptomsExperienced => 'Opplevde symptomer';

  @override
  String get symptomsLogNoSymptoms => 'Ingen symptomer';

  @override
  String get symptomsLogNoSymptomsToday => 'Ingen symptomer i dag';

  @override
  String get symptomsLogOther => 'Annet...';

  @override
  String get symptomsLogSeverityLevel => 'Alvorlighetsnivå';

  @override
  String get symptomsLogNotes => 'Notater';

  @override
  String get symptomsLogAnxiety => 'Angst';

  @override
  String get symptomsLogBelching => 'Raping';

  @override
  String get symptomsLogBloating => 'Oppblåsthet';

  @override
  String get symptomsLogConstipation => 'Forstoppelse';

  @override
  String get symptomsLogDiarrhea => 'Diaré';

  @override
  String get symptomsLogFatigue => 'Slapphet';

  @override
  String get symptomsLogFoodNoise => 'Matstøy';

  @override
  String get symptomsLogHairLoss => 'Hårtap';

  @override
  String get symptomsLogHeartburn => 'Halsbrann';

  @override
  String get symptomsLogIndigestion => 'Fordøyelsesbesvær';

  @override
  String get symptomsLogInjectionSiteReaction => 'Reaksjon på injeksjonssted';

  @override
  String get symptomsLogMetallicTaste => 'Metallsmak';

  @override
  String get symptomsLogHeadache => 'Hodepine';

  @override
  String get symptomsLogMoodSwings => 'Humørsvingninger';

  @override
  String get symptomsLogNausea => 'Kvalme';

  @override
  String get symptomsLogReflux => 'Refluks';

  @override
  String get symptomsLogStomachPain => 'Magesmerter';

  @override
  String get symptomsLogSuppressedAppetite => 'Satt appetitt';

  @override
  String get symptomsLogVomiting => 'Oppkast';

  @override
  String get symptomsLogLogged => 'Symptomer logget';

  @override
  String get symptomsLogMild => 'Lett';

  @override
  String get symptomsLogModerate => 'Moderat';

  @override
  String get symptomsLogSevere => 'Alvorlig';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Er det noe verdt å huske om hvordan du følte deg?';

  @override
  String get symptomsLogSaveChanges => 'Lagre endringer';

  @override
  String get symptomsLogAddSymptoms => '+ Legg til symptomerlogg';

  @override
  String get symptomsLogDeleteTitle => 'Slette denne symptomerloggen?';

  @override
  String get symptomsLogDeleteMessage => 'Denne handlingen kan ikke angres.';

  @override
  String get symptomsLogDeleteLog => 'Slett logg';

  @override
  String get symptomsLogSaving => 'Lagrer...';

  @override
  String get symptomsLogCouldNotSave =>
      'Kunne ikke lagre denne symptomerloggen ennå.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Kunne ikke slette denne symptomerloggen ennå.';

  @override
  String get symptomsLogDeleted => 'Symptomer slettet';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Lagt til i symptomerloggen din';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% av dagsmålet';
  }

  @override
  String get commonDisclaimer =>
      'Glu er et sporingsverktøy, ikke et medisinsk utstyr. Det gir ikke medisinsk råd, diagnose eller behandling. Rådfør deg alltid med helsepersonell om medisinen og helsebeslutningene dine.';
}
