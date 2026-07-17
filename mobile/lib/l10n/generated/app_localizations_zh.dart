// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => '正在启动...';

  @override
  String get startupFailed => '启动失败';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonSaving => '保存中...';

  @override
  String get commonContinue => '继续';

  @override
  String get commonSkip => '跳过';

  @override
  String get commonDelete => '删除';

  @override
  String get commonNotNow => '暂不';

  @override
  String get commonNow => '现在';

  @override
  String get commonTomorrow => '明天';

  @override
  String get noteTriggerAddNote => '添加备注';

  @override
  String get noteTriggerCancelNote => '取消备注';

  @override
  String homeDoseReminderInDays(Object count) {
    return '$count 天后';
  }

  @override
  String get homeDoseReminderInOneWeek => '1 周后';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return '$count 周后';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => '已延后 1 天';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return '已延后 $count 天';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => '已延后 1 周';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return '已延后 $count 周';
  }

  @override
  String get bmiIndicatorYourBmi => '你的 BMI';

  @override
  String get bmiIndicatorCurrentBmi => '你当前的 BMI';

  @override
  String get bmiIndicatorUnderweight => '偏瘦';

  @override
  String get bmiIndicatorNormal => '正常';

  @override
  String get bmiIndicatorOverweight => '超重';

  @override
  String get bmiIndicatorObesity => '肥胖';

  @override
  String get heightRulerCmUnit => '厘米';

  @override
  String get heightRulerFtUnit => '英尺';

  @override
  String get heightRulerInUnit => '英寸';

  @override
  String get heightRulerFtInUnit => '英尺/英寸';

  @override
  String get weightDialKgUnit => '公斤';

  @override
  String get weightDialLbUnit => '磅';

  @override
  String get logNoteIndicatorHasNote => '有备注';

  @override
  String get paywallTitle => '解锁 Glu Pro';

  @override
  String get paywallSubtitle => '没有 Pro，你将失去：';

  @override
  String get paywallMonthlyTitle => '月付';

  @override
  String get paywallMonthlySubtitle => '无试用';

  @override
  String get paywallYearlyTitle => '年付';

  @override
  String get paywallYearlySubtitle => '7 天免费试用';

  @override
  String get paywallNoCommitment => '无承诺';

  @override
  String get paywallCancelAnytime => '随时取消';

  @override
  String get paywallContinue => '继续';

  @override
  String get paywallRestore => '恢复';

  @override
  String get paywallTerms => '条款';

  @override
  String get paywallPrivacy => '隐私';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return '节省 $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => '当前无法打开链接。';

  @override
  String get paywallAlreadySubscribed => '你已经拥有 Glu Pro。';

  @override
  String get paywallPurchaseSuccess => '欢迎使用 Glu Pro！';

  @override
  String get paywallPurchaseIncomplete => '购买未完成，请重试。';

  @override
  String get paywallPurchaseFailed => '购买失败，请重试。';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return '购买失败：$errorCode';
  }

  @override
  String get paywallRestoreSuccess => '订阅已恢复！';

  @override
  String get paywallRestoreNoSubscription => '未找到有效订阅。';

  @override
  String get paywallRestoreFailed => '恢复失败，请重试。';

  @override
  String get paywallBenefitReminders => '没有提醒，容易漏打剂量';

  @override
  String get paywallBenefitShareProgress => '更难分享你的进展';

  @override
  String get paywallBenefitSpotRegain => '错过体重反弹的迹象';

  @override
  String get paywallBenefitInsights => '错过你的每日规律';

  @override
  String get paywallBenefitWeeklyGoals => '失去每周的节奏';

  @override
  String get paywallBenefitHealthyHabits => '没有支持，习惯容易松懈';

  @override
  String get onboardingWelcomeTitle => '保持体重不反弹';

  @override
  String get onboardingWelcomeSubtitle => 'Glu 帮助你围绕治疗、目标和每周习惯保护你的进展。';

  @override
  String get onboardingWelcomeBullet1 => '适配你的治疗和目标';

  @override
  String get onboardingWelcomeBullet2 => '简单且现实的支持';

  @override
  String get onboardingWelcomeBullet3 => '更容易发现体重反弹的早期迹象';

  @override
  String get onboardingWelcomeBullet4 => '继续前进，而不是从头再来';

  @override
  String get onboardingMedicationStatusQuestion => '你目前正在使用减重笔或药片类药物吗？';

  @override
  String get onboardingMedicationStatusExplainer => '我们用它来展示与你当前阶段相匹配的指导。';

  @override
  String get onboardingMedicationStatusUsing => '是，我现在正在用';

  @override
  String get onboardingMedicationStatusWeaningOff => '是，我正在减量';

  @override
  String get onboardingMedicationStatusNotTaking => '不，我没有在用';

  @override
  String get onboardingMedicationStatusStartingSoon => '不，我很快会开始';

  @override
  String get onboardingMedicationStatusRecentlyStopped => '不，我最近刚停用';

  @override
  String get onboardingMedicationMethodQuestion => '你如何使用你的药物？';

  @override
  String get onboardingMedicationMethodExplainer => '我们用它来根据你的用药形式调整说明和提醒。';

  @override
  String get onboardingMedicationMethodInjection => '注射';

  @override
  String get onboardingMedicationMethodPill => '药片';

  @override
  String get onboardingMedicationMethodUnknown => '我还不知道';

  @override
  String get onboardingMedicationNameQuestion => '你正在使用哪种药物？';

  @override
  String get onboardingMedicationNameExplainer => '我们用它来个性化剂量追踪和药物相关指导。';

  @override
  String get onboardingCurrentDoseQuestion => '你当前的剂量是多少？';

  @override
  String get onboardingCurrentDoseExplainer => '我们用它来调整剂量追踪和未来的进展检查。';

  @override
  String get onboardingMedicationCustomDose => '自定义';

  @override
  String get onboardingDeviceTypeQuestion => '你用什么设备来用药？';

  @override
  String get onboardingDeviceTypeExplainer => '我们用它让提醒和建议更贴合你的使用方式。';

  @override
  String get onboardingDeviceSinglePen => '单支笔';

  @override
  String get onboardingDeviceAutoInjector => '自动注射器';

  @override
  String get onboardingDeviceSyringeAndVial => '注射器和药瓶';

  @override
  String get onboardingOther => '其他';

  @override
  String get onboardingTypeYourDevice => '输入你的设备';

  @override
  String get onboardingMedicationFrequencyQuestion => '你多久用一次药？';

  @override
  String get onboardingMedicationFrequencyExplainer => '我们用它根据你的日程安排提醒和日常支持。';

  @override
  String get onboardingEveryDay => '每天';

  @override
  String get onboardingEvery7Days => '每 7 天';

  @override
  String get onboardingEvery14Days => '每 14 天';

  @override
  String get onboardingCustom => '自定义';

  @override
  String get onboardingDaysBetweenDoses => '每次剂量间隔天数';

  @override
  String get onboardingPrimaryGoalQuestion => '你现在最主要的目标是什么？';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      '我们用它把你的计划、提醒和进展聚焦在最重要的事情上。';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      '我们用它从一开始就塑造你的计划。';

  @override
  String get onboardingPrimaryGoalExplainerDefault => '我们用它支持你的下一阶段，并帮助你保持节奏。';

  @override
  String get onboardingGoalLoseWeight => '减重';

  @override
  String get onboardingGoalMaintainWeight => '保持体重';

  @override
  String get onboardingGoalManageDiabetes => '管理糖尿病';

  @override
  String get onboardingGoalManagePcos => '管理多囊卵巢综合征';

  @override
  String get onboardingGoalImproveHeartHealth => '改善心脏健康';

  @override
  String get onboardingAgeQuestion => '你多大了？';

  @override
  String get onboardingAgeExplainer => '我们用它来更合适地调整指导和健康计算。';

  @override
  String get onboardingHeightQuestion => '你的身高是多少？';

  @override
  String get onboardingHeightExplainer => '我们将它与你的体重一起用于计算 BMI 和健康范围。';

  @override
  String get onboardingWeightQuestion => '你当前的体重是多少？';

  @override
  String get onboardingWeightExplainer => '我们把它作为你的起点，用于进展、目标和健康估算。';

  @override
  String get onboardingMedicationStartedQuestionStopped => '你是什么时候停药的？';

  @override
  String get onboardingMedicationStartedQuestionWeaning => '你是什么时候开始减量的？';

  @override
  String get onboardingMedicationStartedQuestionStarted => '你是什么时候开始用药的？';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      '我们用它来了解你最近的治疗历史和下一阶段。';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      '我们用它来了解你的过渡阶段，并支持现在最重要的习惯。';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      '我们用它来了解你接受治疗多久，并跟踪变化。';

  @override
  String get onboardingGoalWeightQuestion => '你的目标体重是多少？';

  @override
  String get onboardingGoalWeightExplainer => '我们用它来呈现进展，并为你显示一个目标 BMI 范围。';

  @override
  String get onboardingBenefitsQuestion => 'Glu 接下来能帮你做什么';

  @override
  String get onboardingBenefitsExplainer => 'Glu 会把你分享的信息转化为适合你日常的提醒、支持和结构。';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle => '看看 Glu 如何帮助你维持进展';

  @override
  String get onboardingBenefitsHeroDiabetesTitle => '看看 Glu 如何支持你的糖尿病日常';

  @override
  String get onboardingBenefitsHeroPcosTitle => '看看 Glu 如何支持你的多囊卵巢日常';

  @override
  String get onboardingBenefitsHeroHeartTitle => '看看 Glu 如何支持你的心脏健康';

  @override
  String get onboardingBenefitsHeroWeightLossTitle => '看看 Glu 如何帮助你减重';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      '看看 Glu 如何帮助你保护当前体重，并及早发现反弹。';

  @override
  String get onboardingBenefitsHeroDiabetesBody => '看看 Glu 如何帮助你让餐食、体重和日常更稳定。';

  @override
  String get onboardingBenefitsHeroPcosBody => '看看 Glu 如何帮助你在症状、体重和日常上更稳定。';

  @override
  String get onboardingBenefitsHeroHeartBody => '看看 Glu 如何帮助你保持支持心脏健康的习惯。';

  @override
  String get onboardingBenefitsHeroWeightLossBody => '看看 Glu 如何帮助你发现让体重下降的模式。';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      '没有结构时，反弹会悄悄累积。Glu 帮助你更早发现并保持稳定。';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      '没有结构时，餐食和体重模式会更难看清。Glu 让信号更清晰。';

  @override
  String get onboardingBenefitsSpecificPcos => '没有结构时，症状和日常可能更容易波动。Glu 帮助你更稳定。';

  @override
  String get onboardingBenefitsSpecificHeart =>
      '没有结构时，健康习惯容易偏离。Glu 帮助你保持活动和体重在正确轨道。';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      '没有结构时，体重可能停滞或回升。Glu 帮助你把进展保持在正确方向。';

  @override
  String get onboardingBenefitsAxisWeight => '体重';

  @override
  String get onboardingBenefitsAxisMealsWeight => '餐食与体重';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => '症状与体重';

  @override
  String get onboardingBenefitsAxisExerciseWeight => '运动与体重';

  @override
  String get onboardingNotificationsQuestion => '开启支持你目标的提醒';

  @override
  String get onboardingNotificationsExplainer => '我们会用通知帮助你保持一致、做好准备并维持节奏。';

  @override
  String get onboardingNotificationsHeadline => '让 Glu 在合适的时刻帮助你。';

  @override
  String get onboardingNotificationsBody => '开启通知，让 Glu 强化支持你目标的习惯。';

  @override
  String get onboardingNotificationsDaily => '与你每日用药节奏相匹配的定时提醒';

  @override
  String get onboardingNotificationsEvery14Days => '更长周期的提醒，让剂量日不会悄悄到来';

  @override
  String get onboardingNotificationsCustom => '围绕你的自定义日程设计的提醒';

  @override
  String get onboardingNotificationsWeekly => '与每周节奏保持一致的剂量提醒';

  @override
  String get onboardingNotificationsSupportive => '在动力下降时仍能让你的日常保持可见的支持性提醒';

  @override
  String get onboardingNotificationsProgress => '围绕进展、习惯和你说过最重要的目标发出的及时提醒';

  @override
  String get onboardingNotificationsHelpful => '在你最需要的时候，让 Glu 更有用的实用提示';

  @override
  String get onboardingDailyRoutineQuestion => '你的日常节奏是怎样的？';

  @override
  String get onboardingDailyRoutineExplainer => '我们用它让你的计划更贴近真实的日常。';

  @override
  String get onboardingRoutineSedentary => '久坐';

  @override
  String get onboardingRoutineSedentaryDescription => '大多坐着、办公桌工作，几乎没有主动运动。';

  @override
  String get onboardingRoutineLightlyActive => '轻度活跃';

  @override
  String get onboardingRoutineLightlyActiveDescription => '每周几次散步、跑腿或轻量训练。';

  @override
  String get onboardingRoutineActive => '活跃';

  @override
  String get onboardingRoutineActiveDescription => '经常活动或锻炼，例如每天散步、健身房或活跃型工作。';

  @override
  String get onboardingRoutineVeryActive => '非常活跃';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      '高强度训练、体力要求高的工作，或大多数日子都活动量很大。';

  @override
  String get onboardingSymptomConcernsQuestion => '如果有，你最担心哪些症状？';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      '我们用它来优先处理你最在意的症状相关提示和指导。';

  @override
  String get onboardingSymptomConcernsExplainerDefault => '我们用它来聚焦你想提前关注的症状。';

  @override
  String get onboardingGenderQuestion => '你如何描述自己的性别？';

  @override
  String get onboardingGenderExplainer => '我们用它来提供更相关的指导和未来个性化。';

  @override
  String get onboardingGenderFemale => '女性';

  @override
  String get onboardingGenderMale => '男性';

  @override
  String get onboardingGenderPreferNotToSay => '不愿透露';

  @override
  String get onboardingTypeYourGender => '输入你的性别';

  @override
  String get onboardingPreferredNameQuestion => '我们应该怎么称呼你？';

  @override
  String get onboardingPreferredNameExplainer => '我们用它在与你交流时让 Glu 更有亲切感。';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => '正在为你设置计划';

  @override
  String get onboardingSetupSummaryExplainer => '我们正在把你分享的信息变成 Glu 现在就能支持的计划。';

  @override
  String get onboardingSetupSummaryMaintainStep1 => '正在固定体重维持目标...';

  @override
  String get onboardingSetupSummaryMaintainStep2 => '正在设置反弹监测点...';

  @override
  String get onboardingSetupSummaryMaintainStep3 => '正在调整与你日常相符的提醒...';

  @override
  String get onboardingSetupSummaryMaintainStep4 => '正在准备更稳定的每周计划...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 => '正在定义餐食和体重模式...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 => '正在设置补水支持...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 => '正在准备一致性提醒...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 => '正在构建更清晰的日常结构...';

  @override
  String get onboardingSetupSummaryPcosStep1 => '正在组织症状支持...';

  @override
  String get onboardingSetupSummaryPcosStep2 => '正在定义每周运动目标...';

  @override
  String get onboardingSetupSummaryPcosStep3 => '正在设置补水和日常支点...';

  @override
  String get onboardingSetupSummaryPcosStep4 => '正在准备更稳定的计划...';

  @override
  String get onboardingSetupSummaryHeartStep1 => '正在设置活动目标...';

  @override
  String get onboardingSetupSummaryHeartStep2 => '正在定义补水支持...';

  @override
  String get onboardingSetupSummaryHeartStep3 => '正在准备每周习惯提醒...';

  @override
  String get onboardingSetupSummaryHeartStep4 => '正在构建心脏健康日常...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 => '正在定义热量边界...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 => '正在设置喝水量...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 => '正在构建运动目标...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 => '正在准备你的每周计划...';

  @override
  String get onboardingSetupSummaryHeadline => '你的 Glu 设置已准备好。';

  @override
  String get onboardingSetupLoadingTitle => '正在构建你的设置';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu 已准备好通过更清晰的结构和更早的反弹信号，帮助你保护进展。';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu 已准备好支持更稳定的餐食、体重追踪以及日常重要习惯。';

  @override
  String get onboardingSetupSummaryPcosBody => 'Glu 已准备好支持围绕症状、治疗和进展的更稳定日常。';

  @override
  String get onboardingSetupSummaryHeartBody => 'Glu 已准备好强化支持你长期心脏健康的习惯。';

  @override
  String get onboardingSetupSummaryWeightLossBody => 'Glu 已准备好支持帮助你保持体重的日常。';

  @override
  String get onboardingSetupSummaryLabel => '摘要';

  @override
  String get onboardingSetupAdjustLater => '你之后可以在设置中调整这些内容。';

  @override
  String get onboardingSummaryGoal => '目标';

  @override
  String get onboardingSummaryCurrentWeight => '当前体重';

  @override
  String get onboardingSummaryMedication => '药物';

  @override
  String get onboardingSummaryCurrentDose => '当前剂量';

  @override
  String get onboardingSummaryCadence => '频率';

  @override
  String get onboardingSummaryStarted => '开始时间';

  @override
  String get onboardingSummaryTargetWeight => '目标体重';

  @override
  String get onboardingSummaryRoutine => '日常节奏';

  @override
  String get onboardingSummaryFocus => '重点';

  @override
  String get onboardingFrequencyEveryDay => '每天';

  @override
  String get onboardingFrequencyEveryWeek => '每周';

  @override
  String get onboardingFrequencyEvery2Weeks => '每 2 周';

  @override
  String get onboardingFrequencyCustomSchedule => '自定义日程';

  @override
  String get onboardingTapOptionContinue => '点按一个选项继续。';

  @override
  String get onboardingTypeGenderContinue => '输入你的性别以继续。';

  @override
  String get onboardingTypeDeviceContinue => '输入你的设备以继续。';

  @override
  String get onboardingTypeMedicationContinue => '输入你的药物以继续。';

  @override
  String get onboardingEnterDaysBetweenDosesContinue => '输入剂量间隔天数以继续。';

  @override
  String get onboardingChooseScheduleContinue => '选择一个日程以继续。';

  @override
  String get onboardingScrollChooseAge => '滚动选择你的年龄。';

  @override
  String get onboardingDragOrTapHeight => '拖动或点按标尺选择你的身高。';

  @override
  String get onboardingDragTapOrUseWeight => '拖动、点按或使用步进按钮选择体重。';

  @override
  String get onboardingPickDateAndWeight => '选择日期和体重以继续。';

  @override
  String get onboardingSelectSymptoms => '选择你希望 Glu 重点关注的症状。';

  @override
  String get onboardingTypeName => '输入你希望 Glu 使用的名字。';

  @override
  String get onboardingSaving => '保存中...';

  @override
  String get onboardingLetsBegin => '开始吧';

  @override
  String get onboardingContinueWithGlu => '继续使用 Glu';

  @override
  String get onboardingKeepGoing => '继续';

  @override
  String get onboardingTurnOnNotifications => '开启通知';

  @override
  String get onboardingFinish => '完成';

  @override
  String get onboardingTargetBmiTitle => '你的目标 BMI';

  @override
  String get onboardingChartToday => '今天';

  @override
  String get onboardingChartOverTime => '随时间变化';

  @override
  String get onboardingChartWithoutGlu => '没有 Glu';

  @override
  String get onboardingChartWithGlu => '有 Glu';

  @override
  String get onboardingReviewQuestion => '人们使用 Glu 来保持稳定并获得支持';

  @override
  String get onboardingReviewExplainer => '快速评分能帮助更多人找到这种简单的支持。';

  @override
  String get onboardingReviewBody => '人们使用 Glu，是为了在过程中获得更多支持、更稳定，也更不孤单。';

  @override
  String get onboardingTypeYourMedication => '输入你的药物';

  @override
  String get onboardingSelectStartDate => '选择开始日期';

  @override
  String get goalsSaveDialogTitle => '保存目标？';

  @override
  String get goalsSaveDialogMessage => '你有未保存的目标更改。离开此标签前要保存吗？';

  @override
  String get commonLater => '稍后';

  @override
  String get homeGreetingAnonymous => '嗨';

  @override
  String homeGreetingWithName(Object name) {
    return '嗨，$name';
  }

  @override
  String get homeInsightEmptyTitle => '记录今天，查看分析';

  @override
  String get homeInsightEmptyBody => '今天记录一些内容，你今晚就能看到分析。';

  @override
  String get homeInsightLogTodayTitle => '点击查看你的洞察';

  @override
  String get homeInsightMoreLogsVariant1Title => '点击查看今天的洞察';

  @override
  String get homeInsightMoreLogsVariant1Body => '你的记录已经开始显示出规律 — 点击查看。';

  @override
  String get homeInsightMoreLogsVariant2Title => '点击查看你的洞察';

  @override
  String get homeInsightMoreLogsVariant2Body => '再多记几条，就能让画面清晰很多 — 随时点击查看。';

  @override
  String get homeInsightMoreLogsVariant3Title => '点击揭晓今天的洞察';

  @override
  String get homeInsightMoreLogsVariant3Body => '你的这一天里，也许已经藏着一个规律 — 点击查看。';

  @override
  String get homeInsightLogTodayBodyNoLogs => '今天记录一些内容，然后点击查看揭示了什么。';

  @override
  String get homeInsightExpandedTitle => '这对你有帮助吗？';

  @override
  String get homeInsightExpandedBody => '快速评价可以帮助 Glu 了解你最在意什么。';

  @override
  String get homeInsightReasonHint => '哪里可以更好？（可选）';

  @override
  String get homeInsightReasonSubmit => '提交';

  @override
  String get homeInsightLearningMessage => '我会从中学习。';

  @override
  String get homeInsightChecking => '正在检查今日分析...';

  @override
  String get homeInsightGenerating => '正在加载今日分析...';

  @override
  String get homeInsightTryAgain => '重试';

  @override
  String get homeSeeAllInsights => '查看全部分析';

  @override
  String get insightsProgressTitle => '全部分析';

  @override
  String get insightsProgressEmptyState => '你的分析生成后会显示在这里。';

  @override
  String get homeDoseReminderTitle => '剂量提醒';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return '此处为记录 $label 的交互。';
  }

  @override
  String get homeCalorieGoalRequiredTitle => '需要热量目标';

  @override
  String get homeCalorieGoalRequiredBody =>
      '份量检查需要把饮食目标设为热量，才能估算你的份量。请先在目标中设置。';

  @override
  String get homeSetGoal => '设置目标';

  @override
  String get homeYourProgress => '你的进展';

  @override
  String get homeRemindersShowcaseTitle => '保持节奏';

  @override
  String get homeRemindersShowcaseDescription => '设置提醒，按时完成剂量和补充剂。';

  @override
  String get homePickNextDoseDate => '选择下次剂量日期';

  @override
  String get homeSetReminder => '设置提醒';

  @override
  String get homeSupplementReminders => '补充剂提醒';

  @override
  String get homeNoUpcomingSupplements => '暂无即将到来的补充剂';

  @override
  String get homeNoMoreUpcomingSupplements => '没有更多即将到来的项目';

  @override
  String get homeSetUpYourSupplements => '设置你的补充剂';

  @override
  String get homeSetUp => '设置';

  @override
  String get homeSupplementFallback => '补充剂';

  @override
  String get doseReminderNotificationTitle => '准备好打针了吗？';

  @override
  String get doseReminderFallbackBody => '打开 Glu 查看你的下一次剂量。';

  @override
  String get supplementReminderNotificationTitle => '该吃补充剂了';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => '今天早上';

  @override
  String get supplementReminderThisAfternoon => '今天下午';

  @override
  String get supplementReminderTonight => '今晚';

  @override
  String get dailyReminderMorningTitle => '早晨签到';

  @override
  String get dailyReminderMorningBodies =>
      '晨间任务：给 Glu 一点数据可玩。\n用一个快速记录和一点动能开启这一天。\n起床就记录。未来的你会感谢它。\n用一个小更新和一个大开局开始这一天。\n给 Glu 一个早晨线索，然后继续前进。\n现在快速记录一下，今天会更有意思。\n让晨间打卡为今天加分。';

  @override
  String get dailyReminderMiddayTitle => '午间签到';

  @override
  String get dailyReminderMiddayBodies =>
      '中午停靠：快速记录一下，继续前进。\n午休时间？正好给 Glu 一个更新。\n已经过半。给 Glu 一个小线索。\n一个小小的午间记录能让故事继续。\n现在签到，让这一天继续滚动。\n给你的日子一点推动，用一个快速更新。\n用一次快速午间点按保持节奏。';

  @override
  String get dailyReminderAfternoonTitle => '下午签到';

  @override
  String get dailyReminderAfternoonBodies =>
      '快收尾了。再给 Glu 一块小碎片。\n一次快速的下午记录能让今晚的分析更亮眼。\n用一次小更新和一个大收获为这一天收尾。\n再记录一次，就快结束了？\n帮助 Glu 把线索串起来，来一次下午快速签到。\n用一次小记录把这一切串起来，让魔法继续。\n现在最后点一下，今晚的分析会更好。';

  @override
  String get homePortionCheckTitle => '份量检查';

  @override
  String get homePortionCheckBody => '了解每餐该吃多少';

  @override
  String get homeGlowUpTitle => '你的\n蜕变';

  @override
  String get homeGlowUpBody => '创建你的前后对比故事';

  @override
  String get homeDoctorReportTitle => '医生报告';

  @override
  String get homeDoctorReportBody => '与医生分享你的进展';

  @override
  String get doctorReportViewerRenderError => '无法显示报告。请重试。';

  @override
  String get doctorReportViewerShare => '分享';

  @override
  String get homeGoalsStatusTitle => '今日目标';

  @override
  String get homeGoalsStatusViewAll => '查看全部';

  @override
  String get homeWaterTitle => '水';

  @override
  String get homeWeightTitle => '体重';

  @override
  String get homeExerciseTitle => '运动';

  @override
  String get homeMealsTitle => '餐食';

  @override
  String get homeCaloriesTitle => '热量';

  @override
  String get homeProteinsTitle => '蛋白质';

  @override
  String get homeFibersTitle => '纤维';

  @override
  String get homeSymptomsTitle => '症状';

  @override
  String get homeMoodTitle => '情绪';

  @override
  String get homeCravingsTitle => '渴望';

  @override
  String get homeDoseTitle => '剂量';

  @override
  String get homeMedicationLevelTitle => '估算药物水平';

  @override
  String get homeMedicationLevelInfoTitle => '如何解读此图表';

  @override
  String get homeMedicationLevelInfoBody =>
      '该图表根据您记录的剂量和药物的半衰期，估算您体内可能仍然有效的药物量。\n\n较高的点通常表示最近或较大剂量。随着时间推移，药物从体内清除，曲线会逐渐下降。\n\n请将此视为趋势参考，而非精确测量或医疗建议。';

  @override
  String get homeMedicationLevelInfoDismiss => '知道了';

  @override
  String get homeMedicationLevelEmptyBody => '记录您的剂量，以便 Glu 估算您体内仍有多少药物处于活跃状态。';

  @override
  String get homeMedicationLevelOfRecentPeak => '为近期峰值的';

  @override
  String get homeMedicationLevelActiveNow => '当前活跃';

  @override
  String get homeMedicationLevelHalfLife => '半衰期';

  @override
  String get homeMedicationLevelLastDose => '最近一次剂量';

  @override
  String get homeStartHydration => '开始补水';

  @override
  String get homeLogFirstSession => '记录你的第一项活动';

  @override
  String get homeLogTodayWeight => '记录今天的体重';

  @override
  String get homeAtYourTarget => '你已达到目标';

  @override
  String get homeLogMealsToTrackCalories => '记录餐食以追踪热量';

  @override
  String get homeLogFirstMeal => '记录你的第一餐';

  @override
  String get homeTrackProteinFromMeals => '从餐食中追踪蛋白质';

  @override
  String get homeTrackFiberFromMeals => '从餐食中追踪纤维';

  @override
  String get homeAllClear => '一切正常';

  @override
  String get homeTrackSymptoms => '追踪症状';

  @override
  String get homeGreat => '很好';

  @override
  String get homeGood => '不错';

  @override
  String get homeBad => '不佳';

  @override
  String get homeOkay => '还好';

  @override
  String get homeLogHowYouFeel => '记录你的感受';

  @override
  String get homeLogACraving => '记录渴望';

  @override
  String get homeLogTodaysDose => '记录今天的剂量';

  @override
  String get homeTaken => '已服用';

  @override
  String get homeStartHereTitle => '从这里开始';

  @override
  String get homeStartHereBody =>
      '先从这个卡片开始，再扩展到其他项目。随着你记录得越多，Glu 就越能更准确地展示模式和分析。';

  @override
  String get waterLogTitle => '补水';

  @override
  String get waterLogEditTitle => '编辑补水';

  @override
  String get waterLogLogTitle => '记录喝水';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ 添加饮品（$amount）';
  }

  @override
  String get waterLogSaving => '保存中...';

  @override
  String get waterLogCustomDrinkTitle => '自定义饮品';

  @override
  String get waterLogCustomDrinkBody => '选择你现在想添加的量。';

  @override
  String get waterLogUseThisAmount => '使用此量';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '已加入补水记录（$amount）';
  }

  @override
  String get waterLogCouldNotSave => '暂时无法保存这条喝水记录。';

  @override
  String get waterLogDeleteTitle => '删除这条补水记录？';

  @override
  String get waterLogDeleteMessage => '此操作无法撤销。';

  @override
  String get waterLogCouldNotDelete => '暂时无法删除这条喝水记录。';

  @override
  String get waterLogDeleteLog => '删除记录';

  @override
  String get waterLogDeleted => '补水记录已删除';

  @override
  String get moodLogTitle => '情绪';

  @override
  String get moodEditTitle => '编辑情绪';

  @override
  String get moodHowYouFeel => '你的感受';

  @override
  String get moodBad => '差';

  @override
  String get moodOkay => '还好';

  @override
  String get moodGood => '好';

  @override
  String get moodGreat => '很好';

  @override
  String get moodNotes => '备注';

  @override
  String get moodAnythingWorthRemembering => '这次情绪有什么值得记住的吗？';

  @override
  String get moodCouldNotSave => '暂时无法保存这条情绪记录。';

  @override
  String get moodDeleteTitle => '删除这条情绪记录？';

  @override
  String get moodDeleteMessage => '此操作无法撤销。';

  @override
  String get moodDeleteLog => '删除记录';

  @override
  String get moodSaving => '保存中...';

  @override
  String get moodAddMoodLog => '+ 记录情绪';

  @override
  String get moodLogged => '情绪已记录';

  @override
  String get moodDeleted => '情绪已删除';

  @override
  String get moodCouldNotDelete => '暂时无法删除这条情绪记录。';

  @override
  String get moodAddedToMoodLog => '已添加到你的情绪记录';

  @override
  String get cravingsLogTitle => '渴望';

  @override
  String get cravingsEditTitle => '编辑渴望';

  @override
  String get cravingsWhatsGoingOn => '发生了什么';

  @override
  String get cravingsTypeGeneral => '想吃东西';

  @override
  String get cravingsTypeSweet => '想吃甜食';

  @override
  String get cravingsTypeSalty => '想吃咸食';

  @override
  String get cravingsIntensityLabel => '强度（可选）';

  @override
  String get cravingsIntensityMild => '轻微';

  @override
  String get cravingsIntensityModerate => '中等';

  @override
  String get cravingsIntensityStrong => '强烈';

  @override
  String get cravingsOutcomeLabel => '结果（可选）';

  @override
  String get cravingsOutcomeResisted => '忍住了';

  @override
  String get cravingsOutcomeGaveIn => '没忍住';

  @override
  String get cravingsNotes => '备注';

  @override
  String get cravingsAnythingWorthRemembering => '这次渴望有什么值得记住的吗？';

  @override
  String get cravingsCouldNotSave => '暂时无法保存这条渴望记录。';

  @override
  String get cravingsDeleteTitle => '删除这条渴望记录？';

  @override
  String get cravingsDeleteMessage => '此操作无法撤销。';

  @override
  String get cravingsDeleteLog => '删除记录';

  @override
  String get cravingsSaving => '保存中...';

  @override
  String get cravingsAddLog => '+ 记录渴望';

  @override
  String get cravingsLogged => '渴望已记录';

  @override
  String get cravingsDeleted => '渴望已删除';

  @override
  String get cravingsCouldNotDelete => '暂时无法删除这条渴望记录。';

  @override
  String get cravingsAddedToLog => '已添加到你的渴望记录';

  @override
  String get portionCheckTitle => '份量检查';

  @override
  String get portionCheckAnalyzingMeal => '正在分析你的餐食…';

  @override
  String get portionCheckCouldNotAnalyzePhoto => '无法分析这张照片';

  @override
  String get portionCheckTakeNewPhoto => '重新拍照';

  @override
  String get portionCheckSomethingWentWrong => '出了点问题。';

  @override
  String get portionCheckYouHitDailyLimit => '你已达到每日上限';

  @override
  String get portionCheckYouCanEat => '你可以吃';

  @override
  String get portionCheckYouCanEatUpTo => '你最多可以吃';

  @override
  String get portionCheckTryLighterOption => '试试更轻的选择，或跳过这项';

  @override
  String get portionCheckThisEntireMeal => '整顿餐食';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '这顿餐食的 $percent%';
  }

  @override
  String get portionCheckToStayWithinGoals => '以保持在你的每日目标内。';

  @override
  String get portionCheckNutritionBreakdown => '营养分解';

  @override
  String get portionCheckTipsToBalanceMeal => '平衡这顿餐食的小建议';

  @override
  String get portionCheckTipsPool =>
      '吃慢一点，让饱腹信号有时间跟上来。\n把盘子的一半装满蔬菜。\n每餐都加入蛋白质。\n饭前先喝水。\n把零食提前分装到小盒子里。\n把碳水和蛋白质或脂肪搭配起来，可以更久地保持饱腹感。\n尽量选择完整、少加工的食物。\n避免在看屏幕分心时进食。\n如果跳过一餐会让你之后吃更多，就不要跳过。\n在饿之前先计划好零食。';

  @override
  String get portionCheckRetake => '重新拍摄';

  @override
  String get portionCheckLogThisPortion => '记录这个份量';

  @override
  String get portionCheckCarbs => '碳水';

  @override
  String get portionCheckProteins => '蛋白质';

  @override
  String get portionCheckFats => '脂肪';

  @override
  String get portionCheckFiber => '纤维';

  @override
  String get mealLogScreenTitle => '餐食';

  @override
  String get mealLogEditTitle => '编辑餐食';

  @override
  String get mealLogLogTitle => '记录餐食';

  @override
  String get mealLogSaving => '保存中...';

  @override
  String get mealLogAddMealLog => '+ 添加餐食记录';

  @override
  String get mealLogCouldNotStartRecording => '无法开始录音。';

  @override
  String get mealLogRecordingStoppedAtLimit => '录音已在 60 秒处停止。';

  @override
  String get mealLogCouldNotAnalyzeRecording => '无法分析这段录音。';

  @override
  String get mealLogCouldNotAnalyzeText => '无法分析这段文字。';

  @override
  String get mealLogCouldNotAnalyzePhoto => '无法分析这张照片。';

  @override
  String get mealLogCouldNotProcessMealPhoto => '暂时无法处理这张餐食照片。';

  @override
  String get mealLogDiscardTitle => '要放弃这顿餐食吗？';

  @override
  String get mealLogDiscardMessage => '你查看了照片但没有保存条目，它不会被记录。';

  @override
  String get mealLogDiscard => '放弃';

  @override
  String get mealLogDeleteTitle => '删除这条餐食记录？';

  @override
  String get mealLogDeleteMessage => '此操作无法撤销。';

  @override
  String get mealLogDelete => '删除';

  @override
  String get mealLogDeleteLog => '删除记录';

  @override
  String get mealLogCouldNotSave => '暂时无法保存这条餐食记录。';

  @override
  String get mealLogCouldNotDelete => '暂时无法删除这条餐食记录。';

  @override
  String get mealLogAnalyzing => '分析中...';

  @override
  String get mealLogAnalyzeText => '分析文字';

  @override
  String get mealLogSendRecording => '发送录音';

  @override
  String get mealLogMealDefaultName => '餐食';

  @override
  String get mealLogMealNameHint => '餐食名称';

  @override
  String get mealLogCouldNotPrefillTitle => '无法预填这顿餐食';

  @override
  String get mealLogHowMuchDidYouEat => '你吃了多少？';

  @override
  String get mealLogNotes => '备注';

  @override
  String get mealLogAnythingWorthRemembering => '这顿餐食有什么值得记住的吗？';

  @override
  String get mealLogAnalyzingYourMealTitle => '正在分析你的餐食';

  @override
  String get mealLogAnalyzingYourMealBody => '正在把你的输入转成营养字段。保存前你可以检查全部内容。';

  @override
  String get mealLogDescribeYourMealTitle => '描述你的餐食';

  @override
  String get mealLogDescribeYourMealBody => '写下你吃了什么以及你知道的分量。我们会把它转换成营养字段。';

  @override
  String get mealLogDescribeYourMealHint => '例如：烤鸡沙拉、橄榄油酱、1 个苹果、气泡水';

  @override
  String get mealLogCaptureYourMealTitle => '拍摄你的餐食';

  @override
  String get mealLogCaptureYourMealBody => '拍张照片，我们会为你估算营养字段。';

  @override
  String get mealLogTakePhoto => '拍照';

  @override
  String get mealLogRecordingYourMealTitle => '正在录入你的餐食';

  @override
  String get mealLogRecordingReadyTitle => '录音已就绪';

  @override
  String get mealLogRecordMealDescriptionTitle => '录入餐食描述';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return '完成后点按停止。剩余 $remaining 秒';
  }

  @override
  String get mealLogRecordingReadyBody => '可以发送分析，或重新录制。';

  @override
  String get mealLogRecordMealDescriptionBody => '自然地说出你吃了什么，我们会把它解析成宏量营养素。';

  @override
  String get mealLogStopRecording => '停止录音';

  @override
  String get mealLogRecordAgain => '重新录制';

  @override
  String get mealLogStartRecording => '开始录音';

  @override
  String get mealLogBreakfast => '早餐';

  @override
  String get mealLogLunch => '午餐';

  @override
  String get mealLogSnack => '加餐';

  @override
  String get mealLogDinner => '晚餐';

  @override
  String get mealLogKcalUnit => '千卡';

  @override
  String get mealLogToday => '今天';

  @override
  String get mealLogYesterday => '昨天';

  @override
  String mealLogKcal(Object count) {
    return '$count 千卡';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '已记录 $count 千卡';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '已记录 $amount 克 $macro';
  }

  @override
  String get mealLogDeleted => '餐食已删除';

  @override
  String get mealLogAddedToMealLog => '已添加到你的餐食记录';

  @override
  String get mealLogCarbs => '碳水';

  @override
  String get mealLogProteins => '蛋白质';

  @override
  String get mealLogFats => '脂肪';

  @override
  String get mealLogFiber => '纤维';

  @override
  String get settingsLanguage => '语言';

  @override
  String get settingsLanguageDialogTitle => '选择语言';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsPreferences => '偏好';

  @override
  String get settingsHealthGoal => '健康目标';

  @override
  String get settingsHealthGoalDialogTitle => '选择健康目标';

  @override
  String get settingsHabitGoals => '习惯目标';

  @override
  String get settingsDisabled => '已停用';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count 个已启用';
  }

  @override
  String get settingsHeight => '身高';

  @override
  String get settingsAge => '年龄';

  @override
  String get settingsGender => '性别';

  @override
  String get settingsMeasurementUnit => '计量单位';

  @override
  String get settingsReminders => '提醒';

  @override
  String get settingsDoseReminder => '剂量提醒';

  @override
  String get settingsSupplementReminder => '补充剂提醒';

  @override
  String get settingsDailyReminders => '每日提醒';

  @override
  String get settingsSubscription => '订阅';

  @override
  String get settingsSupport => '支持';

  @override
  String get settingsSendFeedback => '发送反馈';

  @override
  String get feedbackSheetTitle => '发送反馈';

  @override
  String get feedbackSheetHint => '告诉我们你的想法…';

  @override
  String get feedbackSheetSend => '发送';

  @override
  String get feedbackSheetSuccess => '感谢你的反馈！';

  @override
  String get feedbackSheetError => '发送失败。请重试。';

  @override
  String get settingsTermsOfService => '服务条款';

  @override
  String get settingsPrivacyPolicy => '隐私政策';

  @override
  String get settingsInternal => '内部';

  @override
  String get settingsSubscriptionOverride => '订阅覆盖';

  @override
  String get settingsTodayInsightCard => '今日分析卡片';

  @override
  String get settingsResetOnboarding => '重置新手引导';

  @override
  String get settingsResetShowcases => '重置展示引导';

  @override
  String get settingsResetUserData => '重置用户数据';

  @override
  String get settingsDeletingAccount => '正在删除账户...';

  @override
  String get settingsDisconnect => '断开';

  @override
  String get settingsDeleteAccount => '删除账户';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return '断开 $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return '断开 $provider？';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return '除非以后重新连接，否则你将无法在此设备上使用 $provider 登录。';
  }

  @override
  String get settingsDeleteAccountTitle => '删除账户？';

  @override
  String get settingsDeleteAccountBody => '这将永久删除你的账户及所有数据，且无法撤销。';

  @override
  String get settingsDeleteAccountConfirmHint => '输入 DELETE 确认';

  @override
  String get settingsDeleteAccountError =>
      '删除账户时出现问题。请联系 support@layline.ventures。';

  @override
  String get settingsRestartAppToSeeOnboarding => '重启应用以查看新手引导';

  @override
  String get settingsShowcasesReset => '展示引导已重置';

  @override
  String get settingsResetUserDataTitle => '重置用户数据？';

  @override
  String get settingsResetUserDataBody => '这将清除所有餐食、水、运动、体重、情绪、症状、补充剂和剂量记录。';

  @override
  String get settingsUserDataReset => '用户数据已重置';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      '已保存，但当前无法安排每日提醒。';

  @override
  String get settingsSubscriptionOverrideTitle => '订阅覆盖';

  @override
  String get settingsSubscriptionOverrideAuto => '自动';

  @override
  String get settingsSubscriptionOverrideForceFree => '强制免费';

  @override
  String get settingsSubscriptionOverrideForcePro => '强制 Pro';

  @override
  String get settingsTodayInsightCardTitle => '今日分析卡片';

  @override
  String get settingsTodayInsightCardAuto => '自动';

  @override
  String get settingsTodayInsightCardOn => '开启';

  @override
  String get settingsTodayInsightCardOff => '关闭';

  @override
  String get settingsYourName => '你的名字';

  @override
  String get settingsSignOut => '退出登录';

  @override
  String get settingsHeightCm => '厘米';

  @override
  String get settingsHeightFtIn => '英尺/英寸';

  @override
  String get settingsHeightFt => '英尺';

  @override
  String get settingsHeightIn => '英寸';

  @override
  String get settingsGenderMale => '男性';

  @override
  String get settingsGenderFemale => '女性';

  @override
  String get settingsGenderPreferNotToSay => '不愿透露';

  @override
  String get settingsGenderOther => '其他';

  @override
  String get settingsYourProfile => '你的资料';

  @override
  String get settingsNotSet => '未设置';

  @override
  String settingsYears(Object value) {
    return '$value 岁';
  }

  @override
  String get settingsOff => '关闭';

  @override
  String get settingsOn => '开启';

  @override
  String get settingsNoneSet => '未设置任何项';

  @override
  String settingsSupplementCount(Object count) {
    return '$count 个补充剂';
  }

  @override
  String get commonToday => '今天';

  @override
  String get mainShellHome => '首页';

  @override
  String get mainShellLog => '记录';

  @override
  String get mainShellProgress => '进展';

  @override
  String get mainShellSettings => '设置';

  @override
  String get mainShellLogShowcaseTitle => '记录重要事项';

  @override
  String get mainShellLogShowcaseDescription => '每天记录对你最重要的活动。';

  @override
  String get logMoodShowcaseTitle => '从心情开始';

  @override
  String get logMoodShowcaseDescription =>
      '先记录心情，再逐步记录其他内容，这样 Glu 就能更准确地发现习惯和模式。';

  @override
  String get mainShellProgressShowcaseTitle => '查看你的进展';

  @override
  String get mainShellProgressShowcaseDescription =>
      '检查你的模式和趋势，了解你的习惯和体重如何随时间变化。';

  @override
  String get progressMenuShowcaseTitle => '探索你的数据';

  @override
  String get progressMenuShowcaseDescription =>
      '查看所有图表，阅读 AI 生成的洞察，或创建一份医生报告与你的医疗团队分享。';

  @override
  String get settingsFeedbackShowcaseTitle => '我们很想听听你的反馈';

  @override
  String get settingsFeedbackShowcaseDescription => '点击此处分享哪些地方有效、哪些无效，或任何想法。';

  @override
  String get authCouldNotOpenLink => '当前无法打开链接。';

  @override
  String get authWelcomeTitle => '欢迎使用 Glu';

  @override
  String get authSubtitle => '为你的健康助手提供安全登录';

  @override
  String get authContinueWithGoogle => '使用 Google 继续';

  @override
  String get authContinueWithApple => '使用 Apple 继续';

  @override
  String get authEmailHint => 'name@email.com';

  @override
  String get authSending => '发送中...';

  @override
  String get authResendLink => '重新发送链接';

  @override
  String get authUseDifferentEmail => '使用其他邮箱';

  @override
  String get habitGoalsTitle => '习惯目标';

  @override
  String get goalsProteins => '蛋白质';

  @override
  String get goalsFibers => '纤维';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value 克/天';
  }

  @override
  String get goalsWater => '水';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value 升/天';
  }

  @override
  String get goalsExercise => '运动';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value 分钟/天';
  }

  @override
  String get goalsMeals => '餐食';

  @override
  String get goalsCalories => '热量';

  @override
  String get goalsKcalUnit => '千卡';

  @override
  String get goalsPerWeekSuffix => '每周';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count 餐/天';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count 千卡/天';
  }

  @override
  String get goalsWeight => '体重';

  @override
  String get goalsAddLoggedWeightToCalculatePace => '添加已记录的体重以计算进度。';

  @override
  String get goalsAlreadyAtThisTarget => '你已经达到此目标';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '距离目标还需每周 $value $unit';
  }

  @override
  String get goalsSetTargetForNextWeek => '为下周设定目标。';

  @override
  String get progressWeightTitle => '体重';

  @override
  String get progressWeightLabel => '体重 ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => '健康 BMI';

  @override
  String get progressTotal => '总计';

  @override
  String get progressPercent => '百分比';

  @override
  String get progressWeeklyAvg => '每周平均';

  @override
  String get progressRangeAllTime => '全部时间';

  @override
  String get progressRange1Month => '1 个月';

  @override
  String get progressRange3Months => '3 个月';

  @override
  String get progressRange6Months => '6 个月';

  @override
  String get progressLow => '低';

  @override
  String get progressMed => '中';

  @override
  String get progressHigh => '高';

  @override
  String get progressSeverity => '严重程度';

  @override
  String get progressBad => '差';

  @override
  String get progressOkay => '还好';

  @override
  String get progressGood => '好';

  @override
  String get progressGreat => '很好';

  @override
  String get progressMostlyBad => '大多较差';

  @override
  String get progressMostlyOkay => '大多还好';

  @override
  String get progressMostlyGood => '大多较好';

  @override
  String get progressMostlyGreat => '大多很好';

  @override
  String get progressNoDose => '无剂量';

  @override
  String get progressLogged => '已记录';

  @override
  String get progressAllClear => '一切正常';

  @override
  String get progressFreq => '频率';

  @override
  String get progressAverage => '平均';

  @override
  String get progressDaily => '每日';

  @override
  String get progressWeekly => '每周';

  @override
  String get progressMinutes => '分钟';

  @override
  String get progressIntensity => '强度';

  @override
  String get progressCalories => '热量';

  @override
  String get progressByDose => '按剂量';

  @override
  String get progressWeightProgressTitle => '体重进展';

  @override
  String get progressWaterProgressTitle => '补水进展';

  @override
  String get progressExerciseProgressTitle => '运动进展';

  @override
  String get progressDoseProgressTitle => '剂量进展';

  @override
  String get progressMealsProgressTitle => '餐食进展';

  @override
  String get progressSymptomsProgressTitle => '症状进展';

  @override
  String get progressMoodProgressTitle => '情绪进展';

  @override
  String get progressCravingsProgressTitle => '渴望进展';

  @override
  String get progressResisted => '已忍住';

  @override
  String get progressCravingsResistedSubtitle => '记录的渴望中你成功忍住的比例。';

  @override
  String get progressWeightChangeTitle => '体重变化';

  @override
  String get progressTitle => '进展';

  @override
  String get progressMenuViewAllInsights => '查看全部分析';

  @override
  String get progressMenuViewAllCharts => '查看全部图表';

  @override
  String get progressMenuCreateDoctorReport => '创建医生报告';

  @override
  String get progressReportGenerating => '正在生成你的报告…';

  @override
  String get progressReportError => '无法生成报告。请重试。';

  @override
  String get progressReportPendingRetry => '您的报告可能很快就会完成。请再试一次。';

  @override
  String get progressReportOpenError => '您的报告已生成，但我们无法打开它。请再试一次。';

  @override
  String get progressAllProgressTitle => '全部进展';

  @override
  String get progressWeightTrendExplanation => '查看你的体重如何随时间变化。';

  @override
  String get progressNoWeightLogsYet => '暂无体重记录';

  @override
  String get progressNoLogsYet => '暂无记录';

  @override
  String get progressLogWeightToStartTrend => '记录体重以开始追踪趋势。';

  @override
  String get progressLogWeightAndDoseToCompareChange => '记录体重和剂量，比较剂量如何与变化相关。';

  @override
  String get progressEachPointColoredByLatestDose => '每个点都按称重前最近一次的剂量着色。';

  @override
  String get progressNoHydrationYet => '暂无补水记录';

  @override
  String get progressNoMovementYet => '暂无运动记录';

  @override
  String get progressNoDoseLogsYet => '暂无剂量记录';

  @override
  String get progressNoMealsLoggedYet => '暂无餐食记录';

  @override
  String get progressNoSymptomsLoggedYet => '暂无症状记录';

  @override
  String get progressNoMoodLogsYet => '暂无情绪记录';

  @override
  String get progressNoCravingsLoggedYet => '暂无渴望记录';

  @override
  String get progressFutureTrendTitle => '未来趋势';

  @override
  String get progressFutureTrendBody => '展现你进展的美好时间线';

  @override
  String get progressGoal => '目标';

  @override
  String get progressLatestLoggedWeightReadyToTrack => '你最近记录的体重已可追踪。';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return '距离你的目标大约还有 $gap $unit。';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '与你上一条记录相比 $deltaText。';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '与你上一条记录相比 $deltaText。距离目标还有 $gap $unit。';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible => '与上一条记录相比，趋势现已可见。';

  @override
  String get progressWaterTitle => '水';

  @override
  String get manageSubscriptionTitle => '管理订阅';

  @override
  String get manageSubscriptionProPlan => 'Pro 套餐';

  @override
  String get manageSubscriptionFreePlan => '免费套餐';

  @override
  String get manageSubscriptionActiveCopy => '你的订阅处于有效状态。';

  @override
  String get manageSubscriptionUpgradeCopy => '升级以解锁 Glu Pro。';

  @override
  String get manageSubscriptionPlan => '套餐';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => '免费';

  @override
  String get manageSubscriptionProduct => '产品';

  @override
  String get manageSubscriptionRenewal => '续订';

  @override
  String get manageSubscriptionStatus => '状态';

  @override
  String get manageSubscriptionStatusActive => '有效';

  @override
  String get manageSubscriptionStatusInactive => '未激活';

  @override
  String get manageSubscriptionManageButton => '管理订阅';

  @override
  String get manageSubscriptionUpgradeButton => '升级到 Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings => '打开商店订阅设置';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => '恢复购买';

  @override
  String get manageSubscriptionRenewsAutomatically => '自动续订';

  @override
  String get manageSubscriptionLifetime => '终身';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return '续订于 $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return '到期于 $date';
  }

  @override
  String get supplementReminderDayMon => '一';

  @override
  String get supplementReminderDayTue => '二';

  @override
  String get supplementReminderDayWed => '三';

  @override
  String get supplementReminderDayThu => '四';

  @override
  String get supplementReminderDayFri => '五';

  @override
  String get supplementReminderDaySat => '六';

  @override
  String get supplementReminderDaySun => '日';

  @override
  String supplementReminderInDays(Object count) {
    return '$count 天后';
  }

  @override
  String get supplementReminderInOneWeek => '1 周后';

  @override
  String supplementReminderInWeeks(Object count) {
    return '$count 周后';
  }

  @override
  String get subscriptionDebugTitle => 'Glu 订阅';

  @override
  String get subscriptionDebugMonthly => '月度';

  @override
  String get subscriptionDebugYearly => '年度';

  @override
  String get subscriptionDebugRefreshCustomerInfo => '刷新客户信息';

  @override
  String get subscriptionDebugPresentPaywall => '显示付费墙';

  @override
  String get subscriptionDebugOpenCustomerCenter => '打开客户中心';

  @override
  String get subscriptionDebugRestorePurchases => '恢复购买';

  @override
  String get subscriptionDebugSyncPurchases => '同步购买';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCat 状态';

  @override
  String get subscriptionDebugConfigured => '已配置';

  @override
  String get subscriptionDebugBusy => '忙碌中';

  @override
  String get subscriptionDebugAppUserId => '应用用户 ID';

  @override
  String get subscriptionDebugAnonymous => '匿名';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API 密钥可用';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro 已激活';

  @override
  String get subscriptionDebugActiveSubscriptions => '有效订阅';

  @override
  String get subscriptionDebugManagementUrl => '管理链接';

  @override
  String get subscriptionDebugEntitlementProduct => '权益产品';

  @override
  String get subscriptionDebugWillRenew => '将自动续订';

  @override
  String get subscriptionDebugExpiration => '到期时间';

  @override
  String get subscriptionDebugLifetime => '终身';

  @override
  String get subscriptionDebugPackageFound => '已找到套餐';

  @override
  String get subscriptionDebugProductId => '产品 ID';

  @override
  String get subscriptionDebugTitleLabel => '标题';

  @override
  String get subscriptionDebugPrice => '价格';

  @override
  String subscriptionDebugPurchase(Object title) {
    return '购买 $title';
  }

  @override
  String get progressExerciseTitle => '运动';

  @override
  String get progressDoseTitle => '剂量';

  @override
  String get progressMealsTitle => '餐食';

  @override
  String get progressSymptomsTitle => '症状';

  @override
  String get progressMoodTitle => '情绪';

  @override
  String get progressCravingsTitle => '渴望';

  @override
  String get progressTrend => '趋势';

  @override
  String get progressTarget => '目标';

  @override
  String get progressNoTrendYet => '暂无趋势';

  @override
  String get progressNoActivityYet => '暂无活动';

  @override
  String get progressNoCheckInsYet => '暂无签到';

  @override
  String get progressWeightSignatureChip => '体重将成为你的标志性图表';

  @override
  String get progressWeightStartTrendTitle => '用第一次称重开启趋势';

  @override
  String get progressWeightStartTrendBody =>
      '这张图表是你进展故事的核心。记录第一次体重即可解锁动量、里程碑，以及值得分享的视图。';

  @override
  String get progressWeightMomentum => '动量';

  @override
  String get progressWeightMilestones => '里程碑';

  @override
  String get progressWeightShareReady => '可分享';

  @override
  String get progressWeightLogWeight => '记录体重';

  @override
  String get weightProgressUnlocksViewChip => '你的第一次称重会解锁这个视图';

  @override
  String get weightProgressStartsHereTitle => '你的进展故事从这里开始';

  @override
  String get weightProgressStartsHereBody =>
      '记录你的第一次体重即可解锁趋势、里程碑和剂量相关分析，以及值得分享的视图。';

  @override
  String get weightProgressTrendView => '趋势视图';

  @override
  String get weightProgressDoseOverlays => '剂量叠加';

  @override
  String get weightProgressMilestones => '里程碑';

  @override
  String get weightProgressLogWeight => '记录体重';

  @override
  String get glowUpAddBeforeAndAfterFirst => '请先添加前后对比照片。';

  @override
  String get glowUpSavedToGallery => '已保存到你的相册';

  @override
  String get glowUpSaveToGallery => '保存到相册';

  @override
  String get glowUpYourProgress => '你的进展';

  @override
  String get glowUpWeightChange => '体重变化';

  @override
  String get glowUpTime => '时间';

  @override
  String get glowUpShare => '分享';

  @override
  String get glowUpBefore => '之前';

  @override
  String get glowUpAfter => '之后';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$time内 $weight';
  }

  @override
  String get glowUpTimeUnitDaysLabel => '天';

  @override
  String get glowUpTimeUnitWeeksLabel => '周';

  @override
  String get glowUpTimeUnitMonthsLabel => '月';

  @override
  String get glowUpTimeUnitYearsLabel => '年';

  @override
  String glowUpTimeValueDays(int count) {
    return '$count天';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    return '$count周';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    return '$count个月';
  }

  @override
  String glowUpTimeValueYears(int count) {
    return '$count年';
  }

  @override
  String get commonYesterday => '昨天';

  @override
  String get commonSelect => '选择';

  @override
  String get doseReminderTitle => '剂量提醒';

  @override
  String get doseReminderCustomDoseTitle => '自定义剂量';

  @override
  String get doseReminderCustomDoseHint => '输入毫克剂量';

  @override
  String get doseReminderKeepNextDoseReadyOnHome => '在首页保持下一次剂量可见。';

  @override
  String get doseReminderTime => '时间';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome => '开启后会在首页显示下一次剂量。';

  @override
  String get doseReminderSaveReminder => '保存提醒';

  @override
  String loggedOn(Object date) {
    return '记录于 $date';
  }

  @override
  String get waterLogSmallGlass => '小杯';

  @override
  String get waterLogGlass => '杯';

  @override
  String get waterLogBottle => '瓶';

  @override
  String get waterLogLargeBottle => '大瓶';

  @override
  String get waterLogTwoLiters => '2 升';

  @override
  String get waterLogCustomPreset => '自定义';

  @override
  String get waterLogMlUnit => '毫升';

  @override
  String get waterLogOzUnit => '盎司';

  @override
  String get doseLogTitle => '剂量';

  @override
  String get doseLogEditTitle => '编辑剂量';

  @override
  String get doseLogLogTitle => '记录剂量';

  @override
  String get doseLogCustomDose => '自定义剂量';

  @override
  String get doseLogCustomDoseBody => '调整这条记录的毫克剂量。';

  @override
  String get doseLogUseThisDose => '使用此剂量';

  @override
  String get doseLogMedication => '药物';

  @override
  String get doseLogInjectionSite => '部位';

  @override
  String get doseLogNotes => '备注';

  @override
  String get doseLogSaveChanges => '保存更改';

  @override
  String get doseLogAddDose => '+ 记录剂量';

  @override
  String get doseLogDeleteTitle => '删除这条剂量记录？';

  @override
  String get doseLogDeleteMessage => '此操作无法撤销。';

  @override
  String get doseLogDeleteLog => '删除记录';

  @override
  String get doseLogSaving => '保存中...';

  @override
  String get doseLogCouldNotSave => '暂时无法保存这条剂量记录。';

  @override
  String get doseLogCouldNotDelete => '暂时无法删除这条剂量记录。';

  @override
  String get doseLogDeleted => '剂量已删除';

  @override
  String get doseLogAddedToDoseLog => '已添加到你的剂量记录';

  @override
  String get doseLogAnythingWorthRemembering => '这次剂量有什么值得记住的吗？';

  @override
  String get doseLogDoseLabel => '剂量';

  @override
  String get exerciseLogTitle => '运动';

  @override
  String get exerciseLogEditTitle => '编辑运动';

  @override
  String get exerciseLogLogTitle => '记录运动';

  @override
  String get exerciseLogActivityType => '活动类型';

  @override
  String get exerciseLogCustomActivity => '自定义';

  @override
  String get exerciseLogTypeActivity => '输入活动';

  @override
  String get exerciseLogDuration => '时长';

  @override
  String get exerciseLogIntensity => '强度';

  @override
  String get exerciseLogNotes => '备注';

  @override
  String get exerciseLogLight => '轻度';

  @override
  String get exerciseLogModerate => '中度';

  @override
  String get exerciseLogIntense => '高强度';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '已记录 $minutes 分钟';
  }

  @override
  String get exerciseLogSaveChanges => '保存更改';

  @override
  String get exerciseLogAddExercise => '+ 记录运动';

  @override
  String get exerciseLogDeleteTitle => '删除这条运动记录？';

  @override
  String get exerciseLogDeleteMessage => '此操作无法撤销。';

  @override
  String get exerciseLogDeleteLog => '删除记录';

  @override
  String get exerciseLogSaving => '保存中...';

  @override
  String get exerciseLogCouldNotSave => '暂时无法保存这条运动记录。';

  @override
  String get exerciseLogCouldNotDelete => '暂时无法删除这条运动记录。';

  @override
  String get exerciseLogDeleted => '运动已删除';

  @override
  String get exerciseLogAddedToExerciseLog => '已添加到你的运动记录';

  @override
  String get exerciseLogAnythingWorthRemembering => '这次运动有什么值得记住的吗？';

  @override
  String get exerciseLogWalking => '步行';

  @override
  String get exerciseLogRunning => '跑步';

  @override
  String get exerciseLogCycling => '骑行';

  @override
  String get exerciseLogStrength => '力量训练';

  @override
  String get exerciseLogYoga => '瑜伽';

  @override
  String get exerciseLogSwim => '游泳';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => '体重';

  @override
  String get weightLogEditTitle => '编辑体重';

  @override
  String get weightLogLogTitle => '记录体重';

  @override
  String get weightLogSaveChanges => '保存更改';

  @override
  String weightLogAddWeight(Object label) {
    return '+ 添加体重（$label）';
  }

  @override
  String get weightLogDeleteTitle => '删除这条体重记录？';

  @override
  String get weightLogDeleteMessage => '此操作无法撤销。';

  @override
  String get weightLogDeleteLog => '删除记录';

  @override
  String get weightLogSaving => '保存中...';

  @override
  String get weightLogCouldNotSave => '暂时无法保存这条体重记录。';

  @override
  String get weightLogCouldNotDelete => '暂时无法删除这条体重记录。';

  @override
  String get weightLogDeleted => '体重已删除';

  @override
  String get weightLogAddedToWeightLog => '已添加到你的体重记录';

  @override
  String get weightLogNoWeightForDay => '这一天还没有记录体重。';

  @override
  String get injectionSiteAbdomen => '腹部';

  @override
  String get injectionSiteThigh => '大腿';

  @override
  String get injectionSiteUpperArm => '上臂';

  @override
  String get injectionSiteButtocks => '臀部';

  @override
  String get injectionSiteAbdomenUpperLeft => '腹部左上';

  @override
  String get injectionSiteAbdomenUpperRight => '腹部右上';

  @override
  String get injectionSiteAbdomenLowerRight => '腹部右下';

  @override
  String get injectionSiteAbdomenLowerLeft => '腹部左下';

  @override
  String get injectionSiteThighUpperLeft => '大腿左上';

  @override
  String get injectionSiteThighUpperRight => '大腿右上';

  @override
  String get injectionSiteThighLowerRight => '大腿右下';

  @override
  String get injectionSiteThighLowerLeft => '大腿左下';

  @override
  String get injectionSiteUpperArmLeft => '左上臂';

  @override
  String get injectionSiteUpperArmRight => '右上臂';

  @override
  String get injectionSiteButtocksUpperLeft => '臀部左上';

  @override
  String get injectionSiteButtocksUpperRight => '臀部右上';

  @override
  String get doseReminderFormat => '形式';

  @override
  String get doseReminderInjection => '注射';

  @override
  String get doseReminderPill => '药片';

  @override
  String get doseReminderSite => '部位';

  @override
  String get doseReminderDate => '日期';

  @override
  String get supplementReminderTitle => '补充剂提醒';

  @override
  String get supplementReminderAddSupplement => '添加补充剂';

  @override
  String get supplementReminderNoSupplementsYet => '暂无补充剂';

  @override
  String get supplementReminderAddFirstBody => '添加你的第一条补充剂提醒以追踪每日摄入。';

  @override
  String get supplementReminderSupplementFallback => '补充剂';

  @override
  String get supplementReminderEveryDay => '每天';

  @override
  String get supplementReminderEveryXDaysLabel => '每 X 天';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return '每 $interval 天';
  }

  @override
  String get supplementReminderNoDaysSet => '未设置日期';

  @override
  String get supplementReminderSupplementName => '补充剂名称';

  @override
  String get supplementReminderTime => '时间';

  @override
  String get supplementReminderStartDate => '开始日期';

  @override
  String get supplementReminderRepeat => '重复';

  @override
  String get supplementReminderDaysOfWeek => '星期几';

  @override
  String get supplementReminderSelectAtLeastOneDay => '至少选择一天。';

  @override
  String get supplementReminderEvery => '每';

  @override
  String get supplementReminderDay => '天';

  @override
  String get supplementReminderDays => '天';

  @override
  String get supplementReminderAdd => '添加';

  @override
  String get symptomsLogTitle => '症状';

  @override
  String get symptomsLogEditTitle => '编辑症状';

  @override
  String get symptomsLogLogTitle => '记录症状';

  @override
  String get symptomsLogSymptomsExperienced => '出现的症状';

  @override
  String get symptomsLogNoSymptoms => '无症状';

  @override
  String get symptomsLogNoSymptomsToday => '今天没有症状';

  @override
  String get symptomsLogOther => '其他...';

  @override
  String get symptomsLogSeverityLevel => '严重程度';

  @override
  String get symptomsLogNotes => '备注';

  @override
  String get symptomsLogAnxiety => '焦虑';

  @override
  String get symptomsLogBelching => '打嗝';

  @override
  String get symptomsLogBloating => '腹胀';

  @override
  String get symptomsLogConstipation => '便秘';

  @override
  String get symptomsLogDiarrhea => '腹泻';

  @override
  String get symptomsLogFatigue => '疲劳';

  @override
  String get symptomsLogFoodNoise => '食欲噪音';

  @override
  String get symptomsLogHairLoss => '脱发';

  @override
  String get symptomsLogHeartburn => '烧心';

  @override
  String get symptomsLogIndigestion => '消化不良';

  @override
  String get symptomsLogInjectionSiteReaction => '注射部位反应';

  @override
  String get symptomsLogMetallicTaste => '金属味';

  @override
  String get symptomsLogHeadache => '头痛';

  @override
  String get symptomsLogMoodSwings => '情绪波动';

  @override
  String get symptomsLogNausea => '恶心';

  @override
  String get symptomsLogReflux => '反流';

  @override
  String get symptomsLogStomachPain => '胃痛';

  @override
  String get symptomsLogSuppressedAppetite => '食欲受抑';

  @override
  String get symptomsLogVomiting => '呕吐';

  @override
  String get symptomsLogLogged => '症状已记录';

  @override
  String get symptomsLogMild => '轻微';

  @override
  String get symptomsLogModerate => '中等';

  @override
  String get symptomsLogSevere => '严重';

  @override
  String get symptomsLogAnythingWorthRemembering => '你当时的感受有什么值得记住的吗？';

  @override
  String get symptomsLogSaveChanges => '保存更改';

  @override
  String get symptomsLogAddSymptoms => '+ 记录症状';

  @override
  String get symptomsLogDeleteTitle => '删除这条症状记录？';

  @override
  String get symptomsLogDeleteMessage => '此操作无法撤销。';

  @override
  String get symptomsLogDeleteLog => '删除记录';

  @override
  String get symptomsLogSaving => '保存中...';

  @override
  String get symptomsLogCouldNotSave => '暂时无法保存这条症状记录。';

  @override
  String get symptomsLogCouldNotDelete => '暂时无法删除这条症状记录。';

  @override
  String get symptomsLogDeleted => '症状已删除';

  @override
  String get symptomsLogAddedToSymptomsLog => '已添加到你的症状记录';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% 的每日目标';
  }

  @override
  String get commonDisclaimer =>
      'Glu 是一个追踪工具，不是医疗设备。它不提供医疗建议、诊断或治疗。关于你的药物和健康决策，请始终咨询你的医疗服务提供者。';
}
