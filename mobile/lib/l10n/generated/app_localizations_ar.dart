// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'جارٍ الاستيقاظ...';

  @override
  String get startupFailed => 'فشل بدء التشغيل';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonSaving => 'جارٍ الحفظ...';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonNotNow => 'ليس الآن';

  @override
  String get commonNow => 'الآن';

  @override
  String get commonTomorrow => 'غدًا';

  @override
  String get noteTriggerAddNote => 'إضافة ملاحظة';

  @override
  String get noteTriggerCancelNote => 'إلغاء الملاحظة';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'خلال $count يومًا';
  }

  @override
  String get homeDoseReminderInOneWeek => 'خلال أسبوع واحد';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'خلال $count أسابيع';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'متأخر يومًا واحدًا';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'متأخر $count يومًا';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'متأخر أسبوعًا واحدًا';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'متأخر $count أسبوعًا';
  }

  @override
  String get bmiIndicatorYourBmi => 'مؤشر كتلة الجسم الخاص بك';

  @override
  String get bmiIndicatorCurrentBmi => 'مؤشر كتلة الجسم الحالي لديك';

  @override
  String get bmiIndicatorUnderweight => 'نقص الوزن';

  @override
  String get bmiIndicatorNormal => 'طبيعي';

  @override
  String get bmiIndicatorOverweight => 'زيادة الوزن';

  @override
  String get bmiIndicatorObesity => 'السمنة';

  @override
  String get heightRulerCmUnit => 'سم';

  @override
  String get heightRulerFtUnit => 'قدم';

  @override
  String get heightRulerInUnit => 'بوصة';

  @override
  String get heightRulerFtInUnit => 'قدم/بوصة';

  @override
  String get weightDialKgUnit => 'كغ';

  @override
  String get weightDialLbUnit => 'رطل';

  @override
  String get logNoteIndicatorHasNote => 'ملاحظة موجودة';

  @override
  String get paywallTitle => 'افتح Glu برو';

  @override
  String get paywallSubtitle => 'احمِ تقدّمك وتجنّب استعادة الوزن.';

  @override
  String get paywallMonthlyTitle => 'شهري';

  @override
  String get paywallMonthlySubtitle => 'لا توجد فترة تجريبية';

  @override
  String get paywallYearlyTitle => 'سنوي';

  @override
  String get paywallYearlySubtitle => 'تجربة مجانية لمدة 7 أيام';

  @override
  String get paywallNoCommitment => 'بدون التزام';

  @override
  String get paywallCancelAnytime => 'يمكن الإلغاء في أي وقت';

  @override
  String get paywallContinue => 'متابعة';

  @override
  String get paywallRestore => 'استعادة';

  @override
  String get paywallTerms => 'شروط الاستخدام';

  @override
  String get paywallPrivacy => 'الخصوصية';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'وفّر $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'تعذّر فتح الرابط الآن.';

  @override
  String get paywallAlreadySubscribed => 'لديك Glu برو بالفعل.';

  @override
  String get paywallPurchaseSuccess => 'مرحبًا بك في Glu برو!';

  @override
  String get paywallPurchaseIncomplete => 'لم يكتمل الشراء. حاول مرة أخرى.';

  @override
  String get paywallPurchaseFailed => 'فشل الشراء. حاول مرة أخرى.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'فشل الشراء: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'تمت استعادة الاشتراك!';

  @override
  String get paywallRestoreNoSubscription => 'لم يتم العثور على اشتراك نشط.';

  @override
  String get paywallRestoreFailed => 'فشلت الاستعادة. حاول مرة أخرى.';

  @override
  String get paywallBenefitReminders => 'تذكيرات للجرعات والمكمّلات';

  @override
  String get paywallBenefitShareProgress => 'شارك تقدّمك بسهولة';

  @override
  String get paywallBenefitSpotRegain => 'اكتشف استعادة الوزن مبكرًا';

  @override
  String get paywallBenefitInsights => 'شاهد التحليلات والاتجاهات اليومية';

  @override
  String get paywallBenefitWeeklyGoals => 'التزم بأهداف أسبوعية بسيطة';

  @override
  String get paywallBenefitHealthyHabits =>
      'اجعل العادات الصحية أسهل للحفاظ عليها';

  @override
  String get onboardingWelcomeTitle => 'حافظ على الوزن الزائد بعيدًا';

  @override
  String get onboardingWelcomeSubtitle =>
      'يساعدك Glu على حماية تقدّمك حول العلاج والأهداف والعادات الأسبوعية.';

  @override
  String get onboardingWelcomeBullet1 => 'يناسب علاجك وأهدافك';

  @override
  String get onboardingWelcomeBullet2 => 'دعم بسيط وواقعي';

  @override
  String get onboardingWelcomeBullet3 =>
      'سهولة رصد العلامات المبكرة لاستعادة الوزن';

  @override
  String get onboardingWelcomeBullet4 => 'استمر دون أن تبدأ من جديد';

  @override
  String get onboardingMedicationStatusQuestion =>
      'هل تتناول حاليًا دواءً للتخسيس على شكل قلم أو حبوب؟';

  @override
  String get onboardingMedicationStatusExplainer =>
      'نستخدم هذا لإظهار إرشادات تناسب وضعك الحالي.';

  @override
  String get onboardingMedicationStatusUsing => 'نعم، أتناوله الآن';

  @override
  String get onboardingMedicationStatusWeaningOff =>
      'نعم، أخفّف الجرعة تدريجيًا';

  @override
  String get onboardingMedicationStatusNotTaking => 'لا، لا أتناوله';

  @override
  String get onboardingMedicationStatusStartingSoon => 'لا، سأبدأ قريبًا';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'لا، توقفت عنه مؤخرًا';

  @override
  String get onboardingMedicationMethodQuestion => 'كيف تتناول دواءك؟';

  @override
  String get onboardingMedicationMethodExplainer =>
      'نستخدم هذا لتخصيص التعليمات والتذكيرات بحسب شكل دوائك.';

  @override
  String get onboardingMedicationMethodInjection => 'حقن';

  @override
  String get onboardingMedicationMethodPill => 'حبوب';

  @override
  String get onboardingMedicationMethodUnknown => 'لا أعرف بعد';

  @override
  String get onboardingMedicationNameQuestion => 'ما الدواء الذي تتناوله؟';

  @override
  String get onboardingMedicationNameExplainer =>
      'نستخدم هذا لتخصيص تتبّع الجرعات والإرشادات الخاصة بالدواء.';

  @override
  String get onboardingCurrentDoseQuestion => 'ما جرعتك الحالية؟';

  @override
  String get onboardingCurrentDoseExplainer =>
      'نستخدم هذا لتخصيص تتبّع الجرعات وتسجيلات المتابعة المستقبلية.';

  @override
  String get onboardingMedicationCustomDose => 'مخصص';

  @override
  String get onboardingDeviceTypeQuestion =>
      'ما الجهاز الذي تستخدمه لتناول دوائك؟';

  @override
  String get onboardingDeviceTypeExplainer =>
      'نستخدم هذا لجعل التذكيرات والنصائح مناسبة للطريقة التي تتناوله بها.';

  @override
  String get onboardingDeviceSinglePen => 'قلم واحد';

  @override
  String get onboardingDeviceAutoInjector => 'حقنة آلية';

  @override
  String get onboardingDeviceSyringeAndVial => 'سرنجة وقارورة';

  @override
  String get onboardingOther => 'أخرى';

  @override
  String get onboardingTypeYourDevice => 'اكتب جهازك';

  @override
  String get onboardingMedicationFrequencyQuestion => 'كم مرة تتناول دواءك؟';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'نستخدم هذا لتوقيت التذكيرات ودعم الروتين وفقًا لجدولك.';

  @override
  String get onboardingEveryDay => 'كل يوم';

  @override
  String get onboardingEvery7Days => 'كل 7 أيام';

  @override
  String get onboardingEvery14Days => 'كل 14 يومًا';

  @override
  String get onboardingCustom => 'مخصص';

  @override
  String get onboardingDaysBetweenDoses => 'الأيام بين الجرعات';

  @override
  String get onboardingPrimaryGoalQuestion => 'ما هدفك الأساسي الآن؟';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'نستخدم هذا لتركيز خطتك وتذكيراتك وتقدّمك حول ما يهمك أكثر.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'نستخدم هذا لتشكيل خطتك منذ البداية.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'نستخدم هذا لدعم مرحلتك التالية ومساعدتك على البقاء على المسار.';

  @override
  String get onboardingGoalLoseWeight => 'إنقاص الوزن';

  @override
  String get onboardingGoalMaintainWeight => 'الحفاظ على الوزن';

  @override
  String get onboardingGoalManageDiabetes => 'إدارة السكري';

  @override
  String get onboardingGoalManagePcos => 'إدارة تكيّس المبايض';

  @override
  String get onboardingGoalImproveHeartHealth => 'تحسين صحة القلب';

  @override
  String get onboardingAgeQuestion => 'ما عمرك؟';

  @override
  String get onboardingAgeExplainer =>
      'نستخدم هذا لتعديل الإرشادات والحسابات الصحية بشكل أدق.';

  @override
  String get onboardingHeightQuestion => 'ما طولك؟';

  @override
  String get onboardingHeightExplainer =>
      'نستخدم هذا مع وزنك لحساب أشياء مثل مؤشر كتلة الجسم والنطاقات الصحية.';

  @override
  String get onboardingWeightQuestion => 'ما وزنك الحالي؟';

  @override
  String get onboardingWeightExplainer =>
      'نستخدم هذا كنقطة بداية للتقدّم والأهداف والتقديرات الصحية.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'متى توقفت عن الدواء؟';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'متى بدأت تخفيف الجرعة تدريجيًا؟';

  @override
  String get onboardingMedicationStartedQuestionStarted => 'متى بدأت الدواء؟';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'نستخدم هذا لفهم تاريخ علاجك الأخير والمرحلة التالية.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'نستخدم هذا لفهم مرحلة الانتقال ودعم العادات التي تهم أكثر الآن.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'نستخدم هذا لفهم مدة العلاج وتتبع التغيّر مع الوقت.';

  @override
  String get onboardingGoalWeightQuestion => 'ما هدف وزنك؟';

  @override
  String get onboardingGoalWeightExplainer =>
      'نستخدم هذا لتأطير التقدّم وإظهار نطاق مؤشر كتلة الجسم المستهدف لك.';

  @override
  String get onboardingBenefitsQuestion => 'ما سيساعدك Glu على فعله بعد ذلك';

  @override
  String get onboardingBenefitsExplainer =>
      'يحوّل Glu ما شاركته إلى تذكيرات ودعم وبنية تناسب روتينك.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'إليك كيف يمكن لـ Glu مساعدتك على الحفاظ على تقدّمك';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'إليك كيف يمكن لـ Glu دعم روتين السكري الخاص بك';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'إليك كيف يمكن لـ Glu دعم روتين تكيس المبايض الخاص بك';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'إليك كيف يمكن لـ Glu دعم صحة قلبك';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'إليك كيف يمكن لـ Glu مساعدتك على إنقاص الوزن';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'شاهد كيف يساعدك Glu على حماية وزنك الحالي ورصد استعادة الوزن مبكرًا.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'شاهد كيف يساعدك Glu على جعل الوجبات والوزن والروتين أكثر ثباتًا أسبوعًا بعد أسبوع.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'شاهد كيف يساعدك Glu على الثبات أكثر حول الأعراض والوزن والروتين.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'شاهد كيف يساعدك Glu على الثبات مع العادات التي تدعم صحة القلب.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'شاهد كيف يساعدك Glu على رصد الأنماط التي تحافظ على نزول الوزن.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'بدون بنية، قد تحدث استعادة الوزن بصمت. يساعدك Glu على التقاطها مبكرًا والبقاء ثابتًا.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'بدون بنية، تصبح أنماط الوجبات والوزن مشتتة. يحافظ Glu على وضوح الإشارات.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'بدون بنية، قد تتقلب الأعراض والروتين أكثر. يساعدك Glu على البقاء أكثر ثباتًا.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'بدون بنية، تنحرف العادات الصحية. يساعدك Glu على الحفاظ على النشاط والوزن على المسار.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'بدون بنية، قد يتباطأ الوزن أو يرتفع. يساعد Glu على إبقاء التقدّم في الاتجاه الصحيح.';

  @override
  String get onboardingBenefitsAxisWeight => 'الوزن';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'وجبات & الوزن';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'الأعراض والوزن';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'التمرين والوزن';

  @override
  String get onboardingNotificationsQuestion => 'فعّل التذكيرات التي تدعم هدفك';

  @override
  String get onboardingNotificationsExplainer =>
      'سنستخدم الإشعارات لمساعدتك على الثبات والاستعداد والبقاء على المسار.';

  @override
  String get onboardingNotificationsHeadline =>
      'أعد Glu لمساعدتك في اللحظة المناسبة.';

  @override
  String get onboardingNotificationsBody =>
      'فعّل الإشعارات حتى يتمكن Glu من دعم العادات التي تساعدك على تحقيق هدفك.';

  @override
  String get onboardingNotificationsDaily =>
      'تذكيرات موقّتة تتماشى مع إيقاع دوائك اليومي';

  @override
  String get onboardingNotificationsEvery14Days =>
      'تذكيرات بعيدة المدى حتى لا تفاجئك أيام الجرعة';

  @override
  String get onboardingNotificationsCustom => 'تذكيرات مصممة وفق جدولك المخصص';

  @override
  String get onboardingNotificationsWeekly =>
      'تذكيرات الجرعة التي تبقيك متوافقًا مع إيقاعك الأسبوعي';

  @override
  String get onboardingNotificationsSupportive =>
      'تذكيرات داعمة تجعل روتينك حاضرًا عندما ينخفض الحافز';

  @override
  String get onboardingNotificationsProgress =>
      'تنبيهات في الوقت المناسب حول التقدّم والعادات والأهداف التي قلت لنا إنها الأهم';

  @override
  String get onboardingNotificationsHelpful =>
      'تنبيهات مفيدة تجعل Glu أكثر فائدة في اللحظات التي تحتاجه فيها';

  @override
  String get onboardingDailyRoutineQuestion => 'ما روتينك اليومي؟';

  @override
  String get onboardingDailyRoutineExplainer =>
      'نستخدم هذا لجعل خطتك تبدواقعية لحياتك اليومية.';

  @override
  String get onboardingRoutineSedentary => 'خامل';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'معظم الوقت جلوس أو عمل مكتبي وقليل جدًا من التمرين المقصود.';

  @override
  String get onboardingRoutineLightlyActive => 'نشط قليلًا';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'المشي المنتظم أو المهام اليومية أو تمارين خفيفة عدة مرات في الأسبوع.';

  @override
  String get onboardingRoutineActive => 'نشط';

  @override
  String get onboardingRoutineActiveDescription =>
      'حركة أو تمرين متكرر، مثل المشي اليومي أو النادي أو عمل نشط.';

  @override
  String get onboardingRoutineVeryActive => 'نشط جدًا';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'تدريب قوي أو عمل بدني متطلب أو نشاط مرتفع في معظم الأيام.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'ما الأعراض التي تقلقك أكثر، إن وجدت؟';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'نستخدم هذا لترتيب النصائح والإرشادات حول الأعراض التي تهمك أكثر.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'نستخدم هذا للتركيز على الأعراض التي تريد أن تسبقها.';

  @override
  String get onboardingGenderQuestion => 'كيف تصف جنسك؟';

  @override
  String get onboardingGenderExplainer =>
      'نستخدم هذا للحصول على إرشادات أكثر ملاءمة وتخصيص مستقبلي أفضل.';

  @override
  String get onboardingGenderFemale => 'أنثى';

  @override
  String get onboardingGenderMale => 'ذكر';

  @override
  String get onboardingGenderPreferNotToSay => 'أفضل عدم الإجابة';

  @override
  String get onboardingTypeYourGender => 'اكتب جنسك';

  @override
  String get onboardingPreferredNameQuestion => 'كيف تريد أن نناديك؟';

  @override
  String get onboardingPreferredNameExplainer =>
      'نستخدم هذا لجعل Glu يبدو أكثر شخصية عندما نتحدث إليك.';

  @override
  String get onboardingPreferredNameHint => 'أليكس';

  @override
  String get onboardingSetupSummaryQuestion => 'إعداد خطتك';

  @override
  String get onboardingSetupSummaryExplainer =>
      'نحوّل ما شاركته إلى خطة يمكن لـ Glu دعمها فورًا.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'تثبيت أهداف الحفاظ على الوزن...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'إعداد نقاط مراقبة استعادة الوزن...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'ضبط التذكيرات حول روتينك...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'التحضير لخطة أسبوعية أكثر ثباتًا...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'تحديد أنماط الوجبات والوزن...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 => 'إعداد دعم الترطيب...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'التحضير لتذكيرات الاستمرارية...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 => 'بناء بنية يومية أوضح...';

  @override
  String get onboardingSetupSummaryPcosStep1 => 'تنظيم دعم الأعراض...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'تحديد أهداف الحركة الأسبوعية...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'إعداد نقاط ارتكاز للترطيب والروتين...';

  @override
  String get onboardingSetupSummaryPcosStep4 => 'التحضير لخطة أكثر ثباتًا...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'إعداد أهداف النشاط...';

  @override
  String get onboardingSetupSummaryHeartStep2 => 'تحديد دعم الترطيب...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'التحضير لتذكيرات العادات الأسبوعية...';

  @override
  String get onboardingSetupSummaryHeartStep4 => 'بناء روتين لصحة القلب...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 => 'تحديد حدود السعرات...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 => 'إعداد كميات الماء...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'إنشاء خطة أسهل للالتزام بها...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'التحضير لخطة أسبوعية خاصة بك...';

  @override
  String get onboardingSetupSummaryHeadline => 'إعداد Glu الخاص بك جاهز.';

  @override
  String get onboardingSetupLoadingTitle => 'جارٍ بناء إعدادك';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu جاهز لمساعدتك على حماية تقدّمك ببنية أوضح وإشارات مبكرة لاستعادة الوزن.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu جاهز لدعم وجبات أكثر ثباتًا وتتبّع الوزن والعادات التي تهم يوميًا.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu جاهز لدعم روتين أكثر ثباتًا حول الأعراض والعلاج والتقدّم.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu جاهز لتعزيز العادات التي تدعم صحة قلبك على المدى الطويل.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu جاهز لدعم الروتين الذي يساعدك على الحفاظ على الوزن بعيدًا.';

  @override
  String get onboardingSetupSummaryLabel => 'ملخص';

  @override
  String get onboardingSetupAdjustLater =>
      'يمكنك تعديل أي من هذا لاحقًا في الإعدادات.';

  @override
  String get onboardingSummaryGoal => 'هدف';

  @override
  String get onboardingSummaryCurrentWeight => 'الوزن الحالي';

  @override
  String get onboardingSummaryMedication => 'الدواء';

  @override
  String get onboardingSummaryCurrentDose => 'الحالية الجرعة';

  @override
  String get onboardingSummaryCadence => 'الإيقاع';

  @override
  String get onboardingSummaryStarted => 'بدأ';

  @override
  String get onboardingSummaryTargetWeight => 'الوزن المستهدف';

  @override
  String get onboardingSummaryRoutine => 'الروتين';

  @override
  String get onboardingSummaryFocus => 'التركيز';

  @override
  String get onboardingFrequencyEveryDay => 'كل يوم';

  @override
  String get onboardingFrequencyEveryWeek => 'كل أسبوع';

  @override
  String get onboardingFrequencyEvery2Weeks => 'كل 2 أسابيع';

  @override
  String get onboardingFrequencyCustomSchedule => 'جدول مخصص';

  @override
  String get onboardingTapOptionContinue => 'اضغط على خيار للمتابعة.';

  @override
  String get onboardingTypeGenderContinue => 'اكتب جنسك ل متابعة.';

  @override
  String get onboardingTypeDeviceContinue => 'اكتب جهازك ل متابعة.';

  @override
  String get onboardingTypeMedicationContinue => 'اكتب تحليلك الدواء ل متابعة.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'أدخل عدد الأيام بين الجرعات للمتابعة.';

  @override
  String get onboardingChooseScheduleContinue => 'اختر جدول ل متابعة.';

  @override
  String get onboardingScrollChooseAge => 'مرر ل اختر تحليلك عمر.';

  @override
  String get onboardingDragOrTapHeight =>
      'اسحب أو اضغط على المسطرة لاختيار طولك.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'اسحب أو اضغط أو استخدم أزرار الزيادة والنقصان لاختيار الوزن.';

  @override
  String get onboardingPickDateAndWeight => 'اختر تاريخًا ووزنًا للمتابعة.';

  @override
  String get onboardingSelectSymptoms =>
      'اختر أي أعراض تريد أن يركّز Glu عليها.';

  @override
  String get onboardingTypeName => 'اكتب الاسم الذي تريد أن يستخدمه Glu.';

  @override
  String get onboardingSaving => 'جارٍ الحفظ...';

  @override
  String get onboardingLetsBegin => 'لنبدأ';

  @override
  String get onboardingContinueWithGlu => 'متابعة مع Glu';

  @override
  String get onboardingKeepGoing => 'استمر';

  @override
  String get onboardingTurnOnNotifications => 'تشغيل الإشعارات';

  @override
  String get onboardingFinish => 'إنهاء';

  @override
  String get onboardingTargetBmiTitle => 'مؤشر كتلة الجسم المستهدف لك';

  @override
  String get onboardingChartToday => 'اليوم';

  @override
  String get onboardingChartOverTime => 'عبر الزمن';

  @override
  String get onboardingChartWithoutGlu => 'بدون Glu';

  @override
  String get onboardingChartWithGlu => 'مع Glu';

  @override
  String get onboardingReviewQuestion =>
      'يستخدم الناس Glu للبقاء ثابتين ومدعومين';

  @override
  String get onboardingReviewExplainer =>
      'يساعد التقييم السريع المزيد من الناس على العثور على دعم بسيط ومفيد.';

  @override
  String get onboardingReviewBody =>
      'يستخدم الناس Glu ليشعروا بدعم أكبر وثبات أكثر ووحدة أقل خلال العملية.';

  @override
  String get onboardingTypeYourMedication => 'اكتب تحليلك الدواء';

  @override
  String get onboardingSelectStartDate => 'اختر ابدأ تاريخ';

  @override
  String get goalsSaveDialogTitle => 'حفظ أهداف?';

  @override
  String get goalsSaveDialogMessage =>
      'لديك تغييرات غير محفوظة في الأهداف. هل تريد حفظها قبل مغادرة هذا التبويب؟';

  @override
  String get commonLater => 'لاحقًا';

  @override
  String get homeGreetingAnonymous => 'مرحبًا';

  @override
  String homeGreetingWithName(Object name) {
    return 'مرحبًا، $name';
  }

  @override
  String get homeInsightEmptyTitle => 'سجّل اليوم لرؤية التحليل';

  @override
  String get homeInsightEmptyBody =>
      'إذا سجّلت شيئًا اليوم، سترى تحليلك الليلة.';

  @override
  String get homeInsightLogTodayTitle => 'حوّل السجلات إلى تحليل';

  @override
  String get homeInsightMoreLogsVariant1Title => 'سجلات أكثر، تحليل أفضل';

  @override
  String get homeInsightMoreLogsVariant1Body => 'بدأت سجلاتك تُظهر نمطًا.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'تحليلك يتشكّل';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'قد تجعل بضع سجلات إضافية الصورة أوضح بكثير.';

  @override
  String get homeInsightMoreLogsVariant3Title => 'ما تلمّح إليه سجلات اليوم';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'قد يكون هناك نمط يختبئ بالفعل في يومك.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'سجّل مرة واحدة على الأقل اليوم لترى صورة أوضح لتقدّمك.';

  @override
  String get homeInsightExpandedTitle => 'هل كان هذا مفيدًا؟';

  @override
  String get homeInsightExpandedBody =>
      'تساعدنا التقييمات السريعة على معرفة ما يهمك أكثر.';

  @override
  String get homeInsightReasonHint => 'ما الذي يمكن أن يكون أفضل؟ (اختياري)';

  @override
  String get homeInsightReasonSubmit => 'إرسال';

  @override
  String get homeInsightLearningMessage => 'سأتعلم من ذلك.';

  @override
  String get homeInsightChecking => 'جارٍ فحص تحليل اليوم...';

  @override
  String get homeInsightGenerating => 'جارٍ تحميل تحليل اليوم...';

  @override
  String get homeInsightTryAgain => 'حاول مرة أخرى';

  @override
  String get homeSeeAllInsights => 'عرض كل التحليلات';

  @override
  String get insightsProgressTitle => 'كل تحليلات';

  @override
  String get insightsProgressEmptyState => 'ستظهر تحليلاتك هنا بمجرد إنشائها.';

  @override
  String get homeDoseReminderTitle => 'الجرعة تذكير';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'سجل تفاعل $label هنا.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'مطلوب هدف سعرات';

  @override
  String get homeCalorieGoalRequiredBody =>
      'يتطلب فحص الحصص تحديد هدف للوجبات بالسعرات لتقدير الحصص. اضبطه من الأهداف للبدء.';

  @override
  String get homeSetGoal => 'ضبط الهدف';

  @override
  String get homeYourProgress => 'تحليلك تقدّم';

  @override
  String get homeRemindersShowcaseTitle => 'ابقَ على المسار';

  @override
  String get homeRemindersShowcaseDescription =>
      'فعّل التذكيرات للحفاظ على الجرعات والمكملات في وقتها.';

  @override
  String get homePickNextDoseDate => 'اختر تاريخ الجرعة التالية';

  @override
  String get homeSetReminder => 'ضبط تذكير';

  @override
  String get homeSupplementReminders => 'المكمّل تذكيرات';

  @override
  String get homeNoUpcomingSupplements => 'لا توجد مكملات قادمة';

  @override
  String get homeNoMoreUpcomingSupplements => 'لا توجد عناصر قادمة أخرى';

  @override
  String get homeSetUpYourSupplements => 'أعد إعداد مكملاتك';

  @override
  String get homeSetUp => 'إعداد';

  @override
  String get homeSupplementFallback => 'المكمّل';

  @override
  String get doseReminderNotificationTitle => 'هل أنت مستعد لجرعتك؟';

  @override
  String get doseReminderFallbackBody => 'افتح Glu لمراجعة جرعتك التالية.';

  @override
  String get supplementReminderNotificationTitle => 'وقت ل تحليلك المكمّل';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'هذا الصباح';

  @override
  String get supplementReminderThisAfternoon => 'هذا الظهيرة';

  @override
  String get supplementReminderTonight => 'هذا المساء';

  @override
  String get dailyReminderMorningTitle => 'فحص الصباح';

  @override
  String get dailyReminderMorningBodies =>
      'مهمة الصباح: امنح Glu بعض البيانات ليعمل بها.\nابدأ اليوم بسجل سريع وزخم جيد.\nاستيقظ وسجّل. سيقدّر مستقبلك هذا.\nابدأ اليوم بتحديث صغير وانطلاقة كبيرة.\nامنح Glu إشارة صباحية وواصل التقدّم.\nيمكن أن يجعل السجل السريع اليوم أكثر إثارة.\nفلنجعل الصباح يستحق مع فحص سريع.';

  @override
  String get dailyReminderMiddayTitle => 'فحص منتصف اليوم';

  @override
  String get dailyReminderMiddayBodies =>
      'استراحة منتصف اليوم: أضف سجلًا سريعًا وواصل السير.\nاستراحة الغداء؟ الوقت المثالي لإعطاء Glu تحديثًا.\nأنت في منتصف الطريق. أرسل إشارة سريعة إلى Glu.\nيمكن لسجل صغير في منتصف اليوم أن يواصل القصة.\nتحقق الآن وحافظ على إيقاع اليوم.\nأعطِ يومك دفعة صغيرة بتحديث سريع.\nحافظ على الطاقة مع نقرة سريعة في منتصف اليوم.';

  @override
  String get dailyReminderAfternoonTitle => 'فحص بعد الظهر';

  @override
  String get dailyReminderAfternoonBodies =>
      'اقتربنا من النهاية. امنح Glu إشارة صغيرة أخرى.\nيمكن لسجل مسائي سريع أن يجعل تحليل الليلة أكثر وضوحًا.\nاختم اليوم بتحديث صغير وإنجاز كبير.\nسجل إضافي واحد قبل نهاية اليوم؟\nساعد Glu على ربط النقاط مع فحص سريع بعد الظهر.\nأغلق الحلقة بسجل صغير واحتفظ بالزخم.\nيمكن لنقرة أخيرة الآن أن تجعل تحليل الليلة أفضل.';

  @override
  String get homePortionCheckTitle => 'فحص الحصص';

  @override
  String get homePortionCheckBody => 'اعرف كم تأكل في كل وجبة';

  @override
  String get homeGlowUpTitle => 'تألّقك';

  @override
  String get homeGlowUpBody => 'أنشئ قصة قبل وبعد خاصة بك';

  @override
  String get homeGoalsStatusTitle => 'أهداف اليوم';

  @override
  String get homeGoalsStatusViewAll => 'عرض الكل';

  @override
  String get homeWaterTitle => 'الماء';

  @override
  String get homeWeightTitle => 'الوزن';

  @override
  String get homeExerciseTitle => 'التمرين';

  @override
  String get homeMealsTitle => 'وجبات';

  @override
  String get homeCaloriesTitle => 'السعرات';

  @override
  String get homeProteinsTitle => 'البروتين';

  @override
  String get homeFibersTitle => 'الألياف';

  @override
  String get homeSymptomsTitle => 'الأعراض';

  @override
  String get homeMoodTitle => 'المزاج';

  @override
  String get homeDoseTitle => 'الجرعة';

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
  String get homeStartHydration => 'ابدأ ترطيب';

  @override
  String get homeLogFirstSession => 'سجّل جلستك الأولى';

  @override
  String get homeLogTodayWeight => 'سجّل وزن اليوم';

  @override
  String get homeAtYourTarget => 'أنت عند هدفك';

  @override
  String get homeLogMealsToTrackCalories => 'سجّل الوجبات لتتبّع السعرات';

  @override
  String get homeLogFirstMeal => 'سجّل وجبتك الأولى';

  @override
  String get homeTrackProteinFromMeals => 'تتبّع البروتين من الوجبات';

  @override
  String get homeTrackFiberFromMeals => 'تتبّع الألياف من الوجبات';

  @override
  String get homeAllClear => 'كل شيء واضح';

  @override
  String get homeTrackSymptoms => 'تتبّع الأعراض';

  @override
  String get homeGreat => 'رائع';

  @override
  String get homeGood => 'جيد';

  @override
  String get homeBad => 'سيئ';

  @override
  String get homeOkay => 'حسنًا';

  @override
  String get homeLogHowYouFeel => 'سجّل شعورك';

  @override
  String get homeLogTodaysDose => 'سجّل جرعة اليوم';

  @override
  String get homeTaken => 'تم التناول';

  @override
  String get homeStartHereTitle => 'ابدأ هنا';

  @override
  String get homeStartHereBody =>
      'ابدأ بهذه البطاقة، ثم وسّعها لاحقًا. كلما تعلّم Glu أكثر عن رحلتك، استطاع عرض أنماط وتحليلات أفضل مع الوقت.';

  @override
  String get waterLogTitle => 'الترطيب';

  @override
  String get waterLogEditTitle => 'تعديل الترطيب';

  @override
  String get waterLogLogTitle => 'سجل الماء';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ إضافة مشروب ($amount)';
  }

  @override
  String get waterLogSaving => 'جارٍ الحفظ...';

  @override
  String get waterLogCustomDrinkTitle => 'مشروب مخصص';

  @override
  String get waterLogCustomDrinkBody => 'اختر الكمية التي تريد إضافتها الآن.';

  @override
  String get waterLogUseThisAmount => 'استخدم هذه الكمية';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return 'تمت إضافة $amount إلى سجل الترطيب';
  }

  @override
  String get waterLogCouldNotSave => 'تعذّر حفظ سجل الماء هذا الآن.';

  @override
  String get waterLogDeleteTitle => 'حذف هذا ترطيب سجل?';

  @override
  String get waterLogDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get waterLogCouldNotDelete => 'تعذّر حذف سجل الماء هذا الآن.';

  @override
  String get waterLogDeleteLog => 'حذف سجل';

  @override
  String get waterLogDeleted => 'تم حذف الترطيب';

  @override
  String get moodLogTitle => 'المزاج';

  @override
  String get moodEditTitle => 'تعديل المزاج';

  @override
  String get moodHowYouFeel => 'كيف تشعر؟';

  @override
  String get moodBad => 'سيئ';

  @override
  String get moodOkay => 'حسنًا';

  @override
  String get moodGood => 'جيد';

  @override
  String get moodGreat => 'رائع';

  @override
  String get moodNotes => 'ملاحظات';

  @override
  String get moodAnythingWorthRemembering => 'أي شيء يستحق التذكّر عن مزاجك؟';

  @override
  String get moodCouldNotSave => 'تعذّر حفظ سجل المزاج هذا الآن.';

  @override
  String get moodDeleteTitle => 'حذف هذا مزاج سجل?';

  @override
  String get moodDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get moodDeleteLog => 'حذف سجل';

  @override
  String get moodSaving => 'جارٍ الحفظ...';

  @override
  String get moodAddMoodLog => '+ إضافة مزاج سجل';

  @override
  String get moodLogged => 'تم تسجيل المزاج';

  @override
  String get moodDeleted => 'تم حذف المزاج';

  @override
  String get moodCouldNotDelete => 'تعذّر حذف سجل المزاج هذا الآن.';

  @override
  String get moodAddedToMoodLog => 'تمت الإضافة إلى سجل المزاج الخاص بك';

  @override
  String get portionCheckTitle => 'فحص الحصص';

  @override
  String get portionCheckAnalyzingMeal => 'جارٍ تحليل وجبتك…';

  @override
  String get portionCheckCouldNotAnalyzePhoto => 'تعذّر تحليل هذه الصورة';

  @override
  String get portionCheckTakeNewPhoto => 'التقاط صورة جديدة';

  @override
  String get portionCheckSomethingWentWrong => 'حدث خطأ ما.';

  @override
  String get portionCheckYouHitDailyLimit => 'لقد وصلت إلى الحد اليومي';

  @override
  String get portionCheckYouCanEat => 'يمكنك أن تأكل';

  @override
  String get portionCheckYouCanEatUpTo => 'يمكنك أن تأكل حتى';

  @override
  String get portionCheckTryLighterOption =>
      'جرّب خيارًا أخف بدلًا من ذلك أو تخطَّ هذا';

  @override
  String get portionCheckThisEntireMeal => 'هذه الوجبة كاملة';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% من هذه الوجبة';
  }

  @override
  String get portionCheckToStayWithinGoals => 'للبقاء ضمن أهدافك اليومية.';

  @override
  String get portionCheckNutritionBreakdown => 'التوزيع الغذائي';

  @override
  String get portionCheckTipsToBalanceMeal => 'نصائح لموازنة الوجبة';

  @override
  String get portionCheckTipsPool =>
      'كل ببطء — تستغرق إشارات الشبع حوالي 20 دقيقة لتلحق بك.\nاملأ نصف طبقك بالخضروات.\nأضف البروتين إلى كل وجبة.\nاشرب الماء قبل الوجبات.\nقسّم الوجبات الخفيفة مسبقًا في علب صغيرة.\nاجمع الكربوهيدرات مع البروتين أو الدهون لتبقى شبعانًا لفترة أطول.\nاختر الأطعمة الكاملة قدر الإمكان.\nتجنب الأكل أثناء التشتيت بالشاشات.\nلا تتخطَّ الوجبات إذا كان ذلك سيجعلك تأكل أكثر لاحقًا.\nخطط لوجباتك الخفيفة قبل أن تشعر بالجوع.';

  @override
  String get portionCheckRetake => 'إعادة الالتقاط';

  @override
  String get portionCheckLogThisPortion => 'سجّل هذه الحصة';

  @override
  String get portionCheckCarbs => 'كربوهيدرات';

  @override
  String get portionCheckProteins => 'البروتين';

  @override
  String get portionCheckFats => 'دهون';

  @override
  String get portionCheckFiber => 'الألياف';

  @override
  String get mealLogScreenTitle => 'وجبات';

  @override
  String get mealLogEditTitle => 'تعديل الوجبة';

  @override
  String get mealLogLogTitle => 'سجل وجبة';

  @override
  String get mealLogSaving => 'جارٍ الحفظ...';

  @override
  String get mealLogAddMealLog => '+ إضافة وجبة سجل';

  @override
  String get mealLogCouldNotStartRecording => 'تعذّر بدء التسجيل.';

  @override
  String get mealLogRecordingStoppedAtLimit => 'توقّف التسجيل عند 60 ثانية.';

  @override
  String get mealLogCouldNotAnalyzeRecording => 'تعذّر تحليل هذا التسجيل.';

  @override
  String get mealLogCouldNotAnalyzeText => 'تعذّر تحليل هذا النص.';

  @override
  String get mealLogCouldNotAnalyzePhoto => 'تعذّر تحليل هذه الصورة.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'تعذّر معالجة صورة الوجبة هذه الآن.';

  @override
  String get mealLogDiscardTitle => 'تجاهل هذه الوجبة؟';

  @override
  String get mealLogDiscardMessage =>
      'لقد راجعت صورة لكنك لم تحفظ الإدخال، لذلك لن يتم تسجيلها.';

  @override
  String get mealLogDiscard => 'تجاهل';

  @override
  String get mealLogDeleteTitle => 'حذف هذا وجبة سجل?';

  @override
  String get mealLogDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get mealLogDelete => 'حذف';

  @override
  String get mealLogDeleteLog => 'حذف سجل';

  @override
  String get mealLogCouldNotSave => 'تعذّر حفظ سجل الوجبة هذا الآن.';

  @override
  String get mealLogCouldNotDelete => 'تعذّر حذف سجل الوجبة هذا الآن.';

  @override
  String get mealLogAnalyzing => 'جارٍ التحليل...';

  @override
  String get mealLogAnalyzeText => 'تحليل النص';

  @override
  String get mealLogSendRecording => 'إرسالتسجيل';

  @override
  String get mealLogMealDefaultName => 'وجبة';

  @override
  String get mealLogMealNameHint => 'وجبة اسم';

  @override
  String get mealLogCouldNotPrefillTitle => 'تعذّر تعبئة الوجبة مسبقًا';

  @override
  String get mealLogHowMuchDidYouEat => 'كم أكلت؟';

  @override
  String get mealLogNotes => 'ملاحظات';

  @override
  String get mealLogAnythingWorthRemembering =>
      'أي شيء يستحق التذكر عن هذه الوجبة؟';

  @override
  String get mealLogAnalyzingYourMealTitle => 'جارٍ تحليل وجبتك';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'تحويل إدخالك إلى حقول غذائية. يمكنك مراجعة كل شيء قبل الحفظ.';

  @override
  String get mealLogDescribeYourMealTitle => 'صف وجبتك';

  @override
  String get mealLogDescribeYourMealBody =>
      'اكتب ما تناولته وأي كميات تعرفها. سنحوّله إلى حقول غذائية.';

  @override
  String get mealLogDescribeYourMealHint =>
      'مثال: سلطة دجاج مشوي، تتبيلة زيت الزيتون، تفاحة واحدة، ماء فوار';

  @override
  String get mealLogCaptureYourMealTitle => 'التقط وجبتك';

  @override
  String get mealLogCaptureYourMealBody =>
      'التقط صورة وسنقدّر لك الحقول الغذائية.';

  @override
  String get mealLogTakePhoto => 'التقاط صورة';

  @override
  String get mealLogRecordingYourMealTitle => 'جارٍ تسجيل وجبتك';

  @override
  String get mealLogRecordingReadyTitle => 'التسجيل جاهز';

  @override
  String get mealLogRecordMealDescriptionTitle => 'سجّل وصفًا للوجبة';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'اضغط إيقاف عندما تنتهي. تبقّى $remaining ثانية';
  }

  @override
  String get mealLogRecordingReadyBody => '';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'تحدّث بشكل طبيعي عما أكلته وسنحوّله إلى عناصر غذائية.';

  @override
  String get mealLogStopRecording => 'إيقاف التسجيل';

  @override
  String get mealLogRecordAgain => 'سجّل مرة أخرى';

  @override
  String get mealLogStartRecording => 'ابدأ التسجيل';

  @override
  String get mealLogBreakfast => 'إفطار';

  @override
  String get mealLogLunch => 'غداء';

  @override
  String get mealLogSnack => 'وجبة خفيفة';

  @override
  String get mealLogDinner => 'عشاء';

  @override
  String get mealLogKcalUnit => 'سعرة';

  @override
  String get mealLogToday => 'اليوم';

  @override
  String get mealLogYesterday => 'أمس';

  @override
  String mealLogKcal(Object count) {
    return '$count سعرة';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return 'تم تسجيل $count سعرة';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return 'تم تسجيل $amount غ من $macro';
  }

  @override
  String get mealLogDeleted => 'تم حذف الوجبة';

  @override
  String get mealLogAddedToMealLog => 'تمت الإضافة إلى سجل الوجبة';

  @override
  String get mealLogCarbs => 'الكربوهيدرات';

  @override
  String get mealLogProteins => 'البروتين';

  @override
  String get mealLogFats => 'الدهون';

  @override
  String get mealLogFiber => 'الألياف';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageDialogTitle => 'اختر اللغة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsPreferences => 'التفضيلات';

  @override
  String get settingsHealthGoal => 'هدف صحي';

  @override
  String get settingsHealthGoalDialogTitle => 'اختر الهدف الصحي';

  @override
  String get settingsHabitGoals => 'عادة أهداف';

  @override
  String get settingsDisabled => 'معطّل';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count مفعّلة';
  }

  @override
  String get settingsHeight => 'الطول';

  @override
  String get settingsAge => 'العمر';

  @override
  String get settingsGender => 'الجنس';

  @override
  String get settingsMeasurementUnit => 'وحدة القياس';

  @override
  String get settingsReminders => 'تذكيرات';

  @override
  String get settingsDoseReminder => 'الجرعة تذكير';

  @override
  String get settingsSupplementReminder => 'المكمّل تذكير';

  @override
  String get settingsDailyReminders => 'يومي تذكيرات';

  @override
  String get settingsSubscription => 'الاشتراك';

  @override
  String get settingsSupport => 'الدعم';

  @override
  String get settingsSendFeedback => 'إرسال ملاحظات';

  @override
  String get feedbackSheetTitle => 'إرسال الملاحظات';

  @override
  String get feedbackSheetHint => 'أخبرنا برأيك…';

  @override
  String get feedbackSheetSend => 'إرسال';

  @override
  String get feedbackSheetSuccess => 'شكرًا على ملاحظاتك!';

  @override
  String get feedbackSheetError => 'تعذّر الإرسال. يُرجى المحاولة مرة أخرى.';

  @override
  String get settingsTermsOfService => 'شروط الخدمة';

  @override
  String get settingsPrivacyPolicy => 'سياسة الخصوصية';

  @override
  String get settingsInternal => 'داخلي';

  @override
  String get settingsSubscriptionOverride => 'تجاوز الاشتراك';

  @override
  String get settingsTodayInsightCard => 'بطاقة تحليل اليوم';

  @override
  String get settingsResetOnboarding => 'إعادة تعيين الإعداد الأولي';

  @override
  String get settingsResetShowcases => 'إعادة تعيين الشروحات';

  @override
  String get settingsResetUserData => 'إعادة تعيين بيانات المستخدم';

  @override
  String get settingsDeletingAccount => 'جارٍ حذف الحساب...';

  @override
  String get settingsDisconnect => 'فصل';

  @override
  String get settingsDeleteAccount => 'حذف الحساب';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'فصل $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'فصل $provider؟';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'لن تتمكن بعد الآن من تسجيل الدخول باستخدام $provider على هذا الجهاز ما لم تُعد ربطه لاحقًا.';
  }

  @override
  String get settingsDeleteAccountTitle => 'حذف الحساب؟';

  @override
  String get settingsDeleteAccountBody =>
      'سيؤدي هذا إلى حذف حسابك وكل بياناتك نهائيًا. لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get settingsDeleteAccountConfirmHint => 'اكتب حذف للتأكيد';

  @override
  String get settingsDeleteAccountError =>
      'حدث خطأ أثناء حذف حسابك. يرجى التواصل مع support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'أعد تشغيل التطبيق لرؤية الإعداد الأولي';

  @override
  String get settingsShowcasesReset => 'تمت إعادة تعيين الشروحات';

  @override
  String get settingsResetUserDataTitle => 'إعادة تعيين بيانات المستخدم؟';

  @override
  String get settingsResetUserDataBody =>
      'سيؤدي هذا إلى مسح كل السجلات المحفوظة للوجبات والماء والتمرين والوزن والمزاج والأعراض والمكملات والجرعات.';

  @override
  String get settingsUserDataReset => 'تمت إعادة تعيين بيانات المستخدم';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'تم الحفظ، لكن تعذّر جدولة التذكيرات اليومية الآن.';

  @override
  String get settingsSubscriptionOverrideTitle => 'تجاوز الاشتراك';

  @override
  String get settingsSubscriptionOverrideAuto => 'تلقائي';

  @override
  String get settingsSubscriptionOverrideForceFree => 'إجبار مجاني';

  @override
  String get settingsSubscriptionOverrideForcePro => 'فرض برو';

  @override
  String get settingsTodayInsightCardTitle => 'بطاقة تحليل اليوم';

  @override
  String get settingsTodayInsightCardAuto => 'تلقائي';

  @override
  String get settingsTodayInsightCardOn => 'تشغيل';

  @override
  String get settingsTodayInsightCardOff => 'إيقاف';

  @override
  String get settingsYourName => 'تحليلك اسم';

  @override
  String get settingsSignOut => 'تسجيل الخروج';

  @override
  String get settingsHeightCm => 'سم';

  @override
  String get settingsHeightFtIn => 'قدم/بوصة';

  @override
  String get settingsHeightFt => 'قدم';

  @override
  String get settingsHeightIn => 'بوصة';

  @override
  String get settingsGenderMale => 'ذكر';

  @override
  String get settingsGenderFemale => 'أنثى';

  @override
  String get settingsGenderPreferNotToSay => 'أفضل عدم الإجابة';

  @override
  String get settingsGenderOther => 'أخرى';

  @override
  String get settingsYourProfile => 'ملفك الشخصي';

  @override
  String get settingsNotSet => 'غير مضبوط';

  @override
  String settingsYears(Object value) {
    return '$value سنة';
  }

  @override
  String get settingsOff => 'إيقاف';

  @override
  String get settingsOn => 'تشغيل';

  @override
  String get settingsNoneSet => 'لا شيء مضبوط';

  @override
  String settingsSupplementCount(Object count) {
    return '$count مكمّل';
  }

  @override
  String get commonToday => 'اليوم';

  @override
  String get mainShellHome => 'الرئيسية';

  @override
  String get mainShellLog => 'السجل';

  @override
  String get mainShellProgress => 'التقدّم';

  @override
  String get mainShellSettings => 'الإعدادات';

  @override
  String get mainShellLogShowcaseTitle => 'سجّل يوميًا ما يهمك';

  @override
  String get mainShellLogShowcaseDescription =>
      'سجّل الأنشطة التي تهمك أكثر كل يوم.';

  @override
  String get logWaterShowcaseTitle => 'ابدأ بالماء';

  @override
  String get logWaterShowcaseDescription =>
      'سجّل الماء الآن، وواصل تسجيل الباقي أثناء يومك حتى يتمكن Glu من رصد العادات والأنماط بدقة أكبر.';

  @override
  String get mainShellProgressShowcaseTitle => 'شاهد تقدّمك';

  @override
  String get mainShellProgressShowcaseDescription =>
      'تحقق من الاتجاهات والأنماط لتفهم كيف تتغير عاداتك ووزنك مع الوقت.';

  @override
  String get progressMenuShowcaseTitle => 'استكشف بياناتك';

  @override
  String get progressMenuShowcaseDescription =>
      'اعرض جميع المخططات، واقرأ الرؤى التي يولدها الذكاء الاصطناعي، أو أنشئ تقريرًا للطبيب لمشاركته مع فريق الرعاية.';

  @override
  String get settingsFeedbackShowcaseTitle => 'نود سماع ملاحظاتك';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'اضغط هنا لمشاركة ما يعمل جيدًا، وما لا يعمل، أو أي أفكار لديك.';

  @override
  String get authCouldNotOpenLink => 'تعذّر فتح الرابط الآن.';

  @override
  String get authWelcomeTitle => 'مرحبًا بك في Glu';

  @override
  String get authSubtitle => 'تسجيل دخول آمن إلى رفيقك الصحي وتحليلك.';

  @override
  String get authContinueWithGoogle => 'المتابعة مع جوجل';

  @override
  String get authContinueWithApple => 'المتابعة مع آبل';

  @override
  String get authEmailHint => 'البريد الإلكتروني';

  @override
  String get authSending => 'جارٍ الإرسال...';

  @override
  String get authResendLink => 'إعادة إرسالرابط';

  @override
  String get authUseDifferentEmail => 'استخدم بريدًا إلكترونيًا آخر';

  @override
  String get habitGoalsTitle => 'عادة أهداف';

  @override
  String get goalsProteins => 'البروتينات';

  @override
  String get goalsFibers => 'الألياف';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value غ يوميًا';
  }

  @override
  String get goalsWater => 'الماء';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value لتر يوميًا';
  }

  @override
  String get goalsExercise => 'التمرين';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value دقيقة يوميًا';
  }

  @override
  String get goalsMeals => 'الوجبات';

  @override
  String get goalsCalories => 'السعرات';

  @override
  String get goalsKcalUnit => 'سعرة';

  @override
  String get goalsPerWeekSuffix => 'في الأسبوع';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count وجبات يوميًا';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count سعرة يوميًا';
  }

  @override
  String get goalsWeight => 'الوزن';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'أضف وزنًا مسجّلًا لحساب الوتيرة';

  @override
  String get goalsAlreadyAtThisTarget => 'أنت بالفعل عند هذا الهدف';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/أسبوع للوصول إلى الهدف';
  }

  @override
  String get goalsSetTargetForNextWeek => 'حدّد الهدف للأسبوع التالي.';

  @override
  String get progressWeightTitle => 'الوزن';

  @override
  String get progressWeightLabel => 'الوزن';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'مؤشر كتلة الجسم الصحي';

  @override
  String get progressTotal => 'الإجمالي';

  @override
  String get progressPercent => 'النسبة';

  @override
  String get progressWeeklyAvg => 'متوسط أسبوعي';

  @override
  String get progressRangeAllTime => 'كل الوقت';

  @override
  String get progressRange1Month => 'شهر واحد';

  @override
  String get progressRange3Months => '3 أشهر';

  @override
  String get progressRange6Months => '6 أشهر';

  @override
  String get progressLow => 'منخفض';

  @override
  String get progressMed => 'متوسط';

  @override
  String get progressHigh => 'مرتفع';

  @override
  String get progressSeverity => 'الشدّة';

  @override
  String get progressBad => 'سيئ';

  @override
  String get progressOkay => 'حسنًا';

  @override
  String get progressGood => 'جيد';

  @override
  String get progressGreat => 'رائع';

  @override
  String get progressMostlyBad => 'سيئ إلى حد ما';

  @override
  String get progressMostlyOkay => 'مقبول إلى حد ما';

  @override
  String get progressMostlyGood => 'جيد إلى حد ما';

  @override
  String get progressMostlyGreat => 'رائع إلى حد ما';

  @override
  String get progressNoDose => 'لا توجد جرعة';

  @override
  String get progressLogged => 'تم التسجيل';

  @override
  String get progressAllClear => 'كل شيء واضح';

  @override
  String get progressFreq => 'التكرار';

  @override
  String get progressAverage => 'المتوسط';

  @override
  String get progressDaily => 'يومي';

  @override
  String get progressWeekly => 'أسبوعي';

  @override
  String get progressMinutes => 'دقائق';

  @override
  String get progressIntensity => 'الشدّة';

  @override
  String get progressCalories => 'السعرات';

  @override
  String get progressByDose => 'حسب الجرعة';

  @override
  String get progressWeightProgressTitle => 'الوزن تقدّم';

  @override
  String get progressWaterProgressTitle => 'الماء تقدّم';

  @override
  String get progressExerciseProgressTitle => 'تمرين تقدّم';

  @override
  String get progressDoseProgressTitle => 'الجرعة تقدّم';

  @override
  String get progressMealsProgressTitle => 'وجبات تقدّم';

  @override
  String get progressSymptomsProgressTitle => 'تقدّم الأعراض';

  @override
  String get progressMoodProgressTitle => 'تقدّم المزاج';

  @override
  String get progressWeightChangeTitle => 'تغيّر الوزن';

  @override
  String get progressTitle => 'التقدّم';

  @override
  String get progressMenuViewAllInsights => 'عرض كل التحليلات';

  @override
  String get progressMenuViewAllCharts => 'عرض كل الرسوم البيانية';

  @override
  String get progressMenuCreateDoctorReport => 'إنشاء تقرير للطبيب';

  @override
  String get progressReportGenerating => 'جارٍ إنشاء تقريرك…';

  @override
  String get progressReportError =>
      'تعذّر إنشاء التقرير. يُرجى المحاولة مرة أخرى.';

  @override
  String get progressReportPendingRetry =>
      'قد يكتمل تقريرك بعد لحظات. يرجى المحاولة مرة أخرى.';

  @override
  String get progressReportOpenError =>
      'تم إنشاء تقريرك، لكننا لم نتمكن من فتحه. يرجى المحاولة مرة أخرى.';

  @override
  String get progressReportOpenedInBrowser =>
      'التقرير جاهز. تم فتحه في المتصفح.';

  @override
  String get progressReportCopiedLink =>
      'التقرير جاهز. لم تكن المشاركة متاحة، لذا تم نسخ الرابط إلى الحافظة.';

  @override
  String get progressAllProgressTitle => 'كل التقدّم';

  @override
  String get progressWeightTrendExplanation => 'شاهد كيف يتغير وزنك مع الوقت.';

  @override
  String get progressNoWeightLogsYet => 'لا توجد سجلات وزن بعد';

  @override
  String get progressNoLogsYet => 'لا توجد سجلات بعد';

  @override
  String get progressLogWeightToStartTrend => 'سجّل الوزن لبدء تتبّع الاتجاه.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'سجّل الوزن والجرعة لمقارنة كيف يرتبط التغيير بالجرعة.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'كل نقطة ملوّنة حسب آخر جرعة استُخدمت قبل ذلك الوزن.';

  @override
  String get progressNoHydrationYet => 'لا توجد سجلات ترطيب بعد';

  @override
  String get progressNoMovementYet => 'لا توجد حركة بعد';

  @override
  String get progressNoDoseLogsYet => 'لا توجد سجلات جرعات بعد';

  @override
  String get progressNoMealsLoggedYet => 'لا توجد وجبات مسجلة بعد';

  @override
  String get progressNoSymptomsLoggedYet => 'لا توجد أعراض مسجلة بعد';

  @override
  String get progressNoMoodLogsYet => 'لا توجد سجلات مزاج بعد';

  @override
  String get progressFutureTrendTitle => 'الاتجاه المستقبلي';

  @override
  String get progressFutureTrendBody => 'خط زمني جميل لزخمك';

  @override
  String get progressGoal => 'هدف';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'آخر وزن مسجّل جاهز للتتبّع.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'حوالي $gap $unit بعيدًا عن هدفك.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText مقارنة بالسجل السابق.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText مقارنة بالسجل السابق. تبقّى $gap $unit عن الهدف.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'بالمقارنة مع السجل السابق، أصبح الاتجاه واضحًا الآن.';

  @override
  String get progressWaterTitle => 'الماء';

  @override
  String get manageSubscriptionTitle => 'إدارة الاشتراك';

  @override
  String get manageSubscriptionProPlan => 'خطة برو';

  @override
  String get manageSubscriptionFreePlan => 'الخطة المجانية';

  @override
  String get manageSubscriptionActiveCopy => 'اشتراكك نشط.';

  @override
  String get manageSubscriptionUpgradeCopy => 'قم بالترقية لفتح Glu برو.';

  @override
  String get manageSubscriptionPlan => 'الخطة';

  @override
  String get manageSubscriptionPro => 'برو';

  @override
  String get manageSubscriptionFree => 'مجاني';

  @override
  String get manageSubscriptionProduct => 'المنتج';

  @override
  String get manageSubscriptionRenewal => 'التجديد';

  @override
  String get manageSubscriptionStatus => 'الحالة';

  @override
  String get manageSubscriptionStatusActive => 'نشط';

  @override
  String get manageSubscriptionStatusInactive => 'غير نشط';

  @override
  String get manageSubscriptionManageButton => 'إدارة الاشتراك';

  @override
  String get manageSubscriptionUpgradeButton => 'الترقية إلى برو';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'فتح إعدادات الاشتراك في المتجر';

  @override
  String get manageSubscriptionProBadge => 'برو';

  @override
  String get manageSubscriptionRestorePurchases => 'استعادة المشتريات';

  @override
  String get manageSubscriptionRenewsAutomatically => 'يتجدد تلقائيًا';

  @override
  String get manageSubscriptionLifetime => 'مدى الحياة';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'يتجدد في $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'ينتهي في $date';
  }

  @override
  String get supplementReminderDayMon => 'الاثنين';

  @override
  String get supplementReminderDayTue => 'الثلاثاء';

  @override
  String get supplementReminderDayWed => 'الأربعاء';

  @override
  String get supplementReminderDayThu => 'الخميس';

  @override
  String get supplementReminderDayFri => 'الجمعة';

  @override
  String get supplementReminderDaySat => 'السبت';

  @override
  String get supplementReminderDaySun => 'الأحد';

  @override
  String supplementReminderInDays(Object count) {
    return 'خلال $count يومًا';
  }

  @override
  String get supplementReminderInOneWeek => 'خلال أسبوع واحد';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'خلال $count أسابيع';
  }

  @override
  String get subscriptionDebugTitle => 'تصحيح اشتراكات Glu';

  @override
  String get subscriptionDebugMonthly => 'شهري';

  @override
  String get subscriptionDebugYearly => 'سنوي';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'تحديث معلومات العميل';

  @override
  String get subscriptionDebugPresentPaywall => 'عرض صفحة الدفع';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'فتح مركز العملاء';

  @override
  String get subscriptionDebugRestorePurchases => 'استعادة المشتريات';

  @override
  String get subscriptionDebugSyncPurchases => 'مزامنة المشتريات';

  @override
  String get subscriptionDebugRevenuecatStatus => 'حالة ريفينيو كات';

  @override
  String get subscriptionDebugConfigured => 'مهيأ';

  @override
  String get subscriptionDebugBusy => 'مشغول';

  @override
  String get subscriptionDebugAppUserId => 'معرّف مستخدم التطبيق';

  @override
  String get subscriptionDebugAnonymous => 'مجهول';

  @override
  String get subscriptionDebugApiKeyAvailable =>
      'مفتاح واجهة برمجة التطبيقات متاح';

  @override
  String get subscriptionDebugGluProActive => 'Glu برو نشط';

  @override
  String get subscriptionDebugActiveSubscriptions => 'الاشتراكات النشطة';

  @override
  String get subscriptionDebugManagementUrl => 'رابط الإدارة';

  @override
  String get subscriptionDebugEntitlementProduct => 'منتج الاستحقاق';

  @override
  String get subscriptionDebugWillRenew => 'سيتجدد';

  @override
  String get subscriptionDebugExpiration => 'الانتهاء';

  @override
  String get subscriptionDebugLifetime => 'مدى الحياة';

  @override
  String get subscriptionDebugPackageFound => 'تم العثور على الحزمة';

  @override
  String get subscriptionDebugProductId => 'معرّف المنتج';

  @override
  String get subscriptionDebugTitleLabel => 'العنوان';

  @override
  String get subscriptionDebugPrice => 'السعر';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'شراء $title';
  }

  @override
  String get progressExerciseTitle => 'التمرين';

  @override
  String get progressDoseTitle => 'الجرعة';

  @override
  String get progressMealsTitle => 'وجبات';

  @override
  String get progressSymptomsTitle => 'الأعراض';

  @override
  String get progressMoodTitle => 'المزاج';

  @override
  String get progressTrend => 'الاتجاه';

  @override
  String get progressTarget => 'الهدف';

  @override
  String get progressNoTrendYet => 'لا يوجد اتجاه بعد';

  @override
  String get progressNoActivityYet => 'لا توجد أنشطة بعد';

  @override
  String get progressNoCheckInsYet => 'لا توجد تسجيلات متابعة بعد';

  @override
  String get progressWeightSignatureChip => 'سيصبح الوزن مخططك التحليلي المميز';

  @override
  String get progressWeightStartTrendTitle =>
      'ابدأ اتجاه تحليلك مع أول قياس وزن';

  @override
  String get progressWeightStartTrendBody =>
      'هذا الرسم هو محور قصة تقدّمك. سجّل وزنك الأول لفتح الزخم والمحطات والتحليلات الجديرة بالمشاركة.';

  @override
  String get progressWeightMomentum => 'زخم الوزن';

  @override
  String get progressWeightMilestones => 'محطات';

  @override
  String get progressWeightShareReady => 'جاهز للمشاركة';

  @override
  String get progressWeightLogWeight => 'سجل الوزن';

  @override
  String get weightProgressUnlocksViewChip =>
      'يفتح أول قياس وزن لديك هذا العرض';

  @override
  String get weightProgressStartsHereTitle => 'تبدأ قصة تقدّمك هنا';

  @override
  String get weightProgressStartsHereBody =>
      'سجّل وزنك الأول لفتح الاتجاهات والمحطات والتحليلات المرتبطة بالجرعة في عرض يستحق المشاركة.';

  @override
  String get weightProgressTrendView => 'اتجاه عرض';

  @override
  String get weightProgressDoseOverlays => 'تراكبات الجرعة';

  @override
  String get weightProgressMilestones => 'محطات';

  @override
  String get weightProgressLogWeight => 'سجل الوزن';

  @override
  String get glowUpAddBeforeAndAfterFirst => 'أضف صورة قبل وبعد أولًا.';

  @override
  String get glowUpSavedToGallery => 'تم الحفظ في معرض الصور الخاص بك';

  @override
  String get glowUpSaveToGallery => 'حفظ في المعرض';

  @override
  String get glowUpYourProgress => 'تحليلك تقدّم';

  @override
  String get glowUpWeightChange => 'تغيّر الوزن';

  @override
  String get glowUpTime => 'الوقت';

  @override
  String get glowUpShare => 'مشاركة';

  @override
  String get glowUpBefore => 'قبل';

  @override
  String get glowUpAfter => 'بعد';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight خلال $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'أيام';

  @override
  String get glowUpTimeUnitWeeksLabel => 'أسابيع';

  @override
  String get glowUpTimeUnitMonthsLabel => 'أشهر';

  @override
  String get glowUpTimeUnitYearsLabel => 'سنوات';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم',
      many: '$count يومًا',
      few: '$count أيام',
      two: 'يومان',
      one: 'يوم واحد',
      zero: '$count يوم',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count أسبوع',
      many: '$count أسبوعًا',
      few: '$count أسابيع',
      two: 'أسبوعان',
      one: 'أسبوع واحد',
      zero: '$count أسبوع',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شهر',
      many: '$count شهرًا',
      few: '$count أشهر',
      two: 'شهران',
      one: 'شهر واحد',
      zero: '$count شهر',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سنة',
      many: '$count سنة',
      few: '$count سنوات',
      two: 'سنتان',
      one: 'سنة واحدة',
      zero: '$count سنة',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'أمس';

  @override
  String get commonSelect => 'اختيار';

  @override
  String get doseReminderTitle => 'الجرعة تذكير';

  @override
  String get doseReminderCustomDoseTitle => 'جرعة مخصصة';

  @override
  String get doseReminderCustomDoseHint => 'اكتب الجرعة بالملغ';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'حافظ على الجرعة التالية جاهزة على الرئيسية.';

  @override
  String get doseReminderTime => 'الوقت';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'فعّل هذا لإظهار الجرعة التالية في الرئيسية.';

  @override
  String get doseReminderSaveReminder => 'حفظ تذكير';

  @override
  String loggedOn(Object date) {
    return 'تم التسجيل في $date';
  }

  @override
  String get waterLogSmallGlass => 'كوب صغير';

  @override
  String get waterLogGlass => 'كوب';

  @override
  String get waterLogBottle => 'زجاجة';

  @override
  String get waterLogLargeBottle => 'زجاجة كبيرة';

  @override
  String get waterLogTwoLiters => '2 لتر';

  @override
  String get waterLogCustomPreset => 'مخصص';

  @override
  String get waterLogMlUnit => 'مل';

  @override
  String get waterLogOzUnit => 'أوقية';

  @override
  String get doseLogTitle => 'الجرعة';

  @override
  String get doseLogEditTitle => 'تعديل الجرعة';

  @override
  String get doseLogLogTitle => 'سجل الجرعة';

  @override
  String get doseLogCustomDose => 'جرعة مخصصة';

  @override
  String get doseLogCustomDoseBody => 'عدّل الجرعة بالملغ لهذا السجل.';

  @override
  String get doseLogUseThisDose => 'استخدم هذه الجرعة';

  @override
  String get doseLogMedication => 'الدواء';

  @override
  String get doseLogInjectionSite => 'موقع الحقن';

  @override
  String get doseLogNotes => 'ملاحظات';

  @override
  String get doseLogSaveChanges => 'حفظ التغييرات';

  @override
  String get doseLogAddDose => '+ سجل الجرعة';

  @override
  String get doseLogDeleteTitle => 'حذف هذا الجرعة سجل?';

  @override
  String get doseLogDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get doseLogDeleteLog => 'حذف سجل';

  @override
  String get doseLogSaving => 'جارٍ الحفظ...';

  @override
  String get doseLogCouldNotSave => 'تعذّر حفظ سجل الجرعة هذا الآن.';

  @override
  String get doseLogCouldNotDelete => 'تعذّر حذف سجل الجرعة هذا الآن.';

  @override
  String get doseLogDeleted => 'تم حذف الجرعة';

  @override
  String get doseLogAddedToDoseLog => 'تمت الإضافة إلى سجل الجرعة';

  @override
  String get doseLogAnythingWorthRemembering =>
      'هل هناك شيء يستحق التذكر بخصوص هذه الجرعة؟';

  @override
  String get doseLogDoseLabel => 'الجرعة';

  @override
  String get exerciseLogTitle => 'التمرين';

  @override
  String get exerciseLogEditTitle => 'تعديل التمرين';

  @override
  String get exerciseLogLogTitle => 'سجل التمرين';

  @override
  String get exerciseLogActivityType => 'نوع النشاط';

  @override
  String get exerciseLogCustomActivity => 'نشاط مخصص';

  @override
  String get exerciseLogTypeActivity => 'نوع النشاط';

  @override
  String get exerciseLogDuration => 'المدة';

  @override
  String get exerciseLogIntensity => 'الشدّة';

  @override
  String get exerciseLogNotes => 'ملاحظات';

  @override
  String get exerciseLogLight => 'خفيف';

  @override
  String get exerciseLogModerate => 'متوسط';

  @override
  String get exerciseLogIntense => 'شديد';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return 'تم تسجيل $minutes دقيقة';
  }

  @override
  String get exerciseLogSaveChanges => 'حفظ التغييرات';

  @override
  String get exerciseLogAddExercise => '+ إضافة سجل تمرين';

  @override
  String get exerciseLogDeleteTitle => 'حذف سجل التمرين هذا؟';

  @override
  String get exerciseLogDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get exerciseLogDeleteLog => 'حذف سجل';

  @override
  String get exerciseLogSaving => 'جارٍ الحفظ...';

  @override
  String get exerciseLogCouldNotSave => 'تعذّر حفظ سجل التمرين هذا الآن.';

  @override
  String get exerciseLogCouldNotDelete => 'تعذّر حذف سجل التمرين هذا الآن.';

  @override
  String get exerciseLogDeleted => 'تم حذف النشاط';

  @override
  String get exerciseLogAddedToExerciseLog => 'تمت الإضافة إلى سجل التمرين';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'هل هناك شيء يستحق التذكر في هذه الجلسة؟';

  @override
  String get exerciseLogWalking => 'المشي';

  @override
  String get exerciseLogRunning => 'الجري';

  @override
  String get exerciseLogCycling => 'الدراجات';

  @override
  String get exerciseLogStrength => 'القوة';

  @override
  String get exerciseLogYoga => 'يوغا';

  @override
  String get exerciseLogSwim => 'السباحة';

  @override
  String get exerciseLogHiit => 'تمارين عالية الشدة';

  @override
  String get weightLogTitle => 'الوزن';

  @override
  String get weightLogEditTitle => 'تعديل الوزن';

  @override
  String get weightLogLogTitle => 'سجل الوزن';

  @override
  String get weightLogSaveChanges => 'حفظ التغييرات';

  @override
  String weightLogAddWeight(Object label) {
    return '+ إضافة الوزن ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'حذف هذا الوزن سجل?';

  @override
  String get weightLogDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get weightLogDeleteLog => 'حذف سجل';

  @override
  String get weightLogSaving => 'جارٍ الحفظ...';

  @override
  String get weightLogCouldNotSave => 'تعذّر حفظ سجل الوزن هذا الآن.';

  @override
  String get weightLogCouldNotDelete => 'تعذّر حذف سجل الوزن هذا الآن.';

  @override
  String get weightLogDeleted => 'تم حذف الوزن';

  @override
  String get weightLogAddedToWeightLog => 'تمت الإضافة إلى سجل الوزن';

  @override
  String get weightLogNoWeightForDay => 'لم يتم تسجيل وزن لهذا اليوم بعد.';

  @override
  String get injectionSiteAbdomen => 'البطن';

  @override
  String get injectionSiteThigh => 'الفخذ';

  @override
  String get injectionSiteUpperArm => 'العضد';

  @override
  String get injectionSiteButtocks => 'الأرداف';

  @override
  String get injectionSiteAbdomenUpperLeft => 'أعلى يسار البطن';

  @override
  String get injectionSiteAbdomenUpperRight => 'أعلى يمين البطن';

  @override
  String get injectionSiteAbdomenLowerRight => 'أسفل يمين البطن';

  @override
  String get injectionSiteAbdomenLowerLeft => 'أسفل يسار البطن';

  @override
  String get injectionSiteThighUpperLeft => 'أعلى يسار الفخذ';

  @override
  String get injectionSiteThighUpperRight => 'أعلى يمين الفخذ';

  @override
  String get injectionSiteThighLowerRight => 'أسفل يمين الفخذ';

  @override
  String get injectionSiteThighLowerLeft => 'أسفل يسار الفخذ';

  @override
  String get injectionSiteUpperArmLeft => 'العضد الأيسر';

  @override
  String get injectionSiteUpperArmRight => 'العضد الأيمن';

  @override
  String get injectionSiteButtocksUpperLeft => 'أعلى يسار الأرداف';

  @override
  String get injectionSiteButtocksUpperRight => 'أعلى يمين الأرداف';

  @override
  String get doseReminderFormat => 'الصيغة';

  @override
  String get doseReminderInjection => 'حقن';

  @override
  String get doseReminderPill => 'حبوب';

  @override
  String get doseReminderSite => 'الموقع';

  @override
  String get doseReminderDate => 'التاريخ';

  @override
  String get supplementReminderTitle => 'حان وقت المكمل';

  @override
  String get supplementReminderAddSupplement => 'إضافة المكمّل';

  @override
  String get supplementReminderNoSupplementsYet => 'لا توجد مكملات بعد';

  @override
  String get supplementReminderAddFirstBody =>
      'أضف أول تذكير للمكملات لتتبّع تناولك اليومي.';

  @override
  String get supplementReminderSupplementFallback => 'المكمّل';

  @override
  String get supplementReminderEveryDay => 'كل يوم';

  @override
  String get supplementReminderEveryXDaysLabel => 'كل X أيام';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'كل $interval أيام';
  }

  @override
  String get supplementReminderNoDaysSet => 'لم يتم تحديد أيام';

  @override
  String get supplementReminderSupplementName => 'اسم المكمل';

  @override
  String get supplementReminderTime => 'الوقت';

  @override
  String get supplementReminderStartDate => 'تاريخ البدء';

  @override
  String get supplementReminderRepeat => 'تكرار';

  @override
  String get supplementReminderDaysOfWeek => 'أيام الأسبوع';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'اختر يومًا واحدًا على الأقل.';

  @override
  String get supplementReminderEvery => 'كل';

  @override
  String get supplementReminderDay => 'يوم';

  @override
  String get supplementReminderDays => 'أيام';

  @override
  String get supplementReminderAdd => 'إضافة';

  @override
  String get symptomsLogTitle => 'الأعراض';

  @override
  String get symptomsLogEditTitle => 'تعديل الأعراض';

  @override
  String get symptomsLogLogTitle => 'سجل الأعراض';

  @override
  String get symptomsLogSymptomsExperienced => 'الأعراض التي شعرت بها';

  @override
  String get symptomsLogNoSymptoms => 'لا توجد أعراض';

  @override
  String get symptomsLogNoSymptomsToday => 'لا توجد أعراض اليوم';

  @override
  String get symptomsLogOther => 'أخرى...';

  @override
  String get symptomsLogSeverityLevel => 'مستوى الشدّة';

  @override
  String get symptomsLogNotes => 'ملاحظات';

  @override
  String get symptomsLogAnxiety => 'قلق';

  @override
  String get symptomsLogBelching => 'تجشؤ';

  @override
  String get symptomsLogBloating => 'انتفاخ';

  @override
  String get symptomsLogConstipation => 'إمساك';

  @override
  String get symptomsLogDiarrhea => 'إسهال';

  @override
  String get symptomsLogFatigue => 'إرهاق';

  @override
  String get symptomsLogFoodNoise => 'ضجيج الطعام';

  @override
  String get symptomsLogHairLoss => 'تساقط الشعر';

  @override
  String get symptomsLogHeartburn => 'حرقة المعدة';

  @override
  String get symptomsLogIndigestion => 'عسر الهضم';

  @override
  String get symptomsLogInjectionSiteReaction => 'رد فعل في موقع الحقن';

  @override
  String get symptomsLogMetallicTaste => 'طعم معدني';

  @override
  String get symptomsLogHeadache => 'صداع';

  @override
  String get symptomsLogMoodSwings => 'تقلّبات المزاج';

  @override
  String get symptomsLogNausea => 'غثيان';

  @override
  String get symptomsLogReflux => 'ارتجاع';

  @override
  String get symptomsLogStomachPain => 'ألم في المعدة';

  @override
  String get symptomsLogSuppressedAppetite => 'انخفاض الشهية';

  @override
  String get symptomsLogVomiting => 'قيء';

  @override
  String get symptomsLogLogged => 'تم تسجيل العرض';

  @override
  String get symptomsLogMild => 'خفيف';

  @override
  String get symptomsLogModerate => 'متوسط';

  @override
  String get symptomsLogSevere => 'شديد';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'هل هناك شيء يستحق التذكّر عن شعورك؟';

  @override
  String get symptomsLogSaveChanges => 'حفظ التغييرات';

  @override
  String get symptomsLogAddSymptoms => '+ إضافة سجل أعراض';

  @override
  String get symptomsLogDeleteTitle => 'حذف سجل الأعراض هذا؟';

  @override
  String get symptomsLogDeleteMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get symptomsLogDeleteLog => 'حذف سجل';

  @override
  String get symptomsLogSaving => 'جارٍ الحفظ...';

  @override
  String get symptomsLogCouldNotSave => 'تعذّر حفظ سجل الأعراض هذا الآن.';

  @override
  String get symptomsLogCouldNotDelete => 'تعذّر حذف سجل الأعراض هذا الآن.';

  @override
  String get symptomsLogDeleted => 'تم حذف العرض';

  @override
  String get symptomsLogAddedToSymptomsLog => 'تمت الإضافة إلى سجل الأعراض';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% من الهدف اليومي';
  }

  @override
  String get commonDisclaimer =>
      'Glu أداة تتبّع وليست جهازًا طبيًا. لا يقدّم نصائح طبية أو تشخيصًا أو علاجًا. استشر دائمًا مقدم الرعاية الصحية بشأن دوائك وقراراتك الصحية.';
}
