// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Wird wach...';

  @override
  String get startupFailed => 'Start fehlgeschlagen';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonSaving => 'Wird gespeichert...';

  @override
  String get commonContinue => 'Weiter';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonNotNow => 'Nicht jetzt';

  @override
  String get commonNow => 'Jetzt';

  @override
  String get commonTomorrow => 'Morgen';

  @override
  String get noteTriggerAddNote => 'Notiz hinzufügen';

  @override
  String get noteTriggerCancelNote => 'Notiz abbrechen';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'In $count Tagen';
  }

  @override
  String get homeDoseReminderInOneWeek => 'In 1 Woche';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'In $count Wochen';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Vor 1 Tag fällig';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Vor $count Tagen fällig';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Vor 1 Woche fällig';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Vor $count Wochen fällig';
  }

  @override
  String get bmiIndicatorYourBmi => 'Dein BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Dein aktueller BMI';

  @override
  String get bmiIndicatorUnderweight => 'Untergewicht';

  @override
  String get bmiIndicatorNormal => 'Normalgewicht';

  @override
  String get bmiIndicatorOverweight => 'Übergewicht';

  @override
  String get bmiIndicatorObesity => 'Adipositas';

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
  String get logNoteIndicatorHasNote => 'Notiz vorhanden';

  @override
  String get paywallTitle => 'Glu Pro freischalten';

  @override
  String get paywallSubtitle => 'Ohne Pro verlierst du das:';

  @override
  String get paywallMonthlyTitle => 'Monatlich';

  @override
  String get paywallMonthlySubtitle => 'Kein Testzeitraum';

  @override
  String get paywallYearlyTitle => 'Jährlich';

  @override
  String get paywallYearlySubtitle => '7 Tage gratis testen';

  @override
  String get paywallNoCommitment => 'Keine Bindung';

  @override
  String get paywallCancelAnytime => 'Jederzeit kündbar';

  @override
  String get paywallContinue => 'Fortfahren';

  @override
  String get paywallRestore => 'Wiederherstellen';

  @override
  String get paywallTerms => 'Nutzungsbedingungen';

  @override
  String get paywallPrivacy => 'Datenschutz';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Spare $percent%';
  }

  @override
  String get paywallCouldNotOpenLink =>
      'Der Link konnte jetzt nicht geöffnet werden.';

  @override
  String get paywallAlreadySubscribed => 'Du hast bereits Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Willkommen bei Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'Der Kauf wurde nicht abgeschlossen. Bitte versuche es erneut.';

  @override
  String get paywallPurchaseFailed =>
      'Der Kauf ist fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Der Kauf ist fehlgeschlagen: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Abo wiederhergestellt!';

  @override
  String get paywallRestoreNoSubscription => 'Kein aktives Abo gefunden.';

  @override
  String get paywallRestoreFailed =>
      'Wiederherstellung fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get paywallBenefitReminders => 'Dosen ohne Erinnerungen verpassen';

  @override
  String get paywallBenefitShareProgress =>
      'Schwerer, deinen Fortschritt zu teilen';

  @override
  String get paywallBenefitSpotRegain =>
      'Anzeichen für Gewichtszunahme verpassen';

  @override
  String get paywallBenefitInsights => 'Deine täglichen Muster verpassen';

  @override
  String get paywallBenefitWeeklyGoals =>
      'Deine wöchentliche Struktur verlieren';

  @override
  String get paywallBenefitHealthyHabits =>
      'Gewohnheiten schwinden ohne Unterstützung';

  @override
  String get onboardingWelcomeTitle => 'Behalten der Gewicht aus';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu hilft du protect dein Fortschritt around treatment, Ziele, und wöchentlich Gewohnheiten.';

  @override
  String get onboardingWelcomeBullet1 => 'Fits dein treatment und Ziele';

  @override
  String get onboardingWelcomeBullet2 => 'Simple und realistic unterstützen';

  @override
  String get onboardingWelcomeBullet3 =>
      'Easily spot early signs von Gewicht regain';

  @override
  String get onboardingWelcomeBullet4 => 'Behalten gehend ohne startend over';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Nimmst du derzeit ein Medikament zum Abnehmen in Pen- oder Tablettenform ein?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Wir verwenden dies, um show guidance that matches where you are right now.';

  @override
  String get onboardingMedicationStatusUsing => 'Ja, Ich bin taking it jetzt';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Ja, Ich bin weaning aus';

  @override
  String get onboardingMedicationStatusNotTaking =>
      'Nein, Ich bin not taking it';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'Nein, Ich werde starten soon';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Nein, I recently stopped';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Wie nimmst du deine Medikamente ein?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Wir verwenden dies, um tailor instructions and reminders to your medication format.';

  @override
  String get onboardingMedicationMethodInjection => 'Injektion';

  @override
  String get onboardingMedicationMethodPill => 'Pille';

  @override
  String get onboardingMedicationMethodUnknown => 'Unbekannt';

  @override
  String get onboardingMedicationNameQuestion =>
      'Welche Medikamente nimmst du ein?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Wir verwenden dies, um personalize dose tracking and medication-specific guidance.';

  @override
  String get onboardingCurrentDoseQuestion => 'Was ist dein current dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Wir verwenden dies, um tailor dose tracking and future progress check-ins.';

  @override
  String get onboardingMedicationCustomDose => 'Eigene Dosis';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Welches Gerät verwendest du, um deine Medikamente einzunehmen?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Wir verwenden dies, um make reminders and tips match the way you take it.';

  @override
  String get onboardingDeviceSinglePen => 'Einzelner Pen';

  @override
  String get onboardingDeviceAutoInjector => 'Autoinjektor';

  @override
  String get onboardingDeviceSyringeAndVial => 'Syringe und vial';

  @override
  String get onboardingOther => 'Andere';

  @override
  String get onboardingTypeYourDevice => 'Gib deine device ein';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Wie oft nimmst du deine Medikamente ein?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Wir verwenden dies, um time reminders and routine support around your schedule.';

  @override
  String get onboardingEveryDay => 'Every Tag';

  @override
  String get onboardingEvery7Days => 'Every 7 Tage';

  @override
  String get onboardingEvery14Days => 'Every 14 Tage';

  @override
  String get onboardingCustom => 'Benutzerdefiniert';

  @override
  String get onboardingDaysBetweenDoses => 'Tage between Dosen';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'Was ist dein primary goal right now?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Wir verwenden dies, um focus your plan, reminders, and progress around what matters most to you.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Wir verwenden dies, um shape your plan from the very beginning.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Wir verwenden dies, um support your next phase and help you stay on track.';

  @override
  String get onboardingGoalLoseWeight => 'Abnehmen';

  @override
  String get onboardingGoalMaintainWeight => 'Mein Gewicht halten';

  @override
  String get onboardingGoalManageDiabetes => 'Diabetes behandeln';

  @override
  String get onboardingGoalManagePcos => 'PCOS behandeln';

  @override
  String get onboardingGoalImproveHeartHealth =>
      'Meine Herzgesundheit verbessern';

  @override
  String get onboardingAgeQuestion => 'Wie alt bist du?';

  @override
  String get onboardingAgeExplainer =>
      'Wir verwenden dies, um adjust guidance and health calculations more appropriately.';

  @override
  String get onboardingHeightQuestion => 'Wie groß bist du?';

  @override
  String get onboardingHeightExplainer =>
      'Wir verwenden dies mit dein Gewicht zu calculate things like BMI und healthy ranges.';

  @override
  String get onboardingWeightQuestion => 'Was ist dein current weight?';

  @override
  String get onboardingWeightExplainer =>
      'Wir verwenden dies as dein startend point für Fortschritt, Ziele, und Gesundheit estimates.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'When did du stop der Medikament?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'When did du starten weaning aus der Medikament?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'When did du starten der Medikament?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Wir verwenden dies, um understand your recent treatment history and next phase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Wir verwenden dies, um understand your transition phase and support the habits that matter most now.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Wir verwenden dies, um understand how long you’ve been on treatment and track change over time.';

  @override
  String get onboardingGoalWeightQuestion => 'Wie hoch ist dein goal weight?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Wir verwenden dies, um frame progress and show a target BMI range for you.';

  @override
  String get onboardingBenefitsQuestion => 'What Glu will helfen du do nächste';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu verwandelt das, was du geteilt hast, in reminders, support, and structure that fit your routine.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'So kann Glu dir helfen, maintain your progress';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'So kann Glu deine diabetes routine unterstützen';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'So kann Glu deine PCOS routine unterstützen';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'So kann Glu deine heart health unterstützen';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'So kann Glu dir helfen, lose weight';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Sieh, wie Glu dir hilft, protect your current weight and catch regain early.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Sieh, wie Glu dir hilft, keep meals, weight, and routines steadier week to week.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Sieh, wie Glu dir hilft, stay steadier around symptoms, weight, and routine.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Sieh, wie Glu dir hilft, stay consistent with the habits that support heart health.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Sieh, wie Glu dir hilft, spot the patterns that keep weight moving down.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Ohne Struktur, regain can build quietly. Glu helps you catch it earlier and stay steady.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Ohne Struktur, meals and weight patterns get noisy. Glu keeps the signals clearer.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Ohne Struktur, symptoms and routines can swing more. Glu helps you stay steadier.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Ohne Struktur, healthy habits drift. Glu helps you keep activity and weight on track.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Ohne Struktur, weight can stall or drift up. Glu helps keep progress moving in the right direction.';

  @override
  String get onboardingBenefitsAxisWeight => 'Gewicht';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Mahlzeiten & Gewicht';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Symptome & Gewicht';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Bewegung & Gewicht';

  @override
  String get onboardingNotificationsQuestion =>
      'Aktiviere Erinnerungen, die dein Ziel unterstützen';

  @override
  String get onboardingNotificationsExplainer =>
      'Wir’ll verwenden notifications zu helfen du stay consistent, prepared, und ein verfolgen.';

  @override
  String get onboardingNotificationsHeadline =>
      'Setzen Glu up zu helfen bei der right moment.';

  @override
  String get onboardingNotificationsBody =>
      'Schalten ein notifications so Glu can reinforce der Gewohnheiten das unterstützen dein Ziel.';

  @override
  String get onboardingNotificationsDaily =>
      'Timed Erinnerungen das match dein täglich Medikament rhythm';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Longer-range Erinnerungen so Dosis Tage do not sneak up ein du';

  @override
  String get onboardingNotificationsCustom =>
      'Erinnerungen formend around dein custom schedule';

  @override
  String get onboardingNotificationsWeekly =>
      'Dosis Erinnerungen das stay aligned mit dein wöchentlich rhythm';

  @override
  String get onboardingNotificationsSupportive =>
      'Unterstützend Erinnerungen das behalten dein Routine visible when motivation dips';

  @override
  String get onboardingNotificationsProgress =>
      'Timely nudges around Fortschritt, Gewohnheiten, und der Ziele du told us matter most';

  @override
  String get onboardingNotificationsHelpful =>
      'helfenful prompts das make Glu mehr useful in der moments du need it';

  @override
  String get onboardingDailyRoutineQuestion => 'Was ist dein daily routine?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Wir verwenden dies, um make your plan feel realistic for your day-to-day life.';

  @override
  String get onboardingRoutineSedentary => 'Sitzend';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Mostly sitting, desk work, und very little intentional Bewegung.';

  @override
  String get onboardingRoutineLightlyActive => 'Lightly aktiv';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regular walking, errands, oder light workouts ein few times ein Woche.';

  @override
  String get onboardingRoutineActive => 'Aktiv';

  @override
  String get onboardingRoutineActiveDescription =>
      'Frequent movement oder Bewegung, like täglich walks, gym, oder aktiv work.';

  @override
  String get onboardingRoutineVeryActive => 'Very aktiv';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard training, physically demanding work, oder high activity most Tage.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Which Symptome are du most concerned about, if any?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Wir verwenden dies, um prioritize tips and guidance around the symptoms you care about most.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Wir verwenden dies, um focus on the symptoms you want to stay ahead of.';

  @override
  String get onboardingGenderQuestion => 'How do du describe dein Geschlecht?';

  @override
  String get onboardingGenderExplainer =>
      'Wir verwenden dies für mehr relevant Leitfäden und future personalization.';

  @override
  String get onboardingGenderFemale => 'Weiblich';

  @override
  String get onboardingGenderMale => 'Männlich';

  @override
  String get onboardingGenderPreferNotToSay => 'Prefer not zu say';

  @override
  String get onboardingTypeYourGender => 'Gib deine gender ein';

  @override
  String get onboardingPreferredNameQuestion => 'Wie sollen wir dich nennen?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Wir verwenden dies, um make Glu feel more personal when we talk to you.';

  @override
  String get onboardingPreferredNameHint => 'Bevorzugter Name';

  @override
  String get onboardingSetupSummaryQuestion => 'Setzen up dein plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Wir’re turning what du shared into ein plan Glu can unterstützen right away.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Locking in Gewicht-maintenance targets...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Setzen up regain watchpoints...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Tuning Erinnerungen around dein Routine...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Preparing ein steadier wöchentlich plan...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Defining Mahlzeit und Gewicht Muster...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Setzen hydration unterstützen...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Preparing consistency Erinnerungen...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Aufbauend ein clearer täglich structure...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Organizing Symptom unterstützen...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Defining wöchentlich movement targets...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Setzen hydration und Routine anchors...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Preparing ein steadier plan...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'Setzen activity targets...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Defining hydration unterstützen...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Preparing wöchentlich Gewohnheit Erinnerungen...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Aufbauend ein heart-Gesundheit Routine...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Defining Kalorie boundaries...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Setzen Wasser amounts...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Aufbauend Bewegung targets...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Preparing dein wöchentlich plan...';

  @override
  String get onboardingSetupSummaryHeadline => 'Dein Glu setup is bereit.';

  @override
  String get onboardingSetupLoadingTitle => 'Aufbauend dein setup';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu ist bereit, help you protect your progress with clearer structure and earlier regain signals.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu ist bereit, support steadier meals, weight tracking, and habits that matter day to day.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu ist bereit, support steadier routines around symptoms, treatment, and progress.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu ist bereit, reinforce the habits that support your long-term heart health.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu ist bereit, support the routines that help you keep the weight off.';

  @override
  String get onboardingSetupSummaryLabel => 'Zusammenfassung';

  @override
  String get onboardingSetupAdjustLater =>
      'Du can adjust any von dies später in Einstellungen.';

  @override
  String get onboardingSummaryGoal => 'Ziel';

  @override
  String get onboardingSummaryCurrentWeight => 'Aktuell Gewicht';

  @override
  String get onboardingSummaryMedication => 'Medikament';

  @override
  String get onboardingSummaryCurrentDose => 'Aktuell Dosis';

  @override
  String get onboardingSummaryCadence => 'Rhythmus';

  @override
  String get onboardingSummaryStarted => 'Gestartet';

  @override
  String get onboardingSummaryTargetWeight => 'Target Gewicht';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'fokussieren';

  @override
  String get onboardingFrequencyEveryDay => 'Every Tag';

  @override
  String get onboardingFrequencyEveryWeek => 'Every Woche';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Every 2 Wochen';

  @override
  String get onboardingFrequencyCustomSchedule =>
      'Benutzerdefinierter Zeitplan';

  @override
  String get onboardingTapOptionContinue =>
      'Tippe auf eine Option, um fortzufahren.';

  @override
  String get onboardingTypeGenderContinue =>
      'Gib deine gender ein, um fortzufahren.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Gib deine device ein, um fortzufahren.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Gib deine medication ein, um fortzufahren.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Gib die Tage zwischen den Dosen ein, um fortzufahren.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Wähle einen Zeitplan, um fortzufahren.';

  @override
  String get onboardingScrollChooseAge => 'Scrolle, um dein Alter auszuwählen.';

  @override
  String get onboardingDragOrTapHeight =>
      'Ziehe oder tippe auf das Lineal, um deine Größe zu wählen.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Ziehe, tippe oder verwende die Schrittknöpfe, um ein Gewicht zu wählen.';

  @override
  String get onboardingPickDateAndWeight =>
      'Wähle ein Datum und ein Gewicht, um fortzufahren.';

  @override
  String get onboardingSelectSymptoms =>
      'Wähle alle Symptome aus, auf die sich Glu konzentrieren soll.';

  @override
  String get onboardingTypeName =>
      'Eingeben der Name du want Glu zu verwenden.';

  @override
  String get onboardingSaving => 'Speichert...';

  @override
  String get onboardingLetsBegin => 'Los geht\'s';

  @override
  String get onboardingContinueWithGlu => 'Fortfahren mit Glu';

  @override
  String get onboardingKeepGoing => 'Behalten gehend';

  @override
  String get onboardingTurnOnNotifications => 'Schalten ein notifications';

  @override
  String get onboardingFinish => 'Fertig';

  @override
  String get onboardingTargetBmiTitle => 'Dein target BMI';

  @override
  String get onboardingChartToday => 'Heute';

  @override
  String get onboardingChartOverTime => 'Over Zeit';

  @override
  String get onboardingChartWithoutGlu => 'Ohne Glu';

  @override
  String get onboardingChartWithGlu => 'Mit Glu';

  @override
  String get onboardingReviewQuestion =>
      'Menschen nutzen Glu, um stay steady and supported';

  @override
  String get onboardingReviewExplainer =>
      'Eine kurze Bewertung hilft mehr Menschen, Unterstützung zu finden, die sich so einfach anfühlt.';

  @override
  String get onboardingReviewBody =>
      'Menschen nutzen Glu, um feel more supported, more consistent, and less alone in the process.';

  @override
  String get onboardingTypeYourMedication => 'Gib deine medication ein';

  @override
  String get onboardingSelectStartDate => 'Auswählen starten date';

  @override
  String get goalsSaveDialogTitle => 'Speichern Ziele?';

  @override
  String get goalsSaveDialogMessage =>
      'Du hast ungespeicherte Zieländerungen. Möchtest du sie speichern, bevor du diesen Tab verlässt?';

  @override
  String get commonLater => 'Später';

  @override
  String get homeGreetingAnonymous => 'Hallo';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hallo, $name';
  }

  @override
  String get homeInsightEmptyTitle =>
      'Trage heute etwas ein, um deine Analyse zu sehen';

  @override
  String get homeInsightEmptyBody =>
      'Wenn du heute etwas einträgst, siehst du heute Abend deine Analyse.';

  @override
  String get homeInsightLogTodayTitle => 'Mach aus Einträgen Erkenntnisse';

  @override
  String get homeInsightMoreLogsVariant1Title => 'Mehr Logs, bessere Einsicht';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Deine Logs beginnen, ein Muster zu zeigen.';

  @override
  String get homeInsightMoreLogsVariant2Title =>
      'Deine Einsicht nimmt Gestalt an';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Ein paar weitere Logs könnten das Bild viel klarer machen.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Worauf die heutigen Logs hindeuten';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Vielleicht steckt in deinem Tag schon ein Muster.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Trage heute mindestens einmal etwas ein, um ein klareres Bild deines Fortschritts zu sehen.';

  @override
  String get homeInsightExpandedTitle => 'War das hilfreich?';

  @override
  String get homeInsightExpandedBody =>
      'Eine schnelle Bewertung hilft Glu zu lernen, was dir am wichtigsten ist.';

  @override
  String get homeInsightReasonHint => 'Was könnte besser sein? (optional)';

  @override
  String get homeInsightReasonSubmit => 'Senden';

  @override
  String get homeInsightLearningMessage => 'Ich lerne daraus.';

  @override
  String get homeInsightChecking => 'Heutige Analyse wird geprüft...';

  @override
  String get homeInsightGenerating => 'Heutige Analyse wird geladen...';

  @override
  String get homeInsightTryAgain => 'Erneut versuchen';

  @override
  String get homeSeeAllInsights => 'Alle Analysen ansehen';

  @override
  String get insightsProgressTitle => 'Alle Analysen';

  @override
  String get insightsProgressEmptyState =>
      'Deine Analysen erscheinen hier, sobald sie generiert wurden.';

  @override
  String get homeDoseReminderTitle => 'Dosis-Erinnerung';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Hier kommt die Protokoll-Interaktion für $label hin.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Kalorienziel erforderlich';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portionskontrolle braucht ein Mahlzeitenziel auf Kalorien, um deine Portion zu schätzen. Lege eines unter Ziele fest, um zu beginnen.';

  @override
  String get homeSetGoal => 'Ziel festlegen';

  @override
  String get homeYourProgress => 'Dein Fortschritt';

  @override
  String get homeRemindersShowcaseTitle => 'Bleib auf Kurs';

  @override
  String get homeRemindersShowcaseDescription =>
      'Richte Erinnerungen ein, um Dosen und Nahrungsergänzungsmittel pünktlich zu nehmen.';

  @override
  String get homePickNextDoseDate => 'Datum der nächsten Dosis wählen';

  @override
  String get homeSetReminder => 'Erinnerung einrichten';

  @override
  String get homeSupplementReminders => 'Erinnerungen für Nahrungsergänzungen';

  @override
  String get homeNoUpcomingSupplements =>
      'Keine anstehenden Nahrungsergänzungen';

  @override
  String get homeNoMoreUpcomingSupplements => 'Keine weiteren anstehenden';

  @override
  String get homeSetUpYourSupplements => 'Nahrungsergänzungen einrichten';

  @override
  String get homeSetUp => 'Einrichten';

  @override
  String get homeSupplementFallback => 'Nahrungsergänzung';

  @override
  String get doseReminderNotificationTitle => 'Bereit für deine Dosis?';

  @override
  String get doseReminderFallbackBody =>
      'Öffne Glu, um deine nächste Dosis zu prüfen.';

  @override
  String get supplementReminderNotificationTitle =>
      'Zeit für dein Nahrungsergänzungsmittel';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Heute Morgen';

  @override
  String get supplementReminderThisAfternoon => 'Heute Nachmittag';

  @override
  String get supplementReminderTonight => 'Heute Abend';

  @override
  String get dailyReminderMorningTitle => 'Morgen-Check-in';

  @override
  String get dailyReminderMorningBodies =>
      'Morgen mission: give Glu ein little data zu play mit.\nKick aus der Tag mit ein quick Protokoll und some gut momentum.\nRise und Protokoll. Future du will appreciate it.\nStarten der Tag mit ein tiny update und ein big head starten.\nGive Glu ein Morgen clue und behalten moving.\nEIN quick Protokoll jetzt can make heute way mehr interesting.\nLet’s make der Morgen count mit ein fast prüfen-in.';

  @override
  String get dailyReminderMiddayTitle => 'Mittags-Check-in';

  @override
  String get dailyReminderMiddayBodies =>
      'Midday pit stop: drop ein quick Protokoll und behalten cruising.\nLunch break? Perfect Zeit zu give Glu ein update.\nHalfway there. Toss Glu ein quick clue.\nEIN tiny midday Protokoll can behalten der story gehend.\nPrüfen in jetzt und behalten der Tag rolling.\nGive dein Tag ein little nudge mit ein fast update.\nBehalten der energy up mit ein quick midday tippen.';

  @override
  String get dailyReminderAfternoonTitle => 'Nachmittags-Check-in';

  @override
  String get dailyReminderAfternoonBodies =>
      'Almost done. Give Glu one mehr breadcrumb.\nEIN quick Nachmittag Protokoll can make Abend’s Analyse pop.\nWrap der Tag mit ein small update und ein big win.\nOne mehr Protokoll before der Tag wraps up?\nHelfen Glu connect der dots mit ein quick Nachmittag prüfen-in.\nSchließen der loop mit ein tiny Protokoll und behalten der magic gehend.\nEIN final tippen jetzt can make Abend’s Analyse way besser.';

  @override
  String get homePortionCheckTitle => 'Portionskontrolle';

  @override
  String get homePortionCheckBody =>
      'Sieh, wie viel du bei jeder Mahlzeit essen solltest';

  @override
  String get homeGlowUpTitle => 'Dein\nGlow-up';

  @override
  String get homeGlowUpBody => 'Gestalte deine Vorher-Nachher-Geschichte';

  @override
  String get homeDoctorReportTitle => 'Arztbericht';

  @override
  String get homeDoctorReportBody => 'Teile deinen Fortschritt mit deinem Arzt';

  @override
  String get homeGoalsStatusTitle => 'Heutige Ziele';

  @override
  String get homeGoalsStatusViewAll => 'Alle anzeigen';

  @override
  String get homeWaterTitle => 'Wasser';

  @override
  String get homeWeightTitle => 'Gewicht';

  @override
  String get homeExerciseTitle => 'Bewegung';

  @override
  String get homeMealsTitle => 'Mahlzeiten';

  @override
  String get homeCaloriesTitle => 'Kalorien';

  @override
  String get homeProteinsTitle => 'Proteine';

  @override
  String get homeFibersTitle => 'Ballaststoffe';

  @override
  String get homeSymptomsTitle => 'Symptome';

  @override
  String get homeMoodTitle => 'Stimmung';

  @override
  String get homeCravingsTitle => 'Heißhunger';

  @override
  String get homeDoseTitle => 'Dosis';

  @override
  String get homeMedicationLevelTitle => 'Geschätzter Medikamentenspiegel';

  @override
  String get homeMedicationLevelInfoTitle => 'So liest du dieses Diagramm';

  @override
  String get homeMedicationLevelInfoBody =>
      'Dieses Diagramm schätzt, wie viel von deinem Medikament basierend auf den erfassten Dosen und der Halbwertszeit des Medikaments noch aktiv sein könnte.\n\nHöhere Punkte bedeuten meist eine kürzlich erfolgte oder größere Dosis. Die Linie sinkt mit der Zeit, während das Medikament aus deinem Körper abgebaut wird.\n\nBetrachte dies als Trendansicht, nicht als exakte Messung oder medizinische Empfehlung.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Verstanden';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Erfasse deine Dosen, damit Glu schätzen kann, wie viel Medikament noch in deinem Körper aktiv ist.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'des letzten Höchstwerts';

  @override
  String get homeMedicationLevelActiveNow => 'Aktuell aktiv';

  @override
  String get homeMedicationLevelHalfLife => 'Halbwertszeit';

  @override
  String get homeMedicationLevelLastDose => 'Letzte Dosis';

  @override
  String get homeStartHydration => 'Mit dem Trinken beginnen';

  @override
  String get homeLogFirstSession => 'Deine erste Sitzung protokollieren';

  @override
  String get homeLogTodayWeight => 'Heutiges Gewicht protokollieren';

  @override
  String get homeAtYourTarget => 'Du bist bei deinem Ziel';

  @override
  String get homeLogMealsToTrackCalories =>
      'Mahlzeiten protokollieren, um Kalorien zu verfolgen';

  @override
  String get homeLogFirstMeal => 'Deine erste Mahlzeit protokollieren';

  @override
  String get homeTrackProteinFromMeals => 'Protein aus Mahlzeiten verfolgen';

  @override
  String get homeTrackFiberFromMeals =>
      'Ballaststoffe aus Mahlzeiten verfolgen';

  @override
  String get homeAllClear => 'Alles in Ordnung';

  @override
  String get homeTrackSymptoms => 'Symptome verfolgen';

  @override
  String get homeGreat => 'Gut';

  @override
  String get homeGood => 'Okay';

  @override
  String get homeBad => 'Schlecht';

  @override
  String get homeOkay => 'In Ordnung';

  @override
  String get homeLogHowYouFeel => 'Protokolliere, wie du dich fühlst';

  @override
  String get homeLogACraving => 'Heißhunger protokollieren';

  @override
  String get homeLogTodaysDose => 'Heutige Dosis protokollieren';

  @override
  String get homeTaken => 'Eingenommen';

  @override
  String get homeStartHereTitle => 'Hier starten';

  @override
  String get homeStartHereBody =>
      'Starte mit dieser Karte und erweitere dann auf die anderen. Je mehr du protokollierst, desto besser kann Glu Muster und Analysen über die Zeit zeigen.';

  @override
  String get waterLogTitle => 'Wasser';

  @override
  String get waterLogEditTitle => 'Hydration bearbeiten';

  @override
  String get waterLogLogTitle => 'Wasser protokollieren';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Getränk hinzufügen ($amount)';
  }

  @override
  String get waterLogSaving => 'Speichert...';

  @override
  String get waterLogCustomDrinkTitle => 'Benutzerdefiniertes Getränk';

  @override
  String get waterLogCustomDrinkBody =>
      'Wähle die Menge, die du jetzt hinzufügen möchtest.';

  @override
  String get waterLogUseThisAmount => 'Diese Menge verwenden';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount zu deinem Hydrationsprotokoll hinzugefügt';
  }

  @override
  String get waterLogCouldNotSave =>
      'Diese Wasserregistrierung konnte noch nicht gespeichert werden.';

  @override
  String get waterLogDeleteTitle => 'Diese Hydrationsregistrierung löschen?';

  @override
  String get waterLogDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get waterLogCouldNotDelete =>
      'Diese Wasserregistrierung konnte noch nicht gelöscht werden.';

  @override
  String get waterLogDeleteLog => 'Protokoll löschen';

  @override
  String get waterLogDeleted => 'Hydration gelöscht';

  @override
  String get moodLogTitle => 'Stimmung';

  @override
  String get moodEditTitle => 'Stimmung bearbeiten';

  @override
  String get moodHowYouFeel => 'Wie du dich fühlst';

  @override
  String get moodBad => 'Schlecht';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Gut';

  @override
  String get moodGreat => 'Sehr gut';

  @override
  String get moodNotes => 'Notizen';

  @override
  String get moodAnythingWorthRemembering =>
      'Gibt es etwas, das du dir zu deiner Stimmung merken möchtest?';

  @override
  String get moodCouldNotSave =>
      'Diese Stimmungsaufzeichnung konnte noch nicht gespeichert werden.';

  @override
  String get moodDeleteTitle => 'Diese Stimmungsaufzeichnung löschen?';

  @override
  String get moodDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get moodDeleteLog => 'Protokoll löschen';

  @override
  String get moodSaving => 'Speichert...';

  @override
  String get moodAddMoodLog => '+ Stimmung protokollieren';

  @override
  String get moodLogged => 'Stimmung protokolliert';

  @override
  String get moodDeleted => 'Stimmung gelöscht';

  @override
  String get moodCouldNotDelete =>
      'Diese Stimmungsaufzeichnung konnte noch nicht gelöscht werden.';

  @override
  String get moodAddedToMoodLog => 'Zu deinem Stimmungsprotokoll hinzugefügt';

  @override
  String get cravingsLogTitle => 'Heißhunger';

  @override
  String get cravingsEditTitle => 'Heißhunger bearbeiten';

  @override
  String get cravingsWhatsGoingOn => 'Was ist los';

  @override
  String get cravingsTypeGeneral => 'Lust zu essen';

  @override
  String get cravingsTypeSweet => 'Etwas Süßes';

  @override
  String get cravingsTypeSalty => 'Etwas Salziges';

  @override
  String get cravingsIntensityLabel => 'Intensität (optional)';

  @override
  String get cravingsIntensityMild => 'Leicht';

  @override
  String get cravingsIntensityModerate => 'Mittel';

  @override
  String get cravingsIntensityStrong => 'Stark';

  @override
  String get cravingsOutcomeLabel => 'Was ist passiert (optional)';

  @override
  String get cravingsOutcomeResisted => 'Widerstanden';

  @override
  String get cravingsOutcomeGaveIn => 'Nachgegeben';

  @override
  String get cravingsNotes => 'Notizen';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Gibt es etwas, das du dir zu diesem Heißhunger merken möchtest?';

  @override
  String get cravingsCouldNotSave =>
      'Dieser Heißhunger-Eintrag konnte noch nicht gespeichert werden.';

  @override
  String get cravingsDeleteTitle => 'Diesen Heißhunger-Eintrag löschen?';

  @override
  String get cravingsDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cravingsDeleteLog => 'Eintrag löschen';

  @override
  String get cravingsSaving => 'Speichert...';

  @override
  String get cravingsAddLog => '+ Heißhunger protokollieren';

  @override
  String get cravingsLogged => 'Heißhunger protokolliert';

  @override
  String get cravingsDeleted => 'Heißhunger gelöscht';

  @override
  String get cravingsCouldNotDelete =>
      'Dieser Heißhunger-Eintrag konnte noch nicht gelöscht werden.';

  @override
  String get cravingsAddedToLog => 'Zu deinem Heißhunger-Protokoll hinzugefügt';

  @override
  String get portionCheckTitle => 'Portionskontrolle';

  @override
  String get portionCheckAnalyzingMeal => 'Deine Mahlzeit wird analysiert…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Dieses Foto konnte nicht analysiert werden';

  @override
  String get portionCheckTakeNewPhoto => 'Neues Foto aufnehmen';

  @override
  String get portionCheckSomethingWentWrong => 'Etwas ist schiefgelaufen.';

  @override
  String get portionCheckYouHitDailyLimit => 'Du hast dein Tageslimit erreicht';

  @override
  String get portionCheckYouCanEat => 'Du kannst essen';

  @override
  String get portionCheckYouCanEatUpTo => 'Du kannst bis zu';

  @override
  String get portionCheckTryLighterOption =>
      'Versuche stattdessen eine leichtere Option oder lass es weg';

  @override
  String get portionCheckThisEntireMeal => 'diese gesamte Mahlzeit';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% dieser Mahlzeit';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'um innerhalb deiner täglichen Ziele zu bleiben.';

  @override
  String get portionCheckNutritionBreakdown => 'Nährstoffaufschlüsselung';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Tipps, um deine Mahlzeit auszugleichen';

  @override
  String get portionCheckTipsPool =>
      'Iss langsam - das Sättigungsgefühl braucht etwa 20 Minuten, um aufzuholen.\nFülle die Hälfte deines Tellers mit Gemüse.\nBaue zu jeder Mahlzeit Protein ein.\nTrink vor dem Essen Wasser.\nPortioniere Snacks in kleine Behälter vor.\nKombiniere Kohlenhydrate mit Protein oder Fett, damit du länger satt bleibst.\nWähle wenn möglich möglichst unverarbeitete Lebensmittel.\nVermeide Essen mit Ablenkung durch Bildschirme.\nLass Mahlzeiten nicht aus, wenn du später sonst zu viel essen würdest.\nPlane deine Snacks, bevor du hungrig wirst.';

  @override
  String get portionCheckRetake => 'Erneut aufnehmen';

  @override
  String get portionCheckLogThisPortion => 'Diese Portion protokollieren';

  @override
  String get portionCheckCarbs => 'Kohlenhydrate';

  @override
  String get portionCheckProteins => 'Proteine';

  @override
  String get portionCheckFats => 'Fette';

  @override
  String get portionCheckFiber => 'Ballaststoffe';

  @override
  String get mealLogScreenTitle => 'Mahlzeiten';

  @override
  String get mealLogEditTitle => 'Mahlzeit bearbeiten';

  @override
  String get mealLogLogTitle => 'Mahlzeit protokollieren';

  @override
  String get mealLogSaving => 'Speichert...';

  @override
  String get mealLogAddMealLog => '+ Mahlzeitenprotokoll hinzufügen';

  @override
  String get mealLogCouldNotStartRecording =>
      'Aufnahme konnte nicht gestartet werden.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'Aufnahme wurde nach 60 Sekunden gestoppt.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Diese Aufnahme konnte nicht analysiert werden.';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'Dieser Text konnte nicht analysiert werden.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Dieses Foto konnte nicht analysiert werden.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Dieses Essensfoto konnte noch nicht verarbeitet werden.';

  @override
  String get mealLogDiscardTitle => 'Diese Mahlzeit verwerfen?';

  @override
  String get mealLogDiscardMessage =>
      'Du hast ein Foto angesehen, aber den Eintrag nicht gespeichert. Er wird nicht protokolliert.';

  @override
  String get mealLogDiscard => 'Verwerfen';

  @override
  String get mealLogDeleteTitle => 'Dieses Mahlzeitenprotokoll löschen?';

  @override
  String get mealLogDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get mealLogDelete => 'Löschen';

  @override
  String get mealLogDeleteLog => 'Protokoll löschen';

  @override
  String get mealLogCouldNotSave =>
      'Dieses Mahlzeitenprotokoll konnte noch nicht gespeichert werden.';

  @override
  String get mealLogCouldNotDelete =>
      'Dieses Mahlzeitenprotokoll konnte noch nicht gelöscht werden.';

  @override
  String get mealLogAnalyzing => 'Analysiert...';

  @override
  String get mealLogAnalyzeText => 'Text analysieren';

  @override
  String get mealLogSendRecording => 'Aufnahme senden';

  @override
  String get mealLogMealDefaultName => 'Mahlzeit';

  @override
  String get mealLogMealNameHint => 'Name der Mahlzeit';

  @override
  String get mealLogCouldNotPrefillTitle =>
      'Diese Mahlzeit konnte nicht vorausgefüllt werden';

  @override
  String get mealLogHowMuchDidYouEat => 'Wie viel hast du gegessen?';

  @override
  String get mealLogNotes => 'Notizen';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Gibt es etwas, das du dir zu dieser Mahlzeit merken möchtest?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Deine Mahlzeit wird analysiert';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Wir wandeln deine Eingabe in Nährstofffelder um. Du kannst alles vor dem Speichern prüfen.';

  @override
  String get mealLogDescribeYourMealTitle => 'Beschreibe deine Mahlzeit';

  @override
  String get mealLogDescribeYourMealBody =>
      'Schreibe auf, was du gegessen hast und welche Mengen du kennst. Wir wandeln es in Nährstofffelder um.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Beispiel: gegrillter Hähnchensalat, Olivenöldressing, 1 Apfel, Sprudelwasser';

  @override
  String get mealLogCaptureYourMealTitle => 'Erfasse deine Mahlzeit';

  @override
  String get mealLogCaptureYourMealBody =>
      'Mache ein Foto, und wir schätzen die Nährstofffelder für dich.';

  @override
  String get mealLogTakePhoto => 'Foto aufnehmen';

  @override
  String get mealLogRecordingYourMealTitle => 'Deine Mahlzeit wird aufgenommen';

  @override
  String get mealLogRecordingReadyTitle => 'Aufnahme bereit';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Eine Mahlzeitenbeschreibung aufnehmen';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Tippe auf Stopp, wenn du fertig bist. ${remaining}s übrig';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Sende es unten zum Analysieren oder nimm es erneut auf.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Sprich natürlich darüber, was du gegessen hast, und wir zerlegen es in Makros.';

  @override
  String get mealLogStopRecording => 'Aufnahme stoppen';

  @override
  String get mealLogRecordAgain => 'Erneut aufnehmen';

  @override
  String get mealLogStartRecording => 'Aufnahme starten';

  @override
  String get mealLogBreakfast => 'Frühstück';

  @override
  String get mealLogLunch => 'Mittagessen';

  @override
  String get mealLogSnack => 'Snack';

  @override
  String get mealLogDinner => 'Abendessen';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'Heute';

  @override
  String get mealLogYesterday => 'Gestern';

  @override
  String mealLogKcal(Object count) {
    return 'kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal protokolliert';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro protokolliert';
  }

  @override
  String get mealLogDeleted => 'Mahlzeit gelöscht';

  @override
  String get mealLogAddedToMealLog =>
      'Zu deinem Mahlzeitenprotokoll hinzugefügt';

  @override
  String get mealLogCarbs => 'Kohlenhydrate';

  @override
  String get mealLogProteins => 'Proteine';

  @override
  String get mealLogFats => 'Fette';

  @override
  String get mealLogFiber => 'Ballaststoffe';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageDialogTitle => 'Sprache auswählen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsPreferences => 'Einstellungen';

  @override
  String get settingsHealthGoal => 'Gesundheitsziel';

  @override
  String get settingsHealthGoalDialogTitle => 'Gesundheitsziel auswählen';

  @override
  String get settingsHabitGoals => 'Gewohnheitsziele';

  @override
  String get settingsDisabled => 'Deaktiviert';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count aktiv';
  }

  @override
  String get settingsHeight => 'Größe';

  @override
  String get settingsAge => 'Alter';

  @override
  String get settingsGender => 'Geschlecht';

  @override
  String get settingsMeasurementUnit => 'Maßeinheit';

  @override
  String get settingsReminders => 'Erinnerungen';

  @override
  String get settingsDoseReminder => 'Dosis-Erinnerung';

  @override
  String get settingsSupplementReminder => 'Erinnerung für Nahrungsergänzung';

  @override
  String get settingsDailyReminders => 'Tägliche Erinnerungen';

  @override
  String get settingsSubscription => 'Abonnement';

  @override
  String get settingsSupport => 'Hilfe';

  @override
  String get settingsSendFeedback => 'Feedback senden';

  @override
  String get feedbackSheetTitle => 'Feedback senden';

  @override
  String get feedbackSheetHint => 'Sag uns, was du denkst…';

  @override
  String get feedbackSheetSend => 'Senden';

  @override
  String get feedbackSheetSuccess => 'Danke für dein Feedback!';

  @override
  String get feedbackSheetError =>
      'Senden fehlgeschlagen. Bitte versuche es erneut.';

  @override
  String get settingsTermsOfService => 'Nutzungsbedingungen';

  @override
  String get settingsPrivacyPolicy => 'Datenschutzerklärung';

  @override
  String get settingsInternal => 'Intern';

  @override
  String get settingsSubscriptionOverride => 'Abonnement überschreiben';

  @override
  String get settingsTodayInsightCard => 'Karte für die heutige Analyse';

  @override
  String get settingsResetOnboarding => 'Onboarding zurücksetzen';

  @override
  String get settingsResetShowcases => 'Showcases zurücksetzen';

  @override
  String get settingsResetUserData => 'Benutzerdaten zurücksetzen';

  @override
  String get settingsDeletingAccount => 'Konto wird gelöscht...';

  @override
  String get settingsDisconnect => 'Trennen';

  @override
  String get settingsDeleteAccount => 'Konto löschen';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return '$provider trennen';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return '$provider trennen?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Du kannst dich auf diesem Gerät nicht mehr mit $provider anmelden, es sei denn, du verbindest es später erneut.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Konto löschen?';

  @override
  String get settingsDeleteAccountBody =>
      'Dadurch werden dein Konto und alle deine Daten dauerhaft entfernt. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get settingsDeleteAccountConfirmHint =>
      'DELETE eingeben, um zu bestätigen';

  @override
  String get settingsDeleteAccountError =>
      'Beim Löschen deines Kontos ist etwas schiefgelaufen. Bitte kontaktiere support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'App neu starten, um das Onboarding zu sehen';

  @override
  String get settingsShowcasesReset => 'Showcases zurückgesetzt';

  @override
  String get settingsResetUserDataTitle => 'Benutzerdaten zurücksetzen?';

  @override
  String get settingsResetUserDataBody =>
      'Dadurch werden alle protokollierten Einträge für Mahlzeiten, Wasser, Bewegung, Gewicht, Stimmung, Symptome, Nahrungsergänzungen und Dosen gelöscht.';

  @override
  String get settingsUserDataReset => 'Benutzerdaten zurückgesetzt';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Gespeichert, aber die täglichen Erinnerungen konnten gerade nicht geplant werden.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Abonnement überschreiben';

  @override
  String get settingsSubscriptionOverrideAuto => 'Automatisch';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Erzwinge Free';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Erzwinge Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Karte für die heutige Analyse';

  @override
  String get settingsTodayInsightCardAuto => 'Automatisch';

  @override
  String get settingsTodayInsightCardOn => 'Ein';

  @override
  String get settingsTodayInsightCardOff => 'Aus';

  @override
  String get settingsYourName => 'Dein Name';

  @override
  String get settingsSignOut => 'Abmelden';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'ft/in';

  @override
  String get settingsHeightFt => 'ft';

  @override
  String get settingsHeightIn => 'in';

  @override
  String get settingsGenderMale => 'Männlich';

  @override
  String get settingsGenderFemale => 'Weiblich';

  @override
  String get settingsGenderPreferNotToSay => 'Möchte ich nicht sagen';

  @override
  String get settingsGenderOther => 'Anderes';

  @override
  String get settingsYourProfile => 'Dein Profil';

  @override
  String get settingsNotSet => 'Nicht gesetzt';

  @override
  String settingsYears(Object value) {
    return '$value Jahre';
  }

  @override
  String get settingsOff => 'Aus';

  @override
  String get settingsOn => 'Ein';

  @override
  String get settingsNoneSet => 'Nichts gesetzt';

  @override
  String settingsSupplementCount(Object count) {
    return '$count Nahrungsergänzung(en)';
  }

  @override
  String get commonToday => 'Heute';

  @override
  String get mainShellHome => 'Start';

  @override
  String get mainShellLog => 'Protokoll';

  @override
  String get mainShellProgress => 'Fortschritt';

  @override
  String get mainShellSettings => 'Einstellungen';

  @override
  String get mainShellLogShowcaseTitle =>
      'Protokolliere täglich, was wichtig ist';

  @override
  String get mainShellLogShowcaseDescription =>
      'Nutze Protokoll, um die Dinge festzuhalten, die dir im Alltag wichtig sind.';

  @override
  String get logMoodShowcaseTitle => 'Starte mit deiner Stimmung';

  @override
  String get logMoodShowcaseDescription =>
      'Protokolliere jetzt deine Stimmung und den Rest Schritt für Schritt, damit Glu Gewohnheiten und Muster genauer erkennen kann.';

  @override
  String get mainShellProgressShowcaseTitle => 'Sieh deinen Fortschritt';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Prüfe deine Muster und Trends, um zu verstehen, wie sich deine Gewohnheiten und dein Gewicht über die Zeit verändern.';

  @override
  String get progressMenuShowcaseTitle => 'Daten erkunden';

  @override
  String get progressMenuShowcaseDescription =>
      'Alle Diagramme ansehen, KI-gestützte Einblicke lesen oder einen Arztbericht erstellen, um ihn mit deinem Behandlungsteam zu teilen.';

  @override
  String get settingsFeedbackShowcaseTitle =>
      'Wir freuen uns über dein Feedback';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Tippe hier, um zu teilen, was funktioniert, was nicht funktioniert oder welche Ideen du hast.';

  @override
  String get authCouldNotOpenLink => 'Konnte nicht öffnen link right jetzt.';

  @override
  String get authWelcomeTitle => 'Welcome zu Glu';

  @override
  String get authSubtitle => 'Secure sign-in für dein wellness companion';

  @override
  String get authContinueWithGoogle => 'Fortfahren mit Google';

  @override
  String get authContinueWithApple => 'Fortfahren mit Apple';

  @override
  String get authEmailHint => 'Name@email.com';

  @override
  String get authSending => 'Wird gesendet...';

  @override
  String get authResendLink => 'Link erneut senden';

  @override
  String get authUseDifferentEmail => 'Verwenden ein different email';

  @override
  String get habitGoalsTitle => 'Gewohnheitsziele';

  @override
  String get goalsProteins => 'Proteine';

  @override
  String get goalsFibers => 'Ballaststoffe';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g per Tag';
  }

  @override
  String get goalsWater => 'Wasser';

  @override
  String goalsLitersPerDay(Object value) {
    return '${value}L per Tag';
  }

  @override
  String get goalsExercise => 'Bewegung';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min per Tag';
  }

  @override
  String get goalsMeals => 'Mahlzeiten';

  @override
  String get goalsCalories => 'Kalorien';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'per Woche';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count Mahlzeiten per Tag';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal per Tag';
  }

  @override
  String get goalsWeight => 'Gewicht';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Hinzufügen ein logged Gewicht zu calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'Du are already bei dies target';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/Woche zu target';
  }

  @override
  String get goalsSetTargetForNextWeek =>
      'Setzen der target für nächste Woche.';

  @override
  String get progressWeightTitle => 'Gewicht';

  @override
  String get progressWeightLabel => 'Gewicht ';

  @override
  String progressWeightUnit(Object unit) {
    return 'kg';
  }

  @override
  String get progressHealthyBmi => 'Gesunder BMI';

  @override
  String get progressTotal => 'Gesamt';

  @override
  String get progressPercent => 'Prozent';

  @override
  String get progressWeeklyAvg => 'Wöchentlicher Schnitt';

  @override
  String get progressRangeAllTime => 'Gesamter Zeitraum';

  @override
  String get progressRange1Month => '1 Monat';

  @override
  String get progressRange3Months => '3 Monate';

  @override
  String get progressRange6Months => '6 Monate';

  @override
  String get progressLow => 'Niedrig';

  @override
  String get progressMed => 'Mittel';

  @override
  String get progressHigh => 'Hoch';

  @override
  String get progressSeverity => 'Schweregrad';

  @override
  String get progressBad => 'Schlecht';

  @override
  String get progressOkay => 'Okay';

  @override
  String get progressGood => 'Gut';

  @override
  String get progressGreat => 'Sehr gut';

  @override
  String get progressMostlyBad => 'Meistens schlecht';

  @override
  String get progressMostlyOkay => 'Meistens okay';

  @override
  String get progressMostlyGood => 'Meistens gut';

  @override
  String get progressMostlyGreat => 'Meistens sehr gut';

  @override
  String get progressNoDose => 'Keine Dosis';

  @override
  String get progressLogged => 'Protokolliert';

  @override
  String get progressAllClear => 'Alles in Ordnung';

  @override
  String get progressFreq => 'Frequenz';

  @override
  String get progressAverage => 'Durchschnitt';

  @override
  String get progressDaily => 'Täglich';

  @override
  String get progressWeekly => 'Wöchentlich';

  @override
  String get progressMinutes => 'Minuten';

  @override
  String get progressIntensity => 'Intensität';

  @override
  String get progressCalories => 'Kalorien';

  @override
  String get progressByDose => 'Nach Dosis';

  @override
  String get progressWeightProgressTitle => 'Gewichtsfortschritt';

  @override
  String get progressWaterProgressTitle => 'Wasserfortschritt';

  @override
  String get progressExerciseProgressTitle => 'Bewegungsfortschritt';

  @override
  String get progressDoseProgressTitle => 'Dosisfortschritt';

  @override
  String get progressMealsProgressTitle => 'Mahlzeitenfortschritt';

  @override
  String get progressSymptomsProgressTitle => 'Symptomfortschritt';

  @override
  String get progressMoodProgressTitle => 'Stimmungsfortschritt';

  @override
  String get progressCravingsProgressTitle => 'Heißhunger-Fortschritt';

  @override
  String get progressResisted => 'Widerstanden';

  @override
  String get progressCravingsResistedSubtitle =>
      'Anteil der protokollierten Heißhunger-Momente, denen du widerstanden hast.';

  @override
  String get progressWeightChangeTitle => 'Gewichtsveränderung';

  @override
  String get progressTitle => 'Fortschritt';

  @override
  String get progressMenuViewAllInsights => 'Alle Analysen ansehen';

  @override
  String get progressMenuViewAllCharts => 'Alle Diagramme ansehen';

  @override
  String get progressMenuCreateDoctorReport => 'Arztbericht erstellen';

  @override
  String get progressReportGenerating => 'Dein Bericht wird erstellt…';

  @override
  String get progressReportError =>
      'Der Bericht konnte nicht erstellt werden. Bitte versuche es erneut.';

  @override
  String get progressReportPendingRetry =>
      'Dein Bericht wird möglicherweise gleich fertig. Bitte versuche es noch einmal.';

  @override
  String get progressReportOpenError =>
      'Dein Bericht wurde erstellt, aber wir konnten ihn nicht öffnen. Bitte versuche es noch einmal.';

  @override
  String get progressReportOpenedInBrowser =>
      'Bericht bereit. In deinem Browser geöffnet.';

  @override
  String get progressReportCopiedLink =>
      'Bericht bereit. Teilen war nicht verfügbar, daher wurde der Link in deine Zwischenablage kopiert.';

  @override
  String get progressAllProgressTitle => 'Gesamtfortschritt';

  @override
  String get progressWeightTrendExplanation =>
      'Sieh, wie sich dein Gewicht über die Zeit verändert.';

  @override
  String get progressNoWeightLogsYet => 'Noch keine Gewichtsprotokolle';

  @override
  String get progressNoLogsYet => 'Noch keine Protokolle';

  @override
  String get progressLogWeightToStartTrend =>
      'Gewicht protokollieren, um deinen Trend zu verfolgen.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Trage Gewicht und Dosis ein, um zu sehen, wie die Dosierung mit der Veränderung zusammenhängt.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Jeder Punkt ist nach der zuletzt vor dem Wiegen verwendeten Dosis eingefärbt.';

  @override
  String get progressNoHydrationYet => 'Noch keine Hydration';

  @override
  String get progressNoMovementYet => 'Noch keine Bewegung';

  @override
  String get progressNoDoseLogsYet => 'Noch keine Dosisprotokolle';

  @override
  String get progressNoMealsLoggedYet => 'Noch keine Mahlzeiten protokolliert';

  @override
  String get progressNoSymptomsLoggedYet => 'Noch keine Symptome protokolliert';

  @override
  String get progressNoMoodLogsYet => 'Noch keine Stimmungsprotokolle';

  @override
  String get progressNoCravingsLoggedYet =>
      'Noch kein Heißhunger protokolliert';

  @override
  String get progressFutureTrendTitle => 'Zukünftiger Trend';

  @override
  String get progressFutureTrendBody =>
      'Eine schöne Zeitleiste deiner Entwicklung';

  @override
  String get progressGoal => 'Ziel';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Dein zuletzt protokolliertes Gewicht ist bereit, verfolgt zu werden.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Etwa $gap $unit von deinem Ziel entfernt.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText im Vergleich zu deinem vorherigen Protokoll.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText im Vergleich zum vorherigen Protokoll. $gap $unit vom Ziel entfernt.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Im Vergleich zu deinem vorherigen Protokoll ist der Trend jetzt sichtbar.';

  @override
  String get progressWaterTitle => 'Wasser';

  @override
  String get manageSubscriptionTitle => 'Abonnement verwalten';

  @override
  String get manageSubscriptionProPlan => 'Pro-Plan';

  @override
  String get manageSubscriptionFreePlan => 'Gratis-Plan';

  @override
  String get manageSubscriptionActiveCopy => 'Dein Abonnement ist aktiv.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Upgrade, um Glu Pro freizuschalten.';

  @override
  String get manageSubscriptionPlan => 'Abo';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratis';

  @override
  String get manageSubscriptionProduct => 'Produkt';

  @override
  String get manageSubscriptionRenewal => 'Verlängerung';

  @override
  String get manageSubscriptionStatus => 'Status';

  @override
  String get manageSubscriptionStatusActive => 'Aktiv';

  @override
  String get manageSubscriptionStatusInactive => 'Inaktiv';

  @override
  String get manageSubscriptionManageButton => 'Abonnement verwalten';

  @override
  String get manageSubscriptionUpgradeButton => 'Auf Pro upgraden';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Abonnement-Einstellungen des Stores öffnen';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Käufe wiederherstellen';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Verlängert sich automatisch';

  @override
  String get manageSubscriptionLifetime => 'Lebenslang';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Verlängert sich am $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Läuft ab am $date';
  }

  @override
  String get supplementReminderDayMon => 'Mo';

  @override
  String get supplementReminderDayTue => 'Di';

  @override
  String get supplementReminderDayWed => 'Mi';

  @override
  String get supplementReminderDayThu => 'Do';

  @override
  String get supplementReminderDayFri => 'Fr';

  @override
  String get supplementReminderDaySat => 'Sa';

  @override
  String get supplementReminderDaySun => 'So';

  @override
  String supplementReminderInDays(Object count) {
    return 'In $count Tagen';
  }

  @override
  String get supplementReminderInOneWeek => 'In 1 Woche';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'In $count Wochen';
  }

  @override
  String get subscriptionDebugTitle => 'Glu-Abonnements';

  @override
  String get subscriptionDebugMonthly => 'Monatlich';

  @override
  String get subscriptionDebugYearly => 'Jährlich';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Kundeninfo aktualisieren';

  @override
  String get subscriptionDebugPresentPaywall => 'Paywall anzeigen';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Kundencenter öffnen';

  @override
  String get subscriptionDebugRestorePurchases => 'Käufe wiederherstellen';

  @override
  String get subscriptionDebugSyncPurchases => 'Käufe synchronisieren';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat-Status';

  @override
  String get subscriptionDebugConfigured => 'Konfiguriert';

  @override
  String get subscriptionDebugBusy => 'Beschäftigt';

  @override
  String get subscriptionDebugAppUserId => 'App-Benutzer-ID';

  @override
  String get subscriptionDebugAnonymous => 'anonym';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-Schlüssel verfügbar';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro aktiv';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Aktive Abonnements';

  @override
  String get subscriptionDebugManagementUrl => 'Verwaltungs-URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Berechtigungsprodukt';

  @override
  String get subscriptionDebugWillRenew => 'Verlängert sich';

  @override
  String get subscriptionDebugExpiration => 'Ablauf';

  @override
  String get subscriptionDebugLifetime => 'lebenslang';

  @override
  String get subscriptionDebugPackageFound => 'Paket gefunden';

  @override
  String get subscriptionDebugProductId => 'Produkt-ID';

  @override
  String get subscriptionDebugTitleLabel => 'Titel';

  @override
  String get subscriptionDebugPrice => 'Preis';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Kaufen $title';
  }

  @override
  String get progressExerciseTitle => 'Bewegung';

  @override
  String get progressDoseTitle => 'Dosis';

  @override
  String get progressMealsTitle => 'Mahlzeiten';

  @override
  String get progressSymptomsTitle => 'Symptome';

  @override
  String get progressMoodTitle => 'Stimmung';

  @override
  String get progressCravingsTitle => 'Heißhunger';

  @override
  String get progressTrend => 'Trend';

  @override
  String get progressTarget => 'Ziel';

  @override
  String get progressNoTrendYet => 'Noch kein Trend';

  @override
  String get progressNoActivityYet => 'Noch keine Aktivität';

  @override
  String get progressNoCheckInsYet => 'Noch keine Check-ins';

  @override
  String get progressWeightSignatureChip =>
      'Gewicht wird dein Signaturdiagramm';

  @override
  String get progressWeightStartTrendTitle =>
      'Starte deinen Trend mit dem ersten Wiegen';

  @override
  String get progressWeightStartTrendBody =>
      'Dieses Diagramm ist der Kern deiner Fortschrittsgeschichte. Protokolliere dein erstes Gewicht, um Momentum, Meilensteine und eine teilbare Ansicht freizuschalten.';

  @override
  String get progressWeightMomentum => 'Gewichtsverlauf';

  @override
  String get progressWeightMilestones => 'Meilensteine';

  @override
  String get progressWeightShareReady => 'Teilbar';

  @override
  String get progressWeightLogWeight => 'Gewicht protokollieren';

  @override
  String get weightProgressUnlocksViewChip =>
      'Dein erstes Wiegen schaltet diese Ansicht frei';

  @override
  String get weightProgressStartsHereTitle =>
      'Deine Fortschrittsgeschichte beginnt hier';

  @override
  String get weightProgressStartsHereBody =>
      'Protokolliere dein erstes Gewicht, um Trends, Meilensteine und dosisbezogene Analysen in einer teilbaren Ansicht freizuschalten.';

  @override
  String get weightProgressTrendView => 'Trendansicht';

  @override
  String get weightProgressDoseOverlays => 'Dosisüberlagerungen';

  @override
  String get weightProgressMilestones => 'Meilensteine';

  @override
  String get weightProgressLogWeight => 'Gewicht protokollieren';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Füge zuerst ein Vorher- und Nachherfoto hinzu.';

  @override
  String get glowUpSavedToGallery => 'In deiner Galerie gespeichert';

  @override
  String get glowUpSaveToGallery => 'In Galerie speichern';

  @override
  String get glowUpYourProgress => 'Dein Fortschritt';

  @override
  String get glowUpWeightChange => 'Gewichtsveränderung';

  @override
  String get glowUpTime => 'Zeit';

  @override
  String get glowUpShare => 'Teilen';

  @override
  String get glowUpBefore => 'VORHER';

  @override
  String get glowUpAfter => 'NACHHER';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight in $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'Tage';

  @override
  String get glowUpTimeUnitWeeksLabel => 'Wochen';

  @override
  String get glowUpTimeUnitMonthsLabel => 'Monate';

  @override
  String get glowUpTimeUnitYearsLabel => 'Jahre';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Tage',
      one: '$count Tag',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Wochen',
      one: '$count Woche',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Monate',
      one: '$count Monat',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Jahre',
      one: '$count Jahr',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Gestern';

  @override
  String get commonSelect => 'Auswählen';

  @override
  String get doseReminderTitle => 'Dosis-Erinnerung';

  @override
  String get doseReminderCustomDoseTitle => 'Benutzerdefinierte Dosis';

  @override
  String get doseReminderCustomDoseHint => 'Dosis in mg eingeben';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Halte deine nächste Dosis auf der Startseite bereit.';

  @override
  String get doseReminderTime => 'Zeit';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Aktiviere dies, um die nächste Dosis auf der Startseite zu zeigen.';

  @override
  String get doseReminderSaveReminder => 'Erinnerung speichern';

  @override
  String loggedOn(Object date) {
    return 'Logged ein $date';
  }

  @override
  String get waterLogSmallGlass => 'Kleines Glas';

  @override
  String get waterLogGlass => 'Glas';

  @override
  String get waterLogBottle => 'Flasche';

  @override
  String get waterLogLargeBottle => 'Große Flasche';

  @override
  String get waterLogTwoLiters => '2 l';

  @override
  String get waterLogCustomPreset => 'Benutzerdefiniert';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dosis';

  @override
  String get doseLogEditTitle => 'Dosis bearbeiten';

  @override
  String get doseLogLogTitle => 'Dosis protokollieren';

  @override
  String get doseLogCustomDose => 'Benutzerdefinierte Dosis';

  @override
  String get doseLogCustomDoseBody =>
      'Passe die Dosis in mg für diesen Eintrag an.';

  @override
  String get doseLogUseThisDose => 'Diese Dosis verwenden';

  @override
  String get doseLogMedication => 'Medikament';

  @override
  String get doseLogInjectionSite => 'Stelle';

  @override
  String get doseLogNotes => 'Notizen';

  @override
  String get doseLogSaveChanges => 'Änderungen speichern';

  @override
  String get doseLogAddDose => '+ Dosis protokollieren';

  @override
  String get doseLogDeleteTitle => 'Dieses Dosisprotokoll löschen?';

  @override
  String get doseLogDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get doseLogDeleteLog => 'Protokoll löschen';

  @override
  String get doseLogSaving => 'Speichert...';

  @override
  String get doseLogCouldNotSave =>
      'Dieses Dosisprotokoll konnte noch nicht gespeichert werden.';

  @override
  String get doseLogCouldNotDelete =>
      'Dieses Dosisprotokoll konnte noch nicht gelöscht werden.';

  @override
  String get doseLogDeleted => 'Dosis gelöscht';

  @override
  String get doseLogAddedToDoseLog => 'Zu deinem Dosisprotokoll hinzugefügt';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Gibt es etwas, das du dir zu dieser Dosis merken möchtest?';

  @override
  String get doseLogDoseLabel => 'Dosis';

  @override
  String get exerciseLogTitle => 'Bewegung';

  @override
  String get exerciseLogEditTitle => 'Bewegung bearbeiten';

  @override
  String get exerciseLogLogTitle => 'Bewegung protokollieren';

  @override
  String get exerciseLogActivityType => 'Aktivitätstyp';

  @override
  String get exerciseLogCustomActivity => 'Benutzerdefinierte Aktivität';

  @override
  String get exerciseLogTypeActivity => 'Aktivität eingeben';

  @override
  String get exerciseLogDuration => 'Dauer';

  @override
  String get exerciseLogIntensity => 'Intensität';

  @override
  String get exerciseLogNotes => 'Notizen';

  @override
  String get exerciseLogLight => 'Leicht';

  @override
  String get exerciseLogModerate => 'Mittel';

  @override
  String get exerciseLogIntense => 'Intensiv';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes Min. protokolliert';
  }

  @override
  String get exerciseLogSaveChanges => 'Änderungen speichern';

  @override
  String get exerciseLogAddExercise => '+ Bewegung protokollieren';

  @override
  String get exerciseLogDeleteTitle => 'Diese Bewegungsaufzeichnung löschen?';

  @override
  String get exerciseLogDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get exerciseLogDeleteLog => 'Protokoll löschen';

  @override
  String get exerciseLogSaving => 'Speichert...';

  @override
  String get exerciseLogCouldNotSave =>
      'Diese Bewegungsaufzeichnung konnte noch nicht gespeichert werden.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Diese Bewegungsaufzeichnung konnte noch nicht gelöscht werden.';

  @override
  String get exerciseLogDeleted => 'Bewegung gelöscht';

  @override
  String get exerciseLogAddedToExerciseLog =>
      'Zu deinem Bewegungsprotokoll hinzugefügt';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Gibt es etwas, das du dir zu dieser Einheit merken möchtest?';

  @override
  String get exerciseLogWalking => 'Gehen';

  @override
  String get exerciseLogRunning => 'Laufen';

  @override
  String get exerciseLogCycling => 'Radfahren';

  @override
  String get exerciseLogStrength => 'Kraft';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Schwimmen';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Gewicht';

  @override
  String get weightLogEditTitle => 'Gewicht bearbeiten';

  @override
  String get weightLogLogTitle => 'Gewicht protokollieren';

  @override
  String get weightLogSaveChanges => 'Änderungen speichern';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Gewicht hinzufügen ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Diese Gewichtsaufzeichnung löschen?';

  @override
  String get weightLogDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get weightLogDeleteLog => 'Protokoll löschen';

  @override
  String get weightLogSaving => 'Speichert...';

  @override
  String get weightLogCouldNotSave =>
      'Diese Gewichtsaufzeichnung konnte noch nicht gespeichert werden.';

  @override
  String get weightLogCouldNotDelete =>
      'Diese Gewichtsaufzeichnung konnte noch nicht gelöscht werden.';

  @override
  String get weightLogDeleted => 'Gewicht gelöscht';

  @override
  String get weightLogAddedToWeightLog =>
      'Zu deinem Gewichtsprotokoll hinzugefügt';

  @override
  String get weightLogNoWeightForDay =>
      'Für diesen Tag ist noch kein Gewicht protokolliert.';

  @override
  String get injectionSiteAbdomen => 'Bauch';

  @override
  String get injectionSiteThigh => 'Oberschenkel';

  @override
  String get injectionSiteUpperArm => 'Oberarm';

  @override
  String get injectionSiteButtocks => 'Gesäß';

  @override
  String get injectionSiteAbdomenUpperLeft => 'oberer linker Bauch';

  @override
  String get injectionSiteAbdomenUpperRight => 'oberer rechter Bauch';

  @override
  String get injectionSiteAbdomenLowerRight => 'unterer rechter Bauch';

  @override
  String get injectionSiteAbdomenLowerLeft => 'unterer linker Bauch';

  @override
  String get injectionSiteThighUpperLeft => 'oberer linker Oberschenkel';

  @override
  String get injectionSiteThighUpperRight => 'oberer rechter Oberschenkel';

  @override
  String get injectionSiteThighLowerRight => 'unterer rechter Oberschenkel';

  @override
  String get injectionSiteThighLowerLeft => 'unterer linker Oberschenkel';

  @override
  String get injectionSiteUpperArmLeft => 'linker Oberarm';

  @override
  String get injectionSiteUpperArmRight => 'rechter Oberarm';

  @override
  String get injectionSiteButtocksUpperLeft => 'oberer linker Gesäßbereich';

  @override
  String get injectionSiteButtocksUpperRight => 'oberer rechter Gesäßbereich';

  @override
  String get doseReminderFormat => 'Format';

  @override
  String get doseReminderInjection => 'Injektion';

  @override
  String get doseReminderPill => 'Pille';

  @override
  String get doseReminderSite => 'Stelle';

  @override
  String get doseReminderDate => 'Datum';

  @override
  String get supplementReminderTitle => 'Erinnerung für Nahrungsergänzung';

  @override
  String get supplementReminderAddSupplement => 'Nahrungsergänzung hinzufügen';

  @override
  String get supplementReminderNoSupplementsYet =>
      'Noch keine Nahrungsergänzungen';

  @override
  String get supplementReminderAddFirstBody =>
      'Füge deine erste Erinnerung für Nahrungsergänzungen hinzu, um deine tägliche Einnahme zu verfolgen.';

  @override
  String get supplementReminderSupplementFallback => 'Nahrungsergänzung';

  @override
  String get supplementReminderEveryDay => 'Jeden Tag';

  @override
  String get supplementReminderEveryXDaysLabel => 'Alle X Tage';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Alle $interval Tage';
  }

  @override
  String get supplementReminderNoDaysSet => 'Keine Tage festgelegt';

  @override
  String get supplementReminderSupplementName => 'Name der Nahrungsergänzung';

  @override
  String get supplementReminderTime => 'Zeit';

  @override
  String get supplementReminderStartDate => 'Startdatum';

  @override
  String get supplementReminderRepeat => 'Wiederholen';

  @override
  String get supplementReminderDaysOfWeek => 'Wochentage';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Wähle mindestens einen Tag aus.';

  @override
  String get supplementReminderEvery => 'Alle';

  @override
  String get supplementReminderDay => 'Tag';

  @override
  String get supplementReminderDays => 'Tage';

  @override
  String get supplementReminderAdd => 'Hinzufügen';

  @override
  String get symptomsLogTitle => 'Symptome';

  @override
  String get symptomsLogEditTitle => 'Symptome bearbeiten';

  @override
  String get symptomsLogLogTitle => 'Symptome protokollieren';

  @override
  String get symptomsLogSymptomsExperienced => 'Erlebte Symptome';

  @override
  String get symptomsLogNoSymptoms => 'Keine Symptome';

  @override
  String get symptomsLogNoSymptomsToday => 'Heute keine Symptome';

  @override
  String get symptomsLogOther => 'Andere...';

  @override
  String get symptomsLogSeverityLevel => 'Schweregrad';

  @override
  String get symptomsLogNotes => 'Notizen';

  @override
  String get symptomsLogAnxiety => 'Angst';

  @override
  String get symptomsLogBelching => 'Aufstoßen';

  @override
  String get symptomsLogBloating => 'Blähungen';

  @override
  String get symptomsLogConstipation => 'Verstopfung';

  @override
  String get symptomsLogDiarrhea => 'Durchfall';

  @override
  String get symptomsLogFatigue => 'Müdigkeit';

  @override
  String get symptomsLogFoodNoise => 'Essensdrang';

  @override
  String get symptomsLogHairLoss => 'Haarausfall';

  @override
  String get symptomsLogHeartburn => 'Sodbrennen';

  @override
  String get symptomsLogIndigestion => 'Verdauungsbeschwerden';

  @override
  String get symptomsLogInjectionSiteReaction =>
      'Reaktion an der Einstichstelle';

  @override
  String get symptomsLogMetallicTaste => 'Metallischer Geschmack';

  @override
  String get symptomsLogHeadache => 'Kopfschmerzen';

  @override
  String get symptomsLogMoodSwings => 'Stimmungsschwankungen';

  @override
  String get symptomsLogNausea => 'Übelkeit';

  @override
  String get symptomsLogReflux => 'Reflux';

  @override
  String get symptomsLogStomachPain => 'Bauchschmerzen';

  @override
  String get symptomsLogSuppressedAppetite => 'Gedämpfter Appetit';

  @override
  String get symptomsLogVomiting => 'Erbrechen';

  @override
  String get symptomsLogLogged => 'Symptome protokolliert';

  @override
  String get symptomsLogMild => 'Leicht';

  @override
  String get symptomsLogModerate => 'Mittel';

  @override
  String get symptomsLogSevere => 'Schwer';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Gibt es etwas, das du dir darüber merken möchtest, wie du dich gefühlt hast?';

  @override
  String get symptomsLogSaveChanges => 'Änderungen speichern';

  @override
  String get symptomsLogAddSymptoms => '+ Symptome protokollieren';

  @override
  String get symptomsLogDeleteTitle => 'Diese Symptomaufzeichnung löschen?';

  @override
  String get symptomsLogDeleteMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get symptomsLogDeleteLog => 'Protokoll löschen';

  @override
  String get symptomsLogSaving => 'Speichert...';

  @override
  String get symptomsLogCouldNotSave =>
      'Diese Symptomaufzeichnung konnte noch nicht gespeichert werden.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Diese Symptomaufzeichnung konnte noch nicht gelöscht werden.';

  @override
  String get symptomsLogDeleted => 'Symptome gelöscht';

  @override
  String get symptomsLogAddedToSymptomsLog =>
      'Zu deinem Symptomprotokoll hinzugefügt';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% des Tagesziels';
  }

  @override
  String get commonDisclaimer =>
      'Glu ist ein Tracking-Tool, kein Medizinprodukt. Es bietet keine medizinische Beratung, Diagnose oder Behandlung. Konsultieren Sie immer Ihren Arzt oder Ihre Ärztin bezüglich Ihrer Medikamente und Gesundheitsentscheidungen.';
}
