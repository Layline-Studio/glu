// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Despertando...';

  @override
  String get startupFailed => 'Error al iniciar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonSaving => 'Guardando...';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonNotNow => 'Ahora no';

  @override
  String get commonNow => 'Ahora';

  @override
  String get commonTomorrow => 'Mañana';

  @override
  String get noteTriggerAddNote => 'Agregar nota';

  @override
  String get noteTriggerCancelNote => 'Cancelar nota';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'En $count días';
  }

  @override
  String get homeDoseReminderInOneWeek => 'En 1 semana';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'En $count semanas';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Due 1 día ago';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Due $count días ago';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Due 1 semana ago';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Due $count semanas ago';
  }

  @override
  String get bmiIndicatorYourBmi => 'Tu BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'Tu BMI actual';

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
  String get heightRulerInUnit => 'en';

  @override
  String get heightRulerFtInUnit => 'ft/en';

  @override
  String get weightDialKgUnit => 'kg';

  @override
  String get weightDialLbUnit => 'lb';

  @override
  String get logNoteIndicatorHasNote => 'Has note';

  @override
  String get paywallTitle => 'Desbloquea Glu Pro';

  @override
  String get paywallSubtitle => 'Sin Pro, esto es lo que pierdes:';

  @override
  String get paywallMonthlyTitle => 'Mensual';

  @override
  String get paywallMonthlySubtitle => 'No trial';

  @override
  String get paywallYearlyTitle => 'Anual';

  @override
  String get paywallYearlySubtitle => '7-día gratis trial';

  @override
  String get paywallNoCommitment => 'Sin compromiso';

  @override
  String get paywallCancelAnytime => 'Cancela cuando quieras';

  @override
  String get paywallContinue => 'Continuar';

  @override
  String get paywallRestore => 'Restaurar';

  @override
  String get paywallTerms => 'Términos';

  @override
  String get paywallPrivacy => 'Privacidad';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Ahorra $percent%';
  }

  @override
  String get paywallCouldNotOpenLink =>
      'No se puede abrir el enlace ahora mismo.';

  @override
  String get paywallAlreadySubscribed => 'Tú already have Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Welcome a Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'Compra did not complete. Please try again.';

  @override
  String get paywallPurchaseFailed => 'Compra failed. Please try again.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Compra failed: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Suscripción restored!';

  @override
  String get paywallRestoreNoSubscription => 'No activo suscripción found.';

  @override
  String get paywallRestoreFailed => 'Restaurar failed. Please try again.';

  @override
  String get paywallBenefitReminders => 'Dosis olvidadas sin recordatorios';

  @override
  String get paywallBenefitShareProgress => 'Más difícil compartir tu progreso';

  @override
  String get paywallBenefitSpotRegain => 'Pasar por alto señales de reganancia';

  @override
  String get paywallBenefitInsights => 'Perder tus patrones diarios';

  @override
  String get paywallBenefitWeeklyGoals => 'Perder tu estructura semanal';

  @override
  String get paywallBenefitHealthyHabits => 'Hábitos que flaquean sin apoyo';

  @override
  String get onboardingWelcomeTitle => 'Mantén el peso';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu ayuda tú protect tu progreso around treatment, objetivos, y semanal hábitos.';

  @override
  String get onboardingWelcomeBullet1 => 'Fits tu treatment y objetivos';

  @override
  String get onboardingWelcomeBullet2 => 'Simple y realistic soporte';

  @override
  String get onboardingWelcomeBullet3 =>
      'Easily spot early signs de peso regain';

  @override
  String get onboardingWelcomeBullet4 => 'Mantener going sin empezando over';

  @override
  String get onboardingMedicationStatusQuestion =>
      '¿Estás tomando actualmente un medicamento para perder peso en pluma o en pastilla?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Usamos esto para mostrar orientación que se adapte a tu momento actual.';

  @override
  String get onboardingMedicationStatusUsing => 'Sí, I\'m taking it ahora';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Sí, I\'m weaning apagado';

  @override
  String get onboardingMedicationStatusNotTaking => 'No, I\'m not taking it';

  @override
  String get onboardingMedicationStatusStartingSoon => 'No, I\'ll empezar soon';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'No, I recently stopped';

  @override
  String get onboardingMedicationMethodQuestion =>
      '¿Cómo tomas tu medicamento?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Usamos esto para adaptar las instrucciones y los recordatorios al formato de tu medicamento.';

  @override
  String get onboardingMedicationMethodInjection => 'Injection';

  @override
  String get onboardingMedicationMethodPill => 'Pill';

  @override
  String get onboardingMedicationMethodUnknown => 'I don\'t know yet';

  @override
  String get onboardingMedicationNameQuestion =>
      '¿Qué medicamento estás tomando?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Usamos esto para personalizar el seguimiento de dosis y la orientación específica del medicamento.';

  @override
  String get onboardingCurrentDoseQuestion => '¿Cuál es tu current dose?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Usamos esto para adaptar el seguimiento de dosis y los controles de progreso futuros.';

  @override
  String get onboardingMedicationCustomDose => 'Custom';

  @override
  String get onboardingDeviceTypeQuestion =>
      '¿Qué dispositivo usas para tomar tu medicamento?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Usamos esto para que los recordatorios y consejos encajen con la forma en que lo tomas.';

  @override
  String get onboardingDeviceSinglePen => 'Single pen';

  @override
  String get onboardingDeviceAutoInjector => 'Auto-injector';

  @override
  String get onboardingDeviceSyringeAndVial => 'Syringe y vial';

  @override
  String get onboardingOther => 'Other';

  @override
  String get onboardingTypeYourDevice => 'Escribe tu device';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      '¿Con qué frecuencia tomas tu medicamento?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Usamos esto para programar recordatorios y apoyo a la rutina según tu horario.';

  @override
  String get onboardingEveryDay => 'Every día';

  @override
  String get onboardingEvery7Days => 'Every 7 días';

  @override
  String get onboardingEvery14Days => 'Every 14 días';

  @override
  String get onboardingCustom => 'Custom';

  @override
  String get onboardingDaysBetweenDoses => 'Días between dosis';

  @override
  String get onboardingPrimaryGoalQuestion =>
      '¿Cuál es tu objetivo principal ahora mismo?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Usamos esto para centrar tu plan, recordatorios y progreso en lo que más te importa.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Usamos esto para dar forma a tu plan desde el principio.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Usamos esto para apoyar tu siguiente etapa y ayudarte a mantener el rumbo.';

  @override
  String get onboardingGoalLoseWeight => 'Perder peso';

  @override
  String get onboardingGoalMaintainWeight => 'Mantener mi peso';

  @override
  String get onboardingGoalManageDiabetes => 'Controlar mi diabetes';

  @override
  String get onboardingGoalManagePcos => 'Controlar mi SOP';

  @override
  String get onboardingGoalImproveHeartHealth => 'Mejorar mi salud del corazón';

  @override
  String get onboardingAgeQuestion => '¿Cuál es tu age?';

  @override
  String get onboardingAgeExplainer =>
      'Usamos esto para ajustar la orientación y los cálculos de salud de forma más adecuada.';

  @override
  String get onboardingHeightQuestion => '¿Cuál es tu height?';

  @override
  String get onboardingHeightExplainer =>
      'Nosotros usar este con tu peso a calculate things like BMI y healthy ranges.';

  @override
  String get onboardingWeightQuestion => '¿Cuál es tu peso actual?';

  @override
  String get onboardingWeightExplainer =>
      'Nosotros usar este as tu empezando point para progreso, objetivos, y salud estimates.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      '¿Cuándo dejaste el medicamento?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      '¿Cuándo empezaste a reducir el medicamento?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      '¿Cuándo empezaste el medicamento?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Usamos esto para entender tu historial reciente de tratamiento y la siguiente etapa.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Usamos esto para entender tu fase de transición y apoyar los hábitos que más importan ahora.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Usamos esto para entender cuánto tiempo llevas en tratamiento y seguir el cambio con el tiempo.';

  @override
  String get onboardingGoalWeightQuestion => '¿Cuál es tu peso objetivo?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Usamos esto para enmarcar el progreso y mostrarte un rango de IMC objetivo.';

  @override
  String get onboardingBenefitsQuestion =>
      'Lo que Glu te ayudará un hacer un continuación';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu convierte lo que compartiste en recordatorios, apoyo y una estructura que encaja con tu rutina.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Así es como Glu puede ayudarte a maintain your progress';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Así es como Glu puede apoyar tu diabetes routine';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Así es como Glu puede apoyar tu PCOS routine';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Así es como Glu puede apoyar tu heart health';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Así es como Glu puede ayudarte a perder peso';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Mira cómo Glu te ayuda a proteger tu peso actual y detectar el reganho pronto.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Mira cómo Glu te ayuda a mantener comidas, peso y rutinas más estables semana a semana.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Mira cómo Glu te ayuda a mantenerte más estable con los síntomas, el peso y la rutina.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Mira cómo Glu te ayuda a mantener los hábitos que apoyan la salud del corazón.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Mira cómo Glu te ayuda a detectar los patrones que mantienen el peso bajando.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Sin estructura, el reganho puede crecer en silencio. Glu te ayuda a detectarlo antes y mantenerte estable.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Sin estructura, las comidas y los patrones de peso se vuelven confusos. Glu aclara las señales.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Sin estructura, symptoms and routines can swing more. Glu helps you stay steadier.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Sin estructura, los hábitos saludables se desvían. Glu te ayuda a mantener la actividad y el peso en el rumbo correcto.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Sin estructura, el peso puede estancarse o subir. Glu ayuda a que el progreso siga avanzando en la dirección correcta.';

  @override
  String get onboardingBenefitsAxisWeight => 'Peso';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Comidas & peso';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Síntomas & peso';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Ejercicio & peso';

  @override
  String get onboardingNotificationsQuestion =>
      'Activa recordatorios que apoyen tu objetivo';

  @override
  String get onboardingNotificationsExplainer =>
      'Nosotros\'ll usar notifications a ayudar tú stay consistent, prepared, y encendido track.';

  @override
  String get onboardingNotificationsHeadline =>
      'Prepara Glu para ayudarte en el momento justo.';

  @override
  String get onboardingNotificationsBody =>
      'Activa las notificaciones para que Glu refuerce los hábitos que apoyan tu objetivo.';

  @override
  String get onboardingNotificationsDaily =>
      'Recordatorios programados que coinciden con tu ritmo diario de medicación';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Recordatorios de más largo plazo para que los días de dosis no te tomen por sorpresa';

  @override
  String get onboardingNotificationsCustom =>
      'Recordatorios diseñados alrededor de tu horario personalizado';

  @override
  String get onboardingNotificationsWeekly =>
      'Recordatorios de dosis que se mantienen alineados con tu ritmo semanal';

  @override
  String get onboardingNotificationsSupportive =>
      'Recordatorios de apoyo que mantienen tu rutina visible cuando baja la motivación';

  @override
  String get onboardingNotificationsProgress =>
      'Timely nudges around progreso, hábitos, y el objetivos tú told us matter most';

  @override
  String get onboardingNotificationsHelpful =>
      'Helpful prompts ese make Glu más useful en el moments tú need it';

  @override
  String get onboardingDailyRoutineQuestion => '¿Cuál es tu daily routine?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Usamos esto para que tu plan se sienta realista para tu día a día.';

  @override
  String get onboardingRoutineSedentary => 'Sedentary';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Mostly sitting, desk work, y very little intentional ejercicio.';

  @override
  String get onboardingRoutineLightlyActive => 'Lightly activo';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regular walking, errands, o light workouts un few times un semana.';

  @override
  String get onboardingRoutineActive => 'Activo';

  @override
  String get onboardingRoutineActiveDescription =>
      'Frequent movement o ejercicio, like diario walks, gym, o activo work.';

  @override
  String get onboardingRoutineVeryActive => 'Very activo';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard training, physically demanding work, o high activity most días.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Which síntomas are tú most concerned about, if any?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Usamos esto para priorizar consejos y orientación sobre los síntomas que más te importan.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Usamos esto para centrarte en los síntomas que quieres anticipar.';

  @override
  String get onboardingGenderQuestion => 'How do tú describe tu género?';

  @override
  String get onboardingGenderExplainer =>
      'Usamos esto para ofrecer una orientación más relevante y una personalización futura.';

  @override
  String get onboardingGenderFemale => 'Female';

  @override
  String get onboardingGenderMale => 'Male';

  @override
  String get onboardingGenderPreferNotToSay => 'Prefer not a say';

  @override
  String get onboardingTypeYourGender => 'Escribe tu gender';

  @override
  String get onboardingPreferredNameQuestion => '¿Cómo deberíamos llamarte?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Usamos esto para make Glu feel more personal when we talk to you.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Configurando tu plan';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Estamos convirtiendo lo que compartiste en un plan que Glu puede apoyar desde ya.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Locking en peso-maintenance targets...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Configurando up regain watchpoints...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Ajustando los recordatorios a tu rutina...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Preparando un plan semanal más estable...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Defining comida y peso patrones...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Configurando hydration soporte...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Preparando recordatorios de consistencia...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Building un clearer diario structure...';

  @override
  String get onboardingSetupSummaryPcosStep1 => 'Organizing síntoma soporte...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Defining semanal movement targets...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Configurando hydration y routine anchors...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Preparando un plan más estable...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'Configurando activity targets...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Defining hydration soporte...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Preparando recordatorios semanales de hábitos...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Building un heart-salud routine...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Defining caloría boundaries...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Configurando agua amounts...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Building ejercicio targets...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Preparando tu plan semanal...';

  @override
  String get onboardingSetupSummaryHeadline =>
      'Tu configuración de Glu está lista.';

  @override
  String get onboardingSetupLoadingTitle => 'Construyendo tu configuración';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu está listo para ayudarte a proteger tu progreso con una estructura más clara y señales más tempranas de reganho.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu está listo para apoyar comidas más estables, seguimiento de peso y hábitos que importan en el día a día.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu está listo para apoyar rutinas más estables alrededor de los síntomas, el tratamiento y el progreso.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu está listo para reforzar los hábitos que apoyan tu salud cardíaca a largo plazo.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu está listo para apoyar las rutinas que te ayudan a mantener el peso.';

  @override
  String get onboardingSetupSummaryLabel => 'Summary';

  @override
  String get onboardingSetupAdjustLater =>
      'Tú can adjust any de este más tarde en Ajustes.';

  @override
  String get onboardingSummaryGoal => 'Objetivo';

  @override
  String get onboardingSummaryCurrentWeight => 'Actual peso';

  @override
  String get onboardingSummaryMedication => 'Medicamento';

  @override
  String get onboardingSummaryCurrentDose => 'Actual dosis';

  @override
  String get onboardingSummaryCadence => 'Cadence';

  @override
  String get onboardingSummaryStarted => 'Empezado';

  @override
  String get onboardingSummaryTargetWeight => 'Target peso';

  @override
  String get onboardingSummaryRoutine => 'Routine';

  @override
  String get onboardingSummaryFocus => 'Enfoque';

  @override
  String get onboardingFrequencyEveryDay => 'Every día';

  @override
  String get onboardingFrequencyEveryWeek => 'Every semana';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Every 2 semanas';

  @override
  String get onboardingFrequencyCustomSchedule => 'Custom schedule';

  @override
  String get onboardingTapOptionContinue => 'Toca una opción para continuar.';

  @override
  String get onboardingTypeGenderContinue =>
      'Escribe tu gender para continuar.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Escribe tu device para continuar.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Escribe tu medicamento para continuar.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Introduce los días entre dosis para continuar.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Elige un horario para continuar.';

  @override
  String get onboardingScrollChooseAge => 'Desplázate para elegir tu edad.';

  @override
  String get onboardingDragOrTapHeight =>
      'Arrastra o toca la regla para elegir tu altura.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Arrastra, toca o usa los botones para elegir un peso.';

  @override
  String get onboardingPickDateAndWeight =>
      'Elige una fecha y un peso para continuar.';

  @override
  String get onboardingSelectSymptoms =>
      'Selecciona cualquier síntoma en el que quieras que Glu se enfoque.';

  @override
  String get onboardingTypeName => 'Escribe el nombre que quieres que use Glu.';

  @override
  String get onboardingSaving => 'Guardando...';

  @override
  String get onboardingLetsBegin => 'Let\'s begin';

  @override
  String get onboardingContinueWithGlu => 'Continuar con Glu';

  @override
  String get onboardingKeepGoing => 'Mantener going';

  @override
  String get onboardingTurnOnNotifications => 'Activar encendido notifications';

  @override
  String get onboardingFinish => 'Finalizar';

  @override
  String get onboardingTargetBmiTitle => 'Tu target BMI';

  @override
  String get onboardingChartToday => 'Hoy';

  @override
  String get onboardingChartOverTime => 'Over time';

  @override
  String get onboardingChartWithoutGlu => 'Sin Glu';

  @override
  String get onboardingChartWithGlu => 'Con Glu';

  @override
  String get onboardingReviewQuestion =>
      'Las personas usan Glu para mantenerse estables y acompañadas';

  @override
  String get onboardingReviewExplainer =>
      'Una valoración rápida ayuda un más personas un encontrar un apoyo tan simple.';

  @override
  String get onboardingReviewBody =>
      'Las personas usan Glu para sentirse más apoyadas, más constantes y menos solas en el proceso.';

  @override
  String get onboardingTypeYourMedication => 'Escribe tu medicamento';

  @override
  String get onboardingSelectStartDate => 'Seleccionar empezar date';

  @override
  String get goalsSaveDialogTitle => 'Guardar objetivos?';

  @override
  String get goalsSaveDialogMessage =>
      'Tienes cambios de objetivo sin guardar. ¿Quieres guardarlos antes de salir de esta pestaña?';

  @override
  String get commonLater => 'Más tarde';

  @override
  String get homeGreetingAnonymous => 'Hola';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hola, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Registra hoy para ver el análisis';

  @override
  String get homeInsightEmptyBody =>
      'Registra algo hoy y verás tu análisis esta noche.';

  @override
  String get homeInsightLogTodayTitle => 'Toca para ver tu análisis';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Toca para ver la perspectiva de hoy';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Tus registros ya empiezan a mostrar un patrón — tócalo para verlo.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Toca para ver tu insight';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Unos cuantos registros más podrían aclarar mucho la imagen — toca cuando quieras.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Toca para descubrir el insight de hoy';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Puede que ya haya un patrón escondido en tu día — toca para verlo.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Registra algo hoy y luego toca para ver qué revela.';

  @override
  String get homeInsightExpandedTitle => '¿Te fue útil?';

  @override
  String get homeInsightExpandedBody =>
      'Una valoración rápida ayuda a Glu a aprender qué es lo que más te importa.';

  @override
  String get homeInsightReasonHint => '¿Qué podría mejorar? (opcional)';

  @override
  String get homeInsightReasonSubmit => 'Enviar';

  @override
  String get homeInsightLearningMessage => 'Aprenderé de esto.';

  @override
  String get homeInsightChecking => 'Comprobando el análisis de hoy...';

  @override
  String get homeInsightGenerating => 'Cargando el análisis de hoy...';

  @override
  String get homeInsightTryAgain => 'Intentar de nuevo';

  @override
  String get homeSeeAllInsights => 'Ver todos los análisis';

  @override
  String get insightsProgressTitle => 'Todos los análisis';

  @override
  String get insightsProgressEmptyState =>
      'Tus análisis aparecerán aquí una vez que se generen.';

  @override
  String get homeDoseReminderTitle => 'Recordatorio de dosis';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Aquí va la interacción de registro de $label.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Se requiere objetivo de calorías';

  @override
  String get homeCalorieGoalRequiredBody =>
      'El control de porciones necesita que el objetivo de comidas esté configurado en calorías para estimar tu porción. Configura uno en Metas para comenzar.';

  @override
  String get homeSetGoal => 'Configurar objetivo';

  @override
  String get homeYourProgress => 'Tu progreso';

  @override
  String get homeRemindersShowcaseTitle => 'Mantente en camino';

  @override
  String get homeRemindersShowcaseDescription =>
      'Configura recordatorios para mantener las dosis y los suplementos a tiempo.';

  @override
  String get homePickNextDoseDate => 'Elige la fecha de tu próxima dosis';

  @override
  String get homeSetReminder => 'Configurar recordatorio';

  @override
  String get homeSupplementReminders => 'Recordatorios de suplementos';

  @override
  String get homeNoUpcomingSupplements => 'No hay suplementos próximos';

  @override
  String get homeNoMoreUpcomingSupplements => 'No hay más próximos';

  @override
  String get homeSetUpYourSupplements => 'Configura tus suplementos';

  @override
  String get homeSetUp => 'Configurar';

  @override
  String get homeSupplementFallback => 'Suplemento';

  @override
  String get doseReminderNotificationTitle => '¿Listo para tu dosis?';

  @override
  String get doseReminderFallbackBody =>
      'Abre Glu para revisar tu próxima dosis.';

  @override
  String get supplementReminderNotificationTitle => 'Hora de tu suplemento';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Esta mañana';

  @override
  String get supplementReminderThisAfternoon => 'Esta tarde';

  @override
  String get supplementReminderTonight => 'Esta noche';

  @override
  String get dailyReminderMorningTitle => 'Chequeo matutino';

  @override
  String get dailyReminderMorningBodies =>
      'Mañana mission: give Glu un little data a play con.\nKick apagado el día con un quick registro y some bueno momentum.\nRise y registro. Future tú will appreciate it.\nEmpezar el día con un tiny update y un big head empezar.\nGive Glu un mañana clue y mantener moving.\nUn registro rápido ahora puede hacer que hoy sea mucho más interesante.\nHagamos que la mañana cuente con un control rápido.';

  @override
  String get dailyReminderMiddayTitle => 'Chequeo del mediodía';

  @override
  String get dailyReminderMiddayBodies =>
      'Parada de mediodía: registra algo rápido y sigue adelante.\n¿Pausa para comer? Perfecto para darle a Glu una actualización.\nYa vas por la mitad. Dale a Glu una pista rápida.\nUn pequeño registro al mediodía puede mantener la historia en marcha.\nRegistra ahora y sigue el día rodando.\nDale un pequeño empujón a tu día con una actualización rápida.\nMantén la energía con un toque rápido al mediodía.';

  @override
  String get dailyReminderAfternoonTitle => 'Chequeo de la tarde';

  @override
  String get dailyReminderAfternoonBodies =>
      'Ya casi terminas. Dale a Glu una pista más.\nUn registro rápido por la tarde puede hacer que el análisis de esta noche destaque.\nCierra el día con una pequeña actualización y una gran victoria.\n¿Un registro más antes de que termine el día?\nAyuda a Glu a conectar las piezas con un chequeo rápido por la tarde.\nCierra el ciclo con un pequeño registro y sigue con la magia.\nUn toque final ahora puede hacer que el análisis de esta noche sea mucho mejor.';

  @override
  String get homePortionCheckTitle => 'Control de porción';

  @override
  String get homePortionCheckBody => 'Sabe cuánto comer en cada comida';

  @override
  String get homeGlowUpTitle => 'Tu\nGlow up';

  @override
  String get homeGlowUpBody => 'Crea tu historia de antes y después';

  @override
  String get homeDoctorReportTitle => 'Informe médico';

  @override
  String get homeDoctorReportBody => 'Comparte tu progreso con tu médico';

  @override
  String get doctorReportViewerRenderError =>
      'No se pudo mostrar el informe. Inténtalo de nuevo.';

  @override
  String get doctorReportViewerShare => 'Compartir';

  @override
  String get homeGoalsStatusTitle => 'Metas de hoy';

  @override
  String get homeGoalsStatusViewAll => 'Ver todo';

  @override
  String get homeWaterTitle => 'Agua';

  @override
  String get homeWeightTitle => 'Peso';

  @override
  String get homeExerciseTitle => 'Ejercicio';

  @override
  String get homeMealsTitle => 'Comidas';

  @override
  String get homeCaloriesTitle => 'Calorías';

  @override
  String get homeProteinsTitle => 'Proteínas';

  @override
  String get homeFibersTitle => 'Fibras';

  @override
  String get homeSymptomsTitle => 'Síntomas';

  @override
  String get homeMoodTitle => 'Estado de ánimo';

  @override
  String get homeCravingsTitle => 'Antojos';

  @override
  String get homeDoseTitle => 'Dosis';

  @override
  String get homeMedicationLevelTitle => 'Nivel estimado del medicamento';

  @override
  String get homeMedicationLevelInfoTitle => 'Cómo leer este gráfico';

  @override
  String get homeMedicationLevelInfoBody =>
      'Este gráfico estima cuánto de tu medicamento puede seguir activo según las dosis registradas y la vida media del medicamento.\n\nLos puntos más altos suelen indicar una dosis más reciente o mayor. La línea desciende con el tiempo a medida que el medicamento se elimina de tu organismo.\n\nUsa esto como una vista de tendencia, no como una medición exacta ni una recomendación médica.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Entendido';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Registra tus dosis para que Glu pueda estimar cuánto medicamento sigue activo en tu organismo.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'del pico reciente';

  @override
  String get homeMedicationLevelActiveNow => 'Activo ahora';

  @override
  String get homeMedicationLevelHalfLife => 'Vida media';

  @override
  String get homeMedicationLevelLastDose => 'Última dosis';

  @override
  String get homeStartHydration => 'Empieza a hidratarte';

  @override
  String get homeLogFirstSession => 'Registra tu primera sesión';

  @override
  String get homeLogTodayWeight => 'Registra el peso de hoy';

  @override
  String get homeAtYourTarget => 'Estás en tu objetivo';

  @override
  String get homeLogMealsToTrackCalories =>
      'Registra comidas para seguir las calorías';

  @override
  String get homeLogFirstMeal => 'Registra tu primera comida';

  @override
  String get homeTrackProteinFromMeals =>
      'Sigue la proteína a partir de las comidas';

  @override
  String get homeTrackFiberFromMeals =>
      'Sigue la fibra a partir de las comidas';

  @override
  String get homeAllClear => 'Todo en orden';

  @override
  String get homeTrackSymptoms => 'Seguimiento de síntomas';

  @override
  String get homeGreat => 'Genial';

  @override
  String get homeGood => 'Bien';

  @override
  String get homeBad => 'Mal';

  @override
  String get homeOkay => 'Regular';

  @override
  String get homeLogHowYouFeel => 'Registra cómo te sientes';

  @override
  String get homeLogACraving => 'Registrar un antojo';

  @override
  String get homeLogTodaysDose => 'Registra la dosis de hoy';

  @override
  String get homeTaken => 'Tomado';

  @override
  String get homeStartHereTitle => 'Empieza aquí';

  @override
  String get homeStartHereBody =>
      'Empieza con esta tarjeta y luego amplía a otras. Cuanto más registres, más podrá Glu mostrar patrones y análisis con precisión.';

  @override
  String get waterLogTitle => 'Hidratación';

  @override
  String get waterLogEditTitle => 'Editar hidratación';

  @override
  String get waterLogLogTitle => 'Registrar agua';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Agregar bebida ($amount)';
  }

  @override
  String get waterLogSaving => 'Guardando...';

  @override
  String get waterLogCustomDrinkTitle => 'Bebida personalizada';

  @override
  String get waterLogCustomDrinkBody =>
      'Elige la cantidad que quieres agregar ahora.';

  @override
  String get waterLogUseThisAmount => 'Usar esta cantidad';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount añadido a tu registro de hidratación';
  }

  @override
  String get waterLogCouldNotSave =>
      'Todavía no se pudo guardar este registro de agua.';

  @override
  String get waterLogDeleteTitle => '¿Eliminar este registro de hidratación?';

  @override
  String get waterLogDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get waterLogCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de agua.';

  @override
  String get waterLogDeleteLog => 'Eliminar registro';

  @override
  String get waterLogDeleted => 'Hidratación eliminada';

  @override
  String get moodLogTitle => 'Estado de ánimo';

  @override
  String get moodEditTitle => 'Editar estado de ánimo';

  @override
  String get moodHowYouFeel => 'Cómo te sientes';

  @override
  String get moodBad => 'Mal';

  @override
  String get moodOkay => 'Regular';

  @override
  String get moodGood => 'Bien';

  @override
  String get moodGreat => 'Muy bien';

  @override
  String get moodNotes => 'Notas';

  @override
  String get moodAnythingWorthRemembering =>
      '¿Algo que valga la pena recordar sobre tu estado de ánimo?';

  @override
  String get moodCouldNotSave =>
      'Todavía no se pudo guardar este registro de estado de ánimo.';

  @override
  String get moodDeleteTitle => '¿Eliminar este registro de estado de ánimo?';

  @override
  String get moodDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get moodDeleteLog => 'Eliminar registro';

  @override
  String get moodSaving => 'Guardando...';

  @override
  String get moodAddMoodLog => '+ Registrar estado de ánimo';

  @override
  String get moodLogged => 'Estado de ánimo registrado';

  @override
  String get moodDeleted => 'Estado de ánimo eliminado';

  @override
  String get moodCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de estado de ánimo.';

  @override
  String get moodAddedToMoodLog => 'Añadido a tu registro de estado de ánimo';

  @override
  String get cravingsLogTitle => 'Antojos';

  @override
  String get cravingsEditTitle => 'Editar antojo';

  @override
  String get cravingsWhatsGoingOn => 'Qué está pasando';

  @override
  String get cravingsTypeGeneral => 'Ganas de comer';

  @override
  String get cravingsTypeSweet => 'Algo dulce';

  @override
  String get cravingsTypeSalty => 'Algo salado';

  @override
  String get cravingsIntensityLabel => 'Intensidad (opcional)';

  @override
  String get cravingsIntensityMild => 'Leve';

  @override
  String get cravingsIntensityModerate => 'Moderada';

  @override
  String get cravingsIntensityStrong => 'Fuerte';

  @override
  String get cravingsOutcomeLabel => 'Qué pasó (opcional)';

  @override
  String get cravingsOutcomeResisted => 'Lo resistí';

  @override
  String get cravingsOutcomeGaveIn => 'Cedí';

  @override
  String get cravingsNotes => 'Notas';

  @override
  String get cravingsAnythingWorthRemembering =>
      '¿Algo que valga la pena recordar sobre este antojo?';

  @override
  String get cravingsCouldNotSave =>
      'Todavía no se pudo guardar este registro de antojo.';

  @override
  String get cravingsDeleteTitle => '¿Eliminar este registro de antojo?';

  @override
  String get cravingsDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get cravingsDeleteLog => 'Eliminar registro';

  @override
  String get cravingsSaving => 'Guardando...';

  @override
  String get cravingsAddLog => '+ Registrar antojo';

  @override
  String get cravingsLogged => 'Antojo registrado';

  @override
  String get cravingsDeleted => 'Antojo eliminado';

  @override
  String get cravingsCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de antojo.';

  @override
  String get cravingsAddedToLog => 'Añadido a tu registro de antojos';

  @override
  String get portionCheckTitle => 'Control de porción';

  @override
  String get portionCheckAnalyzingMeal => 'Analizando tu comida…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'No se pudo analizar esta foto';

  @override
  String get portionCheckTakeNewPhoto => 'Tomar una nueva foto';

  @override
  String get portionCheckSomethingWentWrong => 'Algo salió mal.';

  @override
  String get portionCheckYouHitDailyLimit => 'Has alcanzado tu límite diario';

  @override
  String get portionCheckYouCanEat => 'Puedes comer';

  @override
  String get portionCheckYouCanEatUpTo => 'Puedes comer hasta';

  @override
  String get portionCheckTryLighterOption =>
      'Prueba una opción más ligera o sáltala';

  @override
  String get portionCheckThisEntireMeal => 'toda esta comida';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% de esta comida';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'para mantenerte dentro de tus objetivos diarios.';

  @override
  String get portionCheckNutritionBreakdown => 'Desglose nutricional';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Consejos para equilibrar tu comida';

  @override
  String get portionCheckTipsPool =>
      'Come despacio: la sensación de saciedad tarda unos 20 minutos en llegar.\nLlena la mitad del plato con verduras.\nIncluye proteína en cada comida.\nBebe agua antes de comer.\nPorciona los snacks en recipientes pequeños.\nCombina carbohidratos con proteína o grasa para saciarte por más tiempo.\nElige alimentos poco procesados siempre que puedas.\nEvita comer distraído por pantallas.\nNo saltes comidas si eso hace que luego comas de más.\nPlanifica tus snacks antes de tener hambre.';

  @override
  String get portionCheckRetake => 'Volver a tomar';

  @override
  String get portionCheckLogThisPortion => 'Registrar esta porción';

  @override
  String get portionCheckCarbs => 'Carbohidratos';

  @override
  String get portionCheckProteins => 'Proteínas';

  @override
  String get portionCheckFats => 'Grasas';

  @override
  String get portionCheckFiber => 'Fibra';

  @override
  String get mealLogScreenTitle => 'Comidas';

  @override
  String get mealLogEditTitle => 'Editar comida';

  @override
  String get mealLogLogTitle => 'Registrar comida';

  @override
  String get mealLogSaving => 'Guardando...';

  @override
  String get mealLogAddMealLog => '+ Agregar registro de comida';

  @override
  String get mealLogCouldNotStartRecording =>
      'No se pudo iniciar la grabación.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'La grabación se detuvo a los 60 segundos.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'No se pudo analizar esta grabación.';

  @override
  String get mealLogCouldNotAnalyzeText => 'No se pudo analizar este texto.';

  @override
  String get mealLogCouldNotAnalyzePhoto => 'No se pudo analizar esta foto.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Todavía no se pudo procesar esta foto de comida.';

  @override
  String get mealLogDiscardTitle => '¿Descartar esta comida?';

  @override
  String get mealLogDiscardMessage =>
      'Revisaste una foto pero no guardaste la entrada. No se registrará.';

  @override
  String get mealLogDiscard => 'Descartar';

  @override
  String get mealLogDeleteTitle => '¿Eliminar este registro de comida?';

  @override
  String get mealLogDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get mealLogDelete => 'Eliminar';

  @override
  String get mealLogDeleteLog => 'Eliminar registro';

  @override
  String get mealLogCouldNotSave =>
      'Todavía no se pudo guardar este registro de comida.';

  @override
  String get mealLogCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de comida.';

  @override
  String get mealLogAnalyzing => 'Analizando...';

  @override
  String get mealLogAnalyzeText => 'Analizar texto';

  @override
  String get mealLogSendRecording => 'Enviar grabación';

  @override
  String get mealLogMealDefaultName => 'Comida';

  @override
  String get mealLogMealNameHint => 'Nombre de la comida';

  @override
  String get mealLogCouldNotPrefillTitle => 'No se pudo completar esta comida';

  @override
  String get mealLogHowMuchDidYouEat => '¿Cuánto comiste?';

  @override
  String get mealLogNotes => 'Notas';

  @override
  String get mealLogAnythingWorthRemembering =>
      '¿Algo que valga la pena recordar sobre esta comida?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analizando tu comida';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Estamos convirtiendo tu entrada en campos nutricionales. Puedes revisar todo antes de guardar.';

  @override
  String get mealLogDescribeYourMealTitle => 'Describe tu comida';

  @override
  String get mealLogDescribeYourMealBody =>
      'Escribe qué comiste y las cantidades que conozcas. Lo convertiremos en campos nutricionales.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Ejemplo: ensalada de pollo a la parrilla, aderezo de aceite de oliva, 1 manzana, agua con gas';

  @override
  String get mealLogCaptureYourMealTitle => 'Captura tu comida';

  @override
  String get mealLogCaptureYourMealBody =>
      'Toma una foto y estimaremos los campos nutricionales por ti.';

  @override
  String get mealLogTakePhoto => 'Tomar foto';

  @override
  String get mealLogRecordingYourMealTitle => 'Grabando tu comida';

  @override
  String get mealLogRecordingReadyTitle => 'Grabación lista';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Grabar una descripción de la comida';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Toca detener cuando termines. Quedan ${remaining}s';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Envíalo abajo para analizarlo, o graba de nuevo.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Habla con naturalidad sobre lo que comiste y lo analizaremos para convertirlo en macros.';

  @override
  String get mealLogStopRecording => 'Detener grabación';

  @override
  String get mealLogRecordAgain => 'Grabar de nuevo';

  @override
  String get mealLogStartRecording => 'Empezar a grabar';

  @override
  String get mealLogBreakfast => 'Desayuno';

  @override
  String get mealLogLunch => 'Almuerzo';

  @override
  String get mealLogSnack => 'Snack';

  @override
  String get mealLogDinner => 'Cena';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'Hoy';

  @override
  String get mealLogYesterday => 'Ayer';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal registradas';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g de $macro registrados';
  }

  @override
  String get mealLogDeleted => 'Comida eliminada';

  @override
  String get mealLogAddedToMealLog => 'Añadido a tu registro de comidas';

  @override
  String get mealLogCarbs => 'Carbohidratos';

  @override
  String get mealLogProteins => 'Proteínas';

  @override
  String get mealLogFats => 'Grasas';

  @override
  String get mealLogFiber => 'Fibra';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDialogTitle => 'Selecciona el idioma';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsPreferences => 'Preferencias';

  @override
  String get settingsHealthGoal => 'Objetivo de salud';

  @override
  String get settingsHealthGoalDialogTitle => 'Selecciona el objetivo de salud';

  @override
  String get settingsHabitGoals => 'Metas de hábito';

  @override
  String get settingsDisabled => 'Desactivado';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count activas';
  }

  @override
  String get settingsHeight => 'Altura';

  @override
  String get settingsAge => 'Edad';

  @override
  String get settingsGender => 'Género';

  @override
  String get settingsMeasurementUnit => 'Unidad de medida';

  @override
  String get settingsReminders => 'Recordatorios';

  @override
  String get settingsDoseReminder => 'Recordatorio de dosis';

  @override
  String get settingsSupplementReminder => 'Recordatorio de suplemento';

  @override
  String get settingsDailyReminders => 'Recordatorios diarios';

  @override
  String get settingsSubscription => 'Suscripción';

  @override
  String get settingsSupport => 'Soporte';

  @override
  String get settingsSendFeedback => 'Enviar comentarios';

  @override
  String get feedbackSheetTitle => 'Enviar comentarios';

  @override
  String get feedbackSheetHint => 'Cuéntanos qué piensas…';

  @override
  String get feedbackSheetSend => 'Enviar';

  @override
  String get feedbackSheetSuccess => '¡Gracias por tus comentarios!';

  @override
  String get feedbackSheetError => 'No se pudo enviar. Inténtalo de nuevo.';

  @override
  String get settingsTermsOfService => 'Términos del servicio';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsInternal => 'Interno';

  @override
  String get settingsSubscriptionOverride => 'Anulación de suscripción';

  @override
  String get settingsTodayInsightCard => 'Tarjeta de análisis de hoy';

  @override
  String get settingsResetOnboarding => 'Restablecer onboarding';

  @override
  String get settingsResetShowcases => 'Restablecer showcases';

  @override
  String get settingsResetUserData => 'Restablecer datos del usuario';

  @override
  String get settingsDeletingAccount => 'Eliminando cuenta...';

  @override
  String get settingsDisconnect => 'Desconectar';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Desconectar $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return '¿Desconectar $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Ya no podrás iniciar sesión con $provider en este dispositivo a menos que lo reconectes más tarde.';
  }

  @override
  String get settingsDeleteAccountTitle => '¿Eliminar cuenta?';

  @override
  String get settingsDeleteAccountBody =>
      'Esto eliminará de forma permanente tu cuenta y todos tus datos. Esta acción no se puede deshacer.';

  @override
  String get settingsDeleteAccountConfirmHint =>
      'Escribe DELETE para confirmar';

  @override
  String get settingsDeleteAccountError =>
      'Algo salió mal al eliminar tu cuenta. Ponte en contacto con support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Reinicia la app para ver el onboarding';

  @override
  String get settingsShowcasesReset => 'Showcases restablecidos';

  @override
  String get settingsResetUserDataTitle => '¿Restablecer datos del usuario?';

  @override
  String get settingsResetUserDataBody =>
      'Esto borrará todos los registros de comidas, agua, ejercicio, peso, estado de ánimo, síntomas, suplementos y dosis.';

  @override
  String get settingsUserDataReset => 'Datos del usuario restablecidos';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Guardado, pero no se pudieron programar los recordatorios diarios por ahora.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Anulación de suscripción';

  @override
  String get settingsSubscriptionOverrideAuto => 'Automático';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Forzar gratis';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Forzar Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Tarjeta de análisis de hoy';

  @override
  String get settingsTodayInsightCardAuto => 'Automático';

  @override
  String get settingsTodayInsightCardOn => 'Activado';

  @override
  String get settingsTodayInsightCardOff => 'Desactivado';

  @override
  String get settingsYourName => 'Tu nombre';

  @override
  String get settingsSignOut => 'Cerrar sesión';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'pies/pulg';

  @override
  String get settingsHeightFt => 'pies';

  @override
  String get settingsHeightIn => 'pulg';

  @override
  String get settingsGenderMale => 'Masculino';

  @override
  String get settingsGenderFemale => 'Femenino';

  @override
  String get settingsGenderPreferNotToSay => 'Prefiero no decirlo';

  @override
  String get settingsGenderOther => 'Otro';

  @override
  String get settingsYourProfile => 'Tu perfil';

  @override
  String get settingsNotSet => 'No establecido';

  @override
  String settingsYears(Object value) {
    return '$value años';
  }

  @override
  String get settingsOff => 'Apagado';

  @override
  String get settingsOn => 'Encendido';

  @override
  String get settingsNoneSet => 'Nada establecido';

  @override
  String settingsSupplementCount(Object count) {
    return '$count suplemento(s)';
  }

  @override
  String get commonToday => 'Hoy';

  @override
  String get mainShellHome => 'Inicio';

  @override
  String get mainShellLog => 'Registros';

  @override
  String get mainShellProgress => 'Progreso';

  @override
  String get mainShellSettings => 'Ajustes';

  @override
  String get mainShellLogShowcaseTitle => 'Registra lo que importa cada día';

  @override
  String get mainShellLogShowcaseDescription =>
      'Registra las actividades que más te importan, todos los días.';

  @override
  String get logMoodShowcaseTitle => 'Empieza con tu estado de ánimo';

  @override
  String get logMoodShowcaseDescription =>
      'Registra tu estado de ánimo ahora y sigue registrando el resto a medida que avanzas para que Glu pueda detectar hábitos y patrones con mayor precisión.';

  @override
  String get mainShellProgressShowcaseTitle => 'Ve tu progreso';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Revisa tus patrones y tendencias para entender cómo cambian tus hábitos y tu peso con el tiempo.';

  @override
  String get progressMenuShowcaseTitle => 'Explora tus datos';

  @override
  String get progressMenuShowcaseDescription =>
      'Consulta todos los gráficos, lee información generada por IA o crea un informe para tu médico y compártelo con tu equipo de salud.';

  @override
  String get settingsFeedbackShowcaseTitle =>
      'Nos encantaría conocer tu opinión';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Toca aquí para compartir lo que funciona, lo que no o cualquier idea que tengas.';

  @override
  String get authCouldNotOpenLink => 'No se puede abrir el enlace ahora mismo.';

  @override
  String get authWelcomeTitle => 'Welcome a Glu';

  @override
  String get authSubtitle => 'Secure sign-en para tu wellness companion';

  @override
  String get authContinueWithGoogle => 'Continuar con Google';

  @override
  String get authContinueWithApple => 'Continuar con Apple';

  @override
  String get authEmailHint => 'nombre@email.com';

  @override
  String get authSending => 'Sending...';

  @override
  String get authResendLink => 'Resend link';

  @override
  String get authUseDifferentEmail => 'Usar un different email';

  @override
  String get habitGoalsTitle => 'Metas de hábito';

  @override
  String get goalsProteins => 'Proteínas';

  @override
  String get goalsFibers => 'Fibers';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g per día';
  }

  @override
  String get goalsWater => 'Agua';

  @override
  String goalsLitersPerDay(Object value) {
    return '${value}L per día';
  }

  @override
  String get goalsExercise => 'Ejercicio';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min per día';
  }

  @override
  String get goalsMeals => 'Comidas';

  @override
  String get goalsCalories => 'Calorías';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'per semana';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count comidas per día';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal per día';
  }

  @override
  String get goalsWeight => 'Peso';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Agregar un logged peso a calculate pace';

  @override
  String get goalsAlreadyAtThisTarget => 'Tú are already a este target';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/semana a target';
  }

  @override
  String get goalsSetTargetForNextWeek =>
      'Establece el objetivo para la próxima semana.';

  @override
  String get progressWeightTitle => 'Peso';

  @override
  String get progressWeightLabel => 'Peso ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'IMC saludable';

  @override
  String get progressTotal => 'Total';

  @override
  String get progressPercent => 'Porcentaje';

  @override
  String get progressWeeklyAvg => 'Promedio semanal';

  @override
  String get progressRangeAllTime => 'Todo el tiempo';

  @override
  String get progressRange1Month => '1 mes';

  @override
  String get progressRange3Months => '3 meses';

  @override
  String get progressRange6Months => '6 meses';

  @override
  String get progressLow => 'Bajo';

  @override
  String get progressMed => 'Medio';

  @override
  String get progressHigh => 'Alto';

  @override
  String get progressSeverity => 'Severidad';

  @override
  String get progressBad => 'Mal';

  @override
  String get progressOkay => 'Regular';

  @override
  String get progressGood => 'Bien';

  @override
  String get progressGreat => 'Muy bien';

  @override
  String get progressMostlyBad => 'Mayormente mal';

  @override
  String get progressMostlyOkay => 'Mayormente regular';

  @override
  String get progressMostlyGood => 'Mayormente bien';

  @override
  String get progressMostlyGreat => 'Mayormente muy bien';

  @override
  String get progressNoDose => 'Sin dosis';

  @override
  String get progressLogged => 'Registrado';

  @override
  String get progressAllClear => 'Todo en orden';

  @override
  String get progressFreq => 'Frecuencia';

  @override
  String get progressAverage => 'Promedio';

  @override
  String get progressDaily => 'Diario';

  @override
  String get progressWeekly => 'Semanal';

  @override
  String get progressMinutes => 'Minutos';

  @override
  String get progressIntensity => 'Intensidad';

  @override
  String get progressCalories => 'Calorías';

  @override
  String get progressByDose => 'Por dosis';

  @override
  String get progressWeightProgressTitle => 'Progreso de peso';

  @override
  String get progressWaterProgressTitle => 'Progreso de hidratación';

  @override
  String get progressExerciseProgressTitle => 'Progreso de ejercicio';

  @override
  String get progressDoseProgressTitle => 'Progreso de dosis';

  @override
  String get progressMealsProgressTitle => 'Progreso de comidas';

  @override
  String get progressSymptomsProgressTitle => 'Progreso de síntomas';

  @override
  String get progressMoodProgressTitle => 'Progreso de estado de ánimo';

  @override
  String get progressCravingsProgressTitle => 'Progreso de antojos';

  @override
  String get progressResisted => 'Resistidos';

  @override
  String get progressCravingsResistedSubtitle =>
      'Proporción de antojos registrados que resististe.';

  @override
  String get progressWeightChangeTitle => 'Cambio de peso';

  @override
  String get progressTitle => 'Progreso';

  @override
  String get progressMenuViewAllInsights => 'Ver todos los análisis';

  @override
  String get progressMenuViewAllCharts => 'Ver todos los gráficos';

  @override
  String get progressMenuCreateDoctorReport => 'Crear informe médico';

  @override
  String get progressReportGenerating => 'Generando tu informe…';

  @override
  String get progressReportError =>
      'No se pudo generar el informe. Inténtalo de nuevo.';

  @override
  String get progressReportPendingRetry =>
      'Tu informe aún podría terminar de generarse en un momento. Inténtalo de nuevo.';

  @override
  String get progressReportOpenError =>
      'Tu informe se generó, pero no pudimos abrirlo. Inténtalo de nuevo.';

  @override
  String get progressAllProgressTitle => 'Todo el progreso';

  @override
  String get progressWeightTrendExplanation =>
      'Mira cómo cambia tu peso con el tiempo.';

  @override
  String get progressNoWeightLogsYet => 'Aún no hay registros de peso';

  @override
  String get progressNoLogsYet => 'Aún no hay registros';

  @override
  String get progressLogWeightToStartTrend =>
      'Registra el peso para empezar a seguir tu tendencia.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Registra el peso y la dosis para comparar cómo la dosis se relaciona con el cambio.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Cada punto se colorea según la última dosis usada antes de ese pesaje.';

  @override
  String get progressNoHydrationYet => 'Aún no hay hidratación';

  @override
  String get progressNoMovementYet => 'Aún no hay movimiento';

  @override
  String get progressNoDoseLogsYet => 'Aún no hay registros de dosis';

  @override
  String get progressNoMealsLoggedYet => 'Aún no hay comidas registradas';

  @override
  String get progressNoSymptomsLoggedYet => 'Aún no hay síntomas registrados';

  @override
  String get progressNoMoodLogsYet => 'Aún no hay registros de estado de ánimo';

  @override
  String get progressNoCravingsLoggedYet => 'Aún no hay antojos registrados';

  @override
  String get progressFutureTrendTitle => 'Tendencia futura';

  @override
  String get progressFutureTrendBody =>
      'Una hermosa línea temporal de tu impulso';

  @override
  String get progressGoal => 'Objetivo';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Tu último peso registrado está listo para seguirse.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Aproximadamente a $gap $unit de tu objetivo.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText respecto a tu registro anterior.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText respecto al registro anterior. A $gap $unit del objetivo.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Comparado con tu registro anterior, la tendencia ya es visible.';

  @override
  String get progressWaterTitle => 'Agua';

  @override
  String get manageSubscriptionTitle => 'Administrar suscripción';

  @override
  String get manageSubscriptionProPlan => 'Plan Pro';

  @override
  String get manageSubscriptionFreePlan => 'Plan gratis';

  @override
  String get manageSubscriptionActiveCopy => 'Tu suscripción está activa.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Actualiza para desbloquear Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Plan';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratis';

  @override
  String get manageSubscriptionProduct => 'Producto';

  @override
  String get manageSubscriptionRenewal => 'Renovación';

  @override
  String get manageSubscriptionStatus => 'Estado';

  @override
  String get manageSubscriptionStatusActive => 'Activo';

  @override
  String get manageSubscriptionStatusInactive => 'Inactivo';

  @override
  String get manageSubscriptionManageButton => 'Administrar suscripción';

  @override
  String get manageSubscriptionUpgradeButton => 'Actualizar a Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Abrir configuración de suscripción de la tienda';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Restaurar compras';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Se renueva automáticamente';

  @override
  String get manageSubscriptionLifetime => 'De por vida';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Se renueva el $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Expira el $date';
  }

  @override
  String get supplementReminderDayMon => 'Lu';

  @override
  String get supplementReminderDayTue => 'Ma';

  @override
  String get supplementReminderDayWed => 'Mi';

  @override
  String get supplementReminderDayThu => 'Ju';

  @override
  String get supplementReminderDayFri => 'Vi';

  @override
  String get supplementReminderDaySat => 'Sa';

  @override
  String get supplementReminderDaySun => 'Do';

  @override
  String supplementReminderInDays(Object count) {
    return 'En $count días';
  }

  @override
  String get supplementReminderInOneWeek => 'En 1 semana';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'En $count semanas';
  }

  @override
  String get subscriptionDebugTitle => 'Suscripciones de Glu';

  @override
  String get subscriptionDebugMonthly => 'Mensual';

  @override
  String get subscriptionDebugYearly => 'Anual';

  @override
  String get subscriptionDebugRefreshCustomerInfo =>
      'Actualizar información del cliente';

  @override
  String get subscriptionDebugPresentPaywall => 'Mostrar muro de pago';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Abrir centro de clientes';

  @override
  String get subscriptionDebugRestorePurchases => 'Restaurar compras';

  @override
  String get subscriptionDebugSyncPurchases => 'Sincronizar compras';

  @override
  String get subscriptionDebugRevenuecatStatus => 'Estado de RevenueCat';

  @override
  String get subscriptionDebugConfigured => 'Configurado';

  @override
  String get subscriptionDebugBusy => 'Ocupado';

  @override
  String get subscriptionDebugAppUserId => 'ID de usuario de la app';

  @override
  String get subscriptionDebugAnonymous => 'anónimo';

  @override
  String get subscriptionDebugApiKeyAvailable => 'Clave API disponible';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro activo';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Suscripciones activas';

  @override
  String get subscriptionDebugManagementUrl => 'URL de gestión';

  @override
  String get subscriptionDebugEntitlementProduct => 'Producto de beneficio';

  @override
  String get subscriptionDebugWillRenew => 'Se renovará';

  @override
  String get subscriptionDebugExpiration => 'Vencimiento';

  @override
  String get subscriptionDebugLifetime => 'de por vida';

  @override
  String get subscriptionDebugPackageFound => 'Paquete encontrado';

  @override
  String get subscriptionDebugProductId => 'ID del producto';

  @override
  String get subscriptionDebugTitleLabel => 'Título';

  @override
  String get subscriptionDebugPrice => 'Precio';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Comprar $title';
  }

  @override
  String get progressExerciseTitle => 'Ejercicio';

  @override
  String get progressDoseTitle => 'Dosis';

  @override
  String get progressMealsTitle => 'Comidas';

  @override
  String get progressSymptomsTitle => 'Síntomas';

  @override
  String get progressMoodTitle => 'Estado de ánimo';

  @override
  String get progressCravingsTitle => 'Antojos';

  @override
  String get progressTrend => 'Tendencia';

  @override
  String get progressTarget => 'Objetivo';

  @override
  String get progressNoTrendYet => 'Aún no hay tendencia';

  @override
  String get progressNoActivityYet => 'Aún no hay actividad';

  @override
  String get progressNoCheckInsYet => 'Aún no hay registros de control';

  @override
  String get progressWeightSignatureChip =>
      'El peso será tu gráfico distintivo';

  @override
  String get progressWeightStartTrendTitle =>
      'Empieza tu tendencia con un primer pesaje';

  @override
  String get progressWeightStartTrendBody =>
      'Este gráfico es la pieza central de tu historia de progreso. Registra tu primer peso para desbloquear impulso, hitos y una vista que vale la pena compartir.';

  @override
  String get progressWeightMomentum => 'Impulso';

  @override
  String get progressWeightMilestones => 'Hitos';

  @override
  String get progressWeightShareReady => 'Listo para compartir';

  @override
  String get progressWeightLogWeight => 'Registrar peso';

  @override
  String get weightProgressUnlocksViewChip =>
      'Tu primer pesaje desbloquea esta vista';

  @override
  String get weightProgressStartsHereTitle =>
      'Tu historia de progreso comienza aquí';

  @override
  String get weightProgressStartsHereBody =>
      'Registra tu primer peso para desbloquear tendencias, hitos y análisis con dosis en una vista que vale la pena compartir.';

  @override
  String get weightProgressTrendView => 'Vista de tendencia';

  @override
  String get weightProgressDoseOverlays => 'Superposiciones de dosis';

  @override
  String get weightProgressMilestones => 'Hitos';

  @override
  String get weightProgressLogWeight => 'Registrar peso';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Agrega primero una foto de antes y después.';

  @override
  String get glowUpSavedToGallery => 'Guardado en tu galería';

  @override
  String get glowUpSaveToGallery => 'Guardar en la galería';

  @override
  String get glowUpYourProgress => 'Tu progreso';

  @override
  String get glowUpWeightChange => 'Cambio de peso';

  @override
  String get glowUpTime => 'Tiempo';

  @override
  String get glowUpShare => 'Compartir';

  @override
  String get glowUpBefore => 'ANTES';

  @override
  String get glowUpAfter => 'DESPUÉS';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight en $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'días';

  @override
  String get glowUpTimeUnitWeeksLabel => 'semanas';

  @override
  String get glowUpTimeUnitMonthsLabel => 'meses';

  @override
  String get glowUpTimeUnitYearsLabel => 'años';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count días',
      one: '$count día',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count semanas',
      one: '$count semana',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count meses',
      one: '$count mes',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count años',
      one: '$count año',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Ayer';

  @override
  String get commonSelect => 'Seleccionar';

  @override
  String get doseReminderTitle => 'Recordatorio de dosis';

  @override
  String get doseReminderCustomDoseTitle => 'Dosis personalizada';

  @override
  String get doseReminderCustomDoseHint => 'Escribe la dosis en mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Mantén tu próxima dosis visible en Inicio.';

  @override
  String get doseReminderTime => 'Hora';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Actívalo para mostrar la próxima dosis en Inicio.';

  @override
  String get doseReminderSaveReminder => 'Guardar recordatorio';

  @override
  String loggedOn(Object date) {
    return 'Logged encendido $date';
  }

  @override
  String get waterLogSmallGlass => 'Vaso pequeño';

  @override
  String get waterLogGlass => 'Vaso';

  @override
  String get waterLogBottle => 'Botella';

  @override
  String get waterLogLargeBottle => 'Botella grande';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Personalizado';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dosis';

  @override
  String get doseLogEditTitle => 'Editar dosis';

  @override
  String get doseLogLogTitle => 'Registrar dosis';

  @override
  String get doseLogCustomDose => 'Dosis personalizada';

  @override
  String get doseLogCustomDoseBody =>
      'Ajusta la dosis en mg para este registro.';

  @override
  String get doseLogUseThisDose => 'Usar esta dosis';

  @override
  String get doseLogMedication => 'Medicamento';

  @override
  String get doseLogInjectionSite => 'Lugar';

  @override
  String get doseLogNotes => 'Notas';

  @override
  String get doseLogSaveChanges => 'Guardar cambios';

  @override
  String get doseLogAddDose => '+ Registrar dosis';

  @override
  String get doseLogDeleteTitle => '¿Eliminar este registro de dosis?';

  @override
  String get doseLogDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get doseLogDeleteLog => 'Eliminar registro';

  @override
  String get doseLogSaving => 'Guardando...';

  @override
  String get doseLogCouldNotSave =>
      'Todavía no se pudo guardar este registro de dosis.';

  @override
  String get doseLogCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de dosis.';

  @override
  String get doseLogDeleted => 'Dosis eliminada';

  @override
  String get doseLogAddedToDoseLog => 'Añadido a tu registro de dosis';

  @override
  String get doseLogAnythingWorthRemembering =>
      '¿Algo que valga la pena recordar sobre esta dosis?';

  @override
  String get doseLogDoseLabel => 'Dosis';

  @override
  String get exerciseLogTitle => 'Ejercicio';

  @override
  String get exerciseLogEditTitle => 'Editar ejercicio';

  @override
  String get exerciseLogLogTitle => 'Registrar ejercicio';

  @override
  String get exerciseLogActivityType => 'Tipo de actividad';

  @override
  String get exerciseLogCustomActivity => 'Actividad personalizada';

  @override
  String get exerciseLogTypeActivity => 'Escribe la actividad';

  @override
  String get exerciseLogDuration => 'Duración';

  @override
  String get exerciseLogIntensity => 'Intensidad';

  @override
  String get exerciseLogNotes => 'Notas';

  @override
  String get exerciseLogLight => 'Ligera';

  @override
  String get exerciseLogModerate => 'Moderada';

  @override
  String get exerciseLogIntense => 'Intensa';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min registrados';
  }

  @override
  String get exerciseLogSaveChanges => 'Guardar cambios';

  @override
  String get exerciseLogAddExercise => '+ Registrar ejercicio';

  @override
  String get exerciseLogDeleteTitle => '¿Eliminar este registro de ejercicio?';

  @override
  String get exerciseLogDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get exerciseLogDeleteLog => 'Eliminar registro';

  @override
  String get exerciseLogSaving => 'Guardando...';

  @override
  String get exerciseLogCouldNotSave =>
      'Todavía no se pudo guardar este registro de ejercicio.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de ejercicio.';

  @override
  String get exerciseLogDeleted => 'Ejercicio eliminado';

  @override
  String get exerciseLogAddedToExerciseLog =>
      'Añadido a tu registro de ejercicio';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      '¿Algo que valga la pena recordar sobre esta sesión?';

  @override
  String get exerciseLogWalking => 'Caminar';

  @override
  String get exerciseLogRunning => 'Correr';

  @override
  String get exerciseLogCycling => 'Ciclismo';

  @override
  String get exerciseLogStrength => 'Fuerza';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Natación';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Peso';

  @override
  String get weightLogEditTitle => 'Editar peso';

  @override
  String get weightLogLogTitle => 'Registrar peso';

  @override
  String get weightLogSaveChanges => 'Guardar cambios';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Agregar peso ($label)';
  }

  @override
  String get weightLogDeleteTitle => '¿Eliminar este registro de peso?';

  @override
  String get weightLogDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get weightLogDeleteLog => 'Eliminar registro';

  @override
  String get weightLogSaving => 'Guardando...';

  @override
  String get weightLogCouldNotSave =>
      'Todavía no se pudo guardar este registro de peso.';

  @override
  String get weightLogCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de peso.';

  @override
  String get weightLogDeleted => 'Peso eliminado';

  @override
  String get weightLogAddedToWeightLog => 'Añadido a tu registro de peso';

  @override
  String get weightLogNoWeightForDay =>
      'Todavía no hay peso registrado para este día.';

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
  String get injectionSiteAbdomenUpperRight =>
      'Abdomen, parte superior derecha';

  @override
  String get injectionSiteAbdomenLowerRight =>
      'Abdomen, parte inferior derecha';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Abdomen, lower left';

  @override
  String get injectionSiteThighUpperLeft => 'Thigh, upper left';

  @override
  String get injectionSiteThighUpperRight => 'Muslo, parte superior derecha';

  @override
  String get injectionSiteThighLowerRight => 'Muslo, parte inferior derecha';

  @override
  String get injectionSiteThighLowerLeft => 'Thigh, lower left';

  @override
  String get injectionSiteUpperArmLeft => 'Upper arm, left';

  @override
  String get injectionSiteUpperArmRight => 'Brazo superior derecho';

  @override
  String get injectionSiteButtocksUpperLeft => 'Buttocks, upper left';

  @override
  String get injectionSiteButtocksUpperRight =>
      'Glúteo, parte superior derecha';

  @override
  String get doseReminderFormat => 'Formato';

  @override
  String get doseReminderInjection => 'Inyección';

  @override
  String get doseReminderPill => 'Píldora';

  @override
  String get doseReminderSite => 'Lugar';

  @override
  String get doseReminderDate => 'Fecha';

  @override
  String get supplementReminderTitle => 'Recordatorio de suplemento';

  @override
  String get supplementReminderAddSupplement => 'Agregar suplemento';

  @override
  String get supplementReminderNoSupplementsYet => 'Aún no hay suplementos';

  @override
  String get supplementReminderAddFirstBody =>
      'Agrega tu primer recordatorio de suplemento para registrar tu consumo diario.';

  @override
  String get supplementReminderSupplementFallback => 'Suplemento';

  @override
  String get supplementReminderEveryDay => 'Todos los días';

  @override
  String get supplementReminderEveryXDaysLabel => 'Cada X días';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Cada $interval días';
  }

  @override
  String get supplementReminderNoDaysSet => 'Sin días configurados';

  @override
  String get supplementReminderSupplementName => 'Nombre del suplemento';

  @override
  String get supplementReminderTime => 'Hora';

  @override
  String get supplementReminderStartDate => 'Fecha de inicio';

  @override
  String get supplementReminderRepeat => 'Repetir';

  @override
  String get supplementReminderDaysOfWeek => 'Días de la semana';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Selecciona al menos un día.';

  @override
  String get supplementReminderEvery => 'Cada';

  @override
  String get supplementReminderDay => 'día';

  @override
  String get supplementReminderDays => 'días';

  @override
  String get supplementReminderAdd => 'Agregar';

  @override
  String get symptomsLogTitle => 'Síntomas';

  @override
  String get symptomsLogEditTitle => 'Editar síntomas';

  @override
  String get symptomsLogLogTitle => 'Registrar síntomas';

  @override
  String get symptomsLogSymptomsExperienced => 'Síntomas experimentados';

  @override
  String get symptomsLogNoSymptoms => 'Sin síntomas';

  @override
  String get symptomsLogNoSymptomsToday => 'Sin síntomas hoy';

  @override
  String get symptomsLogOther => 'Otro...';

  @override
  String get symptomsLogSeverityLevel => 'Nivel de severidad';

  @override
  String get symptomsLogNotes => 'Notas';

  @override
  String get symptomsLogAnxiety => 'Ansiedad';

  @override
  String get symptomsLogBelching => 'Eructos';

  @override
  String get symptomsLogBloating => 'Hinchazón';

  @override
  String get symptomsLogConstipation => 'Estreñimiento';

  @override
  String get symptomsLogDiarrhea => 'Diarrea';

  @override
  String get symptomsLogFatigue => 'Fatiga';

  @override
  String get symptomsLogFoodNoise => 'Ruido de comida';

  @override
  String get symptomsLogHairLoss => 'Pérdida de cabello';

  @override
  String get symptomsLogHeartburn => 'Acidez';

  @override
  String get symptomsLogIndigestion => 'Indigestión';

  @override
  String get symptomsLogInjectionSiteReaction =>
      'Reacción en el sitio de inyección';

  @override
  String get symptomsLogMetallicTaste => 'Sabor metálico';

  @override
  String get symptomsLogHeadache => 'Dolor de cabeza';

  @override
  String get symptomsLogMoodSwings => 'Cambios de ánimo';

  @override
  String get symptomsLogNausea => 'Náuseas';

  @override
  String get symptomsLogReflux => 'Reflujo';

  @override
  String get symptomsLogStomachPain => 'Dolor de estómago';

  @override
  String get symptomsLogSuppressedAppetite => 'Apetito suprimido';

  @override
  String get symptomsLogVomiting => 'Vómitos';

  @override
  String get symptomsLogLogged => 'Síntomas registrados';

  @override
  String get symptomsLogMild => 'Leve';

  @override
  String get symptomsLogModerate => 'Moderado';

  @override
  String get symptomsLogSevere => 'Severo';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      '¿Algo que valga la pena recordar sobre cómo te sentiste?';

  @override
  String get symptomsLogSaveChanges => 'Guardar cambios';

  @override
  String get symptomsLogAddSymptoms => '+ Registrar síntomas';

  @override
  String get symptomsLogDeleteTitle => '¿Eliminar este registro de síntomas?';

  @override
  String get symptomsLogDeleteMessage => 'Esta acción no se puede deshacer.';

  @override
  String get symptomsLogDeleteLog => 'Eliminar registro';

  @override
  String get symptomsLogSaving => 'Guardando...';

  @override
  String get symptomsLogCouldNotSave =>
      'Todavía no se pudo guardar este registro de síntomas.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Todavía no se pudo eliminar este registro de síntomas.';

  @override
  String get symptomsLogDeleted => 'Síntomas eliminados';

  @override
  String get symptomsLogAddedToSymptomsLog =>
      'Añadido a tu registro de síntomas';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% del objetivo diario';
  }

  @override
  String get commonDisclaimer =>
      'Glu es una herramienta de seguimiento, no un dispositivo médico. No ofrece consejo médico, diagnóstico ni tratamiento. Consulta siempre a tu profesional de salud sobre tu medicación y decisiones de salud.';
}
