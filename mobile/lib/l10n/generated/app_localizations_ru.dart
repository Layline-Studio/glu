// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Просыпаемся...';

  @override
  String get startupFailed => 'Ошибка запуска';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonSaving => 'Сохранение...';

  @override
  String get commonContinue => 'Продолжить';

  @override
  String get commonSkip => 'Пропустить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonNotNow => 'Не сейчас';

  @override
  String get commonNow => 'Сейчас';

  @override
  String get commonTomorrow => 'Завтра';

  @override
  String get noteTriggerAddNote => 'Добавить заметку';

  @override
  String get noteTriggerCancelNote => 'Отменить заметку';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'Через $count дн.';
  }

  @override
  String get homeDoseReminderInOneWeek => 'Через 1 неделю';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'Через $count недель';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Просрочено на 1 день';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Просрочено на $count дней';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Просрочено на 1 неделю';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Просрочено на $count недель';
  }

  @override
  String get bmiIndicatorYourBmi => 'Ваш ИМТ';

  @override
  String get bmiIndicatorCurrentBmi => 'Ваш текущий ИМТ';

  @override
  String get bmiIndicatorUnderweight => 'Недостаточная масса';

  @override
  String get bmiIndicatorNormal => 'Норма';

  @override
  String get bmiIndicatorOverweight => 'Избыточная масса';

  @override
  String get bmiIndicatorObesity => 'Ожирение';

  @override
  String get heightRulerCmUnit => 'см';

  @override
  String get heightRulerFtUnit => 'фут';

  @override
  String get heightRulerInUnit => 'дюйм';

  @override
  String get heightRulerFtInUnit => 'фут/дюйм';

  @override
  String get weightDialKgUnit => 'кг';

  @override
  String get weightDialLbUnit => 'фунт';

  @override
  String get logNoteIndicatorHasNote => 'Есть заметка';

  @override
  String get paywallTitle => 'Откройте Glu Pro';

  @override
  String get paywallSubtitle =>
      'Защитите свой прогресс и не допускайте возврата веса.';

  @override
  String get paywallMonthlyTitle => 'Ежемесячно';

  @override
  String get paywallMonthlySubtitle => 'Без пробного периода';

  @override
  String get paywallYearlyTitle => 'Ежегодно';

  @override
  String get paywallYearlySubtitle => '7-дневный бесплатный пробный период';

  @override
  String get paywallNoCommitment => 'Без обязательств';

  @override
  String get paywallCancelAnytime => 'Отмена в любое время';

  @override
  String get paywallContinue => 'Продолжить';

  @override
  String get paywallRestore => 'Восстановить';

  @override
  String get paywallTerms => 'Условия';

  @override
  String get paywallPrivacy => 'Конфиденциальность';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Сэкономьте $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Не удалось открыть ссылку.';

  @override
  String get paywallAlreadySubscribed => 'У вас уже есть Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Добро пожаловать в Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'Покупка не завершена. Попробуйте еще раз.';

  @override
  String get paywallPurchaseFailed => 'Покупка не удалась. Попробуйте еще раз.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Покупка не удалась: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Подписка восстановлена!';

  @override
  String get paywallRestoreNoSubscription => 'Активная подписка не найдена.';

  @override
  String get paywallRestoreFailed =>
      'Восстановление не удалось. Попробуйте еще раз.';

  @override
  String get paywallBenefitReminders => 'Напоминания о дозе и добавках';

  @override
  String get paywallBenefitShareProgress => 'Удобно делиться прогрессом';

  @override
  String get paywallBenefitSpotRegain => 'Раньше замечать возврат веса';

  @override
  String get paywallBenefitInsights => 'Ежедневные инсайты и паттерны';

  @override
  String get paywallBenefitWeeklyGoals => 'Простые еженедельные цели';

  @override
  String get paywallBenefitHealthyHabits =>
      'Проще удерживать здоровые привычки';

  @override
  String get onboardingWelcomeTitle => 'Сохраняйте вес';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu помогает защищать ваш прогресс во время лечения, целей и еженедельных привычек.';

  @override
  String get onboardingWelcomeBullet1 => 'Подходит под ваше лечение и цели';

  @override
  String get onboardingWelcomeBullet2 => 'Простая и реалистичная поддержка';

  @override
  String get onboardingWelcomeBullet3 =>
      'Легко замечать ранние признаки возврата веса';

  @override
  String get onboardingWelcomeBullet4 => 'Продолжайте без начала с нуля';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Вы сейчас принимаете препарат для снижения веса в форме шприц-ручки или таблеток?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Мы используем это, чтобы показывать подсказки, которые соответствуют вашему текущему этапу.';

  @override
  String get onboardingMedicationStatusUsing => 'Да, я принимаю его сейчас';

  @override
  String get onboardingMedicationStatusWeaningOff =>
      'Да, я постепенно отменяю его';

  @override
  String get onboardingMedicationStatusNotTaking => 'Нет, я не принимаю его';

  @override
  String get onboardingMedicationStatusStartingSoon => 'Нет, я скоро начну';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Нет, я недавно прекратил(а)';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Как вы принимаете препарат?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Мы используем это, чтобы подстраивать инструкции и напоминания под форму препарата.';

  @override
  String get onboardingMedicationMethodInjection => 'Инъекция';

  @override
  String get onboardingMedicationMethodPill => 'Таблетка';

  @override
  String get onboardingMedicationMethodUnknown => 'Пока не знаю';

  @override
  String get onboardingMedicationNameQuestion =>
      'Какой препарат вы принимаете?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Мы используем это, чтобы персонализировать отслеживание дозы и подсказки для препарата.';

  @override
  String get onboardingCurrentDoseQuestion => 'Какая у вас текущая доза?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Мы используем это, чтобы подстроить отслеживание дозы и будущие проверки прогресса.';

  @override
  String get onboardingMedicationCustomDose => 'Своя';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Какое устройство вы используете для приема препарата?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Мы используем это, чтобы напоминания и советы соответствовали вашему способу приема.';

  @override
  String get onboardingDeviceSinglePen => 'Одноразовая ручка';

  @override
  String get onboardingDeviceAutoInjector => 'Автоинжектор';

  @override
  String get onboardingDeviceSyringeAndVial => 'Шприц и флакон';

  @override
  String get onboardingOther => 'Другое';

  @override
  String get onboardingTypeYourDevice => 'Введите ваше устройство';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Как часто вы принимаете препарат?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Мы используем это, чтобы подстраивать напоминания и поддержку режима под ваше расписание.';

  @override
  String get onboardingEveryDay => 'Каждый день';

  @override
  String get onboardingEvery7Days => 'Каждые 7 дней';

  @override
  String get onboardingEvery14Days => 'Каждые 14 дней';

  @override
  String get onboardingCustom => 'Пользовательский';

  @override
  String get onboardingDaysBetweenDoses => 'Дней между дозами';

  @override
  String get onboardingPrimaryGoalQuestion => 'Какая ваша главная цель сейчас?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Мы используем это, чтобы сосредоточить ваш план, напоминания и прогресс на самом важном для вас.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Мы используем это, чтобы с самого начала выстроить ваш план.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Мы используем это, чтобы поддержать ваш следующий этап и помочь вам не сбиться с курса.';

  @override
  String get onboardingGoalLoseWeight => 'Похудеть';

  @override
  String get onboardingGoalMaintainWeight => 'Сохранять вес';

  @override
  String get onboardingGoalManageDiabetes => 'Контролировать диабет';

  @override
  String get onboardingGoalManagePcos => 'Контролировать СПКЯ';

  @override
  String get onboardingGoalImproveHeartHealth => 'Улучшить здоровье сердца';

  @override
  String get onboardingAgeQuestion => 'Сколько вам лет?';

  @override
  String get onboardingAgeExplainer =>
      'Мы используем это, чтобы точнее подстроить рекомендации и расчеты здоровья.';

  @override
  String get onboardingHeightQuestion => 'Какой у вас рост?';

  @override
  String get onboardingHeightExplainer =>
      'Мы используем это вместе с весом, чтобы рассчитывать ИМТ и здоровые диапазоны.';

  @override
  String get onboardingWeightQuestion => 'Какой у вас текущий вес?';

  @override
  String get onboardingWeightExplainer =>
      'Мы используем это как отправную точку для прогресса, целей и оценок здоровья.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Когда вы прекратили прием препарата?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Когда вы начали постепенно отменять препарат?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Когда вы начали принимать препарат?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Мы используем это, чтобы понять вашу недавнюю историю лечения и следующий этап.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Мы используем это, чтобы понять переходный этап и поддержать привычки, которые сейчас важнее всего.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Мы используем это, чтобы понять, как долго вы на терапии, и отслеживать изменения со временем.';

  @override
  String get onboardingGoalWeightQuestion => 'Какой у вас целевой вес?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Мы используем это, чтобы показать прогресс и целевой диапазон ИМТ для вас.';

  @override
  String get onboardingBenefitsQuestion => 'Что Glu поможет вам делать дальше';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu превращает то, что вы сообщили, в напоминания, поддержку и структуру, подходящие под ваш режим.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Вот как Glu может помочь вам сохранить прогресс';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Вот как Glu может помочь вам с режимом при диабете';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Вот как Glu может помочь вам с режимом при СПКЯ';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Вот как Glu может помочь вам с режимом для сердца';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Вот как Glu может помочь вам похудеть';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Посмотрите, как Glu помогает защищать текущий вес и раньше замечать возврат.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Посмотрите, как Glu помогает удерживать питание, вес и режим более ровно из недели в неделю.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Посмотрите, как Glu помогает вам быть более стабильными с симптомами, весом и режимом.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Посмотрите, как Glu помогает вам последовательно поддерживать привычки для здоровья сердца.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Посмотрите, как Glu помогает замечать паттерны, которые держат вес в движении вниз.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Без структуры возврат веса может подкрасться незаметно. Glu помогает заметить это раньше и держать курс.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Без структуры питание и вес становятся менее понятными. Glu делает сигналы яснее.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Без структуры симптомы и режим могут сильнее колебаться. Glu помогает держать стабильность.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Без структуры полезные привычки постепенно сходят на нет. Glu помогает держать активность и вес под контролем.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Без структуры вес может застревать или снова расти. Glu помогает держать прогресс в правильном направлении.';

  @override
  String get onboardingBenefitsAxisWeight => 'Вес';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Питание и вес';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Симптомы и вес';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Активность и вес';

  @override
  String get onboardingNotificationsQuestion =>
      'Включить напоминания, которые поддержат вашу цель';

  @override
  String get onboardingNotificationsExplainer =>
      'Мы будем использовать уведомления, чтобы помочь вам сохранять стабильность, быть готовыми и не сбиваться с курса.';

  @override
  String get onboardingNotificationsHeadline =>
      'Настройте Glu, чтобы он помогал в нужный момент.';

  @override
  String get onboardingNotificationsBody =>
      'Включите уведомления, чтобы Glu мог поддерживать привычки, которые помогают вашей цели.';

  @override
  String get onboardingNotificationsDaily =>
      'Напоминания по времени, которые совпадают с вашим ежедневным ритмом приема препарата';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Долгосрочные напоминания, чтобы дни дозы не подкрались незаметно';

  @override
  String get onboardingNotificationsCustom =>
      'Напоминания, настроенные под ваш собственный график';

  @override
  String get onboardingNotificationsWeekly =>
      'Напоминания о дозе, которые совпадают с вашим еженедельным ритмом';

  @override
  String get onboardingNotificationsSupportive =>
      'Поддерживающие напоминания, которые делают режим видимым, когда мотивация падает';

  @override
  String get onboardingNotificationsProgress =>
      'Своевременные подсказки о прогрессе, привычках и целях, которые вы отметили как важные';

  @override
  String get onboardingNotificationsHelpful =>
      'Полезные подсказки, которые делают Glu полезнее в нужный момент';

  @override
  String get onboardingDailyRoutineQuestion =>
      'Какой у вас повседневный режим?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Мы используем это, чтобы ваш план был реалистичным для повседневной жизни.';

  @override
  String get onboardingRoutineSedentary => 'Малоподвижный';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'В основном сидячая работа, офис и очень мало целенаправленных тренировок.';

  @override
  String get onboardingRoutineLightlyActive => 'Слегка активный';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Регулярная ходьба, дела по дому или легкие тренировки несколько раз в неделю.';

  @override
  String get onboardingRoutineActive => 'Активный';

  @override
  String get onboardingRoutineActiveDescription =>
      'Частое движение или тренировки, например ежедневные прогулки, зал или активная работа.';

  @override
  String get onboardingRoutineVeryActive => 'Очень активный';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Интенсивные тренировки, физически тяжелая работа или высокая активность почти каждый день.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Какие симптомы вас больше всего беспокоят, если такие есть?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Мы используем это, чтобы уделять приоритет советам и подсказкам по тем симптомам, которые для вас важнее всего.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Мы используем это, чтобы сосредоточиться на симптомах, которые вы хотите держать под контролем.';

  @override
  String get onboardingGenderQuestion => 'Как вы описываете свой пол?';

  @override
  String get onboardingGenderExplainer =>
      'Мы используем это для более подходящих рекомендаций и будущей персонализации.';

  @override
  String get onboardingGenderFemale => 'Женский';

  @override
  String get onboardingGenderMale => 'Мужской';

  @override
  String get onboardingGenderPreferNotToSay => 'Предпочитаю не указывать';

  @override
  String get onboardingTypeYourGender => 'Введите ваш пол';

  @override
  String get onboardingPreferredNameQuestion => 'Как нам вас называть?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Мы используем это, чтобы Glu звучал более лично, когда общается с вами.';

  @override
  String get onboardingPreferredNameHint => 'Алекс';

  @override
  String get onboardingSetupSummaryQuestion => 'Настраиваем ваш план';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Мы превращаем то, что вы сообщили, в план, который Glu сможет поддерживать сразу.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Фиксируем цели по поддержанию веса...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Настраиваем контроль возврата веса...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Подстраиваем напоминания под ваш режим...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Готовим более стабильный недельный план...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Определяем паттерны питания и веса...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Настраиваем поддержку гидратации...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Готовим напоминания о стабильности...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Строим более понятную ежедневную структуру...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Организуем поддержку симптомов...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Определяем еженедельные цели по движению...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Настраиваем гидратацию и опоры режима...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Готовим более стабильный план...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'Настраиваем цели по активности...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Определяем поддержку гидратации...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Готовим еженедельные напоминания о привычках...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Строим режим для здоровья сердца...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Определяем границы по калориям...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Настраиваем количество воды...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Строим цели по тренировкам...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Готовим ваш недельный план...';

  @override
  String get onboardingSetupSummaryHeadline => 'Ваш Glu настроен и готов.';

  @override
  String get onboardingSetupLoadingTitle => 'Строим вашу настройку';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu готов помочь вам защищать прогресс с более ясной структурой и более ранними сигналами о возврате веса.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu готов поддерживать более стабильное питание, контроль веса и привычки, важные каждый день.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu готов поддерживать более стабильный режим вокруг симптомов, лечения и прогресса.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu готов укреплять привычки, которые поддерживают здоровье сердца в долгую.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu готов поддерживать привычки, которые помогают держать вес под контролем.';

  @override
  String get onboardingSetupSummaryLabel => 'Сводка';

  @override
  String get onboardingSetupAdjustLater =>
      'Вы сможете изменить это позже в настройках.';

  @override
  String get onboardingSummaryGoal => 'Цель';

  @override
  String get onboardingSummaryCurrentWeight => 'Текущий вес';

  @override
  String get onboardingSummaryMedication => 'Препарат';

  @override
  String get onboardingSummaryCurrentDose => 'Текущая доза';

  @override
  String get onboardingSummaryCadence => 'Частота';

  @override
  String get onboardingSummaryStarted => 'Начало';

  @override
  String get onboardingSummaryTargetWeight => 'Целевой вес';

  @override
  String get onboardingSummaryRoutine => 'Режим';

  @override
  String get onboardingSummaryFocus => 'Фокус';

  @override
  String get onboardingFrequencyEveryDay => 'Каждый день';

  @override
  String get onboardingFrequencyEveryWeek => 'Каждую неделю';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Каждые 2 недели';

  @override
  String get onboardingFrequencyCustomSchedule => 'Свой график';

  @override
  String get onboardingTapOptionContinue =>
      'Коснитесь варианта, чтобы продолжить.';

  @override
  String get onboardingTypeGenderContinue =>
      'Введите ваш пол, чтобы продолжить.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Введите ваше устройство, чтобы продолжить.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Введите ваш препарат, чтобы продолжить.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Введите количество дней между дозами, чтобы продолжить.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Выберите график, чтобы продолжить.';

  @override
  String get onboardingScrollChooseAge => 'Прокрутите, чтобы выбрать возраст.';

  @override
  String get onboardingDragOrTapHeight =>
      'Перетащите или коснитесь линейки, чтобы выбрать рост.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Перетащите, коснитесь или используйте кнопки шага, чтобы выбрать вес.';

  @override
  String get onboardingPickDateAndWeight =>
      'Выберите дату и вес, чтобы продолжить.';

  @override
  String get onboardingSelectSymptoms =>
      'Выберите симптомы, на которых Glu должен сосредоточиться.';

  @override
  String get onboardingTypeName =>
      'Введите имя, которое Glu должен использовать.';

  @override
  String get onboardingSaving => 'Сохраняем...';

  @override
  String get onboardingLetsBegin => 'Начнем';

  @override
  String get onboardingContinueWithGlu => 'Продолжить с Glu';

  @override
  String get onboardingKeepGoing => 'Продолжайте';

  @override
  String get onboardingTurnOnNotifications => 'Включить уведомления';

  @override
  String get onboardingFinish => 'Готово';

  @override
  String get onboardingTargetBmiTitle => 'Ваш целевой ИМТ';

  @override
  String get onboardingChartToday => 'Сегодня';

  @override
  String get onboardingChartOverTime => 'Со временем';

  @override
  String get onboardingChartWithoutGlu => 'Без Glu';

  @override
  String get onboardingChartWithGlu => 'С Glu';

  @override
  String get onboardingReviewQuestion =>
      'Люди используют Glu, чтобы сохранять стабильность и чувствовать поддержку';

  @override
  String get onboardingReviewExplainer =>
      'Быстрая оценка поможет большему числу людей найти поддержку, которая кажется такой же простой.';

  @override
  String get onboardingReviewBody =>
      'Люди используют Glu, чтобы чувствовать больше поддержки, стабильности и меньше одиночества в процессе.';

  @override
  String get onboardingTypeYourMedication => 'Введите ваш препарат';

  @override
  String get onboardingSelectStartDate => 'Выберите дату начала';

  @override
  String get goalsSaveDialogTitle => 'Сохранить цели?';

  @override
  String get goalsSaveDialogMessage =>
      'У вас есть несохраненные изменения целей. Сохранить их перед выходом из этой вкладки?';

  @override
  String get commonLater => 'Позже';

  @override
  String get homeGreetingAnonymous => 'Привет';

  @override
  String homeGreetingWithName(Object name) {
    return 'Привет, $name';
  }

  @override
  String get homeInsightEmptyTitle =>
      'Загружайте данные сегодня, чтобы увидеть инсайт';

  @override
  String get homeInsightEmptyBody =>
      'Запишите что-нибудь сегодня, и вечером увидите свой инсайт.';

  @override
  String get homeInsightLogTodayTitle => 'Превратите записи в инсайт';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Больше записей, лучше понимание';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Ваши записи уже начинают показывать закономерность.';

  @override
  String get homeInsightMoreLogsVariant2Title =>
      'Ваше понимание обретает форму';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Ещё несколько записей могут сделать картину гораздо яснее.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'На что намекают сегодняшние записи';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'В вашем дне уже может скрываться закономерность.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Запишите хотя бы что-нибудь сегодня, чтобы увидеть более ясную картину своего прогресса.';

  @override
  String get homeInsightExpandedTitle => 'Это было полезно?';

  @override
  String get homeInsightExpandedBody =>
      'Быстрая оценка помогает Glu понять, что для вас важнее всего.';

  @override
  String get homeInsightReasonHint => 'Что можно улучшить? (необязательно)';

  @override
  String get homeInsightReasonSubmit => 'Отправить';

  @override
  String get homeInsightLearningMessage => 'Я учту это.';

  @override
  String get homeInsightChecking => 'Проверяем инсайт за сегодня...';

  @override
  String get homeInsightGenerating => 'Загружаем инсайт за сегодня...';

  @override
  String get homeInsightTryAgain => 'Попробовать снова';

  @override
  String get homeSeeAllInsights => 'Все инсайты';

  @override
  String get insightsProgressTitle => 'Все инсайты';

  @override
  String get insightsProgressEmptyState =>
      'Ваши инсайты появятся здесь, когда будут готовы.';

  @override
  String get homeDoseReminderTitle => 'Напоминание о дозе';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Логика записи взаимодействия $label здесь.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Требуется цель по калориям';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check нужна цель питания, установленная как Calories, чтобы оценить вашу порцию. Установите её в целях, чтобы начать.';

  @override
  String get homeSetGoal => 'Установить цель';

  @override
  String get homeYourProgress => 'Ваш прогресс';

  @override
  String get homeRemindersShowcaseTitle => 'Держите курс';

  @override
  String get homeRemindersShowcaseDescription =>
      'Настройте напоминания, чтобы не пропускать дозы и добавки.';

  @override
  String get homePickNextDoseDate => 'Выберите дату следующей дозы';

  @override
  String get homeSetReminder => 'Установить напоминание';

  @override
  String get homeSupplementReminders => 'Напоминания о добавках';

  @override
  String get homeNoUpcomingSupplements => 'Нет ближайших добавок';

  @override
  String get homeNoMoreUpcomingSupplements => 'Больше нет ближайших добавок';

  @override
  String get homeSetUpYourSupplements => 'Настройте свои добавки';

  @override
  String get homeSetUp => 'Настроить';

  @override
  String get homeSupplementFallback => 'Добавка';

  @override
  String get doseReminderNotificationTitle => 'Пора принимать дозу?';

  @override
  String get doseReminderFallbackBody =>
      'Откройте Glu, чтобы проверить следующую дозу.';

  @override
  String get supplementReminderNotificationTitle => 'Пора принимать добавку';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Сегодня утром';

  @override
  String get supplementReminderThisAfternoon => 'Сегодня днем';

  @override
  String get supplementReminderTonight => 'Сегодня вечером';

  @override
  String get dailyReminderMorningTitle => 'Утренний чек-ин';

  @override
  String get dailyReminderMorningBodies =>
      'Утренняя миссия: дайте Glu немного данных для работы.\nНачните день с быстрой записи и хорошего импульса.\nСделайте запись с утра. Будущее вы скажет спасибо.\nНачните день с маленького обновления и большого старта.\nДайте Glu утреннюю подсказку и двигайтесь дальше.\nБыстрая запись сейчас сделает день интереснее.\nДавайте сделаем утро полезным с быстрым чек-ином.';

  @override
  String get dailyReminderMiddayTitle => 'Дневной чек-ин';

  @override
  String get dailyReminderMiddayBodies =>
      'Полуденная остановка: сделайте быструю запись и продолжайте движение.\nПерерыв на обед? Самое время дать Glu обновление.\nПоловина пути пройдена. Подкиньте Glu быструю подсказку.\nНебольшая дневная запись поможет сохранить историю.\nПроверьтесь сейчас и продолжайте день.\nДайте дню небольшой толчок быстрым обновлением.\nПоддержите темп быстрым дневным касанием.';

  @override
  String get dailyReminderAfternoonTitle => 'Вечерний чек-ин';

  @override
  String get dailyReminderAfternoonBodies =>
      'Почти готово. Дайте Glu ещё одну крупицу информации.\nБыстрая вечерняя запись может сделать вечерний инсайт ярче.\nЗавершите день маленьким обновлением и большим результатом.\nЕще одна запись перед завершением дня?\nПомогите Glu связать точки быстрой вечерней проверкой.\nЗамкните цикл маленькой записью и продолжайте магию.\nПоследнее касание сейчас может сделать вечерний инсайт намного лучше.';

  @override
  String get homePortionCheckTitle => 'Портион Чек';

  @override
  String get homePortionCheckBody =>
      'Понимайте, сколько есть на каждом приёме пищи';

  @override
  String get homeGlowUpTitle => 'Ваш\nGlow up';

  @override
  String get homeGlowUpBody => 'Создайте свою историю до и после';

  @override
  String get homeGoalsStatusTitle => 'Цели на сегодня';

  @override
  String get homeGoalsStatusViewAll => 'Все';

  @override
  String get homeWaterTitle => 'Вода';

  @override
  String get homeWeightTitle => 'Вес';

  @override
  String get homeExerciseTitle => 'Тренировки';

  @override
  String get homeMealsTitle => 'Приёмы пищи';

  @override
  String get homeCaloriesTitle => 'Калории';

  @override
  String get homeProteinsTitle => 'Белки';

  @override
  String get homeFibersTitle => 'Клетчатка';

  @override
  String get homeSymptomsTitle => 'Симптомы';

  @override
  String get homeMoodTitle => 'Настроение';

  @override
  String get homeDoseTitle => 'Доза';

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
  String get homeStartHydration => 'Начните пить воду';

  @override
  String get homeLogFirstSession => 'Запишите первую тренировку';

  @override
  String get homeLogTodayWeight => 'Запишите сегодняшний вес';

  @override
  String get homeAtYourTarget => 'Вы достигли своей цели';

  @override
  String get homeLogMealsToTrackCalories =>
      'Записывайте приёмы пищи, чтобы следить за калориями';

  @override
  String get homeLogFirstMeal => 'Запишите свой первый приём пищи';

  @override
  String get homeTrackProteinFromMeals => 'Отслеживайте белок из еды';

  @override
  String get homeTrackFiberFromMeals => 'Отслеживайте клетчатку из еды';

  @override
  String get homeAllClear => 'Всё в порядке';

  @override
  String get homeTrackSymptoms => 'Отслеживайте симптомы';

  @override
  String get homeGreat => 'Отлично';

  @override
  String get homeGood => 'Хорошо';

  @override
  String get homeBad => 'Плохо';

  @override
  String get homeOkay => 'Нормально';

  @override
  String get homeLogHowYouFeel => 'Запишите, как вы себя чувствуете';

  @override
  String get homeLogTodaysDose => 'Запишите сегодняшнюю дозу';

  @override
  String get homeTaken => 'Принято';

  @override
  String get homeStartHereTitle => 'Начните здесь';

  @override
  String get homeStartHereBody =>
      'Начните с этой карточки, а затем переходите к другим. По мере того как Glu узнаёт больше о вашем пути, он может показывать более полезные паттерны и инсайты со временем.';

  @override
  String get waterLogTitle => 'Вода';

  @override
  String get waterLogEditTitle => 'Изменить запись воды';

  @override
  String get waterLogLogTitle => 'Записать воду';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Добавить напиток ($amount)';
  }

  @override
  String get waterLogSaving => 'Сохраняем...';

  @override
  String get waterLogCustomDrinkTitle => 'Своя порция';

  @override
  String get waterLogCustomDrinkBody =>
      'Выберите количество, которое хотите добавить сейчас.';

  @override
  String get waterLogUseThisAmount => 'Использовать это количество';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount добавлено в журнал воды';
  }

  @override
  String get waterLogCouldNotSave =>
      'Пока не удалось сохранить эту запись воды.';

  @override
  String get waterLogDeleteTitle => 'Удалить эту запись воды?';

  @override
  String get waterLogDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get waterLogCouldNotDelete =>
      'Пока не удалось удалить эту запись воды.';

  @override
  String get waterLogDeleteLog => 'Удалить запись';

  @override
  String get waterLogDeleted => 'Вода удалена';

  @override
  String get moodLogTitle => 'Настроение';

  @override
  String get moodEditTitle => 'Изменить настроение';

  @override
  String get moodHowYouFeel => 'Как вы себя чувствуете';

  @override
  String get moodBad => 'Плохо';

  @override
  String get moodOkay => 'Нормально';

  @override
  String get moodGood => 'Хорошо';

  @override
  String get moodGreat => 'Отлично';

  @override
  String get moodNotes => 'Заметки';

  @override
  String get moodAnythingWorthRemembering =>
      'Есть ли что-то, что стоит запомнить о вашем настроении?';

  @override
  String get moodCouldNotSave =>
      'Пока не удалось сохранить эту запись настроения.';

  @override
  String get moodDeleteTitle => 'Удалить эту запись настроения?';

  @override
  String get moodDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get moodDeleteLog => 'Удалить запись';

  @override
  String get moodSaving => 'Сохраняем...';

  @override
  String get moodAddMoodLog => '+ Добавить запись настроения';

  @override
  String get moodLogged => 'Настроение записано';

  @override
  String get moodDeleted => 'Настроение удалено';

  @override
  String get moodCouldNotDelete =>
      'Пока не удалось удалить эту запись настроения.';

  @override
  String get moodAddedToMoodLog => 'Добавлено в журнал настроения';

  @override
  String get portionCheckTitle => 'Портион Чек';

  @override
  String get portionCheckAnalyzingMeal => 'Анализируем ваше блюдо…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Не удалось проанализировать это фото';

  @override
  String get portionCheckTakeNewPhoto => 'Сделать новое фото';

  @override
  String get portionCheckSomethingWentWrong => 'Что-то пошло не так.';

  @override
  String get portionCheckYouHitDailyLimit => 'Вы достигли дневного лимита';

  @override
  String get portionCheckYouCanEat => 'Вы можете съесть';

  @override
  String get portionCheckYouCanEatUpTo => 'Вы можете съесть до';

  @override
  String get portionCheckTryLighterOption =>
      'Попробуйте вариант полегче или пропустите этот';

  @override
  String get portionCheckThisEntireMeal => 'весь этот приём пищи';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% этого приёма пищи';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'чтобы оставаться в пределах ваших дневных целей.';

  @override
  String get portionCheckNutritionBreakdown => 'Состав питания';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Советы, как сбалансировать блюдо';

  @override
  String get portionCheckTipsPool =>
      'Ешьте медленно — сигналам сытости нужно около 20 минут, чтобы догнать вас.\nЗаполняйте половину тарелки овощами.\nДобавляйте белок в каждый приём пищи.\nПейте воду перед едой.\nЗаранее распределяйте перекусы по маленьким контейнерам.\nСочетайте углеводы с белком или жиром, чтобы дольше оставаться сытым.\nПо возможности выбирайте цельные продукты.\nНе ешьте, отвлекаясь на экран.\nНе пропускайте приёмы пищи, если потом из-за этого переедаете.\nПланируйте перекусы до того, как проголодаетесь.';

  @override
  String get portionCheckRetake => 'Переснять';

  @override
  String get portionCheckLogThisPortion => 'Записать эту порцию';

  @override
  String get portionCheckCarbs => 'Углеводы';

  @override
  String get portionCheckProteins => 'Белки';

  @override
  String get portionCheckFats => 'Жиры';

  @override
  String get portionCheckFiber => 'Клетчатка';

  @override
  String get mealLogScreenTitle => 'Приёмы пищи';

  @override
  String get mealLogEditTitle => 'Изменить приём пищи';

  @override
  String get mealLogLogTitle => 'Записать приём пищи';

  @override
  String get mealLogSaving => 'Сохраняем...';

  @override
  String get mealLogAddMealLog => '+ Добавить запись приёма пищи';

  @override
  String get mealLogCouldNotStartRecording => 'Не удалось начать запись.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'Запись остановлена через 60 секунд.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Не удалось проанализировать эту запись.';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'Не удалось проанализировать этот текст.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Не удалось проанализировать это фото.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Пока не удалось обработать фото блюда.';

  @override
  String get mealLogDiscardTitle => 'Отменить этот приём пищи?';

  @override
  String get mealLogDiscardMessage =>
      'Вы просмотрели фото, но не сохранили запись. Она не будет добавлена в журнал.';

  @override
  String get mealLogDiscard => 'Отменить';

  @override
  String get mealLogDeleteTitle => 'Удалить эту запись приёма пищи?';

  @override
  String get mealLogDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get mealLogDelete => 'Удалить';

  @override
  String get mealLogDeleteLog => 'Удалить запись';

  @override
  String get mealLogCouldNotSave =>
      'Пока не удалось сохранить эту запись питания.';

  @override
  String get mealLogCouldNotDelete =>
      'Пока не удалось удалить эту запись питания.';

  @override
  String get mealLogAnalyzing => 'Анализируем...';

  @override
  String get mealLogAnalyzeText => 'Анализировать текст';

  @override
  String get mealLogSendRecording => 'Отправить запись';

  @override
  String get mealLogMealDefaultName => 'Приём пищи';

  @override
  String get mealLogMealNameHint => 'Название приёма пищи';

  @override
  String get mealLogCouldNotPrefillTitle =>
      'Не удалось заполнить этот приём пищи заранее';

  @override
  String get mealLogHowMuchDidYouEat => 'Сколько вы съели?';

  @override
  String get mealLogNotes => 'Заметки';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Есть ли что-то, что стоит запомнить об этом приёме пищи?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Анализируем ваш приём пищи';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Преобразуем ваш ввод в поля питания. Вы сможете всё проверить перед сохранением.';

  @override
  String get mealLogDescribeYourMealTitle => 'Опишите ваш приём пищи';

  @override
  String get mealLogDescribeYourMealBody =>
      'Напишите, что вы съели и какие количества знаете. Мы преобразуем это в поля питания.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Например: салат с курицей-гриль, заправка с оливковым маслом, 1 яблоко, газированная вода';

  @override
  String get mealLogCaptureYourMealTitle => 'Сфотографируйте ваш приём пищи';

  @override
  String get mealLogCaptureYourMealBody =>
      'Сделайте фото, и мы оценим поля питания за вас.';

  @override
  String get mealLogTakePhoto => 'Сделать фото';

  @override
  String get mealLogRecordingYourMealTitle => 'Запись вашего приёма пищи';

  @override
  String get mealLogRecordingReadyTitle => 'Запись готова';

  @override
  String get mealLogRecordMealDescriptionTitle => 'Запись описания приёма пищи';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Нажмите стоп, когда закончите. Осталось $remaining с';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Отправьте ниже для анализа или запишите ещё раз.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Говорите естественно о том, что вы съели, и мы разберём это на макросы.';

  @override
  String get mealLogStopRecording => 'Остановить запись';

  @override
  String get mealLogRecordAgain => 'Записать ещё раз';

  @override
  String get mealLogStartRecording => 'Начать запись';

  @override
  String get mealLogBreakfast => 'Завтрак';

  @override
  String get mealLogLunch => 'Обед';

  @override
  String get mealLogSnack => 'Перекус';

  @override
  String get mealLogDinner => 'Ужин';

  @override
  String get mealLogKcalUnit => 'ккал';

  @override
  String get mealLogToday => 'Сегодня';

  @override
  String get mealLogYesterday => 'Вчера';

  @override
  String mealLogKcal(Object count) {
    return '$count ккал';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count ккал записано';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount г $macro записано';
  }

  @override
  String get mealLogDeleted => 'Приём пищи удалён';

  @override
  String get mealLogAddedToMealLog => 'Добавлено в журнал питания';

  @override
  String get mealLogCarbs => 'Углеводы';

  @override
  String get mealLogProteins => 'Белки';

  @override
  String get mealLogFats => 'Жиры';

  @override
  String get mealLogFiber => 'Клетчатка';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageDialogTitle => 'Выберите язык';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsPreferences => 'Параметры';

  @override
  String get settingsHealthGoal => 'Цель здоровья';

  @override
  String get settingsHealthGoalDialogTitle => 'Выберите цель здоровья';

  @override
  String get settingsHabitGoals => 'Цели привычек';

  @override
  String get settingsDisabled => 'Отключено';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count активных';
  }

  @override
  String get settingsHeight => 'Рост';

  @override
  String get settingsAge => 'Возраст';

  @override
  String get settingsGender => 'Пол';

  @override
  String get settingsMeasurementUnit => 'Единицы измерения';

  @override
  String get settingsReminders => 'Напоминания';

  @override
  String get settingsDoseReminder => 'Напоминание о дозе';

  @override
  String get settingsSupplementReminder => 'Напоминание о добавке';

  @override
  String get settingsDailyReminders => 'Ежедневные напоминания';

  @override
  String get settingsSubscription => 'Подписка';

  @override
  String get settingsSupport => 'Поддержка';

  @override
  String get settingsSendFeedback => 'Отправить отзыв';

  @override
  String get feedbackSheetTitle => 'Отправить отзыв';

  @override
  String get feedbackSheetHint => 'Расскажите, что вы думаете…';

  @override
  String get feedbackSheetSend => 'Отправить';

  @override
  String get feedbackSheetSuccess => 'Спасибо за ваш отзыв!';

  @override
  String get feedbackSheetError => 'Не удалось отправить. Попробуйте еще раз.';

  @override
  String get settingsTermsOfService => 'Условия использования';

  @override
  String get settingsPrivacyPolicy => 'Политика конфиденциальности';

  @override
  String get settingsInternal => 'Внутренние настройки';

  @override
  String get settingsSubscriptionOverride => 'Переопределение подписки';

  @override
  String get settingsTodayInsightCard => 'Карточка инсайта на сегодня';

  @override
  String get settingsResetOnboarding => 'Сбросить onboarding';

  @override
  String get settingsResetShowcases => 'Сбросить подсказки';

  @override
  String get settingsResetUserData => 'Сбросить данные пользователя';

  @override
  String get settingsDeletingAccount => 'Удаляем аккаунт...';

  @override
  String get settingsDisconnect => 'Отключить';

  @override
  String get settingsDeleteAccount => 'Удалить аккаунт';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Отключить $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Отключить $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Вы больше не сможете входить через $provider на этом устройстве, пока не подключите его снова.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Удалить аккаунт?';

  @override
  String get settingsDeleteAccountBody =>
      'Это навсегда удалит ваш аккаунт и все данные. Это действие нельзя отменить.';

  @override
  String get settingsDeleteAccountConfirmHint =>
      'Введите DELETE для подтверждения';

  @override
  String get settingsDeleteAccountError =>
      'Что-то пошло не так при удалении аккаунта. Свяжитесь с support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Перезапустите приложение, чтобы увидеть onboarding';

  @override
  String get settingsShowcasesReset => 'Подсказки сброшены';

  @override
  String get settingsResetUserDataTitle => 'Сбросить данные пользователя?';

  @override
  String get settingsResetUserDataBody =>
      'Это очистит все записи по питанию, воде, тренировкам, весу, настроению, симптомам, добавкам и дозам.';

  @override
  String get settingsUserDataReset => 'Данные пользователя сброшены';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Сохранено, но ежедневные напоминания сейчас не удалось запланировать.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Переопределение подписки';

  @override
  String get settingsSubscriptionOverrideAuto => 'Авто';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Принудительно Free';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Принудительно Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Карточка инсайта на сегодня';

  @override
  String get settingsTodayInsightCardAuto => 'Авто';

  @override
  String get settingsTodayInsightCardOn => 'Вкл';

  @override
  String get settingsTodayInsightCardOff => 'Выкл';

  @override
  String get settingsYourName => 'Ваше имя';

  @override
  String get settingsSignOut => 'Выйти';

  @override
  String get settingsHeightCm => 'см';

  @override
  String get settingsHeightFtIn => 'фут/дюйм';

  @override
  String get settingsHeightFt => 'фут';

  @override
  String get settingsHeightIn => 'дюйм';

  @override
  String get settingsGenderMale => 'Мужской';

  @override
  String get settingsGenderFemale => 'Женский';

  @override
  String get settingsGenderPreferNotToSay => 'Предпочитаю не указывать';

  @override
  String get settingsGenderOther => 'Другое';

  @override
  String get settingsYourProfile => 'Ваш профиль';

  @override
  String get settingsNotSet => 'Не задано';

  @override
  String settingsYears(Object value) {
    return '$value лет';
  }

  @override
  String get settingsOff => 'Выкл';

  @override
  String get settingsOn => 'Вкл';

  @override
  String get settingsNoneSet => 'Не задано';

  @override
  String settingsSupplementCount(Object count) {
    return '$count добавок';
  }

  @override
  String get commonToday => 'Сегодня';

  @override
  String get mainShellHome => 'Главная';

  @override
  String get mainShellLog => 'Журнал';

  @override
  String get mainShellProgress => 'Прогресс';

  @override
  String get mainShellSettings => 'Настройки';

  @override
  String get mainShellLogShowcaseTitle => 'Отмечайте важное каждый день';

  @override
  String get mainShellLogShowcaseDescription =>
      'Записывайте действия, которые для вас важны, каждый день.';

  @override
  String get logWaterShowcaseTitle => 'Начните с воды';

  @override
  String get logWaterShowcaseDescription =>
      'Сначала записывайте воду, а затем остальные данные, чтобы Glu точнее замечал привычки и паттерны.';

  @override
  String get mainShellProgressShowcaseTitle => 'Смотрите свой прогресс';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Проверяйте свои паттерны и тенденции, чтобы понимать, как меняются ваши привычки и вес со временем.';

  @override
  String get progressMenuShowcaseTitle => 'Изучите свои данные';

  @override
  String get progressMenuShowcaseDescription =>
      'Просматривайте все графики, читайте ИИ-выводы или создайте отчет для врача, чтобы поделиться им с вашей командой по уходу.';

  @override
  String get settingsFeedbackShowcaseTitle => 'Мы будем рады вашему отзыву';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Нажмите здесь, чтобы поделиться тем, что работает, что не работает, или любыми идеями.';

  @override
  String get authCouldNotOpenLink => 'Не удалось открыть ссылку.';

  @override
  String get authWelcomeTitle => 'Добро пожаловать в Glu';

  @override
  String get authSubtitle => 'Безопасный вход в ваш помощник по здоровью';

  @override
  String get authContinueWithGoogle => 'Продолжить через Google';

  @override
  String get authContinueWithApple => 'Продолжить через Apple';

  @override
  String get authEmailHint => 'имя@почта.com';

  @override
  String get authSending => 'Отправка...';

  @override
  String get authResendLink => 'Отправить ссылку снова';

  @override
  String get authUseDifferentEmail => 'Использовать другой email';

  @override
  String get habitGoalsTitle => 'Цели привычек';

  @override
  String get goalsProteins => 'Белки';

  @override
  String get goalsFibers => 'Клетчатка';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value г в день';
  }

  @override
  String get goalsWater => 'Вода';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value л в день';
  }

  @override
  String get goalsExercise => 'Тренировки';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value мин в день';
  }

  @override
  String get goalsMeals => 'Приёмы пищи';

  @override
  String get goalsCalories => 'Калории';

  @override
  String get goalsKcalUnit => 'ккал';

  @override
  String get goalsPerWeekSuffix => 'в неделю';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count приёмов пищи в день';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count ккал в день';
  }

  @override
  String get goalsWeight => 'Вес';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Добавьте записанный вес, чтобы рассчитать темп';

  @override
  String get goalsAlreadyAtThisTarget => 'Вы уже достигли этой цели';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/нед. до цели';
  }

  @override
  String get goalsSetTargetForNextWeek =>
      'Установите цель на следующую неделю.';

  @override
  String get progressWeightTitle => 'Вес';

  @override
  String get progressWeightLabel => 'Вес';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Здоровый ИМТ';

  @override
  String get progressTotal => 'Всего';

  @override
  String get progressPercent => 'Процент';

  @override
  String get progressWeeklyAvg => 'Среднее за неделю';

  @override
  String get progressRangeAllTime => 'За всё время';

  @override
  String get progressRange1Month => '1 месяц';

  @override
  String get progressRange3Months => '3 месяца';

  @override
  String get progressRange6Months => '6 месяцев';

  @override
  String get progressLow => 'Низкий';

  @override
  String get progressMed => 'Средний';

  @override
  String get progressHigh => 'Высокий';

  @override
  String get progressSeverity => 'Степень';

  @override
  String get progressBad => 'Плохо';

  @override
  String get progressOkay => 'Нормально';

  @override
  String get progressGood => 'Хорошо';

  @override
  String get progressGreat => 'Отлично';

  @override
  String get progressMostlyBad => 'В основном плохо';

  @override
  String get progressMostlyOkay => 'В основном нормально';

  @override
  String get progressMostlyGood => 'В основном хорошо';

  @override
  String get progressMostlyGreat => 'В основном отлично';

  @override
  String get progressNoDose => 'Нет дозы';

  @override
  String get progressLogged => 'Записано';

  @override
  String get progressAllClear => 'Всё спокойно';

  @override
  String get progressFreq => 'Частота';

  @override
  String get progressAverage => 'Среднее';

  @override
  String get progressDaily => 'Ежедневно';

  @override
  String get progressWeekly => 'Еженедельно';

  @override
  String get progressMinutes => 'Минуты';

  @override
  String get progressIntensity => 'Интенсивность';

  @override
  String get progressCalories => 'Калории';

  @override
  String get progressByDose => 'По дозе';

  @override
  String get progressWeightProgressTitle => 'Прогресс веса';

  @override
  String get progressWaterProgressTitle => 'Прогресс воды';

  @override
  String get progressExerciseProgressTitle => 'Прогресс тренировок';

  @override
  String get progressDoseProgressTitle => 'Прогресс доз';

  @override
  String get progressMealsProgressTitle => 'Прогресс питания';

  @override
  String get progressSymptomsProgressTitle => 'Прогресс симптомов';

  @override
  String get progressMoodProgressTitle => 'Прогресс настроения';

  @override
  String get progressWeightChangeTitle => 'Изменение веса';

  @override
  String get progressTitle => 'Прогресс';

  @override
  String get progressMenuViewAllInsights => 'Все инсайты';

  @override
  String get progressMenuViewAllCharts => 'Все графики';

  @override
  String get progressMenuCreateDoctorReport => 'Создать отчет для врача';

  @override
  String get progressReportGenerating => 'Создаем ваш отчет…';

  @override
  String get progressReportError =>
      'Не удалось создать отчет. Попробуйте еще раз.';

  @override
  String get progressReportPendingRetry =>
      'Ваш отчет может быть готов уже через мгновение. Попробуйте еще раз.';

  @override
  String get progressReportOpenError =>
      'Ваш отчет был создан, но нам не удалось его открыть. Попробуйте еще раз.';

  @override
  String get progressReportOpenedInBrowser =>
      'Отчет готов. Открыт в вашем браузере.';

  @override
  String get progressReportCopiedLink =>
      'Отчет готов. Поделиться не удалось, поэтому ссылка была скопирована в буфер обмена.';

  @override
  String get progressAllProgressTitle => 'Весь прогресс';

  @override
  String get progressWeightTrendExplanation =>
      'Посмотрите, как меняется ваш вес со временем.';

  @override
  String get progressNoWeightLogsYet => 'Пока нет записей веса';

  @override
  String get progressNoLogsYet => 'Пока нет записей';

  @override
  String get progressLogWeightToStartTrend =>
      'Запишите вес, чтобы начать отслеживать тенденцию.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Запишите вес и дозу, чтобы сравнить, как изменение связано с дозировкой.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Каждая точка окрашена по последней дозе, сделанной до этого взвешивания.';

  @override
  String get progressNoHydrationYet => 'Пока нет воды';

  @override
  String get progressNoMovementYet => 'Пока нет активности';

  @override
  String get progressNoDoseLogsYet => 'Пока нет записей доз';

  @override
  String get progressNoMealsLoggedYet => 'Пока нет записей питания';

  @override
  String get progressNoSymptomsLoggedYet => 'Пока нет записей симптомов';

  @override
  String get progressNoMoodLogsYet => 'Пока нет записей настроения';

  @override
  String get progressFutureTrendTitle => 'Будущая тенденция';

  @override
  String get progressFutureTrendBody =>
      'Красивая временная линия вашего движения вперёд';

  @override
  String get progressGoal => 'Цель';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Ваш последний записанный вес готов к отслеживанию.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Около $gap $unit до вашей цели.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText по сравнению с предыдущей записью.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText по сравнению с предыдущей записью. $gap $unit до цели.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'По сравнению с предыдущей записью тенденция теперь видна.';

  @override
  String get progressWaterTitle => 'Вода';

  @override
  String get manageSubscriptionTitle => 'Управление подпиской';

  @override
  String get manageSubscriptionProPlan => 'Тариф Pro';

  @override
  String get manageSubscriptionFreePlan => 'Бесплатный тариф';

  @override
  String get manageSubscriptionActiveCopy => 'Ваша подписка активна.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Обновите тариф, чтобы открыть Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Тариф';

  @override
  String get manageSubscriptionPro => 'Премиум';

  @override
  String get manageSubscriptionFree => 'Бесплатно';

  @override
  String get manageSubscriptionProduct => 'Продукт';

  @override
  String get manageSubscriptionRenewal => 'Продление';

  @override
  String get manageSubscriptionStatus => 'Статус';

  @override
  String get manageSubscriptionStatusActive => 'Активна';

  @override
  String get manageSubscriptionStatusInactive => 'Не активна';

  @override
  String get manageSubscriptionManageButton => 'Управлять подпиской';

  @override
  String get manageSubscriptionUpgradeButton => 'Обновить до Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Открыть настройки подписки в магазине';

  @override
  String get manageSubscriptionProBadge => 'ПРЕМИУМ';

  @override
  String get manageSubscriptionRestorePurchases => 'Восстановить покупки';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Продлевается автоматически';

  @override
  String get manageSubscriptionLifetime => 'Пожизненно';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Продлевается $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Истекает $date';
  }

  @override
  String get supplementReminderDayMon => 'Пн';

  @override
  String get supplementReminderDayTue => 'Вт';

  @override
  String get supplementReminderDayWed => 'Ср';

  @override
  String get supplementReminderDayThu => 'Чт';

  @override
  String get supplementReminderDayFri => 'Пт';

  @override
  String get supplementReminderDaySat => 'Сб';

  @override
  String get supplementReminderDaySun => 'Вс';

  @override
  String supplementReminderInDays(Object count) {
    return 'Через $count дней';
  }

  @override
  String get supplementReminderInOneWeek => 'Через 1 неделю';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Через $count недель';
  }

  @override
  String get subscriptionDebugTitle => 'Подписки Glu';

  @override
  String get subscriptionDebugMonthly => 'Ежемесячно';

  @override
  String get subscriptionDebugYearly => 'Ежегодно';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Обновить данные клиента';

  @override
  String get subscriptionDebugPresentPaywall => 'Показать paywall';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Открыть центр клиента';

  @override
  String get subscriptionDebugRestorePurchases => 'Восстановить покупки';

  @override
  String get subscriptionDebugSyncPurchases => 'Синхронизировать покупки';

  @override
  String get subscriptionDebugRevenuecatStatus => 'Статус RevenueCat';

  @override
  String get subscriptionDebugConfigured => 'Настроено';

  @override
  String get subscriptionDebugBusy => 'Занято';

  @override
  String get subscriptionDebugAppUserId => 'ID пользователя приложения';

  @override
  String get subscriptionDebugAnonymous => 'анонимный';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-ключ доступен';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro активен';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Активные подписки';

  @override
  String get subscriptionDebugManagementUrl => 'URL управления';

  @override
  String get subscriptionDebugEntitlementProduct => 'Товар entitlements';

  @override
  String get subscriptionDebugWillRenew => 'Будет продлена';

  @override
  String get subscriptionDebugExpiration => 'Истечение';

  @override
  String get subscriptionDebugLifetime => 'пожизненно';

  @override
  String get subscriptionDebugPackageFound => 'Пакет найден';

  @override
  String get subscriptionDebugProductId => 'ID продукта';

  @override
  String get subscriptionDebugTitleLabel => 'Заголовок';

  @override
  String get subscriptionDebugPrice => 'Цена';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Купить $title';
  }

  @override
  String get progressExerciseTitle => 'Тренировки';

  @override
  String get progressDoseTitle => 'Доза';

  @override
  String get progressMealsTitle => 'Питание';

  @override
  String get progressSymptomsTitle => 'Симптомы';

  @override
  String get progressMoodTitle => 'Настроение';

  @override
  String get progressTrend => 'Тенденция';

  @override
  String get progressTarget => 'Цель';

  @override
  String get progressNoTrendYet => 'Тенденции пока нет';

  @override
  String get progressNoActivityYet => 'Активности пока нет';

  @override
  String get progressNoCheckInsYet => 'Пока нет проверок';

  @override
  String get progressWeightSignatureChip =>
      'Вес станет вашей главной диаграммой';

  @override
  String get progressWeightStartTrendTitle =>
      'Начните тенденцию с одного взвешивания';

  @override
  String get progressWeightStartTrendBody =>
      'Эта диаграмма — центр вашей истории прогресса. Запишите первый вес, чтобы открыть импульс, этапы и вид, которым захочется делиться.';

  @override
  String get progressWeightMomentum => 'Импульс';

  @override
  String get progressWeightMilestones => 'Этапы';

  @override
  String get progressWeightShareReady => 'Готово к отправке';

  @override
  String get progressWeightLogWeight => 'Записать вес';

  @override
  String get weightProgressUnlocksViewChip =>
      'Первое взвешивание откроет этот вид';

  @override
  String get weightProgressStartsHereTitle =>
      'История вашего прогресса начинается здесь';

  @override
  String get weightProgressStartsHereBody =>
      'Запишите первый вес, чтобы открыть тенденции, этапы и инсайты с учетом дозы в виде, которым захочется делиться.';

  @override
  String get weightProgressTrendView => 'Вид тенденции';

  @override
  String get weightProgressDoseOverlays => 'Наложения доз';

  @override
  String get weightProgressMilestones => 'Этапы';

  @override
  String get weightProgressLogWeight => 'Записать вес';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Сначала добавьте фото до и после.';

  @override
  String get glowUpSavedToGallery => 'Сохранено в галерею';

  @override
  String get glowUpSaveToGallery => 'Сохранить в галерею';

  @override
  String get glowUpYourProgress => 'Ваш прогресс';

  @override
  String get glowUpWeightChange => 'Изменение веса';

  @override
  String get glowUpTime => 'Время';

  @override
  String get glowUpShare => 'Поделиться';

  @override
  String get glowUpBefore => 'ДО';

  @override
  String get glowUpAfter => 'ПОСЛЕ';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight за $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'дни';

  @override
  String get glowUpTimeUnitWeeksLabel => 'недели';

  @override
  String get glowUpTimeUnitMonthsLabel => 'месяцы';

  @override
  String get glowUpTimeUnitYearsLabel => 'годы';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count недели',
      many: '$count недель',
      few: '$count недели',
      one: '$count неделя',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count месяца',
      many: '$count месяцев',
      few: '$count месяца',
      one: '$count месяц',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count года',
      many: '$count лет',
      few: '$count года',
      one: '$count год',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Вчера';

  @override
  String get commonSelect => 'Выбрать';

  @override
  String get doseReminderTitle => 'Напоминание о дозе';

  @override
  String get doseReminderCustomDoseTitle => 'Своя доза';

  @override
  String get doseReminderCustomDoseHint => 'Введите дозу в мг';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Держите следующую дозу готовой на главной.';

  @override
  String get doseReminderTime => 'Время';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Включите это, чтобы показывать следующую дозу на главной.';

  @override
  String get doseReminderSaveReminder => 'Сохранить напоминание';

  @override
  String loggedOn(Object date) {
    return 'Записано $date';
  }

  @override
  String get waterLogSmallGlass => 'Небольшой стакан';

  @override
  String get waterLogGlass => 'Стакан';

  @override
  String get waterLogBottle => 'Бутылка';

  @override
  String get waterLogLargeBottle => 'Большая бутылка';

  @override
  String get waterLogTwoLiters => '2 л';

  @override
  String get waterLogCustomPreset => 'Своя';

  @override
  String get waterLogMlUnit => 'мл';

  @override
  String get waterLogOzUnit => 'унц';

  @override
  String get doseLogTitle => 'Доза';

  @override
  String get doseLogEditTitle => 'Изменить дозу';

  @override
  String get doseLogLogTitle => 'Записать дозу';

  @override
  String get doseLogCustomDose => 'Своя доза';

  @override
  String get doseLogCustomDoseBody => 'Измените дозу в мг для этой записи.';

  @override
  String get doseLogUseThisDose => 'Использовать эту дозу';

  @override
  String get doseLogMedication => 'Препарат';

  @override
  String get doseLogInjectionSite => 'Место';

  @override
  String get doseLogNotes => 'Заметки';

  @override
  String get doseLogSaveChanges => 'Сохранить изменения';

  @override
  String get doseLogAddDose => '+ Записать дозу';

  @override
  String get doseLogDeleteTitle => 'Удалить эту запись дозы?';

  @override
  String get doseLogDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get doseLogDeleteLog => 'Удалить запись';

  @override
  String get doseLogSaving => 'Сохраняем...';

  @override
  String get doseLogCouldNotSave =>
      'Пока не удалось сохранить эту запись дозы.';

  @override
  String get doseLogCouldNotDelete =>
      'Пока не удалось удалить эту запись дозы.';

  @override
  String get doseLogDeleted => 'Доза удалена';

  @override
  String get doseLogAddedToDoseLog => 'Добавлено в журнал доз';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Есть ли что-то, что стоит запомнить об этой дозе?';

  @override
  String get doseLogDoseLabel => 'Доза';

  @override
  String get exerciseLogTitle => 'Тренировка';

  @override
  String get exerciseLogEditTitle => 'Изменить тренировку';

  @override
  String get exerciseLogLogTitle => 'Записать тренировку';

  @override
  String get exerciseLogActivityType => 'Тип активности';

  @override
  String get exerciseLogCustomActivity => 'Своя активность';

  @override
  String get exerciseLogTypeActivity => 'Введите активность';

  @override
  String get exerciseLogDuration => 'Длительность';

  @override
  String get exerciseLogIntensity => 'Интенсивность';

  @override
  String get exerciseLogNotes => 'Заметки';

  @override
  String get exerciseLogLight => 'Лёгкая';

  @override
  String get exerciseLogModerate => 'Умеренная';

  @override
  String get exerciseLogIntense => 'Интенсивная';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes мин записано';
  }

  @override
  String get exerciseLogSaveChanges => 'Сохранить изменения';

  @override
  String get exerciseLogAddExercise => '+ Добавить тренировку';

  @override
  String get exerciseLogDeleteTitle => 'Удалить эту запись тренировки?';

  @override
  String get exerciseLogDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get exerciseLogDeleteLog => 'Удалить запись';

  @override
  String get exerciseLogSaving => 'Сохраняем...';

  @override
  String get exerciseLogCouldNotSave =>
      'Пока не удалось сохранить эту запись тренировки.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Пока не удалось удалить эту запись тренировки.';

  @override
  String get exerciseLogDeleted => 'Тренировка удалена';

  @override
  String get exerciseLogAddedToExerciseLog => 'Добавлено в журнал тренировок';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Есть ли что-то, что стоит запомнить об этой сессии?';

  @override
  String get exerciseLogWalking => 'Ходьба';

  @override
  String get exerciseLogRunning => 'Бег';

  @override
  String get exerciseLogCycling => 'Велосипед';

  @override
  String get exerciseLogStrength => 'Силовая';

  @override
  String get exerciseLogYoga => 'Йога';

  @override
  String get exerciseLogSwim => 'Плавание';

  @override
  String get exerciseLogHiit => 'ВИИТ';

  @override
  String get weightLogTitle => 'Вес';

  @override
  String get weightLogEditTitle => 'Изменить вес';

  @override
  String get weightLogLogTitle => 'Записать вес';

  @override
  String get weightLogSaveChanges => 'Сохранить изменения';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Добавить вес ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Удалить эту запись веса?';

  @override
  String get weightLogDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get weightLogDeleteLog => 'Удалить запись';

  @override
  String get weightLogSaving => 'Сохраняем...';

  @override
  String get weightLogCouldNotSave =>
      'Пока не удалось сохранить эту запись веса.';

  @override
  String get weightLogCouldNotDelete =>
      'Пока не удалось удалить эту запись веса.';

  @override
  String get weightLogDeleted => 'Вес удалён';

  @override
  String get weightLogAddedToWeightLog => 'Добавлено в журнал веса';

  @override
  String get weightLogNoWeightForDay => 'За этот день вес ещё не записан.';

  @override
  String get injectionSiteAbdomen => 'Живот';

  @override
  String get injectionSiteThigh => 'Бедро';

  @override
  String get injectionSiteUpperArm => 'Плечо';

  @override
  String get injectionSiteButtocks => 'Ягодицы';

  @override
  String get injectionSiteAbdomenUpperLeft => 'Живот, верхний левый';

  @override
  String get injectionSiteAbdomenUpperRight => 'Живот, верхний правый';

  @override
  String get injectionSiteAbdomenLowerRight => 'Живот, нижний правый';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Живот, нижний левый';

  @override
  String get injectionSiteThighUpperLeft => 'Бедро, верхний левый';

  @override
  String get injectionSiteThighUpperRight => 'Бедро, верхний правый';

  @override
  String get injectionSiteThighLowerRight => 'Бедро, нижний правый';

  @override
  String get injectionSiteThighLowerLeft => 'Бедро, нижний левый';

  @override
  String get injectionSiteUpperArmLeft => 'Плечо, левое';

  @override
  String get injectionSiteUpperArmRight => 'Плечо, правое';

  @override
  String get injectionSiteButtocksUpperLeft => 'Ягодицы, верхний левый';

  @override
  String get injectionSiteButtocksUpperRight => 'Ягодицы, верхний правый';

  @override
  String get doseReminderFormat => 'Формат';

  @override
  String get doseReminderInjection => 'Инъекция';

  @override
  String get doseReminderPill => 'Таблетка';

  @override
  String get doseReminderSite => 'Место';

  @override
  String get doseReminderDate => 'Дата';

  @override
  String get supplementReminderTitle => 'Напоминание о добавке';

  @override
  String get supplementReminderAddSupplement => 'Добавить добавку';

  @override
  String get supplementReminderNoSupplementsYet => 'Пока нет добавок';

  @override
  String get supplementReminderAddFirstBody =>
      'Добавьте первое напоминание о добавке, чтобы отслеживать ежедневный прием.';

  @override
  String get supplementReminderSupplementFallback => 'Добавка';

  @override
  String get supplementReminderEveryDay => 'Каждый день';

  @override
  String get supplementReminderEveryXDaysLabel => 'Каждые X дней';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Каждые $interval дней';
  }

  @override
  String get supplementReminderNoDaysSet => 'Дни не заданы';

  @override
  String get supplementReminderSupplementName => 'Название добавки';

  @override
  String get supplementReminderTime => 'Время';

  @override
  String get supplementReminderStartDate => 'Дата начала';

  @override
  String get supplementReminderRepeat => 'Повтор';

  @override
  String get supplementReminderDaysOfWeek => 'Дни недели';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Выберите хотя бы один день.';

  @override
  String get supplementReminderEvery => 'Каждый';

  @override
  String get supplementReminderDay => 'день';

  @override
  String get supplementReminderDays => 'дня';

  @override
  String get supplementReminderAdd => 'Добавить';

  @override
  String get symptomsLogTitle => 'Симптомы';

  @override
  String get symptomsLogEditTitle => 'Изменить симптомы';

  @override
  String get symptomsLogLogTitle => 'Записать симптомы';

  @override
  String get symptomsLogSymptomsExperienced => 'Испытываемые симптомы';

  @override
  String get symptomsLogNoSymptoms => 'Нет симптомов';

  @override
  String get symptomsLogNoSymptomsToday => 'Сегодня без симптомов';

  @override
  String get symptomsLogOther => 'Другое...';

  @override
  String get symptomsLogSeverityLevel => 'Уровень тяжести';

  @override
  String get symptomsLogNotes => 'Заметки';

  @override
  String get symptomsLogAnxiety => 'Тревога';

  @override
  String get symptomsLogBelching => 'Отрыжка';

  @override
  String get symptomsLogBloating => 'Вздутие';

  @override
  String get symptomsLogConstipation => 'Запор';

  @override
  String get symptomsLogDiarrhea => 'Диарея';

  @override
  String get symptomsLogFatigue => 'Усталость';

  @override
  String get symptomsLogFoodNoise => 'Мысли о еде';

  @override
  String get symptomsLogHairLoss => 'Выпадение волос';

  @override
  String get symptomsLogHeartburn => 'Изжога';

  @override
  String get symptomsLogIndigestion => 'Несварение';

  @override
  String get symptomsLogInjectionSiteReaction => 'Реакция в месте инъекции';

  @override
  String get symptomsLogMetallicTaste => 'Металлический привкус';

  @override
  String get symptomsLogHeadache => 'Головная боль';

  @override
  String get symptomsLogMoodSwings => 'Перепады настроения';

  @override
  String get symptomsLogNausea => 'Тошнота';

  @override
  String get symptomsLogReflux => 'Рефлюкс';

  @override
  String get symptomsLogStomachPain => 'Боль в животе';

  @override
  String get symptomsLogSuppressedAppetite => 'Сниженный аппетит';

  @override
  String get symptomsLogVomiting => 'Рвота';

  @override
  String get symptomsLogLogged => 'Симптомы записаны';

  @override
  String get symptomsLogMild => 'Лёгкая';

  @override
  String get symptomsLogModerate => 'Умеренная';

  @override
  String get symptomsLogSevere => 'Сильная';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Есть ли что-то, что стоит запомнить о вашем самочувствии?';

  @override
  String get symptomsLogSaveChanges => 'Сохранить изменения';

  @override
  String get symptomsLogAddSymptoms => '+ Добавить симптомы';

  @override
  String get symptomsLogDeleteTitle => 'Удалить эту запись симптомов?';

  @override
  String get symptomsLogDeleteMessage => 'Это действие нельзя отменить.';

  @override
  String get symptomsLogDeleteLog => 'Удалить запись';

  @override
  String get symptomsLogSaving => 'Сохраняем...';

  @override
  String get symptomsLogCouldNotSave =>
      'Пока не удалось сохранить эту запись симптомов.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Пока не удалось удалить эту запись симптомов.';

  @override
  String get symptomsLogDeleted => 'Симптомы удалены';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Добавлено в журнал симптомов';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% от дневной цели';
  }

  @override
  String get commonDisclaimer =>
      'Glu — это инструмент для отслеживания, а не медицинское устройство. Он не предоставляет медицинских советов, диагнозов или лечения. Всегда консультируйтесь со своим врачом по поводу препаратов и решений о здоровье.';
}
