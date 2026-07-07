// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Vaknar upp...';

  @override
  String get startupFailed => 'Uppstart misslyckades';

  @override
  String get commonCancel => 'Avbryt';

  @override
  String get commonSave => 'Spara';

  @override
  String get commonSaving => 'Sparar...';

  @override
  String get commonContinue => 'Fortsätt';

  @override
  String get commonSkip => 'Hoppa över';

  @override
  String get commonDelete => 'Ta bort';

  @override
  String get commonNotNow => 'Inte nu';

  @override
  String get commonNow => 'Nu';

  @override
  String get commonTomorrow => 'I morgon';

  @override
  String get noteTriggerAddNote => 'Lägg till anteckning';

  @override
  String get noteTriggerCancelNote => 'Avbryt anteckning';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'Om $count dagar';
  }

  @override
  String get homeDoseReminderInOneWeek => 'Om 1 vecka';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'Om $count veckor';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Förföll för 1 dag sedan';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Förföll för $count dagar sedan';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Förföll för 1 vecka sedan';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Förföll för $count veckor sedan';
  }

  @override
  String get bmiIndicatorYourBmi => 'Ditt BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Ditt nuvarande BMI';

  @override
  String get bmiIndicatorUnderweight => 'Underviktig';

  @override
  String get bmiIndicatorNormal => 'Normal';

  @override
  String get bmiIndicatorOverweight => 'Överviktig';

  @override
  String get bmiIndicatorObesity => 'Obesitas';

  @override
  String get heightRulerCmUnit => 'cm';

  @override
  String get heightRulerFtUnit => 'fot';

  @override
  String get heightRulerInUnit => 'tum';

  @override
  String get heightRulerFtInUnit => 'fot/tum';

  @override
  String get weightDialKgUnit => 'kg';

  @override
  String get weightDialLbUnit => 'lb';

  @override
  String get logNoteIndicatorHasNote => 'Har anteckning';

  @override
  String get paywallTitle => 'Lås upp Glu Pro';

  @override
  String get paywallSubtitle => 'Utan Pro förlorar du detta:';

  @override
  String get paywallMonthlyTitle => 'Månatlig';

  @override
  String get paywallMonthlySubtitle => 'Ingen provperiod';

  @override
  String get paywallYearlyTitle => 'Årlig';

  @override
  String get paywallYearlySubtitle => '7 dagars gratis provperiod';

  @override
  String get paywallNoCommitment => 'Inga förpliktelser';

  @override
  String get paywallCancelAnytime => 'Avsluta när som helst';

  @override
  String get paywallContinue => 'Fortsätt';

  @override
  String get paywallRestore => 'Återställ';

  @override
  String get paywallTerms => 'Villkor';

  @override
  String get paywallPrivacy => 'Sekretess';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Spara $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Kunde inte öppna länken just nu.';

  @override
  String get paywallAlreadySubscribed => 'Du har redan Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Välkommen till Glu Pro!';

  @override
  String get paywallPurchaseIncomplete => 'Köpet slutfördes inte. Försök igen.';

  @override
  String get paywallPurchaseFailed => 'Köpet misslyckades. Försök igen.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Köpet misslyckades: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Prenumerationen återställdes!';

  @override
  String get paywallRestoreNoSubscription =>
      'Ingen aktiv prenumeration hittades.';

  @override
  String get paywallRestoreFailed =>
      'Återställningen misslyckades. Försök igen.';

  @override
  String get paywallBenefitReminders => 'Missade doser utan påminnelser';

  @override
  String get paywallBenefitShareProgress => 'Svårare att dela din utveckling';

  @override
  String get paywallBenefitSpotRegain => 'Tecken på viktuppgång missas';

  @override
  String get paywallBenefitInsights => 'Dina dagliga mönster missas';

  @override
  String get paywallBenefitWeeklyGoals => 'Din veckostruktur försvinner';

  @override
  String get paywallBenefitHealthyHabits => 'Vanor glider iväg utan stöd';

  @override
  String get onboardingWelcomeTitle => 'Håll vikten nere';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu hjälper dig att skydda din framgång kring behandling, mål och veckovanor.';

  @override
  String get onboardingWelcomeBullet1 => 'Passar din behandling och dina mål';

  @override
  String get onboardingWelcomeBullet2 => 'Enkelt och realistiskt stöd';

  @override
  String get onboardingWelcomeBullet3 => 'Se tidiga tecken på viktuppgång';

  @override
  String get onboardingWelcomeBullet4 =>
      'Fortsätt utan att börja om från början';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Tar du just nu en viktminskningspenna eller tablett?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Vi använder detta för att visa vägledning som passar där du är just nu.';

  @override
  String get onboardingMedicationStatusUsing => 'Ja, jag tar den nu';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Ja, jag trappar ner';

  @override
  String get onboardingMedicationStatusNotTaking => 'Nej, jag tar den inte';

  @override
  String get onboardingMedicationStatusStartingSoon => 'Nej, jag börjar snart';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Nej, jag har nyligen slutat';

  @override
  String get onboardingMedicationMethodQuestion => 'Hur tar du din medicin?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Vi använder detta för att anpassa instruktioner och påminnelser efter din medicinform.';

  @override
  String get onboardingMedicationMethodInjection => 'Injektion';

  @override
  String get onboardingMedicationMethodPill => 'Tablett';

  @override
  String get onboardingMedicationMethodUnknown => 'Jag vet inte än';

  @override
  String get onboardingMedicationNameQuestion => 'Vilken medicin tar du?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Vi använder detta för att anpassa dosuppföljning och medicinspecifik vägledning.';

  @override
  String get onboardingCurrentDoseQuestion => 'Vad är din nuvarande dos?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Vi använder detta för att anpassa dosuppföljning och framtida progresscheckar.';

  @override
  String get onboardingMedicationCustomDose => 'Anpassad';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Vilken enhet använder du för att ta din medicin?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Vi använder detta för att göra påminnelser och tips som passar hur du tar den.';

  @override
  String get onboardingDeviceSinglePen => 'Engångspenna';

  @override
  String get onboardingDeviceAutoInjector => 'Autoinjektor';

  @override
  String get onboardingDeviceSyringeAndVial => 'Spruta och injektionsflaska';

  @override
  String get onboardingOther => 'Annat';

  @override
  String get onboardingTypeYourDevice => 'Skriv din enhet';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Hur ofta tar du din medicin?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Vi använder detta för att tajma påminnelser och rutinstöd efter ditt schema.';

  @override
  String get onboardingEveryDay => 'Varje dag';

  @override
  String get onboardingEvery7Days => 'Var 7:e dag';

  @override
  String get onboardingEvery14Days => 'Var 14:e dag';

  @override
  String get onboardingCustom => 'Anpassad';

  @override
  String get onboardingDaysBetweenDoses => 'Dagar mellan doser';

  @override
  String get onboardingPrimaryGoalQuestion => 'Vad är ditt huvudmål just nu?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Vi använder detta för att fokusera din plan, dina påminnelser och din utveckling på det som betyder mest för dig.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Vi använder detta för att forma din plan från allra första början.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Vi använder detta för att stötta din nästa fas och hjälpa dig hålla kursen.';

  @override
  String get onboardingGoalLoseWeight => 'Gå ner i vikt';

  @override
  String get onboardingGoalMaintainWeight => 'Behålla min vikt';

  @override
  String get onboardingGoalManageDiabetes => 'Hantera min diabetes';

  @override
  String get onboardingGoalManagePcos => 'Hantera min PCOS';

  @override
  String get onboardingGoalImproveHeartHealth => 'Förbättra min hjärthälsa';

  @override
  String get onboardingAgeQuestion => 'Hur gammal är du?';

  @override
  String get onboardingAgeExplainer =>
      'Vi använder detta för att anpassa vägledning och hälsoberäkningar mer korrekt.';

  @override
  String get onboardingHeightQuestion => 'Hur lång är du?';

  @override
  String get onboardingHeightExplainer =>
      'Vi använder detta tillsammans med din vikt för att räkna ut sådant som BMI och hälsosamma intervall.';

  @override
  String get onboardingWeightQuestion => 'Vad väger du just nu?';

  @override
  String get onboardingWeightExplainer =>
      'Vi använder detta som din utgångspunkt för utveckling, mål och hälsoestimat.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'När slutade du med medicinen?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'När började du trappa ner medicinen?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'När började du med medicinen?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Vi använder detta för att förstå din senaste behandlingshistorik och nästa fas.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Vi använder detta för att förstå din övergångsfas och stötta de vanor som betyder mest just nu.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Vi använder detta för att förstå hur länge du har varit på behandling och följa förändring över tid.';

  @override
  String get onboardingGoalWeightQuestion => 'Vad är din målvikt?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Vi använder detta för att rama in utvecklingen och visa ett målintervall för BMI.';

  @override
  String get onboardingBenefitsQuestion =>
      'Vad Glu hjälper dig att göra härnäst';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu omvandlar det du delade till påminnelser, stöd och struktur som passar din vardag.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Så här kan Glu hjälpa dig behålla din framgång';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Så här kan Glu stötta din diabetesrutin';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Så här kan Glu stötta din PCOS-rutin';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Så här kan Glu stötta din hjärthälsa';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Så här kan Glu hjälpa dig gå ner i vikt';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Se hur Glu hjälper dig skydda din nuvarande vikt och upptäcka återgång tidigare.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Se hur Glu hjälper dig hålla måltider, vikt och rutiner jämnare vecka för vecka.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Se hur Glu hjälper dig hålla dig jämnare kring symtom, vikt och rutin.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Se hur Glu hjälper dig hålla fast vid vanorna som stödjer hjärthälsa.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Se hur Glu hjälper dig upptäcka mönstren som får vikten att fortsätta nedåt.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Utan struktur kan återgång smyga sig på. Glu hjälper dig upptäcka det tidigare och hålla kursen.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Utan struktur blir måltider och viktmönster otydliga. Glu gör signalerna klarare.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Utan struktur kan symtom och rutiner svänga mer. Glu hjälper dig hålla dig stabilare.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Utan struktur glider hälsosamma vanor lätt iväg. Glu hjälper dig hålla aktivitet och vikt på rätt spår.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Utan struktur kan vikten stanna upp eller börja glida uppåt. Glu hjälper dig hålla utvecklingen i rätt riktning.';

  @override
  String get onboardingBenefitsAxisWeight => 'Vikt';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Måltider och vikt';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symtom och vikt';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Träning och vikt';

  @override
  String get onboardingNotificationsQuestion =>
      'Slå på påminnelser som stödjer ditt mål';

  @override
  String get onboardingNotificationsExplainer =>
      'Vi använder notiser för att hjälpa dig hålla jämnhet, vara förberedd och hålla kursen.';

  @override
  String get onboardingNotificationsHeadline =>
      'Ställ in Glu så den hjälper vid rätt tillfälle.';

  @override
  String get onboardingNotificationsBody =>
      'Slå på notiser så att Glu kan förstärka de vanor som stödjer ditt mål.';

  @override
  String get onboardingNotificationsDaily =>
      'Tidsatta påminnelser som matchar din dagliga medicinrytm';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Påminnelser på längre sikt så att dosdagar inte smyger sig på';

  @override
  String get onboardingNotificationsCustom =>
      'Påminnelser formade efter ditt eget schema';

  @override
  String get onboardingNotificationsWeekly =>
      'Påminnelser om doser som följer din veckorytm';

  @override
  String get onboardingNotificationsSupportive =>
      'Stödjande påminnelser som gör rutinen synlig när motivationen dippar';

  @override
  String get onboardingNotificationsProgress =>
      'Tidsenliga puffar kring framsteg, vanor och de mål du sagt är viktigast';

  @override
  String get onboardingNotificationsHelpful =>
      'Hjälpsamma påminnelser som gör Glu mer användbar när du behöver det';

  @override
  String get onboardingDailyRoutineQuestion => 'Hur ser din dagliga rutin ut?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Vi använder detta för att göra din plan realistisk för vardagen.';

  @override
  String get onboardingRoutineSedentary => 'Stillasittande';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Mest sittande, kontorsarbete och väldigt lite avsiktlig träning.';

  @override
  String get onboardingRoutineLightlyActive => 'Lätt aktiv';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regelbundna promenader, ärenden eller lätta pass några gånger i veckan.';

  @override
  String get onboardingRoutineActive => 'Aktiv';

  @override
  String get onboardingRoutineActiveDescription =>
      'Mycket rörelse eller träning, som dagliga promenader, gym eller aktivt arbete.';

  @override
  String get onboardingRoutineVeryActive => 'Mycket aktiv';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hård träning, fysiskt krävande arbete eller hög aktivitet de flesta dagar.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Vilka symtom oroar dig mest, om några?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Vi använder detta för att prioritera tips och vägledning kring de symtom du bryr dig mest om.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Vi använder detta för att fokusera på de symtom du vill ligga steget före med.';

  @override
  String get onboardingGenderQuestion => 'Hur beskriver du ditt kön?';

  @override
  String get onboardingGenderExplainer =>
      'Vi använder detta för mer relevant vägledning och framtida anpassning.';

  @override
  String get onboardingGenderFemale => 'Kvinna';

  @override
  String get onboardingGenderMale => 'Man';

  @override
  String get onboardingGenderPreferNotToSay => 'Vill inte ange';

  @override
  String get onboardingTypeYourGender => 'Skriv ditt kön';

  @override
  String get onboardingPreferredNameQuestion => 'Vad ska vi kalla dig?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Vi använder detta för att göra Glu mer personligt när vi pratar med dig.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Ställer in din plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Vi omvandlar det du delade till en plan som Glu kan stötta direkt.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Låser in mål för viktunderhåll...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Ställer in bevakningspunkter för viktuppgång...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Anpassar påminnelser efter din rutin...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Förbereder en mer stabil veckoplan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Definierar mönster för måltider och vikt...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Ställer in stöd för vätskeintag...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Förbereder påminnelser om jämnhet...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Bygger en tydligare daglig struktur...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Organiserar stöd för symtom...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Definierar veckomål för rörelse...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Ställer in vätska och rutinfästen...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Förbereder en stabilare plan...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'Ställer in aktivitetsmål...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Definierar stöd för vätskeintag...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Förbereder veckovisa vanepåminnelser...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Bygger en rutin för hjärthälsa...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Definierar kaloriegränser...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Ställer in vattenmängder...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 => 'Bygger träningsmål...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Förbereder din veckoplan...';

  @override
  String get onboardingSetupSummaryHeadline => 'Din Glu-inställning är klar.';

  @override
  String get onboardingSetupLoadingTitle => 'Bygger din inställning';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu är redo att hjälpa dig skydda din framgång med tydligare struktur och tidigare signaler om viktuppgång.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu är redo att stötta jämnare måltider, viktuppföljning och vanor som betyder något varje dag.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu är redo att stötta jämnare rutiner kring symtom, behandling och framsteg.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu är redo att förstärka vanor som stödjer din långsiktiga hjärthälsa.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu är redo att stötta de rutiner som hjälper dig hålla vikten nere.';

  @override
  String get onboardingSetupSummaryLabel => 'Sammanfattning';

  @override
  String get onboardingSetupAdjustLater =>
      'Du kan ändra allt detta senare i Inställningar.';

  @override
  String get onboardingSummaryGoal => 'Mål';

  @override
  String get onboardingSummaryCurrentWeight => 'Nuvarande vikt';

  @override
  String get onboardingSummaryMedication => 'Medicin';

  @override
  String get onboardingSummaryCurrentDose => 'Nuvarande dos';

  @override
  String get onboardingSummaryCadence => 'Frekvens';

  @override
  String get onboardingSummaryStarted => 'Startad';

  @override
  String get onboardingSummaryTargetWeight => 'Målvikt';

  @override
  String get onboardingSummaryRoutine => 'Rutin';

  @override
  String get onboardingSummaryFocus => 'Fokus';

  @override
  String get onboardingFrequencyEveryDay => 'Varje dag';

  @override
  String get onboardingFrequencyEveryWeek => 'Varje vecka';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Varannan vecka';

  @override
  String get onboardingFrequencyCustomSchedule => 'Eget schema';

  @override
  String get onboardingTapOptionContinue =>
      'Tryck på ett alternativ för att fortsätta.';

  @override
  String get onboardingTypeGenderContinue =>
      'Skriv ditt kön för att fortsätta.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Skriv din enhet för att fortsätta.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Skriv din medicin för att fortsätta.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Ange dagar mellan doser för att fortsätta.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Välj ett schema för att fortsätta.';

  @override
  String get onboardingScrollChooseAge => 'Skrolla för att välja din ålder.';

  @override
  String get onboardingDragOrTapHeight =>
      'Dra eller tryck på linjalen för att välja din längd.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Dra, tryck eller använd stegnapparna för att välja en vikt.';

  @override
  String get onboardingPickDateAndWeight =>
      'Välj ett datum och en vikt för att fortsätta.';

  @override
  String get onboardingSelectSymptoms =>
      'Välj de symtom som Glu ska fokusera på.';

  @override
  String get onboardingTypeName => 'Skriv namnet du vill att Glu ska använda.';

  @override
  String get onboardingSaving => 'Sparar...';

  @override
  String get onboardingLetsBegin => 'Låt oss börja';

  @override
  String get onboardingContinueWithGlu => 'Fortsätt med Glu';

  @override
  String get onboardingKeepGoing => 'Fortsätt';

  @override
  String get onboardingTurnOnNotifications => 'Slå på notiser';

  @override
  String get onboardingFinish => 'Slutför';

  @override
  String get onboardingTargetBmiTitle => 'Ditt mål-BMI';

  @override
  String get onboardingChartToday => 'I dag';

  @override
  String get onboardingChartOverTime => 'Över tid';

  @override
  String get onboardingChartWithoutGlu => 'Utan Glu';

  @override
  String get onboardingChartWithGlu => 'Med Glu';

  @override
  String get onboardingReviewQuestion =>
      'Människor använder Glu för att hålla sig stabila och få stöd';

  @override
  String get onboardingReviewExplainer =>
      'En snabb betygssättning hjälper fler att hitta stöd som känns lika enkelt.';

  @override
  String get onboardingReviewBody =>
      'Människor använder Glu för att känna sig mer stöttade, mer konsekventa och mindre ensamma i processen.';

  @override
  String get onboardingTypeYourMedication => 'Skriv din medicin';

  @override
  String get onboardingSelectStartDate => 'Välj startdatum';

  @override
  String get goalsSaveDialogTitle => 'Spara mål?';

  @override
  String get goalsSaveDialogMessage =>
      'Du har osparade målförändringar. Spara dem innan du lämnar fliken?';

  @override
  String get commonLater => 'Senare';

  @override
  String get homeGreetingAnonymous => 'Hej';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hej, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Logga i dag för att se insikten';

  @override
  String get homeInsightEmptyBody =>
      'Logga något i dag så ser du din insikt i kväll.';

  @override
  String get homeInsightLogTodayTitle => 'Gör loggar till insikt';

  @override
  String get homeInsightMoreLogsVariant1Title => 'Fler loggar, bättre insikt';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Dina loggar börjar visa ett mönster.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Din insikt tar form';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Några loggar till kan göra bilden mycket tydligare.';

  @override
  String get homeInsightMoreLogsVariant3Title => 'Vad dagens loggar antyder';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Det kan redan finnas ett mönster gömt i din dag.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Logga minst en gång i dag för att få en tydligare bild av din framgång.';

  @override
  String get homeInsightExpandedTitle => 'Var detta hjälpsamt?';

  @override
  String get homeInsightExpandedBody =>
      'Ett snabbt betyg hjälper Glu att förstå vad som betyder mest för dig.';

  @override
  String get homeInsightReasonHint => 'Vad kan bli bättre? (valfritt)';

  @override
  String get homeInsightReasonSubmit => 'Skicka';

  @override
  String get homeInsightLearningMessage => 'Jag lär mig av detta.';

  @override
  String get homeInsightChecking => 'Kontrollerar dagens insikt...';

  @override
  String get homeInsightGenerating => 'Laddar dagens insikt...';

  @override
  String get homeInsightTryAgain => 'Försök igen';

  @override
  String get homeSeeAllInsights => 'Se alla insikter';

  @override
  String get insightsProgressTitle => 'Alla insikter';

  @override
  String get insightsProgressEmptyState =>
      'Dina insikter visas här när de har genererats.';

  @override
  String get homeDoseReminderTitle => 'Dospåminnelse';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Logik för $label-interaktion hamnar här.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Kalorimål krävs';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check behöver ett måltidsmål satt till kalorier för att kunna uppskatta din portion. Ställ in ett i Mål för att börja.';

  @override
  String get homeSetGoal => 'Ställ in mål';

  @override
  String get homeYourProgress => 'Din utveckling';

  @override
  String get homeRemindersShowcaseTitle => 'Håll kursen';

  @override
  String get homeRemindersShowcaseDescription =>
      'Ställ in påminnelser så att du inte missar doser och tillskott.';

  @override
  String get homePickNextDoseDate => 'Välj datum för nästa dos';

  @override
  String get homeSetReminder => 'Ställ in påminnelse';

  @override
  String get homeSupplementReminders => 'Påminnelser om tillskott';

  @override
  String get homeNoUpcomingSupplements => 'Inga kommande tillskott';

  @override
  String get homeNoMoreUpcomingSupplements => 'Inga fler kommande';

  @override
  String get homeSetUpYourSupplements => 'Ställ in dina tillskott';

  @override
  String get homeSetUp => 'Ställ in';

  @override
  String get homeSupplementFallback => 'Tillskott';

  @override
  String get doseReminderNotificationTitle => 'Dags för din dos?';

  @override
  String get doseReminderFallbackBody => 'Öppna Glu för att se din nästa dos.';

  @override
  String get supplementReminderNotificationTitle => 'Dags för ditt tillskott';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'I morse';

  @override
  String get supplementReminderThisAfternoon => 'I eftermiddag';

  @override
  String get supplementReminderTonight => 'I kväll';

  @override
  String get dailyReminderMorningTitle => 'Morgoncheck-in';

  @override
  String get dailyReminderMorningBodies =>
      'Morgonuppdrag: ge Glu lite data att jobba med.\nStarta dagen med en snabb logg och bra fart.\nUpp och logga. Ditt framtida jag kommer tacka dig.\nBörja dagen med en liten uppdatering och en stor start.\nGe Glu en morgonledtråd och fortsätt framåt.\nEn snabb logg nu kan göra dagen mycket mer intressant.\nLåt oss göra morgonen värd något med en snabb check-in.';

  @override
  String get dailyReminderMiddayTitle => 'Lunchcheck-in';

  @override
  String get dailyReminderMiddayBodies =>
      'Lunchstopp: lägg in en snabb logg och fortsätt rulla.\nLunchrast? Perfekt läge att ge Glu en uppdatering.\nHalvvägs där. Ge Glu en snabb ledtråd.\nEn liten lunchlogg kan hålla berättelsen igång.\nChecka in nu och låt dagen fortsätta.\nGe dagen en liten puff med en snabb uppdatering.\nHåll energin uppe med ett snabbt lunchtryck.';

  @override
  String get dailyReminderAfternoonTitle => 'Eftermiddagscheck-in';

  @override
  String get dailyReminderAfternoonBodies =>
      'Nästan klart. Ge Glu en ledtråd till.\nEn snabb eftermiddagslogg kan göra kvällsinsikten skarpare.\nAvsluta dagen med en liten uppdatering och en stor vinst.\nEn logg till innan dagen är slut?\nHjälp Glu koppla ihop pusselbitarna med en snabb eftermiddagscheck-in.\nAvsluta dagen med en liten logg och fortsätt magin.\nEtt sista tryck nu kan göra kvällsinsikten mycket bättre.';

  @override
  String get homePortionCheckTitle => 'Portionskontroll';

  @override
  String get homePortionCheckBody =>
      'Vet hur mycket du ska äta vid varje måltid';

  @override
  String get homeGlowUpTitle => 'Din\nförvandling';

  @override
  String get homeGlowUpBody => 'Skapa din före-och-efter-historia';

  @override
  String get homeDoctorReportTitle => 'Läkarrapport';

  @override
  String get homeDoctorReportBody => 'Dela dina framsteg med din läkare';

  @override
  String get homeGoalsStatusTitle => 'Dagens mål';

  @override
  String get homeGoalsStatusViewAll => 'Visa alla';

  @override
  String get homeWaterTitle => 'Vatten';

  @override
  String get homeWeightTitle => 'Vikt';

  @override
  String get homeExerciseTitle => 'Träning';

  @override
  String get homeMealsTitle => 'Måltider';

  @override
  String get homeCaloriesTitle => 'Kalorier';

  @override
  String get homeProteinsTitle => 'Proteiner';

  @override
  String get homeFibersTitle => 'Fibrer';

  @override
  String get homeSymptomsTitle => 'Symtom';

  @override
  String get homeMoodTitle => 'Humör';

  @override
  String get homeCravingsTitle => 'Sug';

  @override
  String get homeDoseTitle => 'Dos';

  @override
  String get homeMedicationLevelTitle => 'Uppskattad läkemedelsnivå';

  @override
  String get homeMedicationLevelInfoTitle => 'Så tolkar du diagrammet';

  @override
  String get homeMedicationLevelInfoBody =>
      'Det här diagrammet uppskattar hur mycket av ditt läkemedel som fortfarande kan vara aktivt, baserat på de doser du registrerat och läkemedlets halveringstid.\n\nHögre punkter betyder oftast en nyare eller större dos. Linjen sjunker med tiden när läkemedlet försvinner ur kroppen.\n\nAnvänd detta som en trendvy, inte som en exakt mätning eller medicinsk rekommendation.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Uppfattat';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Registrera dina doser så att Glu kan uppskatta hur mycket läkemedel som fortfarande är aktivt i din kropp.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'av senaste toppen';

  @override
  String get homeMedicationLevelActiveNow => 'Aktivt nu';

  @override
  String get homeMedicationLevelHalfLife => 'Halveringstid';

  @override
  String get homeMedicationLevelLastDose => 'Senaste dosen';

  @override
  String get homeStartHydration => 'Börja med vatten';

  @override
  String get homeLogFirstSession => 'Logga ditt första pass';

  @override
  String get homeLogTodayWeight => 'Logga dagens vikt';

  @override
  String get homeAtYourTarget => 'Du är på ditt mål';

  @override
  String get homeLogMealsToTrackCalories =>
      'Logga måltider för att följa kalorierna';

  @override
  String get homeLogFirstMeal => 'Logga din första måltid';

  @override
  String get homeTrackProteinFromMeals => 'Följ protein från måltiderna';

  @override
  String get homeTrackFiberFromMeals => 'Följ fibrer från måltiderna';

  @override
  String get homeAllClear => 'Allt klart';

  @override
  String get homeTrackSymptoms => 'Följ symtom';

  @override
  String get homeGreat => 'Bra';

  @override
  String get homeGood => 'Okej';

  @override
  String get homeBad => 'Dåligt';

  @override
  String get homeOkay => 'Okej';

  @override
  String get homeLogHowYouFeel => 'Logga hur du mår';

  @override
  String get homeLogACraving => 'Logga ett sug';

  @override
  String get homeLogTodaysDose => 'Logga dagens dos';

  @override
  String get homeTaken => 'Tagen';

  @override
  String get homeStartHereTitle => 'Börja här';

  @override
  String get homeStartHereBody =>
      'Börja med detta kort och bygg sedan vidare på andra. När Glu lär sig mer om din resa kan den visa bättre mönster och insikter över tid.';

  @override
  String get waterLogTitle => 'Vätska';

  @override
  String get waterLogEditTitle => 'Redigera vätska';

  @override
  String get waterLogLogTitle => 'Logga vatten';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Lägg till dryck ($amount)';
  }

  @override
  String get waterLogSaving => 'Sparar...';

  @override
  String get waterLogCustomDrinkTitle => 'Anpassad dryck';

  @override
  String get waterLogCustomDrinkBody => 'Välj mängden du vill lägga till nu.';

  @override
  String get waterLogUseThisAmount => 'Använd denna mängd';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount tillagt i din vätskelogg';
  }

  @override
  String get waterLogCouldNotSave => 'Kunde inte spara denna vattenlogg ännu.';

  @override
  String get waterLogDeleteTitle => 'Ta bort denna vätskelogg?';

  @override
  String get waterLogDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get waterLogCouldNotDelete =>
      'Kunde inte ta bort denna vätskelogg ännu.';

  @override
  String get waterLogDeleteLog => 'Ta bort logg';

  @override
  String get waterLogDeleted => 'Vätska borttagen';

  @override
  String get moodLogTitle => 'Humör';

  @override
  String get moodEditTitle => 'Redigera humör';

  @override
  String get moodHowYouFeel => 'Hur du mår';

  @override
  String get moodBad => 'Dåligt';

  @override
  String get moodOkay => 'Okej';

  @override
  String get moodGood => 'Bra';

  @override
  String get moodGreat => 'Jättebra';

  @override
  String get moodNotes => 'Anteckningar';

  @override
  String get moodAnythingWorthRemembering =>
      'Är det något värt att komma ihåg om ditt humör?';

  @override
  String get moodCouldNotSave => 'Kunde inte spara denna humörlogg ännu.';

  @override
  String get moodDeleteTitle => 'Ta bort denna humörlogg?';

  @override
  String get moodDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get moodDeleteLog => 'Ta bort logg';

  @override
  String get moodSaving => 'Sparar...';

  @override
  String get moodAddMoodLog => '+ Lägg till humörlogg';

  @override
  String get moodLogged => 'Humör loggat';

  @override
  String get moodDeleted => 'Humör borttaget';

  @override
  String get moodCouldNotDelete => 'Kunde inte ta bort denna humörlogg ännu.';

  @override
  String get moodAddedToMoodLog => 'Tillagt i din humörlogg';

  @override
  String get cravingsLogTitle => 'Sug';

  @override
  String get cravingsEditTitle => 'Redigera sug';

  @override
  String get cravingsWhatsGoingOn => 'Vad som händer';

  @override
  String get cravingsTypeGeneral => 'Lust att äta';

  @override
  String get cravingsTypeSweet => 'Något sött';

  @override
  String get cravingsTypeSalty => 'Något salt';

  @override
  String get cravingsIntensityLabel => 'Intensitet (valfritt)';

  @override
  String get cravingsIntensityMild => 'Milt';

  @override
  String get cravingsIntensityModerate => 'Måttligt';

  @override
  String get cravingsIntensityStrong => 'Starkt';

  @override
  String get cravingsOutcomeLabel => 'Vad som hände (valfritt)';

  @override
  String get cravingsOutcomeResisted => 'Stod emot';

  @override
  String get cravingsOutcomeGaveIn => 'Gav efter';

  @override
  String get cravingsNotes => 'Anteckningar';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Är det något värt att komma ihåg om detta sug?';

  @override
  String get cravingsCouldNotSave => 'Kunde inte spara denna sugloggen ännu.';

  @override
  String get cravingsDeleteTitle => 'Ta bort denna sugloggen?';

  @override
  String get cravingsDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get cravingsDeleteLog => 'Ta bort logg';

  @override
  String get cravingsSaving => 'Sparar...';

  @override
  String get cravingsAddLog => '+ Lägg till sug';

  @override
  String get cravingsLogged => 'Sug loggat';

  @override
  String get cravingsDeleted => 'Sug borttaget';

  @override
  String get cravingsCouldNotDelete =>
      'Kunde inte ta bort denna sugloggen ännu.';

  @override
  String get cravingsAddedToLog => 'Tillagt i din suglogg';

  @override
  String get portionCheckTitle => 'Portionskontroll';

  @override
  String get portionCheckAnalyzingMeal => 'Analyserar din måltid…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Kunde inte analysera detta foto';

  @override
  String get portionCheckTakeNewPhoto => 'Ta ett nytt foto';

  @override
  String get portionCheckSomethingWentWrong => 'Något gick fel.';

  @override
  String get portionCheckYouHitDailyLimit => 'Du har nått din dagliga gräns';

  @override
  String get portionCheckYouCanEat => 'Du kan äta';

  @override
  String get portionCheckYouCanEatUpTo => 'Du kan äta upp till';

  @override
  String get portionCheckTryLighterOption =>
      'Försök med ett lättare alternativ eller hoppa över detta';

  @override
  String get portionCheckThisEntireMeal => 'hela denna måltid';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% av denna måltid';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'för att hålla dig inom dina dagliga mål.';

  @override
  String get portionCheckNutritionBreakdown => 'Näringsfördelning';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Tips för att balansera din måltid';

  @override
  String get portionCheckTipsPool =>
      'Ät långsamt - det tar ungefär 20 minuter innan mättnadssignalerna hinner ikapp.\nFyll halva tallriken med grönsaker.\nHa med protein i varje måltid.\nDrick vatten före måltider.\nFördela mellanmål i små behållare i förväg.\nKombinera kolhydrater med protein eller fett för att hålla dig mätt längre.\nVälj helst hela och minimalt bearbetade livsmedel.\nUndvik att äta medan du blir distraherad av skärmar.\nHoppa inte över måltider om det får dig att överäta senare.\nPlanera dina mellanmål innan du blir hungrig.';

  @override
  String get portionCheckRetake => 'Ta om';

  @override
  String get portionCheckLogThisPortion => 'Logga denna portion';

  @override
  String get portionCheckCarbs => 'Kolhydrater';

  @override
  String get portionCheckProteins => 'Proteiner';

  @override
  String get portionCheckFats => 'Fetter';

  @override
  String get portionCheckFiber => 'Fibrer';

  @override
  String get mealLogScreenTitle => 'Måltider';

  @override
  String get mealLogEditTitle => 'Redigera måltid';

  @override
  String get mealLogLogTitle => 'Logga måltid';

  @override
  String get mealLogSaving => 'Sparar...';

  @override
  String get mealLogAddMealLog => '+ Lägg till måltidslogg';

  @override
  String get mealLogCouldNotStartRecording => 'Kunde inte starta inspelningen.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'Inspelningen stoppades vid 60 sekunder.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Kunde inte analysera denna inspelning.';

  @override
  String get mealLogCouldNotAnalyzeText => 'Kunde inte analysera denna text.';

  @override
  String get mealLogCouldNotAnalyzePhoto => 'Kunde inte analysera detta foto.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Kunde inte bearbeta detta matfoto ännu.';

  @override
  String get mealLogDiscardTitle => 'Kasta denna måltid?';

  @override
  String get mealLogDiscardMessage =>
      'Du granskade ett foto men sparade inte posten. Den kommer inte att loggas.';

  @override
  String get mealLogDiscard => 'Kasta';

  @override
  String get mealLogDeleteTitle => 'Ta bort denna måltidslogg?';

  @override
  String get mealLogDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get mealLogDelete => 'Ta bort';

  @override
  String get mealLogDeleteLog => 'Ta bort logg';

  @override
  String get mealLogCouldNotSave => 'Kunde inte spara denna måltidslogg ännu.';

  @override
  String get mealLogCouldNotDelete =>
      'Kunde inte ta bort denna måltidslogg ännu.';

  @override
  String get mealLogAnalyzing => 'Analyserar...';

  @override
  String get mealLogAnalyzeText => 'Analysera text';

  @override
  String get mealLogSendRecording => 'Skicka inspelning';

  @override
  String get mealLogMealDefaultName => 'Måltid';

  @override
  String get mealLogMealNameHint => 'Måltidsnamn';

  @override
  String get mealLogCouldNotPrefillTitle => 'Kunde inte förfylla denna måltid';

  @override
  String get mealLogHowMuchDidYouEat => 'Hur mycket åt du?';

  @override
  String get mealLogNotes => 'Anteckningar';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Är det något värt att komma ihåg om denna måltid?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analyserar din måltid';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Vi omvandlar din input till näringsfält. Du kan granska allt innan du sparar.';

  @override
  String get mealLogDescribeYourMealTitle => 'Beskriv din måltid';

  @override
  String get mealLogDescribeYourMealBody =>
      'Skriv vad du åt och de mängder du känner till. Vi gör om det till näringsfält.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Exempel: grillad kycklingsallad, olivoljedressing, 1 äpple, bubbelvatten';

  @override
  String get mealLogCaptureYourMealTitle => 'Fota din måltid';

  @override
  String get mealLogCaptureYourMealBody =>
      'Ta ett foto så uppskattar vi näringsfälten åt dig.';

  @override
  String get mealLogTakePhoto => 'Ta foto';

  @override
  String get mealLogRecordingYourMealTitle => 'Spelar in din måltid';

  @override
  String get mealLogRecordingReadyTitle => 'Inspelningen är klar';

  @override
  String get mealLogRecordMealDescriptionTitle => 'Spela in måltidsbeskrivning';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tryck på stopp när du är klar. ${remaining}s kvar';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Skicka nedan för analys eller spela in igen.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Berätta naturligt om vad du åt så tolkar vi det till makron.';

  @override
  String get mealLogStopRecording => 'Stoppa inspelning';

  @override
  String get mealLogRecordAgain => 'Spela in igen';

  @override
  String get mealLogStartRecording => 'Börja spela in';

  @override
  String get mealLogBreakfast => 'Frukost';

  @override
  String get mealLogLunch => 'Lunch';

  @override
  String get mealLogSnack => 'Mellanmål';

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
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal loggat';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro loggat';
  }

  @override
  String get mealLogDeleted => 'Måltid borttagen';

  @override
  String get mealLogAddedToMealLog => 'Tillagt i din måltidslogg';

  @override
  String get mealLogCarbs => 'Kolhydrater';

  @override
  String get mealLogProteins => 'Proteiner';

  @override
  String get mealLogFats => 'Fetter';

  @override
  String get mealLogFiber => 'Fibrer';

  @override
  String get settingsLanguage => 'Språk';

  @override
  String get settingsLanguageDialogTitle => 'Välj språk';

  @override
  String get settingsTitle => 'Inställningar';

  @override
  String get settingsPreferences => 'Inställningar';

  @override
  String get settingsHealthGoal => 'Hälsomål';

  @override
  String get settingsHealthGoalDialogTitle => 'Välj hälsomål';

  @override
  String get settingsHabitGoals => 'Vanemål';

  @override
  String get settingsDisabled => 'Avstängt';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count aktiva';
  }

  @override
  String get settingsHeight => 'Längd';

  @override
  String get settingsAge => 'Ålder';

  @override
  String get settingsGender => 'Kön';

  @override
  String get settingsMeasurementUnit => 'Mätenhet';

  @override
  String get settingsReminders => 'Påminnelser';

  @override
  String get settingsDoseReminder => 'Dospåminnelse';

  @override
  String get settingsSupplementReminder => 'Tillskottspåminnelse';

  @override
  String get settingsDailyReminders => 'Dagliga påminnelser';

  @override
  String get settingsSubscription => 'Prenumeration';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsSendFeedback => 'Skicka feedback';

  @override
  String get feedbackSheetTitle => 'Skicka feedback';

  @override
  String get feedbackSheetHint => 'Berätta vad du tycker…';

  @override
  String get feedbackSheetSend => 'Skicka';

  @override
  String get feedbackSheetSuccess => 'Tack för din feedback!';

  @override
  String get feedbackSheetError => 'Det gick inte att skicka. Försök igen.';

  @override
  String get settingsTermsOfService => 'Användarvillkor';

  @override
  String get settingsPrivacyPolicy => 'Integritetspolicy';

  @override
  String get settingsInternal => 'Internt';

  @override
  String get settingsSubscriptionOverride => 'Prenumerationsöverskridning';

  @override
  String get settingsTodayInsightCard => 'Kortet Dagens insikt';

  @override
  String get settingsResetOnboarding => 'Återställ onboarding';

  @override
  String get settingsResetShowcases => 'Återställ guider';

  @override
  String get settingsResetUserData => 'Återställ användardata';

  @override
  String get settingsDeletingAccount => 'Tar bort konto...';

  @override
  String get settingsDisconnect => 'Koppla från';

  @override
  String get settingsDeleteAccount => 'Ta bort konto';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Koppla från $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Koppla från $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Du kommer inte längre kunna logga in med $provider på den här enheten om du inte kopplar in det igen senare.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Ta bort konto?';

  @override
  String get settingsDeleteAccountBody =>
      'Detta tar permanent bort ditt konto och all din data. Den här åtgärden kan inte ångras.';

  @override
  String get settingsDeleteAccountConfirmHint =>
      'Skriv DELETE för att bekräfta';

  @override
  String get settingsDeleteAccountError =>
      'Något gick fel när vi tog bort ditt konto. Kontakta support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Starta om appen för att se onboarding';

  @override
  String get settingsShowcasesReset => 'Guider återställda';

  @override
  String get settingsResetUserDataTitle => 'Återställa användardata?';

  @override
  String get settingsResetUserDataBody =>
      'Detta rensar alla loggade poster för måltider, vatten, träning, vikt, humör, symtom, tillskott och doser.';

  @override
  String get settingsUserDataReset => 'Användardata återställd';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Sparat, men dagliga påminnelser kunde inte schemaläggas just nu.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Prenumerationsöverskridning';

  @override
  String get settingsSubscriptionOverrideAuto => 'Auto';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Tvinga Free';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Tvinga Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Kortet Dagens insikt';

  @override
  String get settingsTodayInsightCardAuto => 'Auto';

  @override
  String get settingsTodayInsightCardOn => 'På';

  @override
  String get settingsTodayInsightCardOff => 'Av';

  @override
  String get settingsYourName => 'Ditt namn';

  @override
  String get settingsSignOut => 'Logga ut';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'fot/tum';

  @override
  String get settingsHeightFt => 'fot';

  @override
  String get settingsHeightIn => 'tum';

  @override
  String get settingsGenderMale => 'Man';

  @override
  String get settingsGenderFemale => 'Kvinna';

  @override
  String get settingsGenderPreferNotToSay => 'Vill inte ange';

  @override
  String get settingsGenderOther => 'Annat';

  @override
  String get settingsYourProfile => 'Din profil';

  @override
  String get settingsNotSet => 'Inte angivet';

  @override
  String settingsYears(Object value) {
    return '$value år';
  }

  @override
  String get settingsOff => 'Av';

  @override
  String get settingsOn => 'På';

  @override
  String get settingsNoneSet => 'Inget valt';

  @override
  String settingsSupplementCount(Object count) {
    return '$count tillskott';
  }

  @override
  String get commonToday => 'I dag';

  @override
  String get mainShellHome => 'Hem';

  @override
  String get mainShellLog => 'Logg';

  @override
  String get mainShellProgress => 'Utveckling';

  @override
  String get mainShellSettings => 'Inställningar';

  @override
  String get mainShellLogShowcaseTitle =>
      'Logga det som betyder något varje dag';

  @override
  String get mainShellLogShowcaseDescription =>
      'Logga de aktiviteter som betyder mest för dig, varje dag.';

  @override
  String get logMoodShowcaseTitle => 'Börja med ditt humör';

  @override
  String get logMoodShowcaseDescription =>
      'Logga ditt humör först och fortsätt sedan med resten så att Glu kan se vanor och mönster tydligare.';

  @override
  String get mainShellProgressShowcaseTitle => 'Se din utveckling';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Kolla dina mönster och trender för att förstå hur dina vanor och din vikt förändras över tid.';

  @override
  String get progressMenuShowcaseTitle => 'Utforska dina data';

  @override
  String get progressMenuShowcaseDescription =>
      'Se alla diagram, läs AI-genererade insikter eller skapa en läkarrapport att dela med ditt vårdteam.';

  @override
  String get settingsFeedbackShowcaseTitle => 'Vi vill gärna höra din feedback';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Tryck här för att dela vad som fungerar, vad som inte gör det eller några idéer du har.';

  @override
  String get authCouldNotOpenLink => 'Kunde inte öppna länken just nu.';

  @override
  String get authWelcomeTitle => 'Välkommen till Glu';

  @override
  String get authSubtitle => 'Säker inloggning för din hälsohjälpare';

  @override
  String get authContinueWithGoogle => 'Fortsätt med Google';

  @override
  String get authContinueWithApple => 'Fortsätt med Apple';

  @override
  String get authEmailHint => 'namn@epost.se';

  @override
  String get authSending => 'Skickar...';

  @override
  String get authResendLink => 'Skicka länken igen';

  @override
  String get authUseDifferentEmail => 'Använd en annan e-post';

  @override
  String get habitGoalsTitle => 'Vanemål';

  @override
  String get goalsProteins => 'Proteiner';

  @override
  String get goalsFibers => 'Fibrer';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g per dag';
  }

  @override
  String get goalsWater => 'Vatten';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value l per dag';
  }

  @override
  String get goalsExercise => 'Träning';

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
  String get goalsPerWeekSuffix => 'per vecka';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count måltider per dag';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal per dag';
  }

  @override
  String get goalsWeight => 'Vikt';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Lägg till en loggad vikt för att räkna ut takten';

  @override
  String get goalsAlreadyAtThisTarget => 'Du är redan på detta mål';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/vecka till mål';
  }

  @override
  String get goalsSetTargetForNextWeek => 'Sätt målet för nästa vecka.';

  @override
  String get progressWeightTitle => 'Vikt';

  @override
  String get progressWeightLabel => 'Vikt';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Hälsosamt BMI';

  @override
  String get progressTotal => 'Totalt';

  @override
  String get progressPercent => 'Procent';

  @override
  String get progressWeeklyAvg => 'Vecko-genomsnitt';

  @override
  String get progressRangeAllTime => 'Hela tiden';

  @override
  String get progressRange1Month => '1 månad';

  @override
  String get progressRange3Months => '3 månader';

  @override
  String get progressRange6Months => '6 månader';

  @override
  String get progressLow => 'Låg';

  @override
  String get progressMed => 'Medel';

  @override
  String get progressHigh => 'Hög';

  @override
  String get progressSeverity => 'Svårighetsgrad';

  @override
  String get progressBad => 'Dåligt';

  @override
  String get progressOkay => 'Okej';

  @override
  String get progressGood => 'Bra';

  @override
  String get progressGreat => 'Jättebra';

  @override
  String get progressMostlyBad => 'Mestadels dåligt';

  @override
  String get progressMostlyOkay => 'Mestadels okej';

  @override
  String get progressMostlyGood => 'Mestadels bra';

  @override
  String get progressMostlyGreat => 'Mestadels jättebra';

  @override
  String get progressNoDose => 'Ingen dos';

  @override
  String get progressLogged => 'Loggad';

  @override
  String get progressAllClear => 'Allt klart';

  @override
  String get progressFreq => 'Frekvens';

  @override
  String get progressAverage => 'Genomsnitt';

  @override
  String get progressDaily => 'Daglig';

  @override
  String get progressWeekly => 'Veckovis';

  @override
  String get progressMinutes => 'Minuter';

  @override
  String get progressIntensity => 'Intensitet';

  @override
  String get progressCalories => 'Kalorier';

  @override
  String get progressByDose => 'Efter dos';

  @override
  String get progressWeightProgressTitle => 'Viktutveckling';

  @override
  String get progressWaterProgressTitle => 'Vätskeutveckling';

  @override
  String get progressExerciseProgressTitle => 'Träningsutveckling';

  @override
  String get progressDoseProgressTitle => 'Dosutveckling';

  @override
  String get progressMealsProgressTitle => 'Måltidsutveckling';

  @override
  String get progressSymptomsProgressTitle => 'Symtomutveckling';

  @override
  String get progressMoodProgressTitle => 'Humörutveckling';

  @override
  String get progressCravingsProgressTitle => 'Sugutveckling';

  @override
  String get progressResisted => 'Stod emot';

  @override
  String get progressCravingsResistedSubtitle =>
      'Andel loggade sug du stod emot.';

  @override
  String get progressWeightChangeTitle => 'Viktförändring';

  @override
  String get progressTitle => 'Utveckling';

  @override
  String get progressMenuViewAllInsights => 'Se alla insikter';

  @override
  String get progressMenuViewAllCharts => 'Se alla diagram';

  @override
  String get progressMenuCreateDoctorReport => 'Skapa läkarrapport';

  @override
  String get progressReportGenerating => 'Genererar din rapport…';

  @override
  String get progressReportError =>
      'Det gick inte att generera rapporten. Försök igen.';

  @override
  String get progressReportPendingRetry =>
      'Din rapport kan fortfarande bli klar om en liten stund. Försök igen.';

  @override
  String get progressReportOpenError =>
      'Din rapport skapades, men vi kunde inte öppna den. Försök igen.';

  @override
  String get progressReportOpenedInBrowser =>
      'Rapporten är klar. Öppnad i din webbläsare.';

  @override
  String get progressReportCopiedLink =>
      'Rapporten är klar. Delning var inte tillgänglig, så länken kopierades till ditt urklipp.';

  @override
  String get progressAllProgressTitle => 'All utveckling';

  @override
  String get progressWeightTrendExplanation =>
      'Se hur din vikt förändras över tid.';

  @override
  String get progressNoWeightLogsYet => 'Inga viktloggar än';

  @override
  String get progressNoLogsYet => 'Inga loggar än';

  @override
  String get progressLogWeightToStartTrend =>
      'Logga vikt för att börja följa din trend.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Logga vikt och dos för att jämföra hur dosering hänger ihop med förändring.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Varje punkt färgas efter den senaste dosen som användes före vägningen.';

  @override
  String get progressNoHydrationYet => 'Ingen vätska än';

  @override
  String get progressNoMovementYet => 'Ingen rörelse än';

  @override
  String get progressNoDoseLogsYet => 'Inga dosloggar än';

  @override
  String get progressNoMealsLoggedYet => 'Inga måltider loggade än';

  @override
  String get progressNoSymptomsLoggedYet => 'Inga symtom loggade än';

  @override
  String get progressNoMoodLogsYet => 'Inga humörloggar än';

  @override
  String get progressNoCravingsLoggedYet => 'Inga sug loggade än';

  @override
  String get progressFutureTrendTitle => 'Framtida trend';

  @override
  String get progressFutureTrendBody =>
      'En vacker tidslinje över din fart framåt';

  @override
  String get progressGoal => 'Mål';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Din senaste loggade vikt är redo att följas.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Cirka $gap $unit från ditt mål.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText jämfört med din tidigare logg.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText jämfört med tidigare logg. $gap $unit från mål.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Jämfört med din tidigare logg är trenden nu synlig.';

  @override
  String get progressWaterTitle => 'Vatten';

  @override
  String get manageSubscriptionTitle => 'Hantera prenumeration';

  @override
  String get manageSubscriptionProPlan => 'Pro-plan';

  @override
  String get manageSubscriptionFreePlan => 'Gratisplan';

  @override
  String get manageSubscriptionActiveCopy => 'Din prenumeration är aktiv.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Uppgradera för att låsa upp Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Plan';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratis';

  @override
  String get manageSubscriptionProduct => 'Produkt';

  @override
  String get manageSubscriptionRenewal => 'Förnyelse';

  @override
  String get manageSubscriptionStatus => 'Status';

  @override
  String get manageSubscriptionStatusActive => 'Aktiv';

  @override
  String get manageSubscriptionStatusInactive => 'Inte aktiv';

  @override
  String get manageSubscriptionManageButton => 'Hantera prenumeration';

  @override
  String get manageSubscriptionUpgradeButton => 'Uppgradera till Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Öppna butikens prenumerationsinställningar';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Återställ köp';

  @override
  String get manageSubscriptionRenewsAutomatically => 'Förnyas automatiskt';

  @override
  String get manageSubscriptionLifetime => 'Livstid';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Förnyas $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Går ut $date';
  }

  @override
  String get supplementReminderDayMon => 'Må';

  @override
  String get supplementReminderDayTue => 'Ti';

  @override
  String get supplementReminderDayWed => 'On';

  @override
  String get supplementReminderDayThu => 'To';

  @override
  String get supplementReminderDayFri => 'Fr';

  @override
  String get supplementReminderDaySat => 'Lö';

  @override
  String get supplementReminderDaySun => 'Sö';

  @override
  String supplementReminderInDays(Object count) {
    return 'Om $count dagar';
  }

  @override
  String get supplementReminderInOneWeek => 'Om 1 vecka';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Om $count veckor';
  }

  @override
  String get subscriptionDebugTitle => 'Glu-prenumerationer';

  @override
  String get subscriptionDebugMonthly => 'Månatlig';

  @override
  String get subscriptionDebugYearly => 'Årlig';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Uppdatera kundinfo';

  @override
  String get subscriptionDebugPresentPaywall => 'Visa betalvägg';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Öppna kundcenter';

  @override
  String get subscriptionDebugRestorePurchases => 'Återställ köp';

  @override
  String get subscriptionDebugSyncPurchases => 'Synka köp';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat-status';

  @override
  String get subscriptionDebugConfigured => 'Konfigurerad';

  @override
  String get subscriptionDebugBusy => 'Upptagen';

  @override
  String get subscriptionDebugAppUserId => 'App-användar-ID';

  @override
  String get subscriptionDebugAnonymous => 'anonym';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-nyckel tillgänglig';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro aktiv';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Aktiva prenumerationer';

  @override
  String get subscriptionDebugManagementUrl => 'Hanterings-URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Rättighetsprodukt';

  @override
  String get subscriptionDebugWillRenew => 'Förnyas';

  @override
  String get subscriptionDebugExpiration => 'Utgång';

  @override
  String get subscriptionDebugLifetime => 'livstid';

  @override
  String get subscriptionDebugPackageFound => 'Paket hittat';

  @override
  String get subscriptionDebugProductId => 'Produkt-ID';

  @override
  String get subscriptionDebugTitleLabel => 'Titel';

  @override
  String get subscriptionDebugPrice => 'Pris';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Köp $title';
  }

  @override
  String get progressExerciseTitle => 'Träning';

  @override
  String get progressDoseTitle => 'Dos';

  @override
  String get progressMealsTitle => 'Måltider';

  @override
  String get progressSymptomsTitle => 'Symtom';

  @override
  String get progressMoodTitle => 'Humör';

  @override
  String get progressCravingsTitle => 'Sug';

  @override
  String get progressTrend => 'Trend';

  @override
  String get progressTarget => 'Mål';

  @override
  String get progressNoTrendYet => 'Ingen trend än';

  @override
  String get progressNoActivityYet => 'Ingen aktivitet än';

  @override
  String get progressNoCheckInsYet => 'Inga check-ins än';

  @override
  String get progressWeightSignatureChip => 'Vikt blir din signaturgraf';

  @override
  String get progressWeightStartTrendTitle => 'Starta din trend med en vägning';

  @override
  String get progressWeightStartTrendBody =>
      'Den här grafen är navet i din utvecklingsberättelse. Logga din första vikt för att låsa upp momentum, milstolpar och en vy värd att dela.';

  @override
  String get progressWeightMomentum => 'Momentum';

  @override
  String get progressWeightMilestones => 'Milstolpar';

  @override
  String get progressWeightShareReady => 'Redo att delas';

  @override
  String get progressWeightLogWeight => 'Logga vikt';

  @override
  String get weightProgressUnlocksViewChip =>
      'Din första vägning låser upp den här vyn';

  @override
  String get weightProgressStartsHereTitle =>
      'Din utvecklingsberättelse börjar här';

  @override
  String get weightProgressStartsHereBody =>
      'Logga din första vikt för att låsa upp trender, milstolpar och dosmedvetna insikter i en vy värd att dela.';

  @override
  String get weightProgressTrendView => 'Trendvy';

  @override
  String get weightProgressDoseOverlays => 'Dosöverlagringar';

  @override
  String get weightProgressMilestones => 'Milstolpar';

  @override
  String get weightProgressLogWeight => 'Logga vikt';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Lägg först till både ett före- och efterfoto.';

  @override
  String get glowUpSavedToGallery => 'Sparat i ditt galleri';

  @override
  String get glowUpSaveToGallery => 'Spara i galleriet';

  @override
  String get glowUpYourProgress => 'Din utveckling';

  @override
  String get glowUpWeightChange => 'Viktförändring';

  @override
  String get glowUpTime => 'Tid';

  @override
  String get glowUpShare => 'Dela';

  @override
  String get glowUpBefore => 'FÖRE';

  @override
  String get glowUpAfter => 'EFTER';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight på $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'dagar';

  @override
  String get glowUpTimeUnitWeeksLabel => 'veckor';

  @override
  String get glowUpTimeUnitMonthsLabel => 'månader';

  @override
  String get glowUpTimeUnitYearsLabel => 'år';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dagar',
      one: '$count dag',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count veckor',
      one: '$count vecka',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count månader',
      one: '$count månad',
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
  String get commonSelect => 'Välj';

  @override
  String get doseReminderTitle => 'Dospåminnelse';

  @override
  String get doseReminderCustomDoseTitle => 'Anpassad dos';

  @override
  String get doseReminderCustomDoseHint => 'Skriv dos i mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Håll nästa dos redo på startsidan.';

  @override
  String get doseReminderTime => 'Tid';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Slå på detta för att visa nästa dos på startsidan.';

  @override
  String get doseReminderSaveReminder => 'Spara påminnelse';

  @override
  String loggedOn(Object date) {
    return 'Loggad $date';
  }

  @override
  String get waterLogSmallGlass => 'Litet glas';

  @override
  String get waterLogGlass => 'Glas';

  @override
  String get waterLogBottle => 'Flaska';

  @override
  String get waterLogLargeBottle => 'Stor flaska';

  @override
  String get waterLogTwoLiters => '2 l';

  @override
  String get waterLogCustomPreset => 'Anpassad';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dos';

  @override
  String get doseLogEditTitle => 'Redigera dos';

  @override
  String get doseLogLogTitle => 'Logga dos';

  @override
  String get doseLogCustomDose => 'Anpassad dos';

  @override
  String get doseLogCustomDoseBody => 'Justera dosen i mg för den här loggen.';

  @override
  String get doseLogUseThisDose => 'Använd denna dos';

  @override
  String get doseLogMedication => 'Medicin';

  @override
  String get doseLogInjectionSite => 'Plats';

  @override
  String get doseLogNotes => 'Anteckningar';

  @override
  String get doseLogSaveChanges => 'Spara ändringar';

  @override
  String get doseLogAddDose => '+ Logga dos';

  @override
  String get doseLogDeleteTitle => 'Ta bort denna doslogg?';

  @override
  String get doseLogDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get doseLogDeleteLog => 'Ta bort logg';

  @override
  String get doseLogSaving => 'Sparar...';

  @override
  String get doseLogCouldNotSave => 'Kunde inte spara denna doslogg ännu.';

  @override
  String get doseLogCouldNotDelete => 'Kunde inte ta bort denna doslogg ännu.';

  @override
  String get doseLogDeleted => 'Dos borttagen';

  @override
  String get doseLogAddedToDoseLog => 'Tillagt i din doslogg';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Är det något värt att komma ihåg om denna dos?';

  @override
  String get doseLogDoseLabel => 'Dos';

  @override
  String get exerciseLogTitle => 'Träning';

  @override
  String get exerciseLogEditTitle => 'Redigera träning';

  @override
  String get exerciseLogLogTitle => 'Logga träning';

  @override
  String get exerciseLogActivityType => 'Aktivitetstyp';

  @override
  String get exerciseLogCustomActivity => 'Anpassad aktivitet';

  @override
  String get exerciseLogTypeActivity => 'Skriv aktiviteten';

  @override
  String get exerciseLogDuration => 'Varaktighet';

  @override
  String get exerciseLogIntensity => 'Intensitet';

  @override
  String get exerciseLogNotes => 'Anteckningar';

  @override
  String get exerciseLogLight => 'Lätt';

  @override
  String get exerciseLogModerate => 'Måttlig';

  @override
  String get exerciseLogIntense => 'Hög';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min loggat';
  }

  @override
  String get exerciseLogSaveChanges => 'Spara ändringar';

  @override
  String get exerciseLogAddExercise => '+ Lägg till träningslogg';

  @override
  String get exerciseLogDeleteTitle => 'Ta bort denna träningslogg?';

  @override
  String get exerciseLogDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get exerciseLogDeleteLog => 'Ta bort logg';

  @override
  String get exerciseLogSaving => 'Sparar...';

  @override
  String get exerciseLogCouldNotSave =>
      'Kunde inte spara denna träningslogg ännu.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Kunde inte ta bort denna träningslogg ännu.';

  @override
  String get exerciseLogDeleted => 'Träning borttagen';

  @override
  String get exerciseLogAddedToExerciseLog => 'Tillagt i din träningslogg';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Är det något värt att komma ihåg om detta pass?';

  @override
  String get exerciseLogWalking => 'Promenad';

  @override
  String get exerciseLogRunning => 'Löpning';

  @override
  String get exerciseLogCycling => 'Cykling';

  @override
  String get exerciseLogStrength => 'Styrka';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Simning';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Vikt';

  @override
  String get weightLogEditTitle => 'Redigera vikt';

  @override
  String get weightLogLogTitle => 'Logga vikt';

  @override
  String get weightLogSaveChanges => 'Spara ändringar';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Lägg till vikt ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Ta bort denna viktlogg?';

  @override
  String get weightLogDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get weightLogDeleteLog => 'Ta bort logg';

  @override
  String get weightLogSaving => 'Sparar...';

  @override
  String get weightLogCouldNotSave => 'Kunde inte spara denna viktlogg ännu.';

  @override
  String get weightLogCouldNotDelete =>
      'Kunde inte ta bort denna viktlogg ännu.';

  @override
  String get weightLogDeleted => 'Vikt borttagen';

  @override
  String get weightLogAddedToWeightLog => 'Tillagt i din viktlogg';

  @override
  String get weightLogNoWeightForDay => 'Ingen vikt loggad för denna dag ännu.';

  @override
  String get injectionSiteAbdomen => 'Mage';

  @override
  String get injectionSiteThigh => 'Lår';

  @override
  String get injectionSiteUpperArm => 'Överarm';

  @override
  String get injectionSiteButtocks => 'Skinkor';

  @override
  String get injectionSiteAbdomenUpperLeft => 'Mage, övre vänster';

  @override
  String get injectionSiteAbdomenUpperRight => 'Mage, övre höger';

  @override
  String get injectionSiteAbdomenLowerRight => 'Mage, nedre höger';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Mage, nedre vänster';

  @override
  String get injectionSiteThighUpperLeft => 'Lår, övre vänster';

  @override
  String get injectionSiteThighUpperRight => 'Lår, övre höger';

  @override
  String get injectionSiteThighLowerRight => 'Lår, nedre höger';

  @override
  String get injectionSiteThighLowerLeft => 'Lår, nedre vänster';

  @override
  String get injectionSiteUpperArmLeft => 'Överarm, vänster';

  @override
  String get injectionSiteUpperArmRight => 'Överarm, höger';

  @override
  String get injectionSiteButtocksUpperLeft => 'Skinkor, övre vänster';

  @override
  String get injectionSiteButtocksUpperRight => 'Skinkor, övre höger';

  @override
  String get doseReminderFormat => 'Format';

  @override
  String get doseReminderInjection => 'Injektion';

  @override
  String get doseReminderPill => 'Piller';

  @override
  String get doseReminderSite => 'Plats';

  @override
  String get doseReminderDate => 'Datum';

  @override
  String get supplementReminderTitle => 'Påminnelse om tillskott';

  @override
  String get supplementReminderAddSupplement => 'Lägg till tillskott';

  @override
  String get supplementReminderNoSupplementsYet => 'Inga tillskott än';

  @override
  String get supplementReminderAddFirstBody =>
      'Lägg till din första påminnelse om tillskott för att följa ditt dagliga intag.';

  @override
  String get supplementReminderSupplementFallback => 'Tillskott';

  @override
  String get supplementReminderEveryDay => 'Varje dag';

  @override
  String get supplementReminderEveryXDaysLabel => 'Var X dagar';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Var $interval dagar';
  }

  @override
  String get supplementReminderNoDaysSet => 'Inga dagar valda';

  @override
  String get supplementReminderSupplementName => 'Tillskottets namn';

  @override
  String get supplementReminderTime => 'Tid';

  @override
  String get supplementReminderStartDate => 'Startdatum';

  @override
  String get supplementReminderRepeat => 'Upprepa';

  @override
  String get supplementReminderDaysOfWeek => 'Veckodagar';

  @override
  String get supplementReminderSelectAtLeastOneDay => 'Välj minst en dag.';

  @override
  String get supplementReminderEvery => 'Varje';

  @override
  String get supplementReminderDay => 'dag';

  @override
  String get supplementReminderDays => 'dagar';

  @override
  String get supplementReminderAdd => 'Lägg till';

  @override
  String get symptomsLogTitle => 'Symtom';

  @override
  String get symptomsLogEditTitle => 'Redigera symtom';

  @override
  String get symptomsLogLogTitle => 'Logga symtom';

  @override
  String get symptomsLogSymptomsExperienced => 'Upplevda symtom';

  @override
  String get symptomsLogNoSymptoms => 'Inga symtom';

  @override
  String get symptomsLogNoSymptomsToday => 'Inga symtom i dag';

  @override
  String get symptomsLogOther => 'Annat...';

  @override
  String get symptomsLogSeverityLevel => 'Svårighetsgrad';

  @override
  String get symptomsLogNotes => 'Anteckningar';

  @override
  String get symptomsLogAnxiety => 'Ångest';

  @override
  String get symptomsLogBelching => 'Rapningar';

  @override
  String get symptomsLogBloating => 'Uppblåsthet';

  @override
  String get symptomsLogConstipation => 'Förstoppning';

  @override
  String get symptomsLogDiarrhea => 'Diarré';

  @override
  String get symptomsLogFatigue => 'Trötthet';

  @override
  String get symptomsLogFoodNoise => 'Matbrus';

  @override
  String get symptomsLogHairLoss => 'Håravfall';

  @override
  String get symptomsLogHeartburn => 'Halsbränna';

  @override
  String get symptomsLogIndigestion => 'Matsmältningsbesvär';

  @override
  String get symptomsLogInjectionSiteReaction =>
      'Reaktion vid injektionsstället';

  @override
  String get symptomsLogMetallicTaste => 'Metallsmak';

  @override
  String get symptomsLogHeadache => 'Huvudvärk';

  @override
  String get symptomsLogMoodSwings => 'Humörsvängningar';

  @override
  String get symptomsLogNausea => 'Illamående';

  @override
  String get symptomsLogReflux => 'Reflux';

  @override
  String get symptomsLogStomachPain => 'Magont';

  @override
  String get symptomsLogSuppressedAppetite => 'Minskad aptit';

  @override
  String get symptomsLogVomiting => 'Kräkningar';

  @override
  String get symptomsLogLogged => 'Symtom loggade';

  @override
  String get symptomsLogMild => 'Lindrig';

  @override
  String get symptomsLogModerate => 'Måttlig';

  @override
  String get symptomsLogSevere => 'Svår';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Är det något värt att komma ihåg om hur du mådde?';

  @override
  String get symptomsLogSaveChanges => 'Spara ändringar';

  @override
  String get symptomsLogAddSymptoms => '+ Lägg till symtomlogg';

  @override
  String get symptomsLogDeleteTitle => 'Ta bort denna symtomlogg?';

  @override
  String get symptomsLogDeleteMessage => 'Den här åtgärden kan inte ångras.';

  @override
  String get symptomsLogDeleteLog => 'Ta bort logg';

  @override
  String get symptomsLogSaving => 'Sparar...';

  @override
  String get symptomsLogCouldNotSave =>
      'Kunde inte spara denna symtomlogg ännu.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Kunde inte ta bort denna symtomlogg ännu.';

  @override
  String get symptomsLogDeleted => 'Symtom borttagna';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Tillagt i din symtomlogg';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% av dagligt mål';
  }

  @override
  String get commonDisclaimer =>
      'Glu är ett spårningsverktyg, inte en medicinsk produkt. Det ger inte medicinska råd, diagnoser eller behandling. Rådfråga alltid vårdgivare om din medicin och dina hälsobeslut.';
}
