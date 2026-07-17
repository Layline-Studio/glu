// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'जाग रहे हैं...';

  @override
  String get startupFailed => 'शुरूआत विफल रही';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonSave => 'सहेजें';

  @override
  String get commonSaving => 'सहेजा जा रहा है...';

  @override
  String get commonContinue => 'जारी रखें';

  @override
  String get commonSkip => 'छोड़ें';

  @override
  String get commonDelete => 'हटाएँ';

  @override
  String get commonNotNow => 'अभी नहीं';

  @override
  String get commonNow => 'अभी';

  @override
  String get commonTomorrow => 'कल';

  @override
  String get noteTriggerAddNote => 'नोट जोड़ें';

  @override
  String get noteTriggerCancelNote => 'नोट रद्द करें';

  @override
  String homeDoseReminderInDays(Object count) {
    return '$count दिनों में';
  }

  @override
  String get homeDoseReminderInOneWeek => '1 सप्ताह में';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return '$count सप्ताह में';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => '1 दिन पहले देय';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return '$count दिन पहले देय';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => '1 सप्ताह पहले देय';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return '$count सप्ताह पहले देय';
  }

  @override
  String get bmiIndicatorYourBmi => 'आपका BMI';

  @override
  String get bmiIndicatorCurrentBmi => 'आपका वर्तमान BMI';

  @override
  String get bmiIndicatorUnderweight => 'कम वजन';

  @override
  String get bmiIndicatorNormal => 'सामान्य';

  @override
  String get bmiIndicatorOverweight => 'अधिक वजन';

  @override
  String get bmiIndicatorObesity => 'मोटापा';

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
  String get logNoteIndicatorHasNote => 'नोट मौजूद है';

  @override
  String get paywallTitle => 'Glu Pro अनलॉक करें';

  @override
  String get paywallSubtitle => 'बिना Pro के, आप यह खो देंगे:';

  @override
  String get paywallMonthlyTitle => 'मासिक';

  @override
  String get paywallMonthlySubtitle => 'कोई ट्रायल नहीं';

  @override
  String get paywallYearlyTitle => 'वार्षिक';

  @override
  String get paywallYearlySubtitle => '7 दिन का मुफ्त ट्रायल';

  @override
  String get paywallNoCommitment => 'कोई बाध्यता नहीं';

  @override
  String get paywallCancelAnytime => 'कभी भी रद्द करें';

  @override
  String get paywallContinue => 'जारी रखें';

  @override
  String get paywallRestore => 'पुनर्स्थापित करें';

  @override
  String get paywallTerms => 'नियम';

  @override
  String get paywallPrivacy => 'गोपनीयता';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'सहेजें $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'लिंक अभी नहीं खोला जा सका।';

  @override
  String get paywallAlreadySubscribed => 'आपके पास पहले से ही Glu Pro है।';

  @override
  String get paywallPurchaseSuccess => 'Glu Pro में आपका स्वागत है!';

  @override
  String get paywallPurchaseIncomplete =>
      'खरीद पूरी नहीं हुई। कृपया फिर से कोशिश करें।';

  @override
  String get paywallPurchaseFailed => 'खरीद विफल रही। कृपया फिर से कोशिश करें।';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'खरीद विफल रही: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'सदस्यता पुनर्स्थापित हो गई!';

  @override
  String get paywallRestoreNoSubscription => 'कोई सक्रिय सदस्यता नहीं मिली।';

  @override
  String get paywallRestoreFailed =>
      'पुनर्स्थापना विफल रही। कृपया फिर से कोशिश करें।';

  @override
  String get paywallBenefitReminders => 'रिमाइंडर बिना खुराकें छूटेंगी';

  @override
  String get paywallBenefitShareProgress => 'प्रगति साझा करना मुश्किल होगा';

  @override
  String get paywallBenefitSpotRegain => 'वजन वापसी के संकेत छूट जाएंगे';

  @override
  String get paywallBenefitInsights => 'आपके रोज़ के पैटर्न छूट जाएंगे';

  @override
  String get paywallBenefitWeeklyGoals => 'साप्ताहिक ढांचा खो देंगे';

  @override
  String get paywallBenefitHealthyHabits => 'बिना सहारे आदतें ढीली पड़ेंगी';

  @override
  String get onboardingWelcomeTitle => 'वजन को बनाए रखें';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu आपकी देखभाल, लक्ष्यों और साप्ताहिक आदतों के आसपास आपकी प्रगति की रक्षा करने में मदद करता है।';

  @override
  String get onboardingWelcomeBullet1 => 'आपकी देखभाल और लक्ष्यों के अनुकूल';

  @override
  String get onboardingWelcomeBullet2 => 'सरल और यथार्थवादी सहायता';

  @override
  String get onboardingWelcomeBullet3 =>
      'वजन वापस बढ़ने के शुरुआती संकेतों को आसानी से पहचानें';

  @override
  String get onboardingWelcomeBullet4 => 'फिर से शुरू किए बिना आगे बढ़ते रहें';

  @override
  String get onboardingMedicationStatusQuestion =>
      'क्या आप अभी वजन कम करने वाली पेन या गोली की दवा ले रहे हैं?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'हम इसका उपयोग आपको आपकी वर्तमान स्थिति के अनुरूप मार्गदर्शन दिखाने के लिए करते हैं।';

  @override
  String get onboardingMedicationStatusUsing =>
      'हाँ, मैं अभी इसे ले रहा/रही हूँ';

  @override
  String get onboardingMedicationStatusWeaningOff =>
      'हाँ, मैं इसे धीरे-धीरे बंद कर रहा/रही हूँ';

  @override
  String get onboardingMedicationStatusNotTaking =>
      'नहीं, मैं इसे नहीं ले रहा/रही हूँ';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'नहीं, मैं जल्द शुरू करूँगा/करूँगी';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'नहीं, मैंने अभी हाल ही में बंद किया है';

  @override
  String get onboardingMedicationMethodQuestion => 'आप अपनी दवा कैसे लेते हैं?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'हम इसका उपयोग आपकी दवा के रूप के अनुसार निर्देश और रिमाइंडर ढालने के लिए करते हैं।';

  @override
  String get onboardingMedicationMethodInjection => 'इंजेक्शन';

  @override
  String get onboardingMedicationMethodPill => 'गोली';

  @override
  String get onboardingMedicationMethodUnknown => 'मुझे अभी नहीं पता';

  @override
  String get onboardingMedicationNameQuestion => 'आप कौन-सी दवा ले रहे हैं?';

  @override
  String get onboardingMedicationNameExplainer =>
      'हम इसका उपयोग खुराक ट्रैकिंग और दवा-विशेष मार्गदर्शन को व्यक्तिगत बनाने के लिए करते हैं।';

  @override
  String get onboardingCurrentDoseQuestion => 'आपकी वर्तमान खुराक क्या है?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'हम इसका उपयोग खुराक ट्रैकिंग और आगे की प्रगति जाँच को ढालने के लिए करते हैं।';

  @override
  String get onboardingMedicationCustomDose => 'कस्टम';

  @override
  String get onboardingDeviceTypeQuestion =>
      'दवा लेने के लिए आप कौन-सा उपकरण उपयोग करते हैं?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'हम इसका उपयोग रिमाइंडर और सुझावों को आपके तरीके से मिलाने के लिए करते हैं।';

  @override
  String get onboardingDeviceSinglePen => 'एकल पेन';

  @override
  String get onboardingDeviceAutoInjector => 'ऑटो-इंजेक्टर';

  @override
  String get onboardingDeviceSyringeAndVial => 'सीरिंज और शीशी';

  @override
  String get onboardingOther => 'अन्य';

  @override
  String get onboardingTypeYourDevice => 'अपना उपकरण लिखें';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'आप अपनी दवा कितनी बार लेते हैं?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'हम इसका उपयोग रिमाइंडर और रूटीन सहायता को आपके शेड्यूल के अनुसार समय देने के लिए करते हैं।';

  @override
  String get onboardingEveryDay => 'हर दिन';

  @override
  String get onboardingEvery7Days => 'हर 7 दिन';

  @override
  String get onboardingEvery14Days => 'हर 14 दिन';

  @override
  String get onboardingCustom => 'कस्टम';

  @override
  String get onboardingDaysBetweenDoses => 'खुराकों के बीच दिन';

  @override
  String get onboardingPrimaryGoalQuestion => 'अभी आपका मुख्य लक्ष्य क्या है?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'हम इसका उपयोग आपकी योजना, रिमाइंडर और प्रगति को उस पर केंद्रित करने के लिए करते हैं जो आपके लिए सबसे महत्वपूर्ण है।';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'हम इसका उपयोग आपकी योजना को बिल्कुल शुरुआत से बनाने के लिए करते हैं।';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'हम इसका उपयोग आपके अगले चरण को सपोर्ट करने और आपको सही रास्ते पर रखने के लिए करते हैं।';

  @override
  String get onboardingGoalLoseWeight => 'वजन कम करें';

  @override
  String get onboardingGoalMaintainWeight => 'मेरा वजन बनाए रखें';

  @override
  String get onboardingGoalManageDiabetes => 'मेरी डायबिटीज़ को मैनेज करें';

  @override
  String get onboardingGoalManagePcos =>
      'पॉलीसिस्टिक ओवरी सिंड्रोम (PCOS) को मैनेज करें';

  @override
  String get onboardingGoalImproveHeartHealth =>
      'मेरे हृदय स्वास्थ्य में सुधार करें';

  @override
  String get onboardingAgeQuestion => 'आपकी आयु क्या है?';

  @override
  String get onboardingAgeExplainer =>
      'हम इसका उपयोग मार्गदर्शन और स्वास्थ्य गणनाओं को अधिक उपयुक्त बनाने के लिए करते हैं।';

  @override
  String get onboardingHeightQuestion => 'आपकी लंबाई क्या है?';

  @override
  String get onboardingHeightExplainer =>
      'हम इसका उपयोग आपके वजन के साथ मिलकर BMI और स्वस्थ रेंज की गणना के लिए करते हैं।';

  @override
  String get onboardingWeightQuestion => 'आपका वर्तमान वजन क्या है?';

  @override
  String get onboardingWeightExplainer =>
      'हम इसका उपयोग प्रगति, लक्ष्यों और स्वास्थ्य अनुमानों के लिए शुरुआती बिंदु के रूप में करते हैं।';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'आपने दवा कब बंद की?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'आपने दवा धीरे-धीरे कब बंद करना शुरू किया?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'आपने दवा कब शुरू की?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'हम इसका उपयोग आपके हाल के उपचार इतिहास और अगले चरण को समझने के लिए करते हैं।';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'हम इसका उपयोग आपके संक्रमण चरण को समझने और अभी महत्वपूर्ण आदतों का समर्थन करने के लिए करते हैं।';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'हम इसका उपयोग यह समझने के लिए करते हैं कि आप उपचार पर कितने समय से हैं और समय के साथ बदलाव को ट्रैक करने के लिए।';

  @override
  String get onboardingGoalWeightQuestion => 'आपका लक्ष्य वजन क्या है?';

  @override
  String get onboardingGoalWeightExplainer =>
      'हम इसका उपयोग आपकी प्रगति को फ्रेम करने और आपको लक्ष्य BMI रेंज दिखाने के लिए करते हैं।';

  @override
  String get onboardingBenefitsQuestion =>
      'Glu आपको आगे क्या करने में मदद करेगा';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu आपकी साझा की गई जानकारी को ऐसे रिमाइंडर, सपोर्ट और संरचना में बदलता है जो आपकी दिनचर्या के अनुकूल हों।';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'यहाँ बताया गया है कि Glu आपको अपनी प्रगति बनाए रखने में कैसे मदद कर सकता है';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'यहाँ बताया गया है कि Glu आपकी डायबिटीज़ दिनचर्या को कैसे सपोर्ट कर सकता है';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'यहाँ बताया गया है कि Glu आपके पॉलीसिस्टिक ओवरी सिंड्रोम (PCOS) रूटीन को कैसे सपोर्ट कर सकता है';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'यहाँ बताया गया है कि Glu आपके हृदय स्वास्थ्य को कैसे सपोर्ट कर सकता है';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'यहाँ बताया गया है कि Glu आपको वजन कम करने में कैसे मदद कर सकता है';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'देखें कि Glu आपके वर्तमान वजन की रक्षा करने और वजन वापस बढ़ने को जल्दी पकड़ने में कैसे मदद करता है।';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'देखें कि Glu भोजन, वजन और दिनचर्या को सप्ताह-दर-सप्ताह अधिक स्थिर रखने में कैसे मदद करता है।';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'देखें कि Glu लक्षणों, वजन और दिनचर्या के आसपास आपको अधिक स्थिर रखने में कैसे मदद करता है।';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'देखें कि Glu आपके हृदय स्वास्थ्य को सपोर्ट करने वाली आदतों के साथ आपको लगातार बने रहने में कैसे मदद करता है।';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'देखें कि Glu वजन कम रखने वाली पैटर्न्स को पहचानने में कैसे मदद करता है।';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'संरचना के बिना, वजन वापस बढ़ना चुपचाप हो सकता है। Glu आपको इसे पहले पकड़ने और स्थिर रहने में मदद करता है।';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'संरचना के बिना, भोजन और वजन के पैटर्न धुंधले हो जाते हैं। Glu संकेतों को स्पष्ट रखता है।';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'संरचना के बिना, लक्षण और दिनचर्याएँ ज़्यादा बदल सकती हैं। Glu आपको अधिक स्थिर रहने में मदद करता है।';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'संरचना के बिना, स्वस्थ आदतें ढीली पड़ सकती हैं। Glu गतिविधि और वजन को सही रास्ते पर रखने में मदद करता है।';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'संरचना के बिना, वजन रुक सकता है या बढ़ सकता है। Glu प्रगति को सही दिशा में बनाए रखने में मदद करता है।';

  @override
  String get onboardingBenefitsAxisWeight => 'वजन';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'भोजन और वजन';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'लक्षण और वजन';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'व्यायाम और वजन';

  @override
  String get onboardingNotificationsQuestion =>
      'ऐसे रिमाइंडर चालू करें जो आपके लक्ष्य का समर्थन करते हैं';

  @override
  String get onboardingNotificationsExplainer =>
      'हम इसका उपयोग आपको लगातार, तैयार और सही रास्ते पर रहने में मदद करने के लिए सूचनाएँ देने में करते हैं।';

  @override
  String get onboardingNotificationsHeadline =>
      'सही समय पर मदद करने के लिए Glu को सेट करें।';

  @override
  String get onboardingNotificationsBody =>
      'सूचनाएँ चालू करें ताकि Glu आपके लक्ष्य को सपोर्ट करने वाली आदतों को मजबूत कर सके।';

  @override
  String get onboardingNotificationsDaily =>
      'आपकी दैनिक दवा की लय से मेल खाते समयबद्ध रिमाइंडर';

  @override
  String get onboardingNotificationsEvery14Days =>
      'लंबी अवधि के रिमाइंडर ताकि खुराक के दिन अचानक न आएँ';

  @override
  String get onboardingNotificationsCustom =>
      'आपके कस्टम शेड्यूल के अनुसार बने रिमाइंडर';

  @override
  String get onboardingNotificationsWeekly =>
      'साप्ताहिक लय के साथ मेल खाते खुराक रिमाइंडर';

  @override
  String get onboardingNotificationsSupportive =>
      'ऐसे सहायक रिमाइंडर जो प्रेरणा कम होने पर भी आपकी दिनचर्या को दिखाई दें';

  @override
  String get onboardingNotificationsProgress =>
      'प्रगति, आदतों और आपके सबसे महत्वपूर्ण लक्ष्यों के आसपास समय पर संकेत';

  @override
  String get onboardingNotificationsHelpful =>
      'ऐसे उपयोगी संकेत जो Glu को उन क्षणों में और भी मददगार बनाते हैं जब आपको इसकी ज़रूरत हो';

  @override
  String get onboardingDailyRoutineQuestion => 'आपकी दैनिक दिनचर्या कैसी है?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'हम इसका उपयोग आपकी योजना को आपके दिन-प्रतिदिन के जीवन के लिए यथार्थवादी बनाने के लिए करते हैं।';

  @override
  String get onboardingRoutineSedentary => 'कम सक्रिय';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'ज़्यादातर बैठना, डेस्क वर्क, और बहुत कम जानबूझकर व्यायाम।';

  @override
  String get onboardingRoutineLightlyActive => 'थोड़ा सक्रिय';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'नियमित पैदल चलना, काम-काज, या सप्ताह में कुछ बार हल्की कसरत।';

  @override
  String get onboardingRoutineActive => 'सक्रिय';

  @override
  String get onboardingRoutineActiveDescription =>
      'नियमित चलना या व्यायाम, जैसे रोज़ाना वॉक, जिम, या सक्रिय काम।';

  @override
  String get onboardingRoutineVeryActive => 'बहुत सक्रिय';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'कठोर प्रशिक्षण, शारीरिक रूप से मांग वाला काम, या अधिकांश दिनों में उच्च गतिविधि।';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'आप किन लक्षणों को लेकर सबसे अधिक चिंतित हैं, यदि कोई हैं?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'हम इसका उपयोग उन लक्षणों के आसपास सुझावों और मार्गदर्शन को प्राथमिकता देने के लिए करते हैं जिनकी आपको सबसे अधिक परवाह है।';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'हम इसका उपयोग उन लक्षणों पर ध्यान केंद्रित करने के लिए करते हैं जिन्हें आप पहले से संभालना चाहते हैं।';

  @override
  String get onboardingGenderQuestion => 'आप अपना जेंडर कैसे बताते हैं?';

  @override
  String get onboardingGenderExplainer =>
      'हम इसका उपयोग अधिक प्रासंगिक मार्गदर्शन और भविष्य के निजीकरण के लिए करते हैं।';

  @override
  String get onboardingGenderFemale => 'महिला';

  @override
  String get onboardingGenderMale => 'पुरुष';

  @override
  String get onboardingGenderPreferNotToSay => 'न बताना पसंद करूंगा/करूँगी';

  @override
  String get onboardingTypeYourGender => 'अपना जेंडर लिखें';

  @override
  String get onboardingPreferredNameQuestion => 'हम आपको क्या कहें?';

  @override
  String get onboardingPreferredNameExplainer =>
      'हम इसका उपयोग बातचीत को और व्यक्तिगत बनाने के लिए करते हैं।';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'आपकी योजना सेट की जा रही है';

  @override
  String get onboardingSetupSummaryExplainer =>
      'हम आपकी साझा की गई जानकारी को एक ऐसी योजना में बदल रहे हैं जिसे Glu तुरंत सपोर्ट कर सके।';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'वजन बनाए रखने के लक्ष्य तय किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'वजन वापस बढ़ने की निगरानी सेट की जा रही है...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'आपकी दिनचर्या के आसपास रिमाइंडर ट्यून किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'एक अधिक स्थिर साप्ताहिक योजना तैयार की जा रही है...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'भोजन और वजन के पैटर्न तय किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'हाइड्रेशन सहायता सेट की जा रही है...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'स्थिरता रिमाइंडर तैयार किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'एक अधिक स्पष्ट दैनिक संरचना बनाई जा रही है...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'लक्षण सहायता व्यवस्थित की जा रही है...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'साप्ताहिक गति लक्ष्य तय किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'हाइड्रेशन और दिनचर्या के एंकर सेट किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'एक अधिक स्थिर योजना तैयार की जा रही है...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'गतिविधि लक्ष्य तय किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'हाइड्रेशन सहायता तय की जा रही है...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'साप्ताहिक आदत रिमाइंडर तैयार किए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'एक हृदय-स्वास्थ्य दिनचर्या बनाई जा रही है...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'कैलोरी सीमाएँ तय की जा रही हैं...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'पानी की मात्रा सेट की जा रही है...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'व्यायाम लक्ष्य बनाए जा रहे हैं...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'आपकी साप्ताहिक योजना तैयार की जा रही है...';

  @override
  String get onboardingSetupSummaryHeadline => 'आपका Glu सेटअप तैयार है।';

  @override
  String get onboardingSetupLoadingTitle => 'आपका सेटअप बनाया जा रहा है';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu अधिक स्पष्ट संरचना और वजन वापस बढ़ने के शुरुआती संकेतों के साथ आपकी प्रगति की रक्षा करने के लिए तैयार है।';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu अधिक स्थिर भोजन, वजन ट्रैकिंग और रोज़मर्रा की महत्वपूर्ण आदतों को सपोर्ट करने के लिए तैयार है।';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu लक्षणों, उपचार और प्रगति के आसपास अधिक स्थिर दिनचर्याओं को सपोर्ट करने के लिए तैयार है.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu आपके दीर्घकालिक हृदय स्वास्थ्य को सपोर्ट करने वाली आदतों को मजबूत करने के लिए तैयार है।';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu उन रूटीन को सपोर्ट करने के लिए तैयार है जो वजन को बनाए रखने में मदद करती हैं।';

  @override
  String get onboardingSetupSummaryLabel => 'सारांश';

  @override
  String get onboardingSetupAdjustLater =>
      'आप इसे बाद में सेटिंग्स में बदल सकते हैं।';

  @override
  String get onboardingSummaryGoal => 'लक्ष्य';

  @override
  String get onboardingSummaryCurrentWeight => 'वर्तमान वजन';

  @override
  String get onboardingSummaryMedication => 'दवा';

  @override
  String get onboardingSummaryCurrentDose => 'वर्तमान खुराक';

  @override
  String get onboardingSummaryCadence => 'ताल';

  @override
  String get onboardingSummaryStarted => 'शुरू किया';

  @override
  String get onboardingSummaryTargetWeight => 'लक्ष्य वजन';

  @override
  String get onboardingSummaryRoutine => 'दिनचर्या';

  @override
  String get onboardingSummaryFocus => 'फोकस';

  @override
  String get onboardingFrequencyEveryDay => 'हर दिन';

  @override
  String get onboardingFrequencyEveryWeek => 'हर हफ्ते';

  @override
  String get onboardingFrequencyEvery2Weeks => 'हर 2 हफ्ते';

  @override
  String get onboardingFrequencyCustomSchedule => 'कस्टम शेड्यूल';

  @override
  String get onboardingTapOptionContinue =>
      'जारी रखने के लिए किसी विकल्प पर टैप करें।';

  @override
  String get onboardingTypeGenderContinue =>
      'जारी रखने के लिए अपना जेंडर लिखें।';

  @override
  String get onboardingTypeDeviceContinue =>
      'जारी रखने के लिए अपना उपकरण लिखें।';

  @override
  String get onboardingTypeMedicationContinue =>
      'जारी रखने के लिए अपनी दवा लिखें।';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'जारी रखने के लिए खुराकों के बीच दिनों की संख्या दर्ज करें।';

  @override
  String get onboardingChooseScheduleContinue =>
      'जारी रखने के लिए एक शेड्यूल चुनें।';

  @override
  String get onboardingScrollChooseAge => 'अपनी आयु चुनने के लिए स्क्रॉल करें।';

  @override
  String get onboardingDragOrTapHeight =>
      'अपनी लंबाई चुनने के लिए रूलर को ड्रैग या टैप करें।';

  @override
  String get onboardingDragTapOrUseWeight =>
      'वजन चुनने के लिए ड्रैग, टैप या स्टेप बटन का उपयोग करें।';

  @override
  String get onboardingPickDateAndWeight =>
      'जारी रखने के लिए तारीख और वजन चुनें।';

  @override
  String get onboardingSelectSymptoms =>
      'वे लक्षण चुनें जिन पर आप चाहते हैं कि Glu ध्यान दे।';

  @override
  String get onboardingTypeName => 'वह नाम लिखें जिसका उपयोग Glu करे।';

  @override
  String get onboardingSaving => 'Saving...';

  @override
  String get onboardingLetsBegin => 'चलो शुरू करें';

  @override
  String get onboardingContinueWithGlu => 'Glu के साथ जारी रखें';

  @override
  String get onboardingKeepGoing => 'जारी रखें';

  @override
  String get onboardingTurnOnNotifications => 'सूचनाएँ चालू करें';

  @override
  String get onboardingFinish => 'समाप्त';

  @override
  String get onboardingTargetBmiTitle => 'आपका लक्ष्य BMI';

  @override
  String get onboardingChartToday => 'आज';

  @override
  String get onboardingChartOverTime => 'समय के साथ';

  @override
  String get onboardingChartWithoutGlu => 'Glu के बिना';

  @override
  String get onboardingChartWithGlu => 'Glu के साथ';

  @override
  String get onboardingReviewQuestion =>
      'लोग Glu का उपयोग स्थिर और समर्थित रहने के लिए करते हैं';

  @override
  String get onboardingReviewExplainer =>
      'एक त्वरित रेटिंग अधिक लोगों को ऐसा सरल समर्थन खोजने में मदद करती है।';

  @override
  String get onboardingReviewBody =>
      'लोग Glu का उपयोग अधिक समर्थित, अधिक सुसंगत और इस प्रक्रिया में कम अकेला महसूस करने के लिए करते हैं।';

  @override
  String get onboardingTypeYourMedication => 'अपनी दवा लिखें';

  @override
  String get onboardingSelectStartDate => 'शुरुआत की तारीख चुनें';

  @override
  String get goalsSaveDialogTitle => 'लक्ष्य सहेजें?';

  @override
  String get goalsSaveDialogMessage =>
      'आपके पास असहेजे गए लक्ष्य परिवर्तन हैं। इस टैब से बाहर जाने से पहले उन्हें सहेजें?';

  @override
  String get commonLater => 'बाद में';

  @override
  String get homeGreetingAnonymous => 'नमस्ते';

  @override
  String homeGreetingWithName(Object name) {
    return 'नमस्ते, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'अंतर्दृष्टि देखने के लिए आज लॉग करें';

  @override
  String get homeInsightEmptyBody =>
      'आज कुछ लॉग करें, और आप अपनी अंतर्दृष्टि रात में देखेंगे।';

  @override
  String get homeInsightLogTodayTitle =>
      'अपनी अंतर्दृष्टि देखने के लिए टैप करें';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'आज की अंतर्दृष्टि देखने के लिए टैप करें';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'आपके लॉग अब एक पैटर्न दिखाने लगे हैं — देखने के लिए टैप करें।';

  @override
  String get homeInsightMoreLogsVariant2Title =>
      'अपनी अंतर्दृष्टि देखने के लिए टैप करें';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'कुछ और लॉग तस्वीर को काफी साफ़ कर सकते हैं — कभी भी टैप करें।';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'आज की अंतर्दृष्टि जानने के लिए टैप करें';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'शायद आपके दिन में पहले से ही एक पैटर्न छुपा हुआ है — देखने के लिए टैप करें।';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'आज कुछ लॉग करें, फिर देखने के लिए टैप करें कि इससे क्या पता चलता है।';

  @override
  String get homeInsightExpandedTitle => 'क्या यह उपयोगी था?';

  @override
  String get homeInsightExpandedBody =>
      'एक त्वरित रेटिंग Glu को यह समझने में मदद करती है कि आपके लिए सबसे महत्वपूर्ण क्या है।';

  @override
  String get homeInsightReasonHint => 'क्या बेहतर हो सकता है? (वैकल्पिक)';

  @override
  String get homeInsightReasonSubmit => 'भेजें';

  @override
  String get homeInsightLearningMessage => 'मैं इससे सीखूँगा/सीखूँगी।';

  @override
  String get homeInsightChecking => 'आज की अंतर्दृष्टि जाँची जा रही है...';

  @override
  String get homeInsightGenerating => 'आज की अंतर्दृष्टि लोड की जा रही है...';

  @override
  String get homeInsightTryAgain => 'फिर से प्रयास करें';

  @override
  String get homeSeeAllInsights => 'सभी अंतर्दृष्टियाँ देखें';

  @override
  String get insightsProgressTitle => 'सभी अंतर्दृष्टियाँ';

  @override
  String get insightsProgressEmptyState =>
      'जैसे ही वे जेनरेट होंगी, आपकी अंतर्दृष्टियाँ यहाँ दिखाई देंगी।';

  @override
  String get homeDoseReminderTitle => 'खुराक रिमाइंडर';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'लॉग $label कार्रवाई यहाँ आती है।';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'कैलोरी लक्ष्य आवश्यक है';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Portion Check को अपनी मात्रा का अनुमान लगाने के लिए Meal लक्ष्य को Calories पर सेट होने की आवश्यकता है। शुरू करने के लिए Goals में एक सेट करें।';

  @override
  String get homeSetGoal => 'लक्ष्य सेट करें';

  @override
  String get homeYourProgress => 'आपकी प्रगति';

  @override
  String get homeRemindersShowcaseTitle => 'ट्रैक पर बने रहें';

  @override
  String get homeRemindersShowcaseDescription =>
      'खुराक और सप्लीमेंट समय पर रखने के लिए रिमाइंडर सेट करें।';

  @override
  String get homePickNextDoseDate => 'अपनी अगली खुराक की तारीख चुनें';

  @override
  String get homeSetReminder => 'रिमाइंडर सेट करें';

  @override
  String get homeSupplementReminders => 'सप्लीमेंट रिमाइंडर';

  @override
  String get homeNoUpcomingSupplements => 'कोई आने वाले सप्लीमेंट नहीं';

  @override
  String get homeNoMoreUpcomingSupplements => 'और कोई आने वाला नहीं';

  @override
  String get homeSetUpYourSupplements => 'अपने सप्लीमेंट सेट करें';

  @override
  String get homeSetUp => 'सेट अप करें';

  @override
  String get homeSupplementFallback => 'सप्लीमेंट';

  @override
  String get doseReminderNotificationTitle => 'अपनी खुराक के लिए तैयार हैं?';

  @override
  String get doseReminderFallbackBody =>
      'अपनी अगली खुराक देखने के लिए Glu खोलें।';

  @override
  String get supplementReminderNotificationTitle => 'आपके सप्लीमेंट का समय';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'आज सुबह';

  @override
  String get supplementReminderThisAfternoon => 'आज दोपहर';

  @override
  String get supplementReminderTonight => 'आज रात';

  @override
  String get dailyReminderMorningTitle => 'सुबह चेक-इन';

  @override
  String get dailyReminderMorningBodies =>
      'सुबह का मिशन: Glu को थोड़ा डेटा दें जिस पर वह काम कर सके।\nदिन की शुरुआत एक त्वरित लॉग और अच्छे मोमेंटम के साथ करें।\nउठें और लॉग करें। आपका भविष्य वाला स्वरूप आपका आभारी होगा।\nदिन की शुरुआत एक छोटे अपडेट और एक बड़ी बढ़त के साथ करें।\nGlu को सुबह का संकेत दें और आगे बढ़ते रहें।\nअभी एक त्वरित लॉग आज को और दिलचस्प बना सकता है।\nएक तेज़ चेक-इन के साथ सुबह को सार्थक बनाइए।';

  @override
  String get dailyReminderMiddayTitle => 'दोपहर चेक-इन';

  @override
  String get dailyReminderMiddayBodies =>
      'दोपहर का ठहराव: एक छोटा लॉग करें और चलते रहें।\nलंच ब्रेक? Glu को अपडेट देने का सही समय।\nआधे रास्ते पर हैं। Glu को एक त्वरित संकेत दें।\nएक छोटा दोपहर लॉग कहानी को आगे बढ़ा सकता है।\nअभी चेक-इन करें और दिन को चलाते रहें।\nएक तेज़ अपडेट के साथ दिन को थोड़ा धक्का दें।\nएक त्वरित दोपहर टैप के साथ ऊर्जा बनाए रखें।';

  @override
  String get dailyReminderAfternoonTitle => 'शाम चेक-इन';

  @override
  String get dailyReminderAfternoonBodies =>
      'लगभग पूरा हो गया। Glu को एक और संकेत दें।\nएक त्वरित शाम का लॉग आज रात की अंतर्दृष्टि को और तेज बना सकता है।\nदिन को एक छोटे अपडेट और बड़ी जीत के साथ बंद करें।\nदिन खत्म होने से पहले एक और लॉग?\nएक त्वरित शाम चेक-इन के साथ Glu को बिंदुओं को जोड़ने में मदद करें।\nएक छोटे लॉग के साथ लूप बंद करें और जादू जारी रखें।\nअभी का एक अंतिम टैप आज रात की अंतर्दृष्टि को बहुत बेहतर बना सकता है।';

  @override
  String get homePortionCheckTitle => 'पोर्टियन चेक';

  @override
  String get homePortionCheckBody => 'जानें कि हर भोजन में कितना खाना है';

  @override
  String get homeGlowUpTitle => 'अपना बदलाव दिखाएँ';

  @override
  String get homeGlowUpBody => 'अपनी पहले और बाद की कहानी बनाएँ';

  @override
  String get homeDoctorReportTitle => 'डॉक्टर रिपोर्ट';

  @override
  String get homeDoctorReportBody => 'अपनी प्रगति अपने डॉक्टर के साथ साझा करें';

  @override
  String get doctorReportViewerRenderError =>
      'रिपोर्ट नहीं दिखाई जा सकी. कृपया फिर कोशिश करें.';

  @override
  String get doctorReportViewerShare => 'साझा करें';

  @override
  String get homeGoalsStatusTitle => 'आज के लक्ष्य';

  @override
  String get homeGoalsStatusViewAll => 'सभी देखें';

  @override
  String get homeWaterTitle => 'पानी';

  @override
  String get homeWeightTitle => 'वजन';

  @override
  String get homeExerciseTitle => 'व्यायाम';

  @override
  String get homeMealsTitle => 'भोजन';

  @override
  String get homeCaloriesTitle => 'कैलोरी';

  @override
  String get homeProteinsTitle => 'प्रोटीन';

  @override
  String get homeFibersTitle => 'फाइबर';

  @override
  String get homeSymptomsTitle => 'लक्षण';

  @override
  String get homeMoodTitle => 'मूड';

  @override
  String get homeCravingsTitle => 'क्रेविंग';

  @override
  String get homeDoseTitle => 'खुराक';

  @override
  String get homeMedicationLevelTitle => 'अनुमानित दवा स्तर';

  @override
  String get homeMedicationLevelInfoTitle => 'इस चार्ट को कैसे पढ़ें';

  @override
  String get homeMedicationLevelInfoBody =>
      'यह चार्ट आपकी लॉग की गई खुराकों और दवा के हाफ-लाइफ के आधार पर अनुमान लगाता है कि आपकी कितनी दवा अभी भी सक्रिय हो सकती है।\n\nऊँचे बिंदु आमतौर पर हाल ही की या बड़ी खुराक दर्शाते हैं। समय के साथ रेखा नीचे जाती है क्योंकि दवा आपके शरीर से साफ होती जाती है।\n\nइसे एक रुझान दृश्य के रूप में उपयोग करें, न कि सटीक माप या चिकित्सीय सलाह के रूप में।';

  @override
  String get homeMedicationLevelInfoDismiss => 'समझ गया';

  @override
  String get homeMedicationLevelEmptyBody =>
      'अपनी खुराकें लॉग करें ताकि Glu अनुमान लगा सके कि आपके शरीर में अभी भी कितनी दवा सक्रिय है।';

  @override
  String get homeMedicationLevelOfRecentPeak => 'हाल के उच्चतम स्तर का';

  @override
  String get homeMedicationLevelActiveNow => 'अभी सक्रिय';

  @override
  String get homeMedicationLevelHalfLife => 'हाफ-लाइफ';

  @override
  String get homeMedicationLevelLastDose => 'आखिरी खुराक';

  @override
  String get homeStartHydration => 'हाइड्रेशन शुरू करें';

  @override
  String get homeLogFirstSession => 'अपना पहला सत्र लॉग करें';

  @override
  String get homeLogTodayWeight => 'आज का वजन लॉग करें';

  @override
  String get homeAtYourTarget => 'आप अपने लक्ष्य पर हैं';

  @override
  String get homeLogMealsToTrackCalories =>
      'कैलोरी ट्रैक करने के लिए भोजन लॉग करें';

  @override
  String get homeLogFirstMeal => 'अपना पहला भोजन लॉग करें';

  @override
  String get homeTrackProteinFromMeals => 'भोजन से प्रोटीन ट्रैक करें';

  @override
  String get homeTrackFiberFromMeals => 'भोजन से फाइबर ट्रैक करें';

  @override
  String get homeAllClear => 'सब ठीक';

  @override
  String get homeTrackSymptoms => 'लक्षण ट्रैक करें';

  @override
  String get homeGreat => 'बहुत अच्छा';

  @override
  String get homeGood => 'अच्छा';

  @override
  String get homeBad => 'खराब';

  @override
  String get homeOkay => 'ठीक';

  @override
  String get homeLogHowYouFeel => 'आप कैसा महसूस करते हैं, लॉग करें';

  @override
  String get homeLogACraving => 'क्रेविंग लॉग करें';

  @override
  String get homeLogTodaysDose => 'आज की खुराक लॉग करें';

  @override
  String get homeTaken => 'लिया गया';

  @override
  String get homeStartHereTitle => 'यहाँ से शुरू करें';

  @override
  String get homeStartHereBody =>
      'इस कार्ड से शुरू करें और बाद में विस्तार करें। जितना अधिक Glu आपकी यात्रा के बारे में सीखेगा, उतने ही बेहतर पैटर्न और अंतर्दृष्टि वह समय के साथ दिखा सकता है।';

  @override
  String get waterLogTitle => 'पानी';

  @override
  String get waterLogEditTitle => 'पानी संपादित करें';

  @override
  String get waterLogLogTitle => 'पानी लॉग करें';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ पेय जोड़ें ($amount)';
  }

  @override
  String get waterLogSaving => 'सहेजा जा रहा है...';

  @override
  String get waterLogCustomDrinkTitle => 'कस्टम पेय';

  @override
  String get waterLogCustomDrinkBody => 'इस पानी की मात्रा को चुनें।';

  @override
  String get waterLogUseThisAmount => 'इस मात्रा का उपयोग करें';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount हाइड्रेशन लॉग में जोड़ा गया';
  }

  @override
  String get waterLogCouldNotSave => 'इस पानी के लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get waterLogDeleteTitle => 'क्या यह हाइड्रेशन लॉग हटाएँ?';

  @override
  String get waterLogDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get waterLogCouldNotDelete =>
      'इस हाइड्रेशन लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get waterLogDeleteLog => 'लॉग हटाएँ';

  @override
  String get waterLogDeleted => 'हाइड्रेशन हटाया गया';

  @override
  String get moodLogTitle => 'मूड';

  @override
  String get moodEditTitle => 'मूड संपादित करें';

  @override
  String get moodHowYouFeel => 'आप कैसा महसूस करते हैं';

  @override
  String get moodBad => 'खराब';

  @override
  String get moodOkay => 'ठीक';

  @override
  String get moodGood => 'अच्छा';

  @override
  String get moodGreat => 'बहुत अच्छा';

  @override
  String get moodNotes => 'नोट्स';

  @override
  String get moodAnythingWorthRemembering =>
      'अपने मूड के बारे में याद रखने लायक कुछ है?';

  @override
  String get moodCouldNotSave => 'इस मूड लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get moodDeleteTitle => 'क्या यह मूड लॉग हटाएँ?';

  @override
  String get moodDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get moodDeleteLog => 'हटाएँ लॉग';

  @override
  String get moodSaving => 'सहेजा जा रहा है...';

  @override
  String get moodAddMoodLog => '+ मूड लॉग जोड़ें';

  @override
  String get moodLogged => 'मूड लॉगged';

  @override
  String get moodDeleted => 'मूड हटाया गया';

  @override
  String get moodCouldNotDelete => 'इस मूड लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get moodAddedToMoodLog => 'आपके मूड लॉग में जोड़ा गया';

  @override
  String get cravingsLogTitle => 'क्रेविंग';

  @override
  String get cravingsEditTitle => 'क्रेविंग संपादित करें';

  @override
  String get cravingsWhatsGoingOn => 'क्या हो रहा है';

  @override
  String get cravingsTypeGeneral => 'कुछ खाने की इच्छा';

  @override
  String get cravingsTypeSweet => 'कुछ मीठा';

  @override
  String get cravingsTypeSalty => 'कुछ नमकीन';

  @override
  String get cravingsIntensityLabel => 'तीव्रता (वैकल्पिक)';

  @override
  String get cravingsIntensityMild => 'हल्की';

  @override
  String get cravingsIntensityModerate => 'मध्यम';

  @override
  String get cravingsIntensityStrong => 'तेज़';

  @override
  String get cravingsOutcomeLabel => 'क्या हुआ (वैकल्पिक)';

  @override
  String get cravingsOutcomeResisted => 'रोका';

  @override
  String get cravingsOutcomeGaveIn => 'हार मान ली';

  @override
  String get cravingsNotes => 'नोट्स';

  @override
  String get cravingsAnythingWorthRemembering =>
      'इस क्रेविंग के बारे में याद रखने लायक कुछ है?';

  @override
  String get cravingsCouldNotSave =>
      'इस क्रेविंग लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get cravingsDeleteTitle => 'क्या यह क्रेविंग लॉग हटाएँ?';

  @override
  String get cravingsDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get cravingsDeleteLog => 'हटाएँ लॉग';

  @override
  String get cravingsSaving => 'सहेजा जा रहा है...';

  @override
  String get cravingsAddLog => '+ क्रेविंग लॉग जोड़ें';

  @override
  String get cravingsLogged => 'क्रेविंग लॉग हो गई';

  @override
  String get cravingsDeleted => 'क्रेविंग हटाई गई';

  @override
  String get cravingsCouldNotDelete =>
      'इस क्रेविंग लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get cravingsAddedToLog => 'आपके क्रेविंग लॉग में जोड़ा गया';

  @override
  String get portionCheckTitle => 'पोर्टियन चेक';

  @override
  String get portionCheckAnalyzingMeal =>
      'आपके भोजन का विश्लेषण किया जा रहा है…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'इस फोटो का विश्लेषण नहीं किया जा सका';

  @override
  String get portionCheckTakeNewPhoto => 'नई फोटो लें';

  @override
  String get portionCheckSomethingWentWrong => 'कुछ गड़बड़ हुई।';

  @override
  String get portionCheckYouHitDailyLimit => 'आपकी दैनिक सीमा पूरी हो गई है';

  @override
  String get portionCheckYouCanEat => 'आप खा सकते हैं';

  @override
  String get portionCheckYouCanEatUpTo => 'आप अधिकतम खा सकते हैं';

  @override
  String get portionCheckTryLighterOption =>
      'इसके बजाय हल्का विकल्प आज़माएँ या इसे छोड़ दें';

  @override
  String get portionCheckThisEntireMeal => 'यह पूरा भोजन';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return 'इस भोजन का $percent%';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'अपने दैनिक लक्ष्यों के भीतर रहने के लिए।';

  @override
  String get portionCheckNutritionBreakdown => 'पोषण विवरण';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'अपने भोजन को संतुलित करने के टिप्स';

  @override
  String get portionCheckTipsPool =>
      'धीरे खाएँ — तृप्ति का संकेत पहुँचने में लगभग 20 मिनट लगते हैं।\nअपनी प्लेट का आधा हिस्सा सब्ज़ियों से भरें।\nहर भोजन में प्रोटीन शामिल करें।\nभोजन से पहले पानी पिएँ।\nस्नैक्स को छोटे डिब्बों में पहले से बाँट लें।\nलंबे समय तक भरा महसूस करने के लिए कार्ब्स को प्रोटीन या फैट के साथ लें।\nजब संभव हो, कम प्रोसेस्ड/संपूर्ण खाद्य चुनें।\nस्क्रीन के साथ ध्यान भंग होकर खाते समय खाने से बचें।\nअगर बाद में ज़्यादा खाने की संभावना हो तो भोजन न छोड़ें।\nभूख लगने से पहले अपने स्नैक्स की योजना बनाएं।';

  @override
  String get portionCheckRetake => 'फिर से लें';

  @override
  String get portionCheckLogThisPortion => 'इस हिस्से को लॉग करें';

  @override
  String get portionCheckCarbs => 'कार्ब्स';

  @override
  String get portionCheckProteins => 'प्रोटीन';

  @override
  String get portionCheckFats => 'फैट्स';

  @override
  String get portionCheckFiber => 'फाइबर';

  @override
  String get mealLogScreenTitle => 'भोजन';

  @override
  String get mealLogEditTitle => 'भोजन संपादित करें';

  @override
  String get mealLogLogTitle => 'भोजन लॉग करें';

  @override
  String get mealLogSaving => 'सहेजा जा रहा है...';

  @override
  String get mealLogAddMealLog => '+ भोजन लॉग जोड़ें';

  @override
  String get mealLogCouldNotStartRecording => 'रिकॉर्डिंग शुरू नहीं की जा सकी।';

  @override
  String get mealLogRecordingStoppedAtLimit => 'रिकॉर्डिंग 60 सेकंड पर रुक गई।';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'इस रिकॉर्डिंग का विश्लेषण नहीं किया जा सका।';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'इस टेक्स्ट का विश्लेषण नहीं किया जा सका।';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'इस फोटो का विश्लेषण नहीं किया जा सका।';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'इस भोजन फोटो को अभी प्रोसेस नहीं किया जा सका।';

  @override
  String get mealLogDiscardTitle => 'इस भोजन को हटाएँ?';

  @override
  String get mealLogDiscardMessage =>
      'आपने फोटो देखी लेकिन एंट्री सहेजी नहीं। इसे लॉग नहीं किया जाएगा।';

  @override
  String get mealLogDiscard => 'हटाएँ';

  @override
  String get mealLogDeleteTitle => 'यह भोजन लॉग हटाएँ?';

  @override
  String get mealLogDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get mealLogDelete => 'हटाएँ';

  @override
  String get mealLogDeleteLog => 'लॉग हटाएँ';

  @override
  String get mealLogCouldNotSave => 'इस भोजन लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get mealLogCouldNotDelete => 'इस भोजन लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get mealLogAnalyzing => 'विश्लेषण किया जा रहा है...';

  @override
  String get mealLogAnalyzeText => 'टेक्स्ट का विश्लेषण करें';

  @override
  String get mealLogSendRecording => 'रिकॉर्डिंग भेजें';

  @override
  String get mealLogMealDefaultName => 'भोजन';

  @override
  String get mealLogMealNameHint => 'भोजन का नाम';

  @override
  String get mealLogCouldNotPrefillTitle => 'इस भोजन को पहले से भर नहीं सके';

  @override
  String get mealLogHowMuchDidYouEat => 'आपने कितना खाया?';

  @override
  String get mealLogNotes => 'नोट्स';

  @override
  String get mealLogAnythingWorthRemembering =>
      'इस भोजन के बारे में याद रखने लायक कुछ है?';

  @override
  String get mealLogAnalyzingYourMealTitle =>
      'आपके भोजन का विश्लेषण किया जा रहा है';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'आपकी इनपुट को पोषण फ़ील्ड में बदला जा रहा है। आप सहेजने से पहले सब कुछ देख सकते हैं।';

  @override
  String get mealLogDescribeYourMealTitle => 'अपने भोजन का वर्णन करें';

  @override
  String get mealLogDescribeYourMealBody =>
      'आपने क्या खाया और जितनी मात्रा जानते हैं लिखें। हम इसे पोषण फ़ील्ड में बदल देंगे।';

  @override
  String get mealLogDescribeYourMealHint =>
      'उदाहरण: ग्रिल्ड चिकन सलाद, ऑलिव ऑयल ड्रेसिंग, 1 सेब, स्पार्कलिंग वॉटर';

  @override
  String get mealLogCaptureYourMealTitle => 'अपने भोजन को कैप्चर करें';

  @override
  String get mealLogCaptureYourMealBody =>
      'फोटो लें और हम आपके लिए पोषण फ़ील्ड का अनुमान लगाएंगे।';

  @override
  String get mealLogTakePhoto => 'फोटो लें';

  @override
  String get mealLogRecordingYourMealTitle =>
      'आपका भोजन रिकॉर्ड किया जा रहा है';

  @override
  String get mealLogRecordingReadyTitle => 'रिकॉर्डिंग तैयार है';

  @override
  String get mealLogRecordMealDescriptionTitle => 'भोजन का विवरण रिकॉर्ड करें';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'जब आप तैयार हों तो स्टॉप टैप करें। ${remaining}s शेष';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'इसे नीचे विश्लेषण के लिए भेजें, या फिर से रिकॉर्ड करें।';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'स्वाभाविक रूप से बताइए आपने क्या खाया, और हम इसे मैक्रो में पार्स करेंगे।';

  @override
  String get mealLogStopRecording => 'रिकॉर्डिंग रोकें';

  @override
  String get mealLogRecordAgain => 'फिर से रिकॉर्ड करें';

  @override
  String get mealLogStartRecording => 'रिकॉर्डिंग शुरू करें';

  @override
  String get mealLogBreakfast => 'नाश्ता';

  @override
  String get mealLogLunch => 'दोपहर का भोजन';

  @override
  String get mealLogSnack => 'स्नैक';

  @override
  String get mealLogDinner => 'रात का खाना';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'आज';

  @override
  String get mealLogYesterday => 'कल';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal लॉग किया गया';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro लॉग किया गया';
  }

  @override
  String get mealLogDeleted => 'भोजन हटाया गया';

  @override
  String get mealLogAddedToMealLog => 'आपके भोजन लॉग में जोड़ा गया';

  @override
  String get mealLogCarbs => 'कार्ब्स';

  @override
  String get mealLogProteins => 'प्रोटीन';

  @override
  String get mealLogFats => 'फैट्स';

  @override
  String get mealLogFiber => 'फाइबर';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsLanguageDialogTitle => 'भाषा चुनें';

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsPreferences => 'प्राथमिकताएँ';

  @override
  String get settingsHealthGoal => 'स्वास्थ्य लक्ष्य';

  @override
  String get settingsHealthGoalDialogTitle => 'स्वास्थ्य लक्ष्य चुनें';

  @override
  String get settingsHabitGoals => 'आदत लक्ष्य';

  @override
  String get settingsDisabled => 'अक्षम';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count सक्रिय';
  }

  @override
  String get settingsHeight => 'ऊँचाई';

  @override
  String get settingsAge => 'आयु';

  @override
  String get settingsGender => 'लिंग';

  @override
  String get settingsMeasurementUnit => 'माप की इकाई';

  @override
  String get settingsReminders => 'रिमाइंडर';

  @override
  String get settingsDoseReminder => 'खुराक रिमाइंडर';

  @override
  String get settingsSupplementReminder => 'सप्लीमेंट रिमाइंडर';

  @override
  String get settingsDailyReminders => 'दैनिक रिमाइंडर';

  @override
  String get settingsSubscription => 'सदस्यता';

  @override
  String get settingsSupport => 'सहायता';

  @override
  String get settingsSendFeedback => 'प्रतिक्रिया भेजें';

  @override
  String get feedbackSheetTitle => 'प्रतिक्रिया भेजें';

  @override
  String get feedbackSheetHint => 'हमें बताएं कि आप क्या सोचते हैं…';

  @override
  String get feedbackSheetSend => 'भेजें';

  @override
  String get feedbackSheetSuccess => 'आपकी प्रतिक्रिया के लिए धन्यवाद!';

  @override
  String get feedbackSheetError => 'भेजा नहीं जा सका. कृपया फिर कोशिश करें.';

  @override
  String get settingsTermsOfService => 'सेवा की शर्तें';

  @override
  String get settingsPrivacyPolicy => 'गोपनीयता नीति';

  @override
  String get settingsInternal => 'आंतरिक';

  @override
  String get settingsSubscriptionOverride => 'सदस्यता ओवरराइड';

  @override
  String get settingsTodayInsightCard => 'आज की अंतर्दृष्टि कार्ड';

  @override
  String get settingsResetOnboarding => 'ऑनबोर्डिंग रीसेट करें';

  @override
  String get settingsResetShowcases => 'शोकेस रीसेट करें';

  @override
  String get settingsResetUserData => 'उपयोगकर्ता डेटा रीसेट करें';

  @override
  String get settingsDeletingAccount => 'खाता हटाया जा रहा है...';

  @override
  String get settingsDisconnect => 'डिस्कनेक्ट करें';

  @override
  String get settingsDeleteAccount => 'खाता हटाएँ';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return '$provider डिस्कनेक्ट करें';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'क्या $provider डिस्कनेक्ट करें?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'जब तक आप इसे फिर से न जोड़ें, आप इस डिवाइस से $provider से साइन इन नहीं कर पाएँगे।';
  }

  @override
  String get settingsDeleteAccountTitle => 'खाता हटाएँ?';

  @override
  String get settingsDeleteAccountBody =>
      'यह आपका खाता और सभी डेटा स्थायी रूप से हटा देगा। यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get settingsDeleteAccountConfirmHint =>
      'पुष्टि करने के लिए DELETE टाइप करें';

  @override
  String get settingsDeleteAccountError =>
      'आपका खाता हटाते समय एक त्रुटि हुई। कृपया support@layline.ventures से संपर्क करें।';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'ऑनबोर्डिंग देखने के लिए ऐप रीस्टार्ट करें';

  @override
  String get settingsShowcasesReset => 'शोकेस रीसेट हो गए';

  @override
  String get settingsResetUserDataTitle => 'उपयोगकर्ता डेटा रीसेट करें?';

  @override
  String get settingsResetUserDataBody =>
      'यह भोजन, पानी, व्यायाम, वजन, मूड, लक्षण, सप्लीमेंट और खुराक के सभी लॉग हटाएगा।';

  @override
  String get settingsUserDataReset => 'उपयोगकर्ता डेटा रीसेट हो गया';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'सेव किया गया, लेकिन दैनिक रिमाइंडर अभी शेड्यूल नहीं किए जा सके।';

  @override
  String get settingsSubscriptionOverrideTitle => 'सदस्यता ओवरराइड';

  @override
  String get settingsSubscriptionOverrideAuto => 'ऑटो';

  @override
  String get settingsSubscriptionOverrideForceFree => 'फ्री मजबूर करें';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Pro मजबूर करें';

  @override
  String get settingsTodayInsightCardTitle => 'आज की अंतर्दृष्टि कार्ड';

  @override
  String get settingsTodayInsightCardAuto => 'ऑटो';

  @override
  String get settingsTodayInsightCardOn => 'चालू';

  @override
  String get settingsTodayInsightCardOff => 'बंद';

  @override
  String get settingsYourName => 'आपका नाम';

  @override
  String get settingsSignOut => 'साइन आउट';

  @override
  String get settingsHeightCm => 'सेमी';

  @override
  String get settingsHeightFtIn => 'फीट/इंच';

  @override
  String get settingsHeightFt => 'फीट';

  @override
  String get settingsHeightIn => 'इंच';

  @override
  String get settingsGenderMale => 'पुरुष';

  @override
  String get settingsGenderFemale => 'महिला';

  @override
  String get settingsGenderPreferNotToSay => 'न बताना पसंद है';

  @override
  String get settingsGenderOther => 'अन्य';

  @override
  String get settingsYourProfile => 'आपकी प्रोफ़ाइल';

  @override
  String get settingsNotSet => 'सेट नहीं';

  @override
  String settingsYears(Object value) {
    return '$value वर्ष';
  }

  @override
  String get settingsOff => 'बंद';

  @override
  String get settingsOn => 'चालू';

  @override
  String get settingsNoneSet => 'कुछ सेट नहीं';

  @override
  String settingsSupplementCount(Object count) {
    return '$count सप्लीमेंट';
  }

  @override
  String get commonToday => 'आज';

  @override
  String get mainShellHome => 'होम';

  @override
  String get mainShellLog => 'लॉग';

  @override
  String get mainShellProgress => 'प्रगति';

  @override
  String get mainShellSettings => 'सेटिंग्स';

  @override
  String get mainShellLogShowcaseTitle => 'लॉग';

  @override
  String get mainShellLogShowcaseDescription =>
      'अपने लॉग खोलने और आपके लिए महत्वपूर्ण चीज़ों को ट्रैक करने के लिए यहाँ टैप करें।';

  @override
  String get logMoodShowcaseTitle => 'अपने मूड से शुरुआत करें';

  @override
  String get logMoodShowcaseDescription =>
      'अभी अपना मूड लॉग करें, और बाकी चीज़ें दिन भर लॉग करते रहें ताकि Glu आदतों और पैटर्न को अधिक सटीक रूप से देख सके।';

  @override
  String get mainShellProgressShowcaseTitle => 'अपनी प्रगति देखें';

  @override
  String get mainShellProgressShowcaseDescription =>
      'अपने लॉग के पीछे के पैटर्न, रुझान, बदलाव और गति को समझने के लिए प्रगति देखें।';

  @override
  String get progressMenuShowcaseTitle => 'अपने डेटा को एक्सप्लोर करें';

  @override
  String get progressMenuShowcaseDescription =>
      'सभी चार्ट देखें, AI से बनी जानकारियाँ पढ़ें, या अपने देखभाल दल के साथ साझा करने के लिए एक डॉक्टर रिपोर्ट बनाएं।';

  @override
  String get settingsFeedbackShowcaseTitle =>
      'हम आपकी प्रतिक्रिया सुनना चाहेंगे';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'यहाँ टैप करके साझा करें कि क्या काम कर रहा है, क्या नहीं, या आपके पास कोई विचार हैं।';

  @override
  String get authCouldNotOpenLink => 'लिंक अभी नहीं खोला जा सका।';

  @override
  String get authWelcomeTitle => 'Glu में आपका स्वागत है';

  @override
  String get authSubtitle => 'आपके वेलनेस साथी के लिए सुरक्षित साइन-इन';

  @override
  String get authContinueWithGoogle => 'Google के साथ जारी रखें';

  @override
  String get authContinueWithApple => 'Apple के साथ जारी रखें';

  @override
  String get authEmailHint => 'name@email.com';

  @override
  String get authSending => 'भेजा जा रहा है...';

  @override
  String get authResendLink => 'लिंक फिर से भेजें';

  @override
  String get authUseDifferentEmail => 'अलग ईमेल का उपयोग करें';

  @override
  String get habitGoalsTitle => 'आदत लक्ष्य';

  @override
  String get goalsProteins => 'प्रोटीन';

  @override
  String get goalsFibers => 'फाइबर';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g प्रति दिन';
  }

  @override
  String get goalsWater => 'पानी';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value L प्रति दिन';
  }

  @override
  String get goalsExercise => 'व्यायाम';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value मिनट प्रति दिन';
  }

  @override
  String get goalsMeals => 'भोजन';

  @override
  String get goalsCalories => 'कैलोरी';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'प्रति सप्ताह';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count भोजन प्रति दिन';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal प्रति दिन';
  }

  @override
  String get goalsWeight => 'वजन';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'गति की गणना करने के लिए वजन और खुराक लॉग करें।';

  @override
  String get goalsAlreadyAtThisTarget => 'आप पहले से ही इस लक्ष्य पर हैं';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return 'लक्ष्य तक $value $unit/सप्ताह';
  }

  @override
  String get goalsSetTargetForNextWeek => 'अगले सप्ताह के लिए लक्ष्य सेट करें।';

  @override
  String get progressWeightTitle => 'वजन';

  @override
  String get progressWeightLabel => 'वजन ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'स्वस्थ BMI';

  @override
  String get progressTotal => 'कुल';

  @override
  String get progressPercent => 'प्रतिशत';

  @override
  String get progressWeeklyAvg => 'साप्ताहिक औसत';

  @override
  String get progressRangeAllTime => 'पूरे समय';

  @override
  String get progressRange1Month => '1 महीना';

  @override
  String get progressRange3Months => '3 महीने';

  @override
  String get progressRange6Months => '6 महीने';

  @override
  String get progressLow => 'कम';

  @override
  String get progressMed => 'मध्यम';

  @override
  String get progressHigh => 'उच्च';

  @override
  String get progressSeverity => 'गंभीरता';

  @override
  String get progressBad => 'खराब';

  @override
  String get progressOkay => 'ठीक';

  @override
  String get progressGood => 'अच्छा';

  @override
  String get progressGreat => 'बहुत अच्छा';

  @override
  String get progressMostlyBad => 'अधिकतर खराब';

  @override
  String get progressMostlyOkay => 'अधिकतर ठीक';

  @override
  String get progressMostlyGood => 'अधिकतर अच्छा';

  @override
  String get progressMostlyGreat => 'अधिकतर बहुत अच्छा';

  @override
  String get progressNoDose => 'कोई खुराक नहीं';

  @override
  String get progressLogged => 'लॉग किया गया';

  @override
  String get progressAllClear => 'सब ठीक';

  @override
  String get progressFreq => 'आवृत्ति';

  @override
  String get progressAverage => 'औसत';

  @override
  String get progressDaily => 'दैनिक';

  @override
  String get progressWeekly => 'साप्ताहिक';

  @override
  String get progressMinutes => 'मिनट';

  @override
  String get progressIntensity => 'तीव्रता';

  @override
  String get progressCalories => 'कैलोरी';

  @override
  String get progressByDose => 'खुराक के अनुसार';

  @override
  String get progressWeightProgressTitle => 'वजन प्रगति';

  @override
  String get progressWaterProgressTitle => 'पानी प्रगति';

  @override
  String get progressExerciseProgressTitle => 'व्यायाम प्रगति';

  @override
  String get progressDoseProgressTitle => 'खुराक प्रगति';

  @override
  String get progressMealsProgressTitle => 'भोजन प्रगति';

  @override
  String get progressSymptomsProgressTitle => 'लक्षण प्रगति';

  @override
  String get progressMoodProgressTitle => 'मूड प्रगति';

  @override
  String get progressCravingsProgressTitle => 'क्रेविंग प्रगति';

  @override
  String get progressResisted => 'रोका गया';

  @override
  String get progressCravingsResistedSubtitle =>
      'लॉग की गई क्रेविंग में से जितनी आपने रोकीं, उनका हिस्सा।';

  @override
  String get progressWeightChangeTitle => 'वजन में बदलाव';

  @override
  String get progressTitle => 'प्रगति';

  @override
  String get progressMenuViewAllInsights => 'सभी अंतर्दृष्टियाँ देखें';

  @override
  String get progressMenuViewAllCharts => 'सभी चार्ट देखें';

  @override
  String get progressMenuCreateDoctorReport => 'डॉक्टर रिपोर्ट बनाएं';

  @override
  String get progressReportGenerating => 'आपकी रिपोर्ट बनाई जा रही है…';

  @override
  String get progressReportError =>
      'रिपोर्ट नहीं बन सकी. कृपया फिर कोशिश करें.';

  @override
  String get progressReportPendingRetry =>
      'आपकी रिपोर्ट एक क्षण में पूरी हो सकती है। कृपया फिर से प्रयास करें।';

  @override
  String get progressReportOpenError =>
      'आपकी रिपोर्ट बन गई, लेकिन हम उसे खोल नहीं सके। कृपया फिर से प्रयास करें।';

  @override
  String get progressAllProgressTitle => 'सभी प्रगति';

  @override
  String get progressWeightTrendExplanation =>
      'देखें कि समय के साथ आपका वजन कैसे बदलता है।';

  @override
  String get progressNoWeightLogsYet => 'अभी तक वजन के लॉग नहीं हैं';

  @override
  String get progressNoLogsYet => 'अभी तक लॉग नहीं हैं';

  @override
  String get progressLogWeightToStartTrend =>
      'रुझान शुरू करने के लिए वजन लॉग करें।';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'बदलाव की तुलना करने के लिए वजन और खुराक लॉग करें।';

  @override
  String get progressEachPointColoredByLatestDose =>
      'हर बिंदु को नवीनतम खुराक के अनुसार रंगा गया है।';

  @override
  String get progressNoHydrationYet => 'अभी तक हाइड्रेशन लॉग नहीं हैं';

  @override
  String get progressNoMovementYet => 'अभी तक व्यायाम लॉग नहीं हैं';

  @override
  String get progressNoDoseLogsYet => 'अभी तक खुराक लॉग नहीं हैं';

  @override
  String get progressNoMealsLoggedYet => 'अभी तक भोजन लॉग नहीं हैं';

  @override
  String get progressNoSymptomsLoggedYet => 'अभी तक लक्षण लॉग नहीं हैं';

  @override
  String get progressNoMoodLogsYet => 'अभी तक मूड लॉग नहीं हैं';

  @override
  String get progressNoCravingsLoggedYet => 'अभी तक कोई क्रेविंग लॉग नहीं है';

  @override
  String get progressFutureTrendTitle => 'भविष्य का रुझान';

  @override
  String get progressFutureTrendBody => 'आपकी गति के लिए एक सुंदर टाइमलाइन';

  @override
  String get progressGoal => 'लक्ष्य';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'हाल ही में लॉग किया गया वजन ट्रैक करने के लिए तैयार है।';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'लक्ष्य से लगभग $gap $unit।';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return 'पिछले लॉग की तुलना में $deltaText।';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return 'पिछले लॉग की तुलना में $deltaText। लक्ष्य तक $gap $unit।';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'पिछले लॉग की तुलना में अब रुझान स्पष्ट है।';

  @override
  String get progressWaterTitle => 'पानी';

  @override
  String get manageSubscriptionTitle => 'सदस्यता प्रबंधित करें';

  @override
  String get manageSubscriptionProPlan => 'Pro प्लान';

  @override
  String get manageSubscriptionFreePlan => 'मुफ्त प्लान';

  @override
  String get manageSubscriptionActiveCopy => 'आपकी सदस्यता सक्रिय है।';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Glu Pro अनलॉक करने के लिए अपग्रेड करें।';

  @override
  String get manageSubscriptionPlan => 'प्लान';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'मुफ्त';

  @override
  String get manageSubscriptionProduct => 'उत्पाद';

  @override
  String get manageSubscriptionRenewal => 'नवीनीकरण';

  @override
  String get manageSubscriptionStatus => 'स्थिति';

  @override
  String get manageSubscriptionStatusActive => 'सक्रिय';

  @override
  String get manageSubscriptionStatusInactive => 'निष्क्रिय';

  @override
  String get manageSubscriptionManageButton => 'सदस्यता प्रबंधित करें';

  @override
  String get manageSubscriptionUpgradeButton => 'Pro में अपग्रेड करें';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'स्टोर की सदस्यता सेटिंग्स खोलें';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases =>
      'खरीदारियाँ पुनर्स्थापित करें';

  @override
  String get manageSubscriptionRenewsAutomatically => 'स्वतः नवीनीकृत होता है';

  @override
  String get manageSubscriptionLifetime => 'आजीवन';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return '$date को नवीनीकृत होगा';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return '$date को समाप्त होगा';
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
    return '$count दिनों में';
  }

  @override
  String get supplementReminderInOneWeek => '1 सप्ताह में';

  @override
  String supplementReminderInWeeks(Object count) {
    return '$count सप्ताह में';
  }

  @override
  String get subscriptionDebugTitle => 'Glu सदस्यता डिबग';

  @override
  String get subscriptionDebugMonthly => 'मासिक';

  @override
  String get subscriptionDebugYearly => 'वार्षिक';

  @override
  String get subscriptionDebugRefreshCustomerInfo =>
      'ग्राहक जानकारी रिफ्रेश करें';

  @override
  String get subscriptionDebugPresentPaywall => 'पेवल दिखाएँ';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'कस्टमर सेंटर खोलें';

  @override
  String get subscriptionDebugRestorePurchases =>
      'खरीदारियाँ पुनर्स्थापित करें';

  @override
  String get subscriptionDebugSyncPurchases => 'खरीदारियाँ सिंक करें';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat स्थिति';

  @override
  String get subscriptionDebugConfigured => 'कॉन्फ़िगर किया गया';

  @override
  String get subscriptionDebugBusy => 'व्यस्त';

  @override
  String get subscriptionDebugAppUserId => 'ऐप यूज़र ID';

  @override
  String get subscriptionDebugAnonymous => 'गुमनाम';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API कुंजी उपलब्ध है';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro सक्रिय है';

  @override
  String get subscriptionDebugActiveSubscriptions => 'सक्रिय सदस्यताएँ';

  @override
  String get subscriptionDebugManagementUrl => 'प्रबंधन URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'एंटाइटलमेंट उत्पाद';

  @override
  String get subscriptionDebugWillRenew => 'नवीनीकृत होगा';

  @override
  String get subscriptionDebugExpiration => 'समाप्ति';

  @override
  String get subscriptionDebugLifetime => 'आजीवन';

  @override
  String get subscriptionDebugPackageFound => 'पैकेज मिला';

  @override
  String get subscriptionDebugProductId => 'उत्पाद ID';

  @override
  String get subscriptionDebugTitleLabel => 'शीर्षक';

  @override
  String get subscriptionDebugPrice => 'कीमत';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'खरीदें $title';
  }

  @override
  String get progressExerciseTitle => 'व्यायाम';

  @override
  String get progressDoseTitle => 'खुराक';

  @override
  String get progressMealsTitle => 'भोजन';

  @override
  String get progressSymptomsTitle => 'लक्षण';

  @override
  String get progressMoodTitle => 'मूड';

  @override
  String get progressCravingsTitle => 'क्रेविंग';

  @override
  String get progressTrend => 'रुझान';

  @override
  String get progressTarget => 'लक्ष्य';

  @override
  String get progressNoTrendYet => 'अभी कोई रुझान नहीं';

  @override
  String get progressNoActivityYet => 'अभी कोई गतिविधि नहीं';

  @override
  String get progressNoCheckInsYet => 'अभी कोई चेक-इन नहीं';

  @override
  String get progressWeightSignatureChip => 'वजन आपका सिग्नेचर चार्ट बन जाएगा';

  @override
  String get progressWeightStartTrendTitle =>
      'एक वेट-इन से अपना रुझान शुरू करें';

  @override
  String get progressWeightStartTrendBody =>
      'यह चार्ट आपकी प्रगति कहानी का केंद्र है। अपनी पहली वजन प्रविष्टि लॉग करें ताकि गति, माइलस्टोन और साझा करने योग्य दृश्य अनलॉक हो सकें।';

  @override
  String get progressWeightMomentum => 'गति';

  @override
  String get progressWeightMilestones => 'माइलस्टोन';

  @override
  String get progressWeightShareReady => 'साझा करने के लिए तैयार';

  @override
  String get progressWeightLogWeight => 'वजन लॉग करें';

  @override
  String get weightProgressUnlocksViewChip =>
      'आपकी पहली वजन प्रविष्टि इस दृश्य को अनलॉक करती है';

  @override
  String get weightProgressStartsHereTitle =>
      'आपकी प्रगति कहानी यहाँ से शुरू होती है';

  @override
  String get weightProgressStartsHereBody =>
      'रुझान, माइलस्टोन और खुराक-आधारित अंतर्दृष्टि को अनलॉक करने के लिए अपना पहला वजन लॉग करें।';

  @override
  String get weightProgressTrendView => 'रुझान दृश्य';

  @override
  String get weightProgressDoseOverlays => 'खुराक ओवरले';

  @override
  String get weightProgressMilestones => 'माइलस्टोन';

  @override
  String get weightProgressLogWeight => 'वजन लॉग करें';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'पहले एक पहले और बाद की फोटो जोड़ें।';

  @override
  String get glowUpSavedToGallery => 'आपकी गैलरी में सहेजा गया';

  @override
  String get glowUpSaveToGallery => 'गैलरी में सहेजें';

  @override
  String get glowUpYourProgress => 'आपकी प्रगति';

  @override
  String get glowUpWeightChange => 'वजन में बदलाव';

  @override
  String get glowUpTime => 'समय';

  @override
  String get glowUpShare => 'साझा करें';

  @override
  String get glowUpBefore => 'पहले';

  @override
  String get glowUpAfter => 'बाद में';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$time में $weight';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'दिन';

  @override
  String get glowUpTimeUnitWeeksLabel => 'सप्ताह';

  @override
  String get glowUpTimeUnitMonthsLabel => 'महीने';

  @override
  String get glowUpTimeUnitYearsLabel => 'वर्ष';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count दिन',
      one: '$count दिन',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count सप्ताह',
      one: '$count सप्ताह',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count महीने',
      one: '$count महीना',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count वर्ष',
      one: '$count वर्ष',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'कल';

  @override
  String get commonSelect => 'चुनें';

  @override
  String get doseReminderTitle => 'खुराक रिमाइंडर';

  @override
  String get doseReminderCustomDoseTitle => 'कस्टम खुराक';

  @override
  String get doseReminderCustomDoseHint => 'mg में खुराक लिखें';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'अपनी अगली खुराक होम पर तैयार रखें।';

  @override
  String get doseReminderTime => 'समय';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'अगली खुराक होम पर दिखाने के लिए इसे चालू करें।';

  @override
  String get doseReminderSaveReminder => 'रिमाइंडर सहेजें';

  @override
  String loggedOn(Object date) {
    return '$date को लॉग किया गया';
  }

  @override
  String get waterLogSmallGlass => 'छोटा गिलास';

  @override
  String get waterLogGlass => 'गिलास';

  @override
  String get waterLogBottle => 'बोतल';

  @override
  String get waterLogLargeBottle => 'बड़ी बोतल';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'कस्टम';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'खुराक';

  @override
  String get doseLogEditTitle => 'खुराक संपादित करें';

  @override
  String get doseLogLogTitle => 'खुराक लॉग करें';

  @override
  String get doseLogCustomDose => 'कस्टम खुराक';

  @override
  String get doseLogCustomDoseBody =>
      'इस लॉग के लिए mg में खुराक समायोजित करें।';

  @override
  String get doseLogUseThisDose => 'इस खुराक का उपयोग करें';

  @override
  String get doseLogMedication => 'दवा';

  @override
  String get doseLogInjectionSite => 'साइट';

  @override
  String get doseLogNotes => 'नोट्स';

  @override
  String get doseLogSaveChanges => 'बदलाव सहेजें';

  @override
  String get doseLogAddDose => '+ खुराक लॉग करें';

  @override
  String get doseLogDeleteTitle => 'क्या यह खुराक लॉग हटाएँ?';

  @override
  String get doseLogDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get doseLogDeleteLog => 'लॉग हटाएँ';

  @override
  String get doseLogSaving => 'सहेजा जा रहा है...';

  @override
  String get doseLogCouldNotSave => 'इस खुराक लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get doseLogCouldNotDelete => 'इस खुराक लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get doseLogDeleted => 'खुराक हटाई गई';

  @override
  String get doseLogAddedToDoseLog => 'आपके खुराक लॉग में जोड़ा गया';

  @override
  String get doseLogAnythingWorthRemembering =>
      'इस खुराक के बारे में याद रखने लायक कुछ है?';

  @override
  String get doseLogDoseLabel => 'खुराक';

  @override
  String get exerciseLogTitle => 'व्यायाम';

  @override
  String get exerciseLogEditTitle => 'व्यायाम संपादित करें';

  @override
  String get exerciseLogLogTitle => 'व्यायाम लॉग';

  @override
  String get exerciseLogActivityType => 'गतिविधि प्रकार';

  @override
  String get exerciseLogCustomActivity => 'कस्टम गतिविधि';

  @override
  String get exerciseLogTypeActivity => 'गतिविधि लिखें';

  @override
  String get exerciseLogDuration => 'अवधि';

  @override
  String get exerciseLogIntensity => 'तीव्रता';

  @override
  String get exerciseLogNotes => 'नोट्स';

  @override
  String get exerciseLogLight => 'हल्का';

  @override
  String get exerciseLogModerate => 'मध्यम';

  @override
  String get exerciseLogIntense => 'तेज़';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes मिनट लॉग किए गए';
  }

  @override
  String get exerciseLogSaveChanges => 'बदलाव सहेजें';

  @override
  String get exerciseLogAddExercise => '+ व्यायाम लॉग जोड़ें';

  @override
  String get exerciseLogDeleteTitle => 'क्या यह व्यायाम लॉग हटाएँ?';

  @override
  String get exerciseLogDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get exerciseLogDeleteLog => 'लॉग हटाएँ';

  @override
  String get exerciseLogSaving => 'सहेजा जा रहा है...';

  @override
  String get exerciseLogCouldNotSave =>
      'इस व्यायाम लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get exerciseLogCouldNotDelete =>
      'इस व्यायाम लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get exerciseLogDeleted => 'गतिविधि हटाई गई';

  @override
  String get exerciseLogAddedToExerciseLog => 'व्यायाम लॉग में जोड़ा गया';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'इस सत्र के बारे में याद रखने लायक कुछ है?';

  @override
  String get exerciseLogWalking => 'चलना';

  @override
  String get exerciseLogRunning => 'दौड़ना';

  @override
  String get exerciseLogCycling => 'साइक्लिंग';

  @override
  String get exerciseLogStrength => 'ताकत';

  @override
  String get exerciseLogYoga => 'योग';

  @override
  String get exerciseLogSwim => 'तैराकी';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'वजन';

  @override
  String get weightLogEditTitle => 'वजन संपादित करें';

  @override
  String get weightLogLogTitle => 'वजन लॉग';

  @override
  String get weightLogSaveChanges => 'बदलाव सहेजें';

  @override
  String weightLogAddWeight(Object label) {
    return '+ वजन जोड़ें ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'क्या यह वजन लॉग हटाएँ?';

  @override
  String get weightLogDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get weightLogDeleteLog => 'लॉग हटाएँ';

  @override
  String get weightLogSaving => 'सहेजा जा रहा है...';

  @override
  String get weightLogCouldNotSave => 'इस वजन लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get weightLogCouldNotDelete => 'इस वजन लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get weightLogDeleted => 'वजन हटाया गया';

  @override
  String get weightLogAddedToWeightLog => 'वजन लॉग में जोड़ा गया';

  @override
  String get weightLogNoWeightForDay =>
      'इस दिन के लिए अभी तक वजन लॉग नहीं किया गया है।';

  @override
  String get injectionSiteAbdomen => 'पेट';

  @override
  String get injectionSiteThigh => 'जांघ';

  @override
  String get injectionSiteUpperArm => 'ऊपरी भुजा';

  @override
  String get injectionSiteButtocks => 'नितंब';

  @override
  String get injectionSiteAbdomenUpperLeft => 'पेट, ऊपरी बाएँ';

  @override
  String get injectionSiteAbdomenUpperRight => 'पेट, ऊपरी दाएँ';

  @override
  String get injectionSiteAbdomenLowerRight => 'पेट, निचला दाएँ';

  @override
  String get injectionSiteAbdomenLowerLeft => 'पेट, निचला बाएँ';

  @override
  String get injectionSiteThighUpperLeft => 'जांघ, ऊपरी बाएँ';

  @override
  String get injectionSiteThighUpperRight => 'जांघ, ऊपरी दाएँ';

  @override
  String get injectionSiteThighLowerRight => 'जांघ, निचला दाएँ';

  @override
  String get injectionSiteThighLowerLeft => 'जांघ, निचला बाएँ';

  @override
  String get injectionSiteUpperArmLeft => 'ऊपरी भुजा, बाएँ';

  @override
  String get injectionSiteUpperArmRight => 'ऊपरी भुजा, दाएँ';

  @override
  String get injectionSiteButtocksUpperLeft => 'नितंब, ऊपरी बाएँ';

  @override
  String get injectionSiteButtocksUpperRight => 'नितंब, ऊपरी दाएँ';

  @override
  String get doseReminderFormat => 'फॉर्मेट';

  @override
  String get doseReminderInjection => 'इंजेक्शन';

  @override
  String get doseReminderPill => 'गोली';

  @override
  String get doseReminderSite => 'साइट';

  @override
  String get doseReminderDate => 'तारीख';

  @override
  String get supplementReminderTitle => 'सप्लीमेंट रिमाइंडर';

  @override
  String get supplementReminderAddSupplement => 'सप्लीमेंट जोड़ें';

  @override
  String get supplementReminderNoSupplementsYet => 'अभी कोई सप्लीमेंट नहीं';

  @override
  String get supplementReminderAddFirstBody =>
      'अपनी दैनिक खपत ट्रैक करने के लिए अपना पहला सप्लीमेंट रिमाइंडर जोड़ें।';

  @override
  String get supplementReminderSupplementFallback => 'सप्लीमेंट';

  @override
  String get supplementReminderEveryDay => 'हर दिन';

  @override
  String get supplementReminderEveryXDaysLabel => 'हर X दिन';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'हर $interval दिन';
  }

  @override
  String get supplementReminderNoDaysSet => 'कोई दिन सेट नहीं';

  @override
  String get supplementReminderSupplementName => 'सप्लीमेंट नाम';

  @override
  String get supplementReminderTime => 'समय';

  @override
  String get supplementReminderStartDate => 'शुरू करने की तारीख';

  @override
  String get supplementReminderRepeat => 'दोहराएँ';

  @override
  String get supplementReminderDaysOfWeek => 'सप्ताह के दिन';

  @override
  String get supplementReminderSelectAtLeastOneDay => 'कम से कम एक दिन चुनें।';

  @override
  String get supplementReminderEvery => 'हर';

  @override
  String get supplementReminderDay => 'दिन';

  @override
  String get supplementReminderDays => 'दिन';

  @override
  String get supplementReminderAdd => 'जोड़ें';

  @override
  String get symptomsLogTitle => 'लक्षण';

  @override
  String get symptomsLogEditTitle => 'लक्षण संपादित करें';

  @override
  String get symptomsLogLogTitle => 'लक्षण लॉग';

  @override
  String get symptomsLogSymptomsExperienced => 'अनुभव किए गए लक्षण';

  @override
  String get symptomsLogNoSymptoms => 'कोई लक्षण नहीं';

  @override
  String get symptomsLogNoSymptomsToday => 'आज कोई लक्षण नहीं';

  @override
  String get symptomsLogOther => 'अन्य...';

  @override
  String get symptomsLogSeverityLevel => 'तीव्रता स्तर';

  @override
  String get symptomsLogNotes => 'नोट्स';

  @override
  String get symptomsLogAnxiety => 'चिंता';

  @override
  String get symptomsLogBelching => 'डकार';

  @override
  String get symptomsLogBloating => 'सूजन';

  @override
  String get symptomsLogConstipation => 'कब्ज';

  @override
  String get symptomsLogDiarrhea => 'दस्त';

  @override
  String get symptomsLogFatigue => 'थकान';

  @override
  String get symptomsLogFoodNoise => 'खाने का शोर';

  @override
  String get symptomsLogHairLoss => 'बाल झड़ना';

  @override
  String get symptomsLogHeartburn => 'सीने में जलन';

  @override
  String get symptomsLogIndigestion => 'अपच';

  @override
  String get symptomsLogInjectionSiteReaction => 'इंजेक्शन साइट प्रतिक्रिया';

  @override
  String get symptomsLogMetallicTaste => 'धातु जैसा स्वाद';

  @override
  String get symptomsLogHeadache => 'सिरदर्द';

  @override
  String get symptomsLogMoodSwings => 'मूड स्विंग्स';

  @override
  String get symptomsLogNausea => 'मतली';

  @override
  String get symptomsLogReflux => 'रिफ्लक्स';

  @override
  String get symptomsLogStomachPain => 'पेट दर्द';

  @override
  String get symptomsLogSuppressedAppetite => 'दबी हुई भूख';

  @override
  String get symptomsLogVomiting => 'उल्टी';

  @override
  String get symptomsLogLogged => 'लक्षण लॉग किया गया';

  @override
  String get symptomsLogMild => 'हल्का';

  @override
  String get symptomsLogModerate => 'मध्यम';

  @override
  String get symptomsLogSevere => 'गंभीर';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'आप कैसा महसूस कर रहे थे, इसके बारे में कुछ याद रखने लायक है?';

  @override
  String get symptomsLogSaveChanges => 'बदलाव सहेजें';

  @override
  String get symptomsLogAddSymptoms => '+ लक्षण लॉग जोड़ें';

  @override
  String get symptomsLogDeleteTitle => 'क्या यह लक्षण लॉग हटाएँ?';

  @override
  String get symptomsLogDeleteMessage => 'यह कार्रवाई वापस नहीं ली जा सकती।';

  @override
  String get symptomsLogDeleteLog => 'लॉग हटाएँ';

  @override
  String get symptomsLogSaving => 'सहेजा जा रहा है...';

  @override
  String get symptomsLogCouldNotSave =>
      'इस लक्षण लॉग को अभी सहेजा नहीं जा सका।';

  @override
  String get symptomsLogCouldNotDelete =>
      'इस लक्षण लॉग को अभी हटाया नहीं जा सका।';

  @override
  String get symptomsLogDeleted => 'लक्षण हटाया गया';

  @override
  String get symptomsLogAddedToSymptomsLog => 'आपके लक्षण लॉग में जोड़ा गया';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% दैनिक लक्ष्य';
  }

  @override
  String get commonDisclaimer =>
      'Glu एक ट्रैकिंग टूल है, मेडिकल डिवाइस नहीं। यह चिकित्सीय सलाह, निदान या उपचार नहीं देता। अपनी दवा और स्वास्थ्य निर्णयों के लिए हमेशा अपने डॉक्टर से सलाह लें।';
}
