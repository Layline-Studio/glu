// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Aan het opstarten...';

  @override
  String get startupFailed => 'Startup failed';

  @override
  String get commonCancel => 'Annuleren';

  @override
  String get commonSave => 'Opslaan';

  @override
  String get commonSaving => 'Aan het opslaan...';

  @override
  String get commonContinue => 'Doorgaan';

  @override
  String get commonSkip => 'Overslaan';

  @override
  String get commonDelete => 'Verwijderen';

  @override
  String get commonNotNow => 'Niet nu';

  @override
  String get commonNow => 'Nu';

  @override
  String get commonTomorrow => 'Morgen';

  @override
  String get noteTriggerAddNote => 'Notitie toevoegen';

  @override
  String get noteTriggerCancelNote => 'Notitie annuleren';

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
  String get bmiIndicatorYourBmi => 'Jouw BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Je huidige BMI';

  @override
  String get bmiIndicatorUnderweight => 'Undergewicht';

  @override
  String get bmiIndicatorNormal => 'Normal';

  @override
  String get bmiIndicatorOverweight => 'Overgewicht';

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
  String get paywallTitle => 'Ontgrendel Glu Pro';

  @override
  String get paywallSubtitle =>
      'Bescherm je voortgang en voorkom dat je weer aankomt.';

  @override
  String get paywallMonthlyTitle => 'Maandelijks';

  @override
  String get paywallMonthlySubtitle => 'Elke maand opzegbaar';

  @override
  String get paywallYearlyTitle => 'Jaarlijks';

  @override
  String get paywallYearlySubtitle => 'Best value';

  @override
  String get paywallNoCommitment => 'Geen verplichting';

  @override
  String get paywallCancelAnytime => 'Altijd opzegbaar';

  @override
  String get paywallContinue => 'Doorgaan';

  @override
  String get paywallRestore => 'Aankopen herstellen';

  @override
  String get paywallTerms => 'Voorwaarden';

  @override
  String get paywallPrivacy => 'Privacy';

  @override
  String get paywallSeparator => 'en';

  @override
  String paywallSavePercent(Object percent) {
    return 'Opslaan $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Kan de link nu niet openen.';

  @override
  String get paywallAlreadySubscribed => 'Je hebt al Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Welkom bij Glu Pro!';

  @override
  String get paywallPurchaseIncomplete => 'Aankoop niet voltooid';

  @override
  String get paywallPurchaseFailed => 'Aankoop mislukt';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Aankoop mislukt ($errorCode)';
  }

  @override
  String get paywallRestoreSuccess => 'Aankopen hersteld';

  @override
  String get paywallRestoreNoSubscription => 'Geen abonnement gevonden';

  @override
  String get paywallRestoreFailed => 'Herstellen mislukt';

  @override
  String get paywallBenefitReminders => 'Doseer- en supplementherinneringen';

  @override
  String get paywallBenefitShareProgress =>
      'Maak je voortgang eenvoudig deelbaar';

  @override
  String get paywallBenefitSpotRegain => 'Zie vroegtijdig weer aankomen';

  @override
  String get paywallBenefitInsights =>
      'Bekijk dagelijkse inzichten en patronen';

  @override
  String get paywallBenefitWeeklyGoals =>
      'Blijf bij eenvoudige wekelijkse doelen';

  @override
  String get paywallBenefitHealthyHabits =>
      'Maak gezonde gewoonten makkelijker vol te houden';

  @override
  String get onboardingWelcomeTitle => 'Beheer je gewicht op een slimme manier';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu helpt je om je voortgang rond behandeling, doelen en wekelijkse gewoonten bij te houden.';

  @override
  String get onboardingWelcomeBullet1 => 'Past bij je behandeling en doelen';

  @override
  String get onboardingWelcomeBullet2 =>
      'Eenvoudige en realistische ondersteuning';

  @override
  String get onboardingWelcomeBullet3 =>
      'Herken vroege signalen van gewichtstoename';

  @override
  String get onboardingWelcomeBullet4 =>
      'Blijf doorgaan zonder opnieuw te beginnen';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Gebruik je momenteel een medicatie-injectie of pil voor gewichtsverlies?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'We gebruiken dit om begeleiding te tonen die past bij waar je nu bent.';

  @override
  String get onboardingMedicationStatusUsing => 'Ja, ik gebruik het nu';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Ik ben aan het afbouwen';

  @override
  String get onboardingMedicationStatusNotTaking => 'Nee';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'Nee, ik begin binnenkort';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Ik ben recent gestopt';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Hoe neem je je medicatie in?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'We gebruiken dit om instructies en herinneringen af te stemmen op de vorm van je medicatie.';

  @override
  String get onboardingMedicationMethodInjection => 'Injectie';

  @override
  String get onboardingMedicationMethodPill => 'Pil';

  @override
  String get onboardingMedicationMethodUnknown => 'Onbekend';

  @override
  String get onboardingMedicationNameQuestion => 'Hoe heet je medicatie?';

  @override
  String get onboardingMedicationNameExplainer =>
      'We gebruiken dit om doseerregistratie en medicatiespecifieke begeleiding te personaliseren.';

  @override
  String get onboardingCurrentDoseQuestion => 'Wat is je huidige dosis?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'We gebruiken dit om de dosistracking en toekomstige voortgangscontroles af te stemmen.';

  @override
  String get onboardingMedicationCustomDose => 'Aangepaste dosis';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Welk hulpmiddel gebruik je om je medicatie in te nemen?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'We gebruiken dit om herinneringen en tips te laten aansluiten op hoe je het inneemt.';

  @override
  String get onboardingDeviceSinglePen => 'Enkele pen';

  @override
  String get onboardingDeviceAutoInjector => 'Auto-injector';

  @override
  String get onboardingDeviceSyringeAndVial => 'Spuit en flacon';

  @override
  String get onboardingOther => 'Anders';

  @override
  String get onboardingTypeYourDevice => 'Typ je hulpmiddel';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Hoe vaak neem je je medicatie?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'We gebruiken dit om herinneringen en routine-ondersteuning af te stemmen op jouw schema.';

  @override
  String get onboardingEveryDay => 'Elke dag';

  @override
  String get onboardingEvery7Days => 'Elke 7 dagen';

  @override
  String get onboardingEvery14Days => 'Elke 14 dagen';

  @override
  String get onboardingCustom => 'Aangepast';

  @override
  String get onboardingDaysBetweenDoses => 'Dagen tussen doses';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'Wat is je belangrijkste doel op dit moment?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'We gebruiken dit om je plan, herinneringen en voortgang te richten op wat voor jou het belangrijkst is.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'We gebruiken dit om je plan vanaf het begin vorm te geven.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'We gebruiken dit om je volgende fase te ondersteunen en je op koers te houden.';

  @override
  String get onboardingGoalLoseWeight => 'Afvallen';

  @override
  String get onboardingGoalMaintainWeight => 'Mijn gewicht behouden';

  @override
  String get onboardingGoalManageDiabetes => 'Diabetes beheren';

  @override
  String get onboardingGoalManagePcos => 'PCOS beheren';

  @override
  String get onboardingGoalImproveHeartHealth => 'Hartgezondheid verbeteren';

  @override
  String get onboardingAgeQuestion => 'Hoe oud ben je?';

  @override
  String get onboardingAgeExplainer =>
      'We gebruiken dit om begeleiding en gezondheidsberekeningen beter af te stemmen.';

  @override
  String get onboardingHeightQuestion => 'Hoe lang ben je?';

  @override
  String get onboardingHeightExplainer =>
      'We gebruiken dit samen met je gewicht om zaken zoals BMI en gezonde bereiken te berekenen.';

  @override
  String get onboardingWeightQuestion => 'Wat is je huidige gewicht?';

  @override
  String get onboardingWeightExplainer =>
      'We gebruiken dit als startpunt voor voortgang, doelen en gezondheidsinschattingen.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Wanneer ben je gestopt met de medicatie?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Wanneer ben je begonnen met afbouwen van de medicatie?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Wanneer ben je begonnen met de medicatie?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'We gebruiken dit om je recente behandelgeschiedenis en volgende fase te begrijpen.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'We gebruiken dit om je overgangsfase te begrijpen en de gewoonten te ondersteunen die nu het belangrijkst zijn.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'We gebruiken dit om te begrijpen hoelang je al in behandeling bent en veranderingen in de tijd te volgen.';

  @override
  String get onboardingGoalWeightQuestion => 'Wat is je doelgewicht?';

  @override
  String get onboardingGoalWeightExplainer =>
      'We gebruiken dit om voortgang in beeld te brengen en een doel-BMI-bereik te tonen.';

  @override
  String get onboardingBenefitsQuestion => 'Waar Glu je mee gaat helpen';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu zet wat je hebt gedeeld om in herinneringen, ondersteuning en structuur die bij je routine past.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Zo helpt Glu je je voortgang te behouden';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Zo ondersteunt Glu je diabetesroutine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Zo ondersteunt Glu je PCOS-routine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Zo ondersteunt Glu je hartgezondheid';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Zo helpt Glu je om af te vallen';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Zie hoe Glu je helpt je huidige gewicht te beschermen en gewichtstoename vroeg te signaleren.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Zie hoe Glu je helpt maaltijden, gewicht en routines van week tot week stabieler te houden.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Zie hoe Glu je helpt stabieler te blijven rond symptomen, gewicht en routine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Zie hoe Glu je helpt consequent te blijven met de gewoonten die de hartgezondheid ondersteunen.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Zie hoe Glu je helpt de patronen te herkennen die gewicht omlaag helpen bewegen.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Zonder structuur kan gewichtstoename ongemerkt ontstaan. Glu helpt je dit eerder te signaleren en stabiel te blijven.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Zonder structuur worden patronen in maaltijden en gewicht onduidelijk. Glu houdt de signalen helderder.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Zonder structuur kunnen symptomen en routines sterker schommelen. Glu helpt je stabieler te blijven.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Zonder structuur verwateren gezonde gewoonten. Glu helpt je activiteit en gewicht op koers te houden.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Zonder structuur kan gewicht stagneren of weer stijgen. Glu helpt de voortgang in de juiste richting te houden.';

  @override
  String get onboardingBenefitsAxisWeight => 'Gewicht';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Maaltijds & gewicht';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptoms & gewicht';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Beweging & gewicht';

  @override
  String get onboardingNotificationsQuestion =>
      'Zet herinneringen aan die je doel ondersteunen';

  @override
  String get onboardingNotificationsExplainer =>
      'We gebruiken meldingen om je consistent, voorbereid en op koers te houden.';

  @override
  String get onboardingNotificationsHeadline =>
      'Stel Glu zo in dat het op het juiste moment helpt.';

  @override
  String get onboardingNotificationsBody =>
      'Zet meldingen aan zodat Glu de gewoonten kan versterken die je doel ondersteunen.';

  @override
  String get onboardingNotificationsDaily =>
      'Tijdige herinneringen die passen bij je dagelijkse medicatieritme';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Doseerherinneringen elke 14 dagen';

  @override
  String get onboardingNotificationsCustom =>
      'Herinneringen afgestemd op je eigen schema';

  @override
  String get onboardingNotificationsWeekly =>
      'Doseerherinneringen die aansluiten op je wekelijkse ritme';

  @override
  String get onboardingNotificationsSupportive =>
      'Ondersteunende herinneringen die je routine zichtbaar houden wanneer de motivatie zakt';

  @override
  String get onboardingNotificationsProgress =>
      'Tijdige duwtjes in de rug rond voortgang, gewoonten en de doelen die volgens jou het belangrijkst zijn';

  @override
  String get onboardingNotificationsHelpful =>
      'Handige meldingen die Glu nuttiger maken op de momenten dat je het nodig hebt.';

  @override
  String get onboardingDailyRoutineQuestion =>
      'Hoe ziet je dagelijkse routine eruit?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'We gebruiken dit om je plan realistisch te laten voelen voor je dagelijkse leven.';

  @override
  String get onboardingRoutineSedentary => 'Zittend';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Vooral zittend, bureauwerk en heel weinig bewuste beweging.';

  @override
  String get onboardingRoutineLightlyActive => 'Licht actief';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Enige beweging, zoals korte wandelingen of lichte dagelijkse activiteit.';

  @override
  String get onboardingRoutineActive => 'Actief';

  @override
  String get onboardingRoutineActiveDescription =>
      'Regelmatige beweging of training, zoals dagelijkse wandelingen, de sportschool of een actieve baan.';

  @override
  String get onboardingRoutineVeryActive => 'Zeer actief';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Zwaar trainen, fysiek zwaar werk of de meeste dagen hoge activiteit.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Waar maak je je zorgen over?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'We gebruiken dit om tips en begeleiding te prioriteren rond de symptomen die jij het belangrijkst vindt.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'We gebruiken dit om ons te richten op de symptomen waarvan je de controle wilt houden.';

  @override
  String get onboardingGenderQuestion => 'Hoe omschrijf je je gender?';

  @override
  String get onboardingGenderExplainer =>
      'We gebruiken dit voor relevantere begeleiding en toekomstige personalisatie.';

  @override
  String get onboardingGenderFemale => 'Vrouw';

  @override
  String get onboardingGenderMale => 'Man';

  @override
  String get onboardingGenderPreferNotToSay => 'Liever niet zeggen';

  @override
  String get onboardingTypeYourGender => 'Typ je gender';

  @override
  String get onboardingPreferredNameQuestion =>
      'Welke naam wil je dat Glu gebruikt?';

  @override
  String get onboardingPreferredNameExplainer =>
      'We gebruiken dit om Glu persoonlijker te laten aanvoelen wanneer we je aanspreken.';

  @override
  String get onboardingPreferredNameHint =>
      'Typ de naam die Glu moet gebruiken';

  @override
  String get onboardingSetupSummaryQuestion => 'Je plan wordt ingesteld';

  @override
  String get onboardingSetupSummaryExplainer =>
      'We zetten wat je hebt gedeeld om in een plan dat Glu direct kan ondersteunen.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Locking in gewicht-maintenance targets...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Koppelen van doseerondersteuning...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Herinneringen afstemmen op je routine...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Een stabieler weekschema voorbereiden...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Maaltijd- en gewichtspatronen vastleggen...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Hydratie-ondersteuning instellen...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Verfijnen van maaltijdpatronen...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Een duidelijkere dagelijkse structuur opbouwen...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Ondersteuning rond symptomen organiseren...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Wekelijkse bewegingsdoelen vastleggen...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Hydratatie- en routineankers instellen...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Een stabieler plan voorbereiden...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'Activiteitsdoelen vastleggen...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Hydratie-ondersteuning vastleggen...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Wekelijkse gewoonteherinneringen voorbereiden...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Een routine voor hartgezondheid opbouwen...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Gewichtsdoelen vastleggen...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Hoeveelheden water instellen...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Bewegingsdoelen opbouwen...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Je wekelijkse plan voorbereiden...';

  @override
  String get onboardingSetupSummaryHeadline => 'Je Glu-configuratie is klaar.';

  @override
  String get onboardingSetupLoadingTitle => 'Je configuratie wordt opgebouwd';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu is klaar om je voortgang te helpen beschermen met meer structuur en eerdere signalen van gewichtstoename.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu is klaar om stabielere maaltijden, gewichtsregistratie en gewoonten die ertoe doen in het dagelijks leven te ondersteunen.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu is klaar om stabielere routines rond symptomen, behandeling en voortgang te ondersteunen.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu is klaar om de gewoonten te versterken die je hartgezondheid op lange termijn ondersteunen.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu is klaar om de routines te ondersteunen die je helpen het gewicht eraf te houden.';

  @override
  String get onboardingSetupSummaryLabel => 'Je configuratie';

  @override
  String get onboardingSetupAdjustLater =>
      'You can adjust any of this later in Instellingen.';

  @override
  String get onboardingSummaryGoal => 'Doel';

  @override
  String get onboardingSummaryCurrentWeight => 'Huidig gewicht';

  @override
  String get onboardingSummaryMedication => 'Medicatie';

  @override
  String get onboardingSummaryCurrentDose => 'Huidige dosis';

  @override
  String get onboardingSummaryCadence => 'Frequentie';

  @override
  String get onboardingSummaryStarted => 'Gestart';

  @override
  String get onboardingSummaryTargetWeight => 'Target gewicht';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'Focus';

  @override
  String get onboardingFrequencyEveryDay => 'Elke dag';

  @override
  String get onboardingFrequencyEveryWeek => 'Elke week';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Elke 2 weken';

  @override
  String get onboardingFrequencyCustomSchedule => 'Aangepast schema';

  @override
  String get onboardingTapOptionContinue => 'Tik op een optie om door te gaan.';

  @override
  String get onboardingTypeGenderContinue => 'Typ je gender om door te gaan.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Typ je hulpmiddel om door te gaan.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Typ je medicatie om door te gaan.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Voer het aantal dagen tussen doses in om door te gaan.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Kies een schema om door te gaan.';

  @override
  String get onboardingScrollChooseAge => 'Scroll om je leeftijd te kiezen.';

  @override
  String get onboardingDragOrTapHeight =>
      'Sleep of tik op de liniaal om je lengte te kiezen.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Sleep, tik of gebruik de stapknoppen om een gewicht te kiezen.';

  @override
  String get onboardingPickDateAndWeight =>
      'Kies een datum en selecteer een gewicht om door te gaan.';

  @override
  String get onboardingSelectSymptoms =>
      'Selecteer de symptomen waarop Glu zich moet richten.';

  @override
  String get onboardingTypeName => 'Typ de naam die Glu moet gebruiken.';

  @override
  String get onboardingSaving => 'Aan het opslaan...';

  @override
  String get onboardingLetsBegin => 'Laten we beginnen';

  @override
  String get onboardingContinueWithGlu => 'Doorgaan met Glu';

  @override
  String get onboardingKeepGoing => 'Ga door';

  @override
  String get onboardingTurnOnNotifications => 'Meldingen inschakelen';

  @override
  String get onboardingFinish => 'Voltooien';

  @override
  String get onboardingTargetBmiTitle => 'Je doel-BMI';

  @override
  String get onboardingChartToday => 'Vandaag';

  @override
  String get onboardingChartOverTime => 'In de loop van de tijd';

  @override
  String get onboardingChartWithoutGlu => 'Zonder Glu';

  @override
  String get onboardingChartWithGlu => 'Met Glu';

  @override
  String get onboardingReviewQuestion =>
      'Mensen gebruiken Glu om stabiel en ondersteund te blijven';

  @override
  String get onboardingReviewExplainer =>
      'Een snelle beoordeling helpt meer mensen ondersteuning te vinden die zo simpel aanvoelt.';

  @override
  String get onboardingReviewBody =>
      'Mensen gebruiken Glu om zich meer ondersteund, consequenter en minder alleen te voelen in dit proces.';

  @override
  String get onboardingTypeYourMedication => 'Typ je medicatie';

  @override
  String get onboardingSelectStartDate => 'Startdatum kiezen';

  @override
  String get goalsSaveDialogTitle => 'Opslaan doelen?';

  @override
  String get goalsSaveDialogMessage =>
      'You have unopslaand doel changes. Opslaan them before leaving this tab?';

  @override
  String get commonLater => 'Later';

  @override
  String get homeGreetingAnonymous => 'Hallo';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hallo, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Log vandaag om je inzicht te krijgen';

  @override
  String get homeInsightEmptyBody =>
      'Log vandaag iets en je ziet vanavond je inzicht.';

  @override
  String get homeInsightLogTodayTitle => 'Maak van logs inzicht';

  @override
  String get homeInsightMoreLogsVariant1Title => 'Meer logs, beter inzicht';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Je logs beginnen een patroon te laten zien.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Je inzicht krijgt vorm';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Een paar logs extra kunnen het beeld veel duidelijker maken.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Waar de logs van vandaag op hinten';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Er zit misschien al een patroon verborgen in je dag.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Log vandaag minstens één keer om een duidelijker beeld van je voortgang te zien.';

  @override
  String get homeInsightExpandedTitle => 'Was dit nuttig?';

  @override
  String get homeInsightExpandedBody =>
      'Een snelle beoordeling helpt Glu te leren wat voor jou het belangrijkst is.';

  @override
  String get homeInsightReasonHint => 'Wat kan beter? (optioneel)';

  @override
  String get homeInsightReasonSubmit => 'Verzenden';

  @override
  String get homeInsightLearningMessage => 'Ik leer hiervan.';

  @override
  String get homeInsightChecking => 'Inzicht van vandaag controleren...';

  @override
  String get homeInsightGenerating => 'Inzicht van vandaag laden...';

  @override
  String get homeInsightTryAgain => 'Opnieuw proberen';

  @override
  String get homeSeeAllInsights => 'Alle inzichten bekijken';

  @override
  String get insightsProgressTitle => 'All inzichten';

  @override
  String get insightsProgressEmptyState =>
      'Je inzichten verschijnen hier zodra ze zijn gegenereerd.';

  @override
  String get homeDoseReminderTitle => 'Doseerherinnering';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Log hier de interactie voor $label.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Calorie doel required';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check heeft een maaltijddoel op calorieën nodig om je portie te schatten. Stel er één in bij Doelen om te beginnen.';

  @override
  String get homeSetGoal => 'Set doel';

  @override
  String get homeYourProgress => 'Je voortgang';

  @override
  String get homeRemindersShowcaseTitle => 'Blijf op koers';

  @override
  String get homeRemindersShowcaseDescription =>
      'Stel herinneringen in om doses en supplementen op tijd te houden.';

  @override
  String get homePickNextDoseDate => 'Kies je volgende doseringsdatum';

  @override
  String get homeSetReminder => 'Herinnering instellen';

  @override
  String get homeSupplementReminders => 'Supplementherinneringen';

  @override
  String get homeNoUpcomingSupplements => 'Geen aankomende meer';

  @override
  String get homeNoMoreUpcomingSupplements => 'Geen aankomende meer';

  @override
  String get homeSetUpYourSupplements => 'Stel je supplementen in';

  @override
  String get homeSetUp => 'Instellen';

  @override
  String get homeSupplementFallback => 'Supplement';

  @override
  String get doseReminderNotificationTitle => 'Klaar voor je dosis?';

  @override
  String get doseReminderFallbackBody =>
      'Open Glu om je volgende dosis te bekijken.';

  @override
  String get supplementReminderNotificationTitle => 'Tijd voor je supplement';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Vanmorgen';

  @override
  String get supplementReminderThisAfternoon => 'Vanmiddag';

  @override
  String get supplementReminderTonight => 'Vanavond';

  @override
  String get dailyReminderMorningTitle => 'Ochtendherinnering';

  @override
  String get dailyReminderMorningBodies =>
      'Ochtendmissie: geef Glu wat data om mee te spelen.\nBegin de dag met een snelle log en lekker momentum.\nSta op en log. Je toekomstige zelf zal je dankbaar zijn.\nBegin de dag met een kleine update en een flinke voorsprong.\nGeef Glu een ochtendhint en blijf in beweging.\nEen snelle log nu maakt vandaag een stuk interessanter.\nLaten we de ochtend laten tellen met een snelle check-in.';

  @override
  String get dailyReminderMiddayTitle => 'Middagherinnering';

  @override
  String get dailyReminderMiddayBodies =>
      'Middagpitstop: zet snel een log en ga lekker door.\nLunchpauze? Perfect moment om Glu een update te geven.\nHalverwege. Geef Glu snel een hint.\nEen kleine middagslog houdt het verhaal gaande.\nCheck nu in en laat de dag doorrollen.\nGeef je dag een kleine duw met een snelle update.\nHoud de energie vast met een snelle tik in de middag.';

  @override
  String get dailyReminderAfternoonTitle => 'Namiddagherinnering';

  @override
  String get dailyReminderAfternoonBodies =>
      'Bijna klaar. Geef Glu nog een broodkruimel.\nEen snelle middaglog kan vanavond extra inzicht geven.\nSluit de dag af met een kleine update en een grote winst.\nNog één log voordat de dag erop zit?\nHelp Glu de puntjes op de i zetten met een snelle middag-check-in.\nSluit de cirkel met een kleine log en houd de magie gaande.\nNog één tik nu kan het inzicht van vanavond veel beter maken.';

  @override
  String get homePortionCheckTitle => 'Portiecontrole';

  @override
  String get homePortionCheckBody => 'Know how much to eat at every maaltijd';

  @override
  String get homeGlowUpTitle => 'Jouw\nGlow up';

  @override
  String get homeGlowUpBody => 'Maak je voor-en-na-verhaal';

  @override
  String get homeGoalsStatusTitle => 'Doelen voor vandaag';

  @override
  String get homeGoalsStatusViewAll => 'Alles bekijken';

  @override
  String get homeWaterTitle => 'Water';

  @override
  String get homeWeightTitle => 'Gewicht';

  @override
  String get homeExerciseTitle => 'Beweging';

  @override
  String get homeMealsTitle => 'Maaltijds';

  @override
  String get homeCaloriesTitle => 'Calorieën';

  @override
  String get homeProteinsTitle => 'Eiwitten';

  @override
  String get homeFibersTitle => 'Vezels';

  @override
  String get homeSymptomsTitle => 'Symptomen';

  @override
  String get homeMoodTitle => 'Stemming';

  @override
  String get homeDoseTitle => 'Dosis';

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
  String get homeStartHydration => 'Begin met hydrateren';

  @override
  String get homeLogFirstSession => 'Log je eerste sessie';

  @override
  String get homeLogTodayWeight => 'Log vandaag je gewicht';

  @override
  String get homeAtYourTarget => 'Je zit op je doel';

  @override
  String get homeLogMealsToTrackCalories =>
      'Log maaltijden om calorieën te volgen';

  @override
  String get homeLogFirstMeal => 'Log je eerste maaltijd';

  @override
  String get homeTrackProteinFromMeals => 'Volg eiwitten uit maaltijden';

  @override
  String get homeTrackFiberFromMeals => 'Volg vezels uit maaltijden';

  @override
  String get homeAllClear => 'Alles in orde';

  @override
  String get homeTrackSymptoms => 'Volg symptomen';

  @override
  String get homeGreat => 'Geweldig';

  @override
  String get homeGood => 'Goed';

  @override
  String get homeBad => 'Slecht';

  @override
  String get homeOkay => 'Oké';

  @override
  String get homeLogHowYouFeel => 'Log hoe je je voelt';

  @override
  String get homeLogTodaysDose => 'Log vandaag je dosis';

  @override
  String get homeTaken => 'Ingenomen';

  @override
  String get homeStartHereTitle => 'Begin hier';

  @override
  String get homeStartHereBody =>
      'Begin met deze kaart en breid daarna uit naar de andere. Naarmate Glu meer leert over jouw traject, kan het betere patronen en inzichten tonen in de loop van de tijd.';

  @override
  String get waterLogTitle => 'Water loggen';

  @override
  String get waterLogEditTitle => 'Bewerk hydration';

  @override
  String get waterLogLogTitle => 'Water loggen';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Voeg drink ($amount)';
  }

  @override
  String get waterLogSaving => 'Aan het opslaan...';

  @override
  String get waterLogCustomDrinkTitle => 'Aangepaste drank';

  @override
  String get waterLogCustomDrinkBody =>
      'Kies de hoeveelheid die je nu wilt toevoegen.';

  @override
  String get waterLogUseThisAmount => 'Gebruik deze hoeveelheid';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount toegevoegd aan je hydratatielogboek';
  }

  @override
  String get waterLogCouldNotSave =>
      'Dit waterlogboek kon nog niet worden opgeslagen.';

  @override
  String get waterLogDeleteTitle => 'Dit hydratatielogboek verwijderen?';

  @override
  String get waterLogDeleteMessage =>
      'Deze waterinvoer verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get waterLogCouldNotDelete =>
      'Dit hydratatielogboek kon nog niet worden verwijderd.';

  @override
  String get waterLogDeleteLog => 'Log verwijderen';

  @override
  String get waterLogDeleted => 'Water verwijderd';

  @override
  String get moodLogTitle => 'Stemming';

  @override
  String get moodEditTitle => 'Bewerk stemming';

  @override
  String get moodHowYouFeel => 'Hoe voel je je?';

  @override
  String get moodBad => 'Slecht';

  @override
  String get moodOkay => 'Oké';

  @override
  String get moodGood => 'Goed';

  @override
  String get moodGreat => 'Geweldig';

  @override
  String get moodNotes => 'Notities';

  @override
  String get moodAnythingWorthRemembering =>
      'Iets dat het waard is om te onthouden over je stemming?';

  @override
  String get moodCouldNotSave => 'Kon dit stemmingslogboek nog niet opslaan.';

  @override
  String get moodDeleteTitle => 'Deze stemmingslog verwijderen?';

  @override
  String get moodDeleteMessage =>
      'Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get moodDeleteLog => 'Log verwijderen';

  @override
  String get moodSaving => 'Aan het opslaan...';

  @override
  String get moodAddMoodLog => '+ Voeg mood log';

  @override
  String get moodLogged => 'Stemming gelogd';

  @override
  String get moodDeleted => 'Stemming verwijderd';

  @override
  String get moodCouldNotDelete =>
      'Kon dit stemmingslogboek nog niet verwijderen.';

  @override
  String get moodAddedToMoodLog => 'Toegevoegd aan je stemmingslogboek';

  @override
  String get portionCheckTitle => 'Portiecontrole';

  @override
  String get portionCheckAnalyzingMeal => 'Je maaltijd analyseren…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Deze foto kon niet worden geanalyseerd.';

  @override
  String get portionCheckTakeNewPhoto => 'Maak een nieuwe foto';

  @override
  String get portionCheckSomethingWentWrong => 'Er is iets misgegaan.';

  @override
  String get portionCheckYouHitDailyLimit =>
      'Je hebt je dagelijkse limiet bereikt';

  @override
  String get portionCheckYouCanEat => 'Je kunt eten';

  @override
  String get portionCheckYouCanEatUpTo => 'Je kunt tot eten';

  @override
  String get portionCheckTryLighterOption => 'Kies een lichtere optie';

  @override
  String get portionCheckThisEntireMeal => 'this entire maaltijd';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% of this maaltijd';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'om binnen je dagelijkse doelen te blijven.';

  @override
  String get portionCheckNutritionBreakdown => 'Voedingsverdeling';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Tips om je maaltijd in balans te brengen';

  @override
  String get portionCheckTipsPool =>
      'Eet langzaam - het duurt ongeveer 20 minuten voordat het verzadigingssignaal je bereikt.\nVul de helft van je bord met groenten.\nNeem bij elke maaltijd eiwitten.\nDrink water voor de maaltijd.\nVerdeel snacks vooraf in kleine bakjes.\nCombineer koolhydraten met eiwit of vet om langer vol te blijven.\nKies waar mogelijk onbewerkte voeding.\nEet niet terwijl je wordt afgeleid door schermen.\nSla geen maaltijden over als je later daardoor meer zou eten.\nPlan je snacks voordat je honger krijgt.';

  @override
  String get portionCheckRetake => 'Opnieuw nemen';

  @override
  String get portionCheckLogThisPortion => 'Log deze portie';

  @override
  String get portionCheckCarbs => 'Koolhydraten';

  @override
  String get portionCheckProteins => 'Eiwitten';

  @override
  String get portionCheckFats => 'Vetten';

  @override
  String get portionCheckFiber => 'Vezels';

  @override
  String get mealLogScreenTitle => 'Maaltijds';

  @override
  String get mealLogEditTitle => 'Bewerk maaltijd';

  @override
  String get mealLogLogTitle => 'Log maaltijd';

  @override
  String get mealLogSaving => 'Aan het opslaan...';

  @override
  String get mealLogAddMealLog => '+ Voeg maaltijd toe';

  @override
  String get mealLogCouldNotStartRecording => 'Opname starten is mislukt.';

  @override
  String get mealLogRecordingStoppedAtLimit => 'Opname gestopt bij de limiet';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Deze opname kon niet worden geanalyseerd.';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'Deze tekst kon niet worden geanalyseerd.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Deze foto kon niet worden geanalyseerd.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Deze maaltijdfoto kon nog niet worden verwerkt.';

  @override
  String get mealLogDiscardTitle => 'Discard this maaltijd?';

  @override
  String get mealLogDiscardMessage =>
      'Je hebt een foto bekeken maar de invoer niet opgeslagen. Deze wordt niet gelogd.';

  @override
  String get mealLogDiscard => 'Verwerpen';

  @override
  String get mealLogDeleteTitle => 'Deze maaltijdlog verwijderen?';

  @override
  String get mealLogDeleteMessage =>
      'Deze maaltijdinvoer verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get mealLogDelete => 'Verwijderen';

  @override
  String get mealLogDeleteLog => 'Log verwijderen';

  @override
  String get mealLogCouldNotSave =>
      'Deze maaltijdlog kon nog niet worden opgeslagen.';

  @override
  String get mealLogCouldNotDelete =>
      'Deze maaltijdlog kon nog niet worden verwijderd.';

  @override
  String get mealLogAnalyzing => 'Analyseren...';

  @override
  String get mealLogAnalyzeText => 'Tekst analyseren';

  @override
  String get mealLogSendRecording => 'Opname verzenden';

  @override
  String get mealLogMealDefaultName => 'Maaltijd';

  @override
  String get mealLogMealNameHint => 'Maaltijd name';

  @override
  String get mealLogCouldNotPrefillTitle => 'Couldn’t prefill this maaltijd';

  @override
  String get mealLogHowMuchDidYouEat => 'Hoeveel heb je gegeten?';

  @override
  String get mealLogNotes => 'Notities';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Anything worth remembering about this maaltijd?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Je maaltijd analyseren';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'We zetten je invoer om in voedingsvelden. Je kunt alles controleren voordat je opslaat.';

  @override
  String get mealLogDescribeYourMealTitle => 'Beschrijf je maaltijd';

  @override
  String get mealLogDescribeYourMealBody =>
      'Schrijf op wat je hebt gegeten en eventuele hoeveelheden die je weet. Wij zetten het om in voedingsvelden.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Voorbeeld: gegrilde kipsalade, olijfoliedressing, 1 appel, bruiswater';

  @override
  String get mealLogCaptureYourMealTitle => 'Leg je maaltijd vast';

  @override
  String get mealLogCaptureYourMealBody =>
      'Maak een foto en wij schatten de voedingsvelden voor je in.';

  @override
  String get mealLogTakePhoto => 'Foto maken';

  @override
  String get mealLogRecordingYourMealTitle => 'Je maaltijd opnemen';

  @override
  String get mealLogRecordingReadyTitle => 'Opname klaar';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Record a maaltijd description';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tik op stoppen wanneer je klaar bent.';
  }

  @override
  String get mealLogRecordingReadyBody => 'Je kunt nu spreken of stoppen.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Praat natuurlijk over wat je hebt gegeten en wij zetten het om in macro’s.';

  @override
  String get mealLogStopRecording => 'Opname stoppen';

  @override
  String get mealLogRecordAgain => 'Opnieuw opnemen';

  @override
  String get mealLogStartRecording => 'Opname starten';

  @override
  String get mealLogBreakfast => 'Ontbijt';

  @override
  String get mealLogLunch => 'Lunch';

  @override
  String get mealLogSnack => 'Snack';

  @override
  String get mealLogDinner => 'Avondeten';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'Vandaag';

  @override
  String get mealLogYesterday => 'Gisteren';

  @override
  String mealLogKcal(Object count) {
    return 'kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal gelogd';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro gelogd';
  }

  @override
  String get mealLogDeleted => 'Maaltijd deleted';

  @override
  String get mealLogAddedToMealLog => 'Toegevoegd aan je maaltijdlog';

  @override
  String get mealLogCarbs => 'Koolhydraten';

  @override
  String get mealLogProteins => 'Eiwitten';

  @override
  String get mealLogFats => 'Vetten';

  @override
  String get mealLogFiber => 'Vezels';

  @override
  String get settingsLanguage => 'Taal';

  @override
  String get settingsLanguageDialogTitle => 'Taal kiezen';

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get settingsPreferences => 'Voorkeuren';

  @override
  String get settingsHealthGoal => 'Health doel';

  @override
  String get settingsHealthGoalDialogTitle => 'Gezondheidsdoel kiezen';

  @override
  String get settingsHabitGoals => 'Habit doelen';

  @override
  String get settingsDisabled => 'Uitgeschakeld';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count actief';
  }

  @override
  String get settingsHeight => 'Lengte';

  @override
  String get settingsAge => 'Leeftijd';

  @override
  String get settingsGender => 'Geslacht';

  @override
  String get settingsMeasurementUnit => 'Maateenheid';

  @override
  String get settingsReminders => 'Herinneringen';

  @override
  String get settingsDoseReminder => 'Doseerherinnering';

  @override
  String get settingsSupplementReminder => 'Supplementherinnering';

  @override
  String get settingsDailyReminders => 'Dagelijkse herinneringen';

  @override
  String get settingsSubscription => 'Abonnement';

  @override
  String get settingsSupport => 'Ondersteuning';

  @override
  String get settingsSendFeedback => 'Feedback verzenden';

  @override
  String get feedbackSheetTitle => 'Feedback verzenden';

  @override
  String get feedbackSheetHint => 'Vertel ons wat je ervan vindt…';

  @override
  String get feedbackSheetSend => 'Verzenden';

  @override
  String get feedbackSheetSuccess => 'Bedankt voor je feedback!';

  @override
  String get feedbackSheetError => 'Verzenden mislukt. Probeer het opnieuw.';

  @override
  String get settingsTermsOfService => 'Servicevoorwaarden';

  @override
  String get settingsPrivacyPolicy => 'Privacybeleid';

  @override
  String get settingsInternal => 'Intern';

  @override
  String get settingsSubscriptionOverride => 'Abonnementsoverschrijving';

  @override
  String get settingsTodayInsightCard => 'Inzichtkaart van vandaag';

  @override
  String get settingsResetOnboarding => 'Onboarding resetten';

  @override
  String get settingsResetShowcases => 'Showcases resetten';

  @override
  String get settingsResetUserData => 'Gebruikersgegevens resetten';

  @override
  String get settingsDeletingAccount => 'Account verwijderen...';

  @override
  String get settingsDisconnect => 'Ontkoppelen';

  @override
  String get settingsDeleteAccount => 'Account verwijderen';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Ontkoppel provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Provider ontkoppelen?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Hiermee wordt de externe aanmelding voor dit account verwijderd.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Account verwijderen?';

  @override
  String get settingsDeleteAccountBody =>
      'Hiermee wordt je account en al je gegevens permanent verwijderd. Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Typ DELETE om te bevestigen';

  @override
  String get settingsDeleteAccountError =>
      'Er is iets misgegaan bij het verwijderen van je account. Neem contact op met support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Herstart de app om onboarding te zien';

  @override
  String get settingsShowcasesReset => 'Showcases gereset';

  @override
  String get settingsResetUserDataTitle => 'Gebruikersgegevens resetten?';

  @override
  String get settingsResetUserDataBody =>
      'Hiermee worden alle gelogde gegevens voor maaltijden, water, beweging, gewicht, stemming, symptomen, supplementen en doses gewist.';

  @override
  String get settingsUserDataReset => 'Gebruikersgegevens gereset';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Opslaan gelukt, maar dagelijkse herinneringen konden nu niet worden gepland.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Abonnementsoverschrijving';

  @override
  String get settingsSubscriptionOverrideAuto => 'Automatisch';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Forceer gratis';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Forceer Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Inzichtkaart van vandaag';

  @override
  String get settingsTodayInsightCardAuto => 'Automatisch';

  @override
  String get settingsTodayInsightCardOn => 'Aan';

  @override
  String get settingsTodayInsightCardOff => 'Uit';

  @override
  String get settingsYourName => 'Je naam';

  @override
  String get settingsSignOut => 'Uitloggen';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'ft/in';

  @override
  String get settingsHeightFt => 'ft';

  @override
  String get settingsHeightIn => 'in';

  @override
  String get settingsGenderMale => 'Man';

  @override
  String get settingsGenderFemale => 'Vrouw';

  @override
  String get settingsGenderPreferNotToSay => 'Liever niet zeggen';

  @override
  String get settingsGenderOther => 'Anders';

  @override
  String get settingsYourProfile => 'Je profiel';

  @override
  String get settingsNotSet => 'Niet ingesteld';

  @override
  String settingsYears(Object value) {
    return 'jaar';
  }

  @override
  String get settingsOff => 'Uit';

  @override
  String get settingsOn => 'Aan';

  @override
  String get settingsNoneSet => 'Niet ingesteld';

  @override
  String settingsSupplementCount(Object count) {
    return '$count supplement(en)';
  }

  @override
  String get commonToday => 'Vandaag';

  @override
  String get mainShellHome => 'Start';

  @override
  String get mainShellLog => 'Logboek';

  @override
  String get mainShellProgress => 'Voortgang';

  @override
  String get mainShellSettings => 'Instellingen';

  @override
  String get mainShellLogShowcaseTitle => 'Logboek';

  @override
  String get mainShellLogShowcaseDescription =>
      'Log elke dag de activiteiten die voor jou het belangrijkst zijn.';

  @override
  String get logWaterShowcaseTitle => 'Begin met water';

  @override
  String get logWaterShowcaseDescription =>
      'Log nu water en blijf daarna de rest loggen zodat Glu gewoonten en patronen nauwkeuriger kan herkennen.';

  @override
  String get mainShellProgressShowcaseTitle => 'Bekijk je voortgang';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Controleer je patronen en trends om te begrijpen hoe je gewoonten en gewicht in de loop van de tijd veranderen.';

  @override
  String get progressMenuShowcaseTitle => 'Verken je gegevens';

  @override
  String get progressMenuShowcaseDescription =>
      'Bekijk alle grafieken, lees AI-gegenereerde inzichten of maak een doktersrapport om te delen met je zorgteam.';

  @override
  String get settingsFeedbackShowcaseTitle => 'We horen graag je feedback';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Tik hier om te delen wat werkt, wat niet werkt of welke ideeën je hebt.';

  @override
  String get authCouldNotOpenLink => 'Kan de link nu niet openen.';

  @override
  String get authWelcomeTitle => 'Welkom bij Glu';

  @override
  String get authSubtitle => 'Veilige aanmelding voor je wellness-assistent';

  @override
  String get authContinueWithGoogle => 'Doorgaan met Google';

  @override
  String get authContinueWithApple => 'Doorgaan met Apple';

  @override
  String get authEmailHint => 'e-mailadres@voorbeeld.com';

  @override
  String get authSending => 'Versturen...';

  @override
  String get authResendLink => 'Link opnieuw verzenden';

  @override
  String get authUseDifferentEmail => 'Gebruik een ander e-mailadres';

  @override
  String get habitGoalsTitle => 'Habit doelen';

  @override
  String get goalsProteins => 'Eiwitten';

  @override
  String get goalsFibers => 'Vezels';

  @override
  String goalsGramsPerDay(Object value) {
    return 'g/dag';
  }

  @override
  String get goalsWater => 'Water';

  @override
  String goalsLitersPerDay(Object value) {
    return 'L/dag';
  }

  @override
  String get goalsExercise => 'Beweging';

  @override
  String goalsMinutesPerDay(Object value) {
    return 'min/dag';
  }

  @override
  String get goalsMeals => 'Maaltijds';

  @override
  String get goalsCalories => 'Calorieën';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => '/week';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count maaltijden per day';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return 'calorieën/dag';
  }

  @override
  String get goalsWeight => 'Gewicht';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Voeg a logged gewicht to calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'Je zit al op dit doel';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '~$value $unit/week naar doel';
  }

  @override
  String get goalsSetTargetForNextWeek =>
      'Stel het doel voor volgende week in.';

  @override
  String get progressWeightTitle => 'Gewicht';

  @override
  String get progressWeightLabel => 'Gewicht ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Gezonde BMI';

  @override
  String get progressTotal => 'Totaal';

  @override
  String get progressPercent => 'Percentage';

  @override
  String get progressWeeklyAvg => 'Wekelijks gemiddelde';

  @override
  String get progressRangeAllTime => 'Alles';

  @override
  String get progressRange1Month => '1 maand';

  @override
  String get progressRange3Months => '3 maanden';

  @override
  String get progressRange6Months => '6 maanden';

  @override
  String get progressLow => 'Laag';

  @override
  String get progressMed => 'Gemiddeld';

  @override
  String get progressHigh => 'Hoog';

  @override
  String get progressSeverity => 'Ernst';

  @override
  String get progressBad => 'Slecht';

  @override
  String get progressOkay => 'Oké';

  @override
  String get progressGood => 'Goed';

  @override
  String get progressGreat => 'Geweldig';

  @override
  String get progressMostlyBad => 'Meestal slecht';

  @override
  String get progressMostlyOkay => 'Meestal oké';

  @override
  String get progressMostlyGood => 'Meestal goed';

  @override
  String get progressMostlyGreat => 'Meestal geweldig';

  @override
  String get progressNoDose => 'Geen dosis';

  @override
  String get progressLogged => 'Gelogd';

  @override
  String get progressAllClear => 'Alles in orde';

  @override
  String get progressFreq => 'Frequentie';

  @override
  String get progressAverage => 'Gemiddeld';

  @override
  String get progressDaily => 'Dagelijks';

  @override
  String get progressWeekly => 'Wekelijks';

  @override
  String get progressMinutes => 'Minuten';

  @override
  String get progressIntensity => 'Intensiteit';

  @override
  String get progressCalories => 'Calorieën';

  @override
  String get progressByDose => 'Per dosis';

  @override
  String get progressWeightProgressTitle => 'Gewichtsvoortgang';

  @override
  String get progressWaterProgressTitle => 'Watervoortgang';

  @override
  String get progressExerciseProgressTitle => 'Bewegingsvoortgang';

  @override
  String get progressDoseProgressTitle => 'Dose voortgang';

  @override
  String get progressMealsProgressTitle => 'Maaltijds voortgang';

  @override
  String get progressSymptomsProgressTitle => 'Symptoms voortgang';

  @override
  String get progressMoodProgressTitle => 'Stemmingsvoortgang';

  @override
  String get progressWeightChangeTitle => 'Gewicht change';

  @override
  String get progressTitle => 'Voortgang';

  @override
  String get progressMenuViewAllInsights => 'Alle inzichten bekijken';

  @override
  String get progressMenuViewAllCharts => 'Alle grafieken bekijken';

  @override
  String get progressMenuCreateDoctorReport => 'Doktersrapport maken';

  @override
  String get progressReportGenerating => 'Je rapport wordt gemaakt…';

  @override
  String get progressReportError =>
      'Het rapport kon niet worden gemaakt. Probeer het opnieuw.';

  @override
  String get progressReportPendingRetry =>
      'Je rapport wordt mogelijk zo meteen nog voltooid. Probeer het opnieuw.';

  @override
  String get progressReportOpenError =>
      'Je rapport is gegenereerd, maar we konden het niet openen. Probeer het opnieuw.';

  @override
  String get progressReportOpenedInBrowser =>
      'Rapport klaar. Geopend in je browser.';

  @override
  String get progressReportCopiedLink =>
      'Rapport klaar. Delen was niet beschikbaar, dus de link is naar je klembord gekopieerd.';

  @override
  String get progressAllProgressTitle => 'All voortgang';

  @override
  String get progressWeightTrendExplanation =>
      'Zie hoe je gewicht in de loop van de tijd verandert.';

  @override
  String get progressNoWeightLogsYet => 'No gewicht logs yet';

  @override
  String get progressNoLogsYet => 'Nog geen logs';

  @override
  String get progressLogWeightToStartTrend =>
      'Log gewicht om je trend te beginnen volgen.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Log gewicht en dosis om te vergelijken hoe dosering samenhangt met verandering.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Elk punt is gekleurd op basis van de laatste dosis vóór die weging.';

  @override
  String get progressNoHydrationYet => 'Nog geen hydratatie';

  @override
  String get progressNoMovementYet => 'Nog geen beweging';

  @override
  String get progressNoDoseLogsYet => 'Nog geen dosislogs';

  @override
  String get progressNoMealsLoggedYet => 'No maaltijden logged yet';

  @override
  String get progressNoSymptomsLoggedYet => 'Nog geen symptomen gelogd';

  @override
  String get progressNoMoodLogsYet => 'Nog geen stemmingslogs';

  @override
  String get progressFutureTrendTitle => 'Toekomstige trend';

  @override
  String get progressFutureTrendBody => 'Een mooie tijdlijn van je momentum';

  @override
  String get progressGoal => 'Doel';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Je laatst gelogde gewicht is klaar om te volgen.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Ongeveer $gap $unit van je doel.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText ten opzichte van je vorige log.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText ten opzichte van de vorige log. $gap $unit van het doel.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Vergeleken met je vorige log is de trend nu zichtbaar.';

  @override
  String get progressWaterTitle => 'Water';

  @override
  String get manageSubscriptionTitle => 'Beheer abonnement';

  @override
  String get manageSubscriptionProPlan => 'Pro-abonnement';

  @override
  String get manageSubscriptionFreePlan => 'Gratis abonnement';

  @override
  String get manageSubscriptionActiveCopy => 'Je abonnement is actief.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Upgrade om Glu Pro te ontgrendelen.';

  @override
  String get manageSubscriptionPlan => 'Abonnement';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratis';

  @override
  String get manageSubscriptionProduct => 'Product';

  @override
  String get manageSubscriptionRenewal => 'Verlenging';

  @override
  String get manageSubscriptionStatus => 'Status';

  @override
  String get manageSubscriptionStatusActive => 'Actief';

  @override
  String get manageSubscriptionStatusInactive => 'Inactief';

  @override
  String get manageSubscriptionManageButton => 'Beheren';

  @override
  String get manageSubscriptionUpgradeButton => 'Upgrade naar Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Open abonnementinstellingen in de store';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Aankopen herstellen';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Wordt automatisch verlengd';

  @override
  String get manageSubscriptionLifetime => 'Levenslang';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Wordt verlengd op';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Verloopt op';
  }

  @override
  String get supplementReminderDayMon => 'Ma';

  @override
  String get supplementReminderDayTue => 'Di';

  @override
  String get supplementReminderDayWed => 'Wo';

  @override
  String get supplementReminderDayThu => 'Do';

  @override
  String get supplementReminderDayFri => 'Vr';

  @override
  String get supplementReminderDaySat => 'Za';

  @override
  String get supplementReminderDaySun => 'Zo';

  @override
  String supplementReminderInDays(Object count) {
    return 'Over $count dagen';
  }

  @override
  String get supplementReminderInOneWeek => 'Over 1 week';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Over $count weken';
  }

  @override
  String get subscriptionDebugTitle => 'Abonnementsdebug';

  @override
  String get subscriptionDebugMonthly => 'Maandelijks';

  @override
  String get subscriptionDebugYearly => 'Jaarlijks';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Klantgegevens vernieuwen';

  @override
  String get subscriptionDebugPresentPaywall => 'Paywall tonen';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Open klantencentrum';

  @override
  String get subscriptionDebugRestorePurchases => 'Aankopen herstellen';

  @override
  String get subscriptionDebugSyncPurchases => 'Aankopen synchroniseren';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat-status';

  @override
  String get subscriptionDebugConfigured => 'Geconfigureerd';

  @override
  String get subscriptionDebugBusy => 'Bezig';

  @override
  String get subscriptionDebugAppUserId => 'App-gebruiker-ID';

  @override
  String get subscriptionDebugAnonymous => 'Anoniem';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-sleutel beschikbaar';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro actief';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Actieve abonnementen';

  @override
  String get subscriptionDebugManagementUrl => 'Beheerders-URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Entitlement-product';

  @override
  String get subscriptionDebugWillRenew => 'Wordt verlengd';

  @override
  String get subscriptionDebugExpiration => 'Vervaldatum';

  @override
  String get subscriptionDebugLifetime => 'Levenslang';

  @override
  String get subscriptionDebugPackageFound => 'Pakket gevonden';

  @override
  String get subscriptionDebugProductId => 'Product-ID';

  @override
  String get subscriptionDebugTitleLabel => 'Titel';

  @override
  String get subscriptionDebugPrice => 'Prijs';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Koop $title';
  }

  @override
  String get progressExerciseTitle => 'Beweging';

  @override
  String get progressDoseTitle => 'Dosis';

  @override
  String get progressMealsTitle => 'Maaltijds';

  @override
  String get progressSymptomsTitle => 'Symptomen';

  @override
  String get progressMoodTitle => 'Stemming';

  @override
  String get progressTrend => 'Trend';

  @override
  String get progressTarget => 'Doel';

  @override
  String get progressNoTrendYet => 'Nog geen trend';

  @override
  String get progressNoActivityYet => 'Nog geen activiteit';

  @override
  String get progressNoCheckInsYet => 'Nog geen check-ins';

  @override
  String get progressWeightSignatureChip =>
      'Gewicht wordt je kenmerkende grafiek';

  @override
  String get progressWeightStartTrendTitle => 'Begin je trend met één weging';

  @override
  String get progressWeightStartTrendBody =>
      'Deze grafiek staat centraal in jouw voortgangsverhaal. Log je eerste gewicht om momentum, mijlpalen en een deelbaar overzicht te ontgrendelen.';

  @override
  String get progressWeightMomentum => 'Gewichts-momentum';

  @override
  String get progressWeightMilestones => 'Gewichtsmijlpalen';

  @override
  String get progressWeightShareReady => 'Klaar om te delen';

  @override
  String get progressWeightLogWeight => 'Gewicht loggen';

  @override
  String get weightProgressUnlocksViewChip =>
      'Je eerste weging ontgrendelt dit overzicht';

  @override
  String get weightProgressStartsHereTitle =>
      'Jouw voortgangsverhaal begint hier';

  @override
  String get weightProgressStartsHereBody =>
      'Log je eerste gewicht om trends, mijlpalen en dosisbewuste inzichten te ontgrendelen in een overzicht dat de moeite waard is om te delen.';

  @override
  String get weightProgressTrendView => 'Trendweergave';

  @override
  String get weightProgressDoseOverlays => 'Doseerlagen';

  @override
  String get weightProgressMilestones => 'Mijlpalen';

  @override
  String get weightProgressLogWeight => 'Gewicht loggen';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Voeg eerst een voor- en na-foto toe.';

  @override
  String get glowUpSavedToGallery => 'Opgeslagen in je galerij';

  @override
  String get glowUpSaveToGallery => 'Opslaan in galerij';

  @override
  String get glowUpYourProgress => 'Je voortgang';

  @override
  String get glowUpWeightChange => 'Gewicht change';

  @override
  String get glowUpTime => 'Tijd';

  @override
  String get glowUpShare => 'Delen';

  @override
  String get glowUpBefore => 'Voor';

  @override
  String get glowUpAfter => 'Na';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight in $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'dagen';

  @override
  String get glowUpTimeUnitWeeksLabel => 'weken';

  @override
  String get glowUpTimeUnitMonthsLabel => 'maanden';

  @override
  String get glowUpTimeUnitYearsLabel => 'jaar';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagen',
      one: '$count dag',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count weken',
      one: '$count week',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count maanden',
      one: '$count maand',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jaar',
      one: '$count jaar',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Gisteren';

  @override
  String get commonSelect => 'Selecteren';

  @override
  String get doseReminderTitle => 'Doseerherinnering';

  @override
  String get doseReminderCustomDoseTitle => 'Aangepaste dosis';

  @override
  String get doseReminderCustomDoseHint => 'Voer je dosis in mg in';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Houd je volgende dosis klaar op Start.';

  @override
  String get doseReminderTime => 'Tijd';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Schakel dit in om de volgende dosis op Start te tonen.';

  @override
  String get doseReminderSaveReminder => 'Herinnering opslaan';

  @override
  String loggedOn(Object date) {
    return 'Gelogd op';
  }

  @override
  String get waterLogSmallGlass => 'Klein glas';

  @override
  String get waterLogGlass => 'Glas';

  @override
  String get waterLogBottle => 'Fles';

  @override
  String get waterLogLargeBottle => 'Grote fles';

  @override
  String get waterLogTwoLiters => '2 liter';

  @override
  String get waterLogCustomPreset => 'Aangepast';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dosis loggen';

  @override
  String get doseLogEditTitle => 'Bewerk dose';

  @override
  String get doseLogLogTitle => 'Dosis loggen';

  @override
  String get doseLogCustomDose => 'Aangepaste dosis';

  @override
  String get doseLogCustomDoseBody =>
      'Pas de dosis in mg aan voor deze invoer.';

  @override
  String get doseLogUseThisDose => 'Gebruik deze dosis';

  @override
  String get doseLogMedication => 'Medicatie';

  @override
  String get doseLogInjectionSite => 'Injectieplaats';

  @override
  String get doseLogNotes => 'Notities';

  @override
  String get doseLogSaveChanges => 'Opslaan changes';

  @override
  String get doseLogAddDose => '+ Dosis loggen';

  @override
  String get doseLogDeleteTitle => 'Deze dosisinvoer verwijderen?';

  @override
  String get doseLogDeleteMessage =>
      'Deze dosisinvoer verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get doseLogDeleteLog => 'Log verwijderen';

  @override
  String get doseLogSaving => 'Aan het opslaan...';

  @override
  String get doseLogCouldNotSave =>
      'Deze dosisinvoer kon nog niet worden opgeslagen.';

  @override
  String get doseLogCouldNotDelete =>
      'Deze dosisinvoer kon nog niet worden verwijderd.';

  @override
  String get doseLogDeleted => 'Dosis verwijderd';

  @override
  String get doseLogAddedToDoseLog => 'Toegevoegd aan je dosislogboek';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Iets dat het waard is om te onthouden?';

  @override
  String get doseLogDoseLabel => 'Dosis';

  @override
  String get exerciseLogTitle => 'Beweging';

  @override
  String get exerciseLogEditTitle => 'Bewerk beweging';

  @override
  String get exerciseLogLogTitle => 'Beweging loggen';

  @override
  String get exerciseLogActivityType => 'Activiteitstype';

  @override
  String get exerciseLogCustomActivity => 'Aangepaste activiteit';

  @override
  String get exerciseLogTypeActivity => 'Typ de activiteit';

  @override
  String get exerciseLogDuration => 'Duur';

  @override
  String get exerciseLogIntensity => 'Intensiteit';

  @override
  String get exerciseLogNotes => 'Notities';

  @override
  String get exerciseLogLight => 'Licht';

  @override
  String get exerciseLogModerate => 'Gemiddeld';

  @override
  String get exerciseLogIntense => 'Intensief';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min gelogd';
  }

  @override
  String get exerciseLogSaveChanges => 'Opslaan changes';

  @override
  String get exerciseLogAddExercise => '+ Voeg bewegingslog toe';

  @override
  String get exerciseLogDeleteTitle => 'Deze bewegingslog verwijderen?';

  @override
  String get exerciseLogDeleteMessage =>
      'Deze bewegingslog verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get exerciseLogDeleteLog => 'Log verwijderen';

  @override
  String get exerciseLogSaving => 'Aan het opslaan...';

  @override
  String get exerciseLogCouldNotSave =>
      'Deze bewegingslog kon nog niet worden opgeslagen.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Deze bewegingslog kon nog niet worden verwijderd.';

  @override
  String get exerciseLogDeleted => 'Beweging verwijderd';

  @override
  String get exerciseLogAddedToExerciseLog =>
      'Toegevoegd aan je bewegingslogboek';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Iets dat het waard is om te onthouden?';

  @override
  String get exerciseLogWalking => 'Wandelen';

  @override
  String get exerciseLogRunning => 'Hardlopen';

  @override
  String get exerciseLogCycling => 'Fietsen';

  @override
  String get exerciseLogStrength => 'Krachttraining';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Zwemmen';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Gewicht';

  @override
  String get weightLogEditTitle => 'Bewerk gewicht';

  @override
  String get weightLogLogTitle => 'Gewicht loggen';

  @override
  String get weightLogSaveChanges => 'Opslaan changes';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Voeg gewicht ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Deze gewichtsinvoer verwijderen?';

  @override
  String get weightLogDeleteMessage =>
      'Deze gewichtsinvoer verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get weightLogDeleteLog => 'Log verwijderen';

  @override
  String get weightLogSaving => 'Aan het opslaan...';

  @override
  String get weightLogCouldNotSave =>
      'Dit gewichtlogboek kon nog niet worden opgeslagen.';

  @override
  String get weightLogCouldNotDelete =>
      'Dit gewichtlogboek kon nog niet worden verwijderd.';

  @override
  String get weightLogDeleted => 'Gewicht verwijderd';

  @override
  String get weightLogAddedToWeightLog => 'Toegevoegd aan je gewichtlogboek';

  @override
  String get weightLogNoWeightForDay => 'No gewicht logged for this day yet.';

  @override
  String get injectionSiteAbdomen => 'Buik';

  @override
  String get injectionSiteThigh => 'Bovenbeen';

  @override
  String get injectionSiteUpperArm => 'Bovenarm';

  @override
  String get injectionSiteButtocks => 'Bil';

  @override
  String get injectionSiteAbdomenUpperLeft => 'Bovenlinks buik';

  @override
  String get injectionSiteAbdomenUpperRight => 'Bovenrechts buik';

  @override
  String get injectionSiteAbdomenLowerRight => 'Onderrechts buik';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Onderlinks buik';

  @override
  String get injectionSiteThighUpperLeft => 'Bovenlinks bovenbeen';

  @override
  String get injectionSiteThighUpperRight => 'Bovenrechts bovenbeen';

  @override
  String get injectionSiteThighLowerRight => 'Onderrechts bovenbeen';

  @override
  String get injectionSiteThighLowerLeft => 'Onderlinks bovenbeen';

  @override
  String get injectionSiteUpperArmLeft => 'Linker bovenarm';

  @override
  String get injectionSiteUpperArmRight => 'Rechter bovenarm';

  @override
  String get injectionSiteButtocksUpperLeft => 'Bovenlinks bil';

  @override
  String get injectionSiteButtocksUpperRight => 'Bovenrechts bil';

  @override
  String get doseReminderFormat => 'Vorm';

  @override
  String get doseReminderInjection => 'Injectie';

  @override
  String get doseReminderPill => 'Pil';

  @override
  String get doseReminderSite => 'Locatie';

  @override
  String get doseReminderDate => 'Datum';

  @override
  String get supplementReminderTitle => 'Supplementherinnering';

  @override
  String get supplementReminderAddSupplement => 'Supplement toevoegen';

  @override
  String get supplementReminderNoSupplementsYet => 'Nog geen supplementen';

  @override
  String get supplementReminderAddFirstBody =>
      'Voeg je eerste supplementherinnering toe om je dagelijkse inname te volgen.';

  @override
  String get supplementReminderSupplementFallback => 'Supplement';

  @override
  String get supplementReminderEveryDay => 'Elke dag';

  @override
  String get supplementReminderEveryXDaysLabel => 'Elke X dagen';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Elke $interval dagen';
  }

  @override
  String get supplementReminderNoDaysSet => 'Geen dagen ingesteld';

  @override
  String get supplementReminderSupplementName => 'Supplementnaam';

  @override
  String get supplementReminderTime => 'Tijd';

  @override
  String get supplementReminderStartDate => 'Startdatum';

  @override
  String get supplementReminderRepeat => 'Herhalen';

  @override
  String get supplementReminderDaysOfWeek => 'Dagen van de week';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Selecteer minstens één dag.';

  @override
  String get supplementReminderEvery => 'Elke';

  @override
  String get supplementReminderDay => 'Dag';

  @override
  String get supplementReminderDays => 'Dagen';

  @override
  String get supplementReminderAdd => 'Voeg';

  @override
  String get symptomsLogTitle => 'Symptomen';

  @override
  String get symptomsLogEditTitle => 'Bewerk symptoms';

  @override
  String get symptomsLogLogTitle => 'Symptomen loggen';

  @override
  String get symptomsLogSymptomsExperienced => 'Ervaren symptomen';

  @override
  String get symptomsLogNoSymptoms => 'Geen symptomen';

  @override
  String get symptomsLogNoSymptomsToday => 'Vandaag geen symptomen';

  @override
  String get symptomsLogOther => 'Overig';

  @override
  String get symptomsLogSeverityLevel => 'Ernstniveau';

  @override
  String get symptomsLogNotes => 'Notities';

  @override
  String get symptomsLogAnxiety => 'Angst';

  @override
  String get symptomsLogBelching => 'Boeren';

  @override
  String get symptomsLogBloating => 'Opgeblazen gevoel';

  @override
  String get symptomsLogConstipation => 'Obstipatie';

  @override
  String get symptomsLogDiarrhea => 'Diarree';

  @override
  String get symptomsLogFatigue => 'Vermoeidheid';

  @override
  String get symptomsLogFoodNoise => 'Eetdrang';

  @override
  String get symptomsLogHairLoss => 'Haaruitval';

  @override
  String get symptomsLogHeartburn => 'Brandend maagzuur';

  @override
  String get symptomsLogIndigestion => 'Spijsverteringsklachten';

  @override
  String get symptomsLogInjectionSiteReaction => 'Reactie op injectieplek';

  @override
  String get symptomsLogMetallicTaste => 'Metaalsmaak';

  @override
  String get symptomsLogHeadache => 'Hoofdpijn';

  @override
  String get symptomsLogMoodSwings => 'Stemmingswisselingen';

  @override
  String get symptomsLogNausea => 'Misselijkheid';

  @override
  String get symptomsLogReflux => 'Reflux';

  @override
  String get symptomsLogStomachPain => 'Buikpijn';

  @override
  String get symptomsLogSuppressedAppetite => 'Verminderde eetlust';

  @override
  String get symptomsLogVomiting => 'Braken';

  @override
  String get symptomsLogLogged => 'Gelogd';

  @override
  String get symptomsLogMild => 'Licht';

  @override
  String get symptomsLogModerate => 'Matig';

  @override
  String get symptomsLogSevere => 'Ernstig';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Iets dat het waard is om te onthouden?';

  @override
  String get symptomsLogSaveChanges => 'Opslaan changes';

  @override
  String get symptomsLogAddSymptoms => '+ Voeg symptoomlog toe';

  @override
  String get symptomsLogDeleteTitle => 'Deze symptoomlog verwijderen?';

  @override
  String get symptomsLogDeleteMessage =>
      'Deze symptoomlog verwijderen? Deze actie kan niet ongedaan worden gemaakt.';

  @override
  String get symptomsLogDeleteLog => 'Log verwijderen';

  @override
  String get symptomsLogSaving => 'Aan het opslaan...';

  @override
  String get symptomsLogCouldNotSave =>
      'Deze symptoomlog kon nog niet worden opgeslagen.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Deze symptoomlog kon nog niet worden verwijderd.';

  @override
  String get symptomsLogDeleted => 'Symptoomlog verwijderd';

  @override
  String get symptomsLogAddedToSymptomsLog =>
      'Toegevoegd aan je symptoomlogboek';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return 'van het dagdoel';
  }

  @override
  String get commonDisclaimer =>
      'Glu is een trackingtool, geen medisch hulpmiddel. Het geeft geen medisch advies, diagnose of behandeling. Raadpleeg altijd je zorgverlener over je medicatie en gezondheidsbeslissingen.';
}
