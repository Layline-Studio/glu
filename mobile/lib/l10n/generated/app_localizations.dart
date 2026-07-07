import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_no.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('nl'),
    Locale('no'),
    Locale('pt'),
    Locale('ru'),
    Locale('sv'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Glu'**
  String get appTitle;

  /// No description provided for @startupWakingUp.
  ///
  /// In en, this message translates to:
  /// **'Waking up...'**
  String get startupWakingUp;

  /// No description provided for @startupFailed.
  ///
  /// In en, this message translates to:
  /// **'Startup failed'**
  String get startupFailed;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get commonSaving;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get commonNotNow;

  /// No description provided for @commonNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get commonNow;

  /// No description provided for @commonTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get commonTomorrow;

  /// No description provided for @noteTriggerAddNote.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get noteTriggerAddNote;

  /// No description provided for @noteTriggerCancelNote.
  ///
  /// In en, this message translates to:
  /// **'Cancel note'**
  String get noteTriggerCancelNote;

  /// No description provided for @homeDoseReminderInDays.
  ///
  /// In en, this message translates to:
  /// **'In {count} days'**
  String homeDoseReminderInDays(Object count);

  /// No description provided for @homeDoseReminderInOneWeek.
  ///
  /// In en, this message translates to:
  /// **'In 1 week'**
  String get homeDoseReminderInOneWeek;

  /// No description provided for @homeDoseReminderInWeeks.
  ///
  /// In en, this message translates to:
  /// **'In {count} weeks'**
  String homeDoseReminderInWeeks(Object count);

  /// No description provided for @homeDoseReminderDueOneDayAgo.
  ///
  /// In en, this message translates to:
  /// **'Due 1 day ago'**
  String get homeDoseReminderDueOneDayAgo;

  /// No description provided for @homeDoseReminderDueDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'Due {count} days ago'**
  String homeDoseReminderDueDaysAgo(Object count);

  /// No description provided for @homeDoseReminderDueOneWeekAgo.
  ///
  /// In en, this message translates to:
  /// **'Due 1 week ago'**
  String get homeDoseReminderDueOneWeekAgo;

  /// No description provided for @homeDoseReminderDueWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'Due {count} weeks ago'**
  String homeDoseReminderDueWeeksAgo(Object count);

  /// No description provided for @bmiIndicatorYourBmi.
  ///
  /// In en, this message translates to:
  /// **'Your BMI'**
  String get bmiIndicatorYourBmi;

  /// No description provided for @bmiIndicatorCurrentBmi.
  ///
  /// In en, this message translates to:
  /// **'Your current BMI'**
  String get bmiIndicatorCurrentBmi;

  /// No description provided for @bmiIndicatorUnderweight.
  ///
  /// In en, this message translates to:
  /// **'Underweight'**
  String get bmiIndicatorUnderweight;

  /// No description provided for @bmiIndicatorNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get bmiIndicatorNormal;

  /// No description provided for @bmiIndicatorOverweight.
  ///
  /// In en, this message translates to:
  /// **'Overweight'**
  String get bmiIndicatorOverweight;

  /// No description provided for @bmiIndicatorObesity.
  ///
  /// In en, this message translates to:
  /// **'Obesity'**
  String get bmiIndicatorObesity;

  /// No description provided for @heightRulerCmUnit.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get heightRulerCmUnit;

  /// No description provided for @heightRulerFtUnit.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get heightRulerFtUnit;

  /// No description provided for @heightRulerInUnit.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get heightRulerInUnit;

  /// No description provided for @heightRulerFtInUnit.
  ///
  /// In en, this message translates to:
  /// **'ft/in'**
  String get heightRulerFtInUnit;

  /// No description provided for @weightDialKgUnit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get weightDialKgUnit;

  /// No description provided for @weightDialLbUnit.
  ///
  /// In en, this message translates to:
  /// **'lb'**
  String get weightDialLbUnit;

  /// No description provided for @logNoteIndicatorHasNote.
  ///
  /// In en, this message translates to:
  /// **'Has note'**
  String get logNoteIndicatorHasNote;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Glu Pro'**
  String get paywallTitle;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Without Pro, here\'s what you lose:'**
  String get paywallSubtitle;

  /// No description provided for @paywallMonthlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get paywallMonthlyTitle;

  /// No description provided for @paywallMonthlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'No trial'**
  String get paywallMonthlySubtitle;

  /// No description provided for @paywallYearlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get paywallYearlyTitle;

  /// No description provided for @paywallYearlySubtitle.
  ///
  /// In en, this message translates to:
  /// **'7-day free trial'**
  String get paywallYearlySubtitle;

  /// No description provided for @paywallNoCommitment.
  ///
  /// In en, this message translates to:
  /// **'No commitment'**
  String get paywallNoCommitment;

  /// No description provided for @paywallCancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime'**
  String get paywallCancelAnytime;

  /// No description provided for @paywallContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get paywallContinue;

  /// No description provided for @paywallRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get paywallRestore;

  /// No description provided for @paywallTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get paywallTerms;

  /// No description provided for @paywallPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get paywallPrivacy;

  /// No description provided for @paywallSeparator.
  ///
  /// In en, this message translates to:
  /// **'•'**
  String get paywallSeparator;

  /// No description provided for @paywallSavePercent.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String paywallSavePercent(Object percent);

  /// No description provided for @paywallCouldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link right now.'**
  String get paywallCouldNotOpenLink;

  /// No description provided for @paywallAlreadySubscribed.
  ///
  /// In en, this message translates to:
  /// **'You already have Glu Pro.'**
  String get paywallAlreadySubscribed;

  /// No description provided for @paywallPurchaseSuccess.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Glu Pro!'**
  String get paywallPurchaseSuccess;

  /// No description provided for @paywallPurchaseIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Purchase did not complete. Please try again.'**
  String get paywallPurchaseIncomplete;

  /// No description provided for @paywallPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed. Please try again.'**
  String get paywallPurchaseFailed;

  /// No description provided for @paywallPurchaseFailedWithCode.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed: {errorCode}'**
  String paywallPurchaseFailedWithCode(Object errorCode);

  /// No description provided for @paywallRestoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Subscription restored!'**
  String get paywallRestoreSuccess;

  /// No description provided for @paywallRestoreNoSubscription.
  ///
  /// In en, this message translates to:
  /// **'No active subscription found.'**
  String get paywallRestoreNoSubscription;

  /// No description provided for @paywallRestoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed. Please try again.'**
  String get paywallRestoreFailed;

  /// No description provided for @paywallBenefitReminders.
  ///
  /// In en, this message translates to:
  /// **'Miss doses without reminders'**
  String get paywallBenefitReminders;

  /// No description provided for @paywallBenefitShareProgress.
  ///
  /// In en, this message translates to:
  /// **'Harder to share your progress'**
  String get paywallBenefitShareProgress;

  /// No description provided for @paywallBenefitSpotRegain.
  ///
  /// In en, this message translates to:
  /// **'Miss regain signs'**
  String get paywallBenefitSpotRegain;

  /// No description provided for @paywallBenefitInsights.
  ///
  /// In en, this message translates to:
  /// **'Miss your daily patterns'**
  String get paywallBenefitInsights;

  /// No description provided for @paywallBenefitWeeklyGoals.
  ///
  /// In en, this message translates to:
  /// **'Lose your weekly structure'**
  String get paywallBenefitWeeklyGoals;

  /// No description provided for @paywallBenefitHealthyHabits.
  ///
  /// In en, this message translates to:
  /// **'Habits slip without support'**
  String get paywallBenefitHealthyHabits;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep the weight off'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Glu helps you protect your progress around treatment, goals, and weekly habits.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingWelcomeBullet1.
  ///
  /// In en, this message translates to:
  /// **'Fits your treatment and goals'**
  String get onboardingWelcomeBullet1;

  /// No description provided for @onboardingWelcomeBullet2.
  ///
  /// In en, this message translates to:
  /// **'Simple and realistic support'**
  String get onboardingWelcomeBullet2;

  /// No description provided for @onboardingWelcomeBullet3.
  ///
  /// In en, this message translates to:
  /// **'Easily spot early signs of weight regain'**
  String get onboardingWelcomeBullet3;

  /// No description provided for @onboardingWelcomeBullet4.
  ///
  /// In en, this message translates to:
  /// **'Keep going without starting over'**
  String get onboardingWelcomeBullet4;

  /// No description provided for @onboardingMedicationStatusQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you currently taking a weight loss pen or pill medication?'**
  String get onboardingMedicationStatusQuestion;

  /// No description provided for @onboardingMedicationStatusExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to show guidance that matches where you are right now.'**
  String get onboardingMedicationStatusExplainer;

  /// No description provided for @onboardingMedicationStatusUsing.
  ///
  /// In en, this message translates to:
  /// **'Yes, I’m taking it now'**
  String get onboardingMedicationStatusUsing;

  /// No description provided for @onboardingMedicationStatusWeaningOff.
  ///
  /// In en, this message translates to:
  /// **'Yes, I’m weaning off'**
  String get onboardingMedicationStatusWeaningOff;

  /// No description provided for @onboardingMedicationStatusNotTaking.
  ///
  /// In en, this message translates to:
  /// **'No, I’m not taking it'**
  String get onboardingMedicationStatusNotTaking;

  /// No description provided for @onboardingMedicationStatusStartingSoon.
  ///
  /// In en, this message translates to:
  /// **'No, I’ll start soon'**
  String get onboardingMedicationStatusStartingSoon;

  /// No description provided for @onboardingMedicationStatusRecentlyStopped.
  ///
  /// In en, this message translates to:
  /// **'No, I recently stopped'**
  String get onboardingMedicationStatusRecentlyStopped;

  /// No description provided for @onboardingMedicationMethodQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do you take your medication?'**
  String get onboardingMedicationMethodQuestion;

  /// No description provided for @onboardingMedicationMethodExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to tailor instructions and reminders to your medication format.'**
  String get onboardingMedicationMethodExplainer;

  /// No description provided for @onboardingMedicationMethodInjection.
  ///
  /// In en, this message translates to:
  /// **'Injection'**
  String get onboardingMedicationMethodInjection;

  /// No description provided for @onboardingMedicationMethodPill.
  ///
  /// In en, this message translates to:
  /// **'Pill'**
  String get onboardingMedicationMethodPill;

  /// No description provided for @onboardingMedicationMethodUnknown.
  ///
  /// In en, this message translates to:
  /// **'I don’t know yet'**
  String get onboardingMedicationMethodUnknown;

  /// No description provided for @onboardingMedicationNameQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which medication are you taking?'**
  String get onboardingMedicationNameQuestion;

  /// No description provided for @onboardingMedicationNameExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to personalize dose tracking and medication-specific guidance.'**
  String get onboardingMedicationNameExplainer;

  /// No description provided for @onboardingCurrentDoseQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your current dose?'**
  String get onboardingCurrentDoseQuestion;

  /// No description provided for @onboardingCurrentDoseExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to tailor dose tracking and future progress check-ins.'**
  String get onboardingCurrentDoseExplainer;

  /// No description provided for @onboardingMedicationCustomDose.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get onboardingMedicationCustomDose;

  /// No description provided for @onboardingDeviceTypeQuestion.
  ///
  /// In en, this message translates to:
  /// **'What device do you use to take your medication?'**
  String get onboardingDeviceTypeQuestion;

  /// No description provided for @onboardingDeviceTypeExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to make reminders and tips match the way you take it.'**
  String get onboardingDeviceTypeExplainer;

  /// No description provided for @onboardingDeviceSinglePen.
  ///
  /// In en, this message translates to:
  /// **'Single pen'**
  String get onboardingDeviceSinglePen;

  /// No description provided for @onboardingDeviceAutoInjector.
  ///
  /// In en, this message translates to:
  /// **'Auto-injector'**
  String get onboardingDeviceAutoInjector;

  /// No description provided for @onboardingDeviceSyringeAndVial.
  ///
  /// In en, this message translates to:
  /// **'Syringe and vial'**
  String get onboardingDeviceSyringeAndVial;

  /// No description provided for @onboardingOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get onboardingOther;

  /// No description provided for @onboardingTypeYourDevice.
  ///
  /// In en, this message translates to:
  /// **'Type your device'**
  String get onboardingTypeYourDevice;

  /// No description provided for @onboardingMedicationFrequencyQuestion.
  ///
  /// In en, this message translates to:
  /// **'How often do you take your medication?'**
  String get onboardingMedicationFrequencyQuestion;

  /// No description provided for @onboardingMedicationFrequencyExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to time reminders and routine support around your schedule.'**
  String get onboardingMedicationFrequencyExplainer;

  /// No description provided for @onboardingEveryDay.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get onboardingEveryDay;

  /// No description provided for @onboardingEvery7Days.
  ///
  /// In en, this message translates to:
  /// **'Every 7 days'**
  String get onboardingEvery7Days;

  /// No description provided for @onboardingEvery14Days.
  ///
  /// In en, this message translates to:
  /// **'Every 14 days'**
  String get onboardingEvery14Days;

  /// No description provided for @onboardingCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get onboardingCustom;

  /// No description provided for @onboardingDaysBetweenDoses.
  ///
  /// In en, this message translates to:
  /// **'Days between doses'**
  String get onboardingDaysBetweenDoses;

  /// No description provided for @onboardingPrimaryGoalQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your primary goal right now?'**
  String get onboardingPrimaryGoalQuestion;

  /// No description provided for @onboardingPrimaryGoalExplainerWithMedication.
  ///
  /// In en, this message translates to:
  /// **'We use this to focus your plan, reminders, and progress around what matters most to you.'**
  String get onboardingPrimaryGoalExplainerWithMedication;

  /// No description provided for @onboardingPrimaryGoalExplainerWithoutMedication.
  ///
  /// In en, this message translates to:
  /// **'We use this to shape your plan from the very beginning.'**
  String get onboardingPrimaryGoalExplainerWithoutMedication;

  /// No description provided for @onboardingPrimaryGoalExplainerDefault.
  ///
  /// In en, this message translates to:
  /// **'We use this to support your next phase and help you stay on track.'**
  String get onboardingPrimaryGoalExplainerDefault;

  /// No description provided for @onboardingGoalLoseWeight.
  ///
  /// In en, this message translates to:
  /// **'Lose weight'**
  String get onboardingGoalLoseWeight;

  /// No description provided for @onboardingGoalMaintainWeight.
  ///
  /// In en, this message translates to:
  /// **'Maintain my weight'**
  String get onboardingGoalMaintainWeight;

  /// No description provided for @onboardingGoalManageDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Manage my diabetes'**
  String get onboardingGoalManageDiabetes;

  /// No description provided for @onboardingGoalManagePcos.
  ///
  /// In en, this message translates to:
  /// **'Manage my PCOS'**
  String get onboardingGoalManagePcos;

  /// No description provided for @onboardingGoalImproveHeartHealth.
  ///
  /// In en, this message translates to:
  /// **'Improve my heart health'**
  String get onboardingGoalImproveHeartHealth;

  /// No description provided for @onboardingAgeQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your age?'**
  String get onboardingAgeQuestion;

  /// No description provided for @onboardingAgeExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to adjust guidance and health calculations more appropriately.'**
  String get onboardingAgeExplainer;

  /// No description provided for @onboardingHeightQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your height?'**
  String get onboardingHeightQuestion;

  /// No description provided for @onboardingHeightExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this with your weight to calculate things like BMI and healthy ranges.'**
  String get onboardingHeightExplainer;

  /// No description provided for @onboardingWeightQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your current weight?'**
  String get onboardingWeightQuestion;

  /// No description provided for @onboardingWeightExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this as your starting point for progress, goals, and health estimates.'**
  String get onboardingWeightExplainer;

  /// No description provided for @onboardingMedicationStartedQuestionStopped.
  ///
  /// In en, this message translates to:
  /// **'When did you stop the medication?'**
  String get onboardingMedicationStartedQuestionStopped;

  /// No description provided for @onboardingMedicationStartedQuestionWeaning.
  ///
  /// In en, this message translates to:
  /// **'When did you start weaning off the medication?'**
  String get onboardingMedicationStartedQuestionWeaning;

  /// No description provided for @onboardingMedicationStartedQuestionStarted.
  ///
  /// In en, this message translates to:
  /// **'When did you start the medication?'**
  String get onboardingMedicationStartedQuestionStarted;

  /// No description provided for @onboardingMedicationStartedExplainerStopped.
  ///
  /// In en, this message translates to:
  /// **'We use this to understand your recent treatment history and next phase.'**
  String get onboardingMedicationStartedExplainerStopped;

  /// No description provided for @onboardingMedicationStartedExplainerWeaning.
  ///
  /// In en, this message translates to:
  /// **'We use this to understand your transition phase and support the habits that matter most now.'**
  String get onboardingMedicationStartedExplainerWeaning;

  /// No description provided for @onboardingMedicationStartedExplainerStarted.
  ///
  /// In en, this message translates to:
  /// **'We use this to understand how long you’ve been on treatment and track change over time.'**
  String get onboardingMedicationStartedExplainerStarted;

  /// No description provided for @onboardingGoalWeightQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your goal weight?'**
  String get onboardingGoalWeightQuestion;

  /// No description provided for @onboardingGoalWeightExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to frame progress and show a target BMI range for you.'**
  String get onboardingGoalWeightExplainer;

  /// No description provided for @onboardingBenefitsQuestion.
  ///
  /// In en, this message translates to:
  /// **'What Glu will help you do next'**
  String get onboardingBenefitsQuestion;

  /// No description provided for @onboardingBenefitsExplainer.
  ///
  /// In en, this message translates to:
  /// **'Glu turns what you shared into reminders, support, and structure that fit your routine.'**
  String get onboardingBenefitsExplainer;

  /// No description provided for @onboardingBenefitsHeroMaintainWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Here’s how Glu can help you maintain your progress'**
  String get onboardingBenefitsHeroMaintainWeightTitle;

  /// No description provided for @onboardingBenefitsHeroDiabetesTitle.
  ///
  /// In en, this message translates to:
  /// **'Here’s how Glu can support your diabetes routine'**
  String get onboardingBenefitsHeroDiabetesTitle;

  /// No description provided for @onboardingBenefitsHeroPcosTitle.
  ///
  /// In en, this message translates to:
  /// **'Here’s how Glu can support your PCOS routine'**
  String get onboardingBenefitsHeroPcosTitle;

  /// No description provided for @onboardingBenefitsHeroHeartTitle.
  ///
  /// In en, this message translates to:
  /// **'Here’s how Glu can support your heart health'**
  String get onboardingBenefitsHeroHeartTitle;

  /// No description provided for @onboardingBenefitsHeroWeightLossTitle.
  ///
  /// In en, this message translates to:
  /// **'Here’s how Glu can help you lose weight'**
  String get onboardingBenefitsHeroWeightLossTitle;

  /// No description provided for @onboardingBenefitsHeroMaintainWeightBody.
  ///
  /// In en, this message translates to:
  /// **'See how Glu helps you protect your current weight and catch regain early.'**
  String get onboardingBenefitsHeroMaintainWeightBody;

  /// No description provided for @onboardingBenefitsHeroDiabetesBody.
  ///
  /// In en, this message translates to:
  /// **'See how Glu helps you keep meals, weight, and routines steadier week to week.'**
  String get onboardingBenefitsHeroDiabetesBody;

  /// No description provided for @onboardingBenefitsHeroPcosBody.
  ///
  /// In en, this message translates to:
  /// **'See how Glu helps you stay steadier around symptoms, weight, and routine.'**
  String get onboardingBenefitsHeroPcosBody;

  /// No description provided for @onboardingBenefitsHeroHeartBody.
  ///
  /// In en, this message translates to:
  /// **'See how Glu helps you stay consistent with the habits that support heart health.'**
  String get onboardingBenefitsHeroHeartBody;

  /// No description provided for @onboardingBenefitsHeroWeightLossBody.
  ///
  /// In en, this message translates to:
  /// **'See how Glu helps you spot the patterns that keep weight moving down.'**
  String get onboardingBenefitsHeroWeightLossBody;

  /// No description provided for @onboardingBenefitsSpecificMaintainWeight.
  ///
  /// In en, this message translates to:
  /// **'Without structure, regain can build quietly. Glu helps you catch it earlier and stay steady.'**
  String get onboardingBenefitsSpecificMaintainWeight;

  /// No description provided for @onboardingBenefitsSpecificDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Without structure, meals and weight patterns get noisy. Glu keeps the signals clearer.'**
  String get onboardingBenefitsSpecificDiabetes;

  /// No description provided for @onboardingBenefitsSpecificPcos.
  ///
  /// In en, this message translates to:
  /// **'Without structure, symptoms and routines can swing more. Glu helps you stay steadier.'**
  String get onboardingBenefitsSpecificPcos;

  /// No description provided for @onboardingBenefitsSpecificHeart.
  ///
  /// In en, this message translates to:
  /// **'Without structure, healthy habits drift. Glu helps you keep activity and weight on track.'**
  String get onboardingBenefitsSpecificHeart;

  /// No description provided for @onboardingBenefitsSpecificWeightLoss.
  ///
  /// In en, this message translates to:
  /// **'Without structure, weight can stall or drift up. Glu helps keep progress moving in the right direction.'**
  String get onboardingBenefitsSpecificWeightLoss;

  /// No description provided for @onboardingBenefitsAxisWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get onboardingBenefitsAxisWeight;

  /// No description provided for @onboardingBenefitsAxisMealsWeight.
  ///
  /// In en, this message translates to:
  /// **'Meals & weight'**
  String get onboardingBenefitsAxisMealsWeight;

  /// No description provided for @onboardingBenefitsAxisSymptomsWeight.
  ///
  /// In en, this message translates to:
  /// **'Symptoms & weight'**
  String get onboardingBenefitsAxisSymptomsWeight;

  /// No description provided for @onboardingBenefitsAxisExerciseWeight.
  ///
  /// In en, this message translates to:
  /// **'Exercise & weight'**
  String get onboardingBenefitsAxisExerciseWeight;

  /// No description provided for @onboardingNotificationsQuestion.
  ///
  /// In en, this message translates to:
  /// **'Turn on reminders that support your goal'**
  String get onboardingNotificationsQuestion;

  /// No description provided for @onboardingNotificationsExplainer.
  ///
  /// In en, this message translates to:
  /// **'We’ll use notifications to help you stay consistent, prepared, and on track.'**
  String get onboardingNotificationsExplainer;

  /// No description provided for @onboardingNotificationsHeadline.
  ///
  /// In en, this message translates to:
  /// **'Set Glu up to help at the right moment.'**
  String get onboardingNotificationsHeadline;

  /// No description provided for @onboardingNotificationsBody.
  ///
  /// In en, this message translates to:
  /// **'Turn on notifications so Glu can reinforce the habits that support your goal.'**
  String get onboardingNotificationsBody;

  /// No description provided for @onboardingNotificationsDaily.
  ///
  /// In en, this message translates to:
  /// **'Timed reminders that match your daily medication rhythm'**
  String get onboardingNotificationsDaily;

  /// No description provided for @onboardingNotificationsEvery14Days.
  ///
  /// In en, this message translates to:
  /// **'Longer-range reminders so dose days do not sneak up on you'**
  String get onboardingNotificationsEvery14Days;

  /// No description provided for @onboardingNotificationsCustom.
  ///
  /// In en, this message translates to:
  /// **'Reminders shaped around your custom schedule'**
  String get onboardingNotificationsCustom;

  /// No description provided for @onboardingNotificationsWeekly.
  ///
  /// In en, this message translates to:
  /// **'Dose reminders that stay aligned with your weekly rhythm'**
  String get onboardingNotificationsWeekly;

  /// No description provided for @onboardingNotificationsSupportive.
  ///
  /// In en, this message translates to:
  /// **'Supportive reminders that keep your routine visible when motivation dips'**
  String get onboardingNotificationsSupportive;

  /// No description provided for @onboardingNotificationsProgress.
  ///
  /// In en, this message translates to:
  /// **'Timely nudges around progress, habits, and the goals you told us matter most'**
  String get onboardingNotificationsProgress;

  /// No description provided for @onboardingNotificationsHelpful.
  ///
  /// In en, this message translates to:
  /// **'Helpful prompts that make Glu more useful in the moments you need it'**
  String get onboardingNotificationsHelpful;

  /// No description provided for @onboardingDailyRoutineQuestion.
  ///
  /// In en, this message translates to:
  /// **'What’s your daily routine?'**
  String get onboardingDailyRoutineQuestion;

  /// No description provided for @onboardingDailyRoutineExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to make your plan feel realistic for your day-to-day life.'**
  String get onboardingDailyRoutineExplainer;

  /// No description provided for @onboardingRoutineSedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get onboardingRoutineSedentary;

  /// No description provided for @onboardingRoutineSedentaryDescription.
  ///
  /// In en, this message translates to:
  /// **'Mostly sitting, desk work, and very little intentional exercise.'**
  String get onboardingRoutineSedentaryDescription;

  /// No description provided for @onboardingRoutineLightlyActive.
  ///
  /// In en, this message translates to:
  /// **'Lightly active'**
  String get onboardingRoutineLightlyActive;

  /// No description provided for @onboardingRoutineLightlyActiveDescription.
  ///
  /// In en, this message translates to:
  /// **'Regular walking, errands, or light workouts a few times a week.'**
  String get onboardingRoutineLightlyActiveDescription;

  /// No description provided for @onboardingRoutineActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get onboardingRoutineActive;

  /// No description provided for @onboardingRoutineActiveDescription.
  ///
  /// In en, this message translates to:
  /// **'Frequent movement or exercise, like daily walks, gym, or active work.'**
  String get onboardingRoutineActiveDescription;

  /// No description provided for @onboardingRoutineVeryActive.
  ///
  /// In en, this message translates to:
  /// **'Very active'**
  String get onboardingRoutineVeryActive;

  /// No description provided for @onboardingRoutineVeryActiveDescription.
  ///
  /// In en, this message translates to:
  /// **'Hard training, physically demanding work, or high activity most days.'**
  String get onboardingRoutineVeryActiveDescription;

  /// No description provided for @onboardingSymptomConcernsQuestion.
  ///
  /// In en, this message translates to:
  /// **'Which symptoms are you most concerned about, if any?'**
  String get onboardingSymptomConcernsQuestion;

  /// No description provided for @onboardingSymptomConcernsExplainerWithMedication.
  ///
  /// In en, this message translates to:
  /// **'We use this to prioritize tips and guidance around the symptoms you care about most.'**
  String get onboardingSymptomConcernsExplainerWithMedication;

  /// No description provided for @onboardingSymptomConcernsExplainerDefault.
  ///
  /// In en, this message translates to:
  /// **'We use this to focus on the symptoms you want to stay ahead of.'**
  String get onboardingSymptomConcernsExplainerDefault;

  /// No description provided for @onboardingGenderQuestion.
  ///
  /// In en, this message translates to:
  /// **'How do you describe your gender?'**
  String get onboardingGenderQuestion;

  /// No description provided for @onboardingGenderExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this for more relevant guidance and future personalization.'**
  String get onboardingGenderExplainer;

  /// No description provided for @onboardingGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get onboardingGenderFemale;

  /// No description provided for @onboardingGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get onboardingGenderMale;

  /// No description provided for @onboardingGenderPreferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get onboardingGenderPreferNotToSay;

  /// No description provided for @onboardingTypeYourGender.
  ///
  /// In en, this message translates to:
  /// **'Type your gender'**
  String get onboardingTypeYourGender;

  /// No description provided for @onboardingPreferredNameQuestion.
  ///
  /// In en, this message translates to:
  /// **'What should we call you?'**
  String get onboardingPreferredNameQuestion;

  /// No description provided for @onboardingPreferredNameExplainer.
  ///
  /// In en, this message translates to:
  /// **'We use this to make Glu feel more personal when we talk to you.'**
  String get onboardingPreferredNameExplainer;

  /// No description provided for @onboardingPreferredNameHint.
  ///
  /// In en, this message translates to:
  /// **'Alex'**
  String get onboardingPreferredNameHint;

  /// No description provided for @onboardingSetupSummaryQuestion.
  ///
  /// In en, this message translates to:
  /// **'Setting up your plan'**
  String get onboardingSetupSummaryQuestion;

  /// No description provided for @onboardingSetupSummaryExplainer.
  ///
  /// In en, this message translates to:
  /// **'We’re turning what you shared into a plan Glu can support right away.'**
  String get onboardingSetupSummaryExplainer;

  /// No description provided for @onboardingSetupSummaryMaintainStep1.
  ///
  /// In en, this message translates to:
  /// **'Locking in weight-maintenance targets...'**
  String get onboardingSetupSummaryMaintainStep1;

  /// No description provided for @onboardingSetupSummaryMaintainStep2.
  ///
  /// In en, this message translates to:
  /// **'Setting up regain watchpoints...'**
  String get onboardingSetupSummaryMaintainStep2;

  /// No description provided for @onboardingSetupSummaryMaintainStep3.
  ///
  /// In en, this message translates to:
  /// **'Tuning reminders around your routine...'**
  String get onboardingSetupSummaryMaintainStep3;

  /// No description provided for @onboardingSetupSummaryMaintainStep4.
  ///
  /// In en, this message translates to:
  /// **'Preparing a steadier weekly plan...'**
  String get onboardingSetupSummaryMaintainStep4;

  /// No description provided for @onboardingSetupSummaryDiabetesStep1.
  ///
  /// In en, this message translates to:
  /// **'Defining meal and weight patterns...'**
  String get onboardingSetupSummaryDiabetesStep1;

  /// No description provided for @onboardingSetupSummaryDiabetesStep2.
  ///
  /// In en, this message translates to:
  /// **'Setting hydration support...'**
  String get onboardingSetupSummaryDiabetesStep2;

  /// No description provided for @onboardingSetupSummaryDiabetesStep3.
  ///
  /// In en, this message translates to:
  /// **'Preparing consistency reminders...'**
  String get onboardingSetupSummaryDiabetesStep3;

  /// No description provided for @onboardingSetupSummaryDiabetesStep4.
  ///
  /// In en, this message translates to:
  /// **'Building a clearer daily structure...'**
  String get onboardingSetupSummaryDiabetesStep4;

  /// No description provided for @onboardingSetupSummaryPcosStep1.
  ///
  /// In en, this message translates to:
  /// **'Organizing symptom support...'**
  String get onboardingSetupSummaryPcosStep1;

  /// No description provided for @onboardingSetupSummaryPcosStep2.
  ///
  /// In en, this message translates to:
  /// **'Defining weekly movement targets...'**
  String get onboardingSetupSummaryPcosStep2;

  /// No description provided for @onboardingSetupSummaryPcosStep3.
  ///
  /// In en, this message translates to:
  /// **'Setting hydration and routine anchors...'**
  String get onboardingSetupSummaryPcosStep3;

  /// No description provided for @onboardingSetupSummaryPcosStep4.
  ///
  /// In en, this message translates to:
  /// **'Preparing a steadier plan...'**
  String get onboardingSetupSummaryPcosStep4;

  /// No description provided for @onboardingSetupSummaryHeartStep1.
  ///
  /// In en, this message translates to:
  /// **'Setting activity targets...'**
  String get onboardingSetupSummaryHeartStep1;

  /// No description provided for @onboardingSetupSummaryHeartStep2.
  ///
  /// In en, this message translates to:
  /// **'Defining hydration support...'**
  String get onboardingSetupSummaryHeartStep2;

  /// No description provided for @onboardingSetupSummaryHeartStep3.
  ///
  /// In en, this message translates to:
  /// **'Preparing weekly habit reminders...'**
  String get onboardingSetupSummaryHeartStep3;

  /// No description provided for @onboardingSetupSummaryHeartStep4.
  ///
  /// In en, this message translates to:
  /// **'Building a heart-health routine...'**
  String get onboardingSetupSummaryHeartStep4;

  /// No description provided for @onboardingSetupSummaryWeightLossStep1.
  ///
  /// In en, this message translates to:
  /// **'Defining calorie boundaries...'**
  String get onboardingSetupSummaryWeightLossStep1;

  /// No description provided for @onboardingSetupSummaryWeightLossStep2.
  ///
  /// In en, this message translates to:
  /// **'Setting water amounts...'**
  String get onboardingSetupSummaryWeightLossStep2;

  /// No description provided for @onboardingSetupSummaryWeightLossStep3.
  ///
  /// In en, this message translates to:
  /// **'Building exercise targets...'**
  String get onboardingSetupSummaryWeightLossStep3;

  /// No description provided for @onboardingSetupSummaryWeightLossStep4.
  ///
  /// In en, this message translates to:
  /// **'Preparing your weekly plan...'**
  String get onboardingSetupSummaryWeightLossStep4;

  /// No description provided for @onboardingSetupSummaryHeadline.
  ///
  /// In en, this message translates to:
  /// **'Your Glu setup is ready.'**
  String get onboardingSetupSummaryHeadline;

  /// No description provided for @onboardingSetupLoadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Building your setup'**
  String get onboardingSetupLoadingTitle;

  /// No description provided for @onboardingSetupSummaryMaintainBody.
  ///
  /// In en, this message translates to:
  /// **'Glu is ready to help you protect your progress with clearer structure and earlier regain signals.'**
  String get onboardingSetupSummaryMaintainBody;

  /// No description provided for @onboardingSetupSummaryDiabetesBody.
  ///
  /// In en, this message translates to:
  /// **'Glu is ready to support steadier meals, weight tracking, and habits that matter day to day.'**
  String get onboardingSetupSummaryDiabetesBody;

  /// No description provided for @onboardingSetupSummaryPcosBody.
  ///
  /// In en, this message translates to:
  /// **'Glu is ready to support steadier routines around symptoms, treatment, and progress.'**
  String get onboardingSetupSummaryPcosBody;

  /// No description provided for @onboardingSetupSummaryHeartBody.
  ///
  /// In en, this message translates to:
  /// **'Glu is ready to reinforce the habits that support your long-term heart health.'**
  String get onboardingSetupSummaryHeartBody;

  /// No description provided for @onboardingSetupSummaryWeightLossBody.
  ///
  /// In en, this message translates to:
  /// **'Glu is ready to support the routines that help you keep the weight off.'**
  String get onboardingSetupSummaryWeightLossBody;

  /// No description provided for @onboardingSetupSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get onboardingSetupSummaryLabel;

  /// No description provided for @onboardingSetupAdjustLater.
  ///
  /// In en, this message translates to:
  /// **'You can adjust any of this later in Settings.'**
  String get onboardingSetupAdjustLater;

  /// No description provided for @onboardingSummaryGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get onboardingSummaryGoal;

  /// No description provided for @onboardingSummaryCurrentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current weight'**
  String get onboardingSummaryCurrentWeight;

  /// No description provided for @onboardingSummaryMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get onboardingSummaryMedication;

  /// No description provided for @onboardingSummaryCurrentDose.
  ///
  /// In en, this message translates to:
  /// **'Current dose'**
  String get onboardingSummaryCurrentDose;

  /// No description provided for @onboardingSummaryCadence.
  ///
  /// In en, this message translates to:
  /// **'Cadence'**
  String get onboardingSummaryCadence;

  /// No description provided for @onboardingSummaryStarted.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get onboardingSummaryStarted;

  /// No description provided for @onboardingSummaryTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target weight'**
  String get onboardingSummaryTargetWeight;

  /// No description provided for @onboardingSummaryRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routine'**
  String get onboardingSummaryRoutine;

  /// No description provided for @onboardingSummaryFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus'**
  String get onboardingSummaryFocus;

  /// No description provided for @onboardingFrequencyEveryDay.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get onboardingFrequencyEveryDay;

  /// No description provided for @onboardingFrequencyEveryWeek.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get onboardingFrequencyEveryWeek;

  /// No description provided for @onboardingFrequencyEvery2Weeks.
  ///
  /// In en, this message translates to:
  /// **'Every 2 weeks'**
  String get onboardingFrequencyEvery2Weeks;

  /// No description provided for @onboardingFrequencyCustomSchedule.
  ///
  /// In en, this message translates to:
  /// **'Custom schedule'**
  String get onboardingFrequencyCustomSchedule;

  /// No description provided for @onboardingTapOptionContinue.
  ///
  /// In en, this message translates to:
  /// **'Tap an option to continue.'**
  String get onboardingTapOptionContinue;

  /// No description provided for @onboardingTypeGenderContinue.
  ///
  /// In en, this message translates to:
  /// **'Type your gender to continue.'**
  String get onboardingTypeGenderContinue;

  /// No description provided for @onboardingTypeDeviceContinue.
  ///
  /// In en, this message translates to:
  /// **'Type your device to continue.'**
  String get onboardingTypeDeviceContinue;

  /// No description provided for @onboardingTypeMedicationContinue.
  ///
  /// In en, this message translates to:
  /// **'Type your medication to continue.'**
  String get onboardingTypeMedicationContinue;

  /// No description provided for @onboardingEnterDaysBetweenDosesContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter days between doses to continue.'**
  String get onboardingEnterDaysBetweenDosesContinue;

  /// No description provided for @onboardingChooseScheduleContinue.
  ///
  /// In en, this message translates to:
  /// **'Choose a schedule to continue.'**
  String get onboardingChooseScheduleContinue;

  /// No description provided for @onboardingScrollChooseAge.
  ///
  /// In en, this message translates to:
  /// **'Scroll to choose your age.'**
  String get onboardingScrollChooseAge;

  /// No description provided for @onboardingDragOrTapHeight.
  ///
  /// In en, this message translates to:
  /// **'Drag or tap the ruler to choose your height.'**
  String get onboardingDragOrTapHeight;

  /// No description provided for @onboardingDragTapOrUseWeight.
  ///
  /// In en, this message translates to:
  /// **'Drag, tap, or use the step buttons to choose a weight.'**
  String get onboardingDragTapOrUseWeight;

  /// No description provided for @onboardingPickDateAndWeight.
  ///
  /// In en, this message translates to:
  /// **'Pick a date and choose a weight to continue.'**
  String get onboardingPickDateAndWeight;

  /// No description provided for @onboardingSelectSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Select any symptoms you want Glu to focus on.'**
  String get onboardingSelectSymptoms;

  /// No description provided for @onboardingTypeName.
  ///
  /// In en, this message translates to:
  /// **'Type the name you want Glu to use.'**
  String get onboardingTypeName;

  /// No description provided for @onboardingSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get onboardingSaving;

  /// No description provided for @onboardingLetsBegin.
  ///
  /// In en, this message translates to:
  /// **'Let’s begin'**
  String get onboardingLetsBegin;

  /// No description provided for @onboardingContinueWithGlu.
  ///
  /// In en, this message translates to:
  /// **'Continue with Glu'**
  String get onboardingContinueWithGlu;

  /// No description provided for @onboardingKeepGoing.
  ///
  /// In en, this message translates to:
  /// **'Keep going'**
  String get onboardingKeepGoing;

  /// No description provided for @onboardingTurnOnNotifications.
  ///
  /// In en, this message translates to:
  /// **'Turn on notifications'**
  String get onboardingTurnOnNotifications;

  /// No description provided for @onboardingFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get onboardingFinish;

  /// No description provided for @onboardingTargetBmiTitle.
  ///
  /// In en, this message translates to:
  /// **'Your target BMI'**
  String get onboardingTargetBmiTitle;

  /// No description provided for @onboardingChartToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get onboardingChartToday;

  /// No description provided for @onboardingChartOverTime.
  ///
  /// In en, this message translates to:
  /// **'Over time'**
  String get onboardingChartOverTime;

  /// No description provided for @onboardingChartWithoutGlu.
  ///
  /// In en, this message translates to:
  /// **'Without Glu'**
  String get onboardingChartWithoutGlu;

  /// No description provided for @onboardingChartWithGlu.
  ///
  /// In en, this message translates to:
  /// **'With Glu'**
  String get onboardingChartWithGlu;

  /// No description provided for @onboardingReviewQuestion.
  ///
  /// In en, this message translates to:
  /// **'People use Glu to stay steady and supported'**
  String get onboardingReviewQuestion;

  /// No description provided for @onboardingReviewExplainer.
  ///
  /// In en, this message translates to:
  /// **'A quick rating helps more people find support that feels this simple.'**
  String get onboardingReviewExplainer;

  /// No description provided for @onboardingReviewBody.
  ///
  /// In en, this message translates to:
  /// **'People use Glu to feel more supported, more consistent, and less alone in the process.'**
  String get onboardingReviewBody;

  /// No description provided for @onboardingTypeYourMedication.
  ///
  /// In en, this message translates to:
  /// **'Type your medication'**
  String get onboardingTypeYourMedication;

  /// No description provided for @onboardingSelectStartDate.
  ///
  /// In en, this message translates to:
  /// **'Select start date'**
  String get onboardingSelectStartDate;

  /// No description provided for @goalsSaveDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Save goals?'**
  String get goalsSaveDialogTitle;

  /// No description provided for @goalsSaveDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved goal changes. Save them before leaving this tab?'**
  String get goalsSaveDialogMessage;

  /// No description provided for @commonLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get commonLater;

  /// No description provided for @homeGreetingAnonymous.
  ///
  /// In en, this message translates to:
  /// **'Hi'**
  String get homeGreetingAnonymous;

  /// No description provided for @homeGreetingWithName.
  ///
  /// In en, this message translates to:
  /// **'Hi, {name}'**
  String homeGreetingWithName(Object name);

  /// No description provided for @homeInsightEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Track today to see insight'**
  String get homeInsightEmptyTitle;

  /// No description provided for @homeInsightEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Log something today, and you’ll see your insight tonight.'**
  String get homeInsightEmptyBody;

  /// No description provided for @homeInsightLogTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn logs into insight'**
  String get homeInsightLogTodayTitle;

  /// No description provided for @homeInsightMoreLogsVariant1Title.
  ///
  /// In en, this message translates to:
  /// **'More logs, better insight'**
  String get homeInsightMoreLogsVariant1Title;

  /// No description provided for @homeInsightMoreLogsVariant1Body.
  ///
  /// In en, this message translates to:
  /// **'Your logs are starting to show a pattern.'**
  String get homeInsightMoreLogsVariant1Body;

  /// No description provided for @homeInsightMoreLogsVariant2Title.
  ///
  /// In en, this message translates to:
  /// **'Your insight is taking shape'**
  String get homeInsightMoreLogsVariant2Title;

  /// No description provided for @homeInsightMoreLogsVariant2Body.
  ///
  /// In en, this message translates to:
  /// **'A few more logs could make the picture much clearer.'**
  String get homeInsightMoreLogsVariant2Body;

  /// No description provided for @homeInsightMoreLogsVariant3Title.
  ///
  /// In en, this message translates to:
  /// **'Today’s logs hint at'**
  String get homeInsightMoreLogsVariant3Title;

  /// No description provided for @homeInsightMoreLogsVariant3Body.
  ///
  /// In en, this message translates to:
  /// **'There may already be a pattern hiding in your day.'**
  String get homeInsightMoreLogsVariant3Body;

  /// No description provided for @homeInsightLogTodayBodyNoLogs.
  ///
  /// In en, this message translates to:
  /// **'Log at least once today to see a clearer picture of your progress.'**
  String get homeInsightLogTodayBodyNoLogs;

  /// No description provided for @homeInsightExpandedTitle.
  ///
  /// In en, this message translates to:
  /// **'Was this helpful?'**
  String get homeInsightExpandedTitle;

  /// No description provided for @homeInsightExpandedBody.
  ///
  /// In en, this message translates to:
  /// **'A quick rating helps Glu learn what matters most to you.'**
  String get homeInsightExpandedBody;

  /// No description provided for @homeInsightReasonHint.
  ///
  /// In en, this message translates to:
  /// **'What could be better? (optional)'**
  String get homeInsightReasonHint;

  /// No description provided for @homeInsightReasonSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get homeInsightReasonSubmit;

  /// No description provided for @homeInsightLearningMessage.
  ///
  /// In en, this message translates to:
  /// **'I\'ll learn from this.'**
  String get homeInsightLearningMessage;

  /// No description provided for @homeInsightChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking today’s insight...'**
  String get homeInsightChecking;

  /// No description provided for @homeInsightGenerating.
  ///
  /// In en, this message translates to:
  /// **'Loading today’s insight...'**
  String get homeInsightGenerating;

  /// No description provided for @homeInsightTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeInsightTryAgain;

  /// No description provided for @homeSeeAllInsights.
  ///
  /// In en, this message translates to:
  /// **'See all insights'**
  String get homeSeeAllInsights;

  /// No description provided for @insightsProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'All insights'**
  String get insightsProgressTitle;

  /// No description provided for @insightsProgressEmptyState.
  ///
  /// In en, this message translates to:
  /// **'Your insights will appear here once they are generated.'**
  String get insightsProgressEmptyState;

  /// No description provided for @homeDoseReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose reminder'**
  String get homeDoseReminderTitle;

  /// No description provided for @homeTileInteractionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Log {label} interaction goes here.'**
  String homeTileInteractionPlaceholder(Object label);

  /// No description provided for @homeCalorieGoalRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie goal required'**
  String get homeCalorieGoalRequiredTitle;

  /// No description provided for @homeCalorieGoalRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'Portion Check needs a Meal goal set to Calories to estimate your portion. Set one in Goals to get started.'**
  String get homeCalorieGoalRequiredBody;

  /// No description provided for @homeSetGoal.
  ///
  /// In en, this message translates to:
  /// **'Set goal'**
  String get homeSetGoal;

  /// No description provided for @homeYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get homeYourProgress;

  /// No description provided for @homeRemindersShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay on track'**
  String get homeRemindersShowcaseTitle;

  /// No description provided for @homeRemindersShowcaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Set up reminders to keep doses and supplements on time.'**
  String get homeRemindersShowcaseDescription;

  /// No description provided for @homePickNextDoseDate.
  ///
  /// In en, this message translates to:
  /// **'Pick your next dose date'**
  String get homePickNextDoseDate;

  /// No description provided for @homeSetReminder.
  ///
  /// In en, this message translates to:
  /// **'Set reminder'**
  String get homeSetReminder;

  /// No description provided for @homeSupplementReminders.
  ///
  /// In en, this message translates to:
  /// **'Supplement reminders'**
  String get homeSupplementReminders;

  /// No description provided for @homeNoUpcomingSupplements.
  ///
  /// In en, this message translates to:
  /// **'No upcoming supplements'**
  String get homeNoUpcomingSupplements;

  /// No description provided for @homeNoMoreUpcomingSupplements.
  ///
  /// In en, this message translates to:
  /// **'No more upcoming'**
  String get homeNoMoreUpcomingSupplements;

  /// No description provided for @homeSetUpYourSupplements.
  ///
  /// In en, this message translates to:
  /// **'Set up your supplements'**
  String get homeSetUpYourSupplements;

  /// No description provided for @homeSetUp.
  ///
  /// In en, this message translates to:
  /// **'Set up'**
  String get homeSetUp;

  /// No description provided for @homeSupplementFallback.
  ///
  /// In en, this message translates to:
  /// **'Supplement'**
  String get homeSupplementFallback;

  /// No description provided for @doseReminderNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready for your dose?'**
  String get doseReminderNotificationTitle;

  /// No description provided for @doseReminderFallbackBody.
  ///
  /// In en, this message translates to:
  /// **'Open Glu to review your next dose.'**
  String get doseReminderFallbackBody;

  /// No description provided for @supplementReminderNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Time for your supplement'**
  String get supplementReminderNotificationTitle;

  /// No description provided for @supplementReminderBody.
  ///
  /// In en, this message translates to:
  /// **'{name} · {daypart}'**
  String supplementReminderBody(Object name, Object daypart);

  /// No description provided for @supplementReminderThisMorning.
  ///
  /// In en, this message translates to:
  /// **'This morning'**
  String get supplementReminderThisMorning;

  /// No description provided for @supplementReminderThisAfternoon.
  ///
  /// In en, this message translates to:
  /// **'This afternoon'**
  String get supplementReminderThisAfternoon;

  /// No description provided for @supplementReminderTonight.
  ///
  /// In en, this message translates to:
  /// **'Tonight'**
  String get supplementReminderTonight;

  /// No description provided for @dailyReminderMorningTitle.
  ///
  /// In en, this message translates to:
  /// **'Morning check-in'**
  String get dailyReminderMorningTitle;

  /// No description provided for @dailyReminderMorningBodies.
  ///
  /// In en, this message translates to:
  /// **'Morning mission: give Glu a little data to play with.\nKick off the day with a quick log and some good momentum.\nRise and log. Future you will appreciate it.\nStart the day with a tiny update and a big head start.\nGive Glu a morning clue and keep moving.\nA quick log now can make today way more interesting.\nLet’s make the morning count with a fast check-in.'**
  String get dailyReminderMorningBodies;

  /// No description provided for @dailyReminderMiddayTitle.
  ///
  /// In en, this message translates to:
  /// **'Midday check-in'**
  String get dailyReminderMiddayTitle;

  /// No description provided for @dailyReminderMiddayBodies.
  ///
  /// In en, this message translates to:
  /// **'Midday pit stop: drop a quick log and keep cruising.\nLunch break? Perfect time to give Glu an update.\nHalfway there. Toss Glu a quick clue.\nA tiny midday log can keep the story going.\nCheck in now and keep the day rolling.\nGive your day a little nudge with a fast update.\nKeep the energy up with a quick midday tap.'**
  String get dailyReminderMiddayBodies;

  /// No description provided for @dailyReminderAfternoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Afternoon check-in'**
  String get dailyReminderAfternoonTitle;

  /// No description provided for @dailyReminderAfternoonBodies.
  ///
  /// In en, this message translates to:
  /// **'Almost done. Give Glu one more breadcrumb.\nA quick afternoon log can make tonight’s insight pop.\nWrap the day with a small update and a big win.\nOne more log before the day wraps up?\nHelp Glu connect the dots with a quick afternoon check-in.\nClose the loop with a tiny log and keep the magic going.\nA final tap now can make tonight’s insight way better.'**
  String get dailyReminderAfternoonBodies;

  /// No description provided for @homePortionCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Portion Check'**
  String get homePortionCheckTitle;

  /// No description provided for @homePortionCheckBody.
  ///
  /// In en, this message translates to:
  /// **'Know how much to eat at every meal'**
  String get homePortionCheckBody;

  /// No description provided for @homeGlowUpTitle.
  ///
  /// In en, this message translates to:
  /// **'Your\nGlow up'**
  String get homeGlowUpTitle;

  /// No description provided for @homeGlowUpBody.
  ///
  /// In en, this message translates to:
  /// **'Create your before-and-after story'**
  String get homeGlowUpBody;

  /// No description provided for @homeDoctorReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor Report'**
  String get homeDoctorReportTitle;

  /// No description provided for @homeDoctorReportBody.
  ///
  /// In en, this message translates to:
  /// **'Share your progress with your doctor'**
  String get homeDoctorReportBody;

  /// No description provided for @homeGoalsStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Goals today'**
  String get homeGoalsStatusTitle;

  /// No description provided for @homeGoalsStatusViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeGoalsStatusViewAll;

  /// No description provided for @homeWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get homeWaterTitle;

  /// No description provided for @homeWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get homeWeightTitle;

  /// No description provided for @homeExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get homeExerciseTitle;

  /// No description provided for @homeMealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get homeMealsTitle;

  /// No description provided for @homeCaloriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get homeCaloriesTitle;

  /// No description provided for @homeProteinsTitle.
  ///
  /// In en, this message translates to:
  /// **'Proteins'**
  String get homeProteinsTitle;

  /// No description provided for @homeFibersTitle.
  ///
  /// In en, this message translates to:
  /// **'Fibers'**
  String get homeFibersTitle;

  /// No description provided for @homeSymptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get homeSymptomsTitle;

  /// No description provided for @homeMoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get homeMoodTitle;

  /// No description provided for @homeCravingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cravings'**
  String get homeCravingsTitle;

  /// No description provided for @homeDoseTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get homeDoseTitle;

  /// No description provided for @homeMedicationLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated medication level'**
  String get homeMedicationLevelTitle;

  /// No description provided for @homeMedicationLevelInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'How to read this chart'**
  String get homeMedicationLevelInfoTitle;

  /// No description provided for @homeMedicationLevelInfoBody.
  ///
  /// In en, this message translates to:
  /// **'This chart estimates how much of your medication may still be active based on the doses you logged and the medication\'s half-life.\n\nHigher points usually mean a more recent or larger dose. The line slopes down over time as the medication clears from your system.\n\nUse this as a trend view, not as an exact measurement or medical recommendation.'**
  String get homeMedicationLevelInfoBody;

  /// No description provided for @homeMedicationLevelInfoDismiss.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get homeMedicationLevelInfoDismiss;

  /// No description provided for @homeMedicationLevelEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Log your doses so Glu can estimate how much medication is still active in your system.'**
  String get homeMedicationLevelEmptyBody;

  /// No description provided for @homeMedicationLevelOfRecentPeak.
  ///
  /// In en, this message translates to:
  /// **'of recent peak'**
  String get homeMedicationLevelOfRecentPeak;

  /// No description provided for @homeMedicationLevelActiveNow.
  ///
  /// In en, this message translates to:
  /// **'Active now'**
  String get homeMedicationLevelActiveNow;

  /// No description provided for @homeMedicationLevelHalfLife.
  ///
  /// In en, this message translates to:
  /// **'Half-life'**
  String get homeMedicationLevelHalfLife;

  /// No description provided for @homeMedicationLevelLastDose.
  ///
  /// In en, this message translates to:
  /// **'Last dose'**
  String get homeMedicationLevelLastDose;

  /// No description provided for @homeStartHydration.
  ///
  /// In en, this message translates to:
  /// **'Start hydration'**
  String get homeStartHydration;

  /// No description provided for @homeLogFirstSession.
  ///
  /// In en, this message translates to:
  /// **'Log your first session'**
  String get homeLogFirstSession;

  /// No description provided for @homeLogTodayWeight.
  ///
  /// In en, this message translates to:
  /// **'Log today’s weight'**
  String get homeLogTodayWeight;

  /// No description provided for @homeAtYourTarget.
  ///
  /// In en, this message translates to:
  /// **'You are at your target'**
  String get homeAtYourTarget;

  /// No description provided for @homeLogMealsToTrackCalories.
  ///
  /// In en, this message translates to:
  /// **'Log meals to track calories'**
  String get homeLogMealsToTrackCalories;

  /// No description provided for @homeLogFirstMeal.
  ///
  /// In en, this message translates to:
  /// **'Log your first meal'**
  String get homeLogFirstMeal;

  /// No description provided for @homeTrackProteinFromMeals.
  ///
  /// In en, this message translates to:
  /// **'Track protein from meals'**
  String get homeTrackProteinFromMeals;

  /// No description provided for @homeTrackFiberFromMeals.
  ///
  /// In en, this message translates to:
  /// **'Track fiber from meals'**
  String get homeTrackFiberFromMeals;

  /// No description provided for @homeAllClear.
  ///
  /// In en, this message translates to:
  /// **'All clear'**
  String get homeAllClear;

  /// No description provided for @homeTrackSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Track symptoms'**
  String get homeTrackSymptoms;

  /// No description provided for @homeGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get homeGreat;

  /// No description provided for @homeGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get homeGood;

  /// No description provided for @homeBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get homeBad;

  /// No description provided for @homeOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get homeOkay;

  /// No description provided for @homeLogHowYouFeel.
  ///
  /// In en, this message translates to:
  /// **'Log how you feel'**
  String get homeLogHowYouFeel;

  /// No description provided for @homeLogACraving.
  ///
  /// In en, this message translates to:
  /// **'Log a craving'**
  String get homeLogACraving;

  /// No description provided for @homeLogTodaysDose.
  ///
  /// In en, this message translates to:
  /// **'Log today’s dose'**
  String get homeLogTodaysDose;

  /// No description provided for @homeTaken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get homeTaken;

  /// No description provided for @homeStartHereTitle.
  ///
  /// In en, this message translates to:
  /// **'Start here'**
  String get homeStartHereTitle;

  /// No description provided for @homeStartHereBody.
  ///
  /// In en, this message translates to:
  /// **'Begin with this card, then expand to others. As Glu learns more about your journey, it can show you better patterns and insights over time.'**
  String get homeStartHereBody;

  /// No description provided for @waterLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Hydration'**
  String get waterLogTitle;

  /// No description provided for @waterLogEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit hydration'**
  String get waterLogEditTitle;

  /// No description provided for @waterLogLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log water'**
  String get waterLogLogTitle;

  /// No description provided for @waterLogAddDrink.
  ///
  /// In en, this message translates to:
  /// **'+ Add drink ({amount})'**
  String waterLogAddDrink(Object amount);

  /// No description provided for @waterLogSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get waterLogSaving;

  /// No description provided for @waterLogCustomDrinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom drink'**
  String get waterLogCustomDrinkTitle;

  /// No description provided for @waterLogCustomDrinkBody.
  ///
  /// In en, this message translates to:
  /// **'Choose the amount you want to add right now.'**
  String get waterLogCustomDrinkBody;

  /// No description provided for @waterLogUseThisAmount.
  ///
  /// In en, this message translates to:
  /// **'Use this amount'**
  String get waterLogUseThisAmount;

  /// No description provided for @waterLogAddedToHydrationLog.
  ///
  /// In en, this message translates to:
  /// **'{amount} added to your hydration log'**
  String waterLogAddedToHydrationLog(Object amount);

  /// No description provided for @waterLogCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this water log yet.'**
  String get waterLogCouldNotSave;

  /// No description provided for @waterLogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this hydration log?'**
  String get waterLogDeleteTitle;

  /// No description provided for @waterLogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get waterLogDeleteMessage;

  /// No description provided for @waterLogCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this hydration log yet.'**
  String get waterLogCouldNotDelete;

  /// No description provided for @waterLogDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get waterLogDeleteLog;

  /// No description provided for @waterLogDeleted.
  ///
  /// In en, this message translates to:
  /// **'Hydration deleted'**
  String get waterLogDeleted;

  /// No description provided for @moodLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get moodLogTitle;

  /// No description provided for @moodEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit mood'**
  String get moodEditTitle;

  /// No description provided for @moodHowYouFeel.
  ///
  /// In en, this message translates to:
  /// **'How you feel'**
  String get moodHowYouFeel;

  /// No description provided for @moodBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get moodBad;

  /// No description provided for @moodOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get moodOkay;

  /// No description provided for @moodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get moodGood;

  /// No description provided for @moodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get moodGreat;

  /// No description provided for @moodNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get moodNotes;

  /// No description provided for @moodAnythingWorthRemembering.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about your mood?'**
  String get moodAnythingWorthRemembering;

  /// No description provided for @moodCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this mood log yet.'**
  String get moodCouldNotSave;

  /// No description provided for @moodDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this mood log?'**
  String get moodDeleteTitle;

  /// No description provided for @moodDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get moodDeleteMessage;

  /// No description provided for @moodDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get moodDeleteLog;

  /// No description provided for @moodSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get moodSaving;

  /// No description provided for @moodAddMoodLog.
  ///
  /// In en, this message translates to:
  /// **'+ Add mood log'**
  String get moodAddMoodLog;

  /// No description provided for @moodLogged.
  ///
  /// In en, this message translates to:
  /// **'Mood logged'**
  String get moodLogged;

  /// No description provided for @moodDeleted.
  ///
  /// In en, this message translates to:
  /// **'Mood deleted'**
  String get moodDeleted;

  /// No description provided for @moodCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this mood log yet.'**
  String get moodCouldNotDelete;

  /// No description provided for @moodAddedToMoodLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your mood log'**
  String get moodAddedToMoodLog;

  /// No description provided for @cravingsLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Cravings'**
  String get cravingsLogTitle;

  /// No description provided for @cravingsEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit craving'**
  String get cravingsEditTitle;

  /// No description provided for @cravingsWhatsGoingOn.
  ///
  /// In en, this message translates to:
  /// **'What\'s going on'**
  String get cravingsWhatsGoingOn;

  /// No description provided for @cravingsTypeGeneral.
  ///
  /// In en, this message translates to:
  /// **'Urge to eat'**
  String get cravingsTypeGeneral;

  /// No description provided for @cravingsTypeSweet.
  ///
  /// In en, this message translates to:
  /// **'Something sweet'**
  String get cravingsTypeSweet;

  /// No description provided for @cravingsTypeSalty.
  ///
  /// In en, this message translates to:
  /// **'Something salty'**
  String get cravingsTypeSalty;

  /// No description provided for @cravingsIntensityLabel.
  ///
  /// In en, this message translates to:
  /// **'Intensity (optional)'**
  String get cravingsIntensityLabel;

  /// No description provided for @cravingsIntensityMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get cravingsIntensityMild;

  /// No description provided for @cravingsIntensityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get cravingsIntensityModerate;

  /// No description provided for @cravingsIntensityStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get cravingsIntensityStrong;

  /// No description provided for @cravingsOutcomeLabel.
  ///
  /// In en, this message translates to:
  /// **'What happened (optional)'**
  String get cravingsOutcomeLabel;

  /// No description provided for @cravingsOutcomeResisted.
  ///
  /// In en, this message translates to:
  /// **'Resisted'**
  String get cravingsOutcomeResisted;

  /// No description provided for @cravingsOutcomeGaveIn.
  ///
  /// In en, this message translates to:
  /// **'Gave in'**
  String get cravingsOutcomeGaveIn;

  /// No description provided for @cravingsNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get cravingsNotes;

  /// No description provided for @cravingsAnythingWorthRemembering.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about this craving?'**
  String get cravingsAnythingWorthRemembering;

  /// No description provided for @cravingsCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this craving log yet.'**
  String get cravingsCouldNotSave;

  /// No description provided for @cravingsDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this craving log?'**
  String get cravingsDeleteTitle;

  /// No description provided for @cravingsDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get cravingsDeleteMessage;

  /// No description provided for @cravingsDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get cravingsDeleteLog;

  /// No description provided for @cravingsSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get cravingsSaving;

  /// No description provided for @cravingsAddLog.
  ///
  /// In en, this message translates to:
  /// **'+ Add craving log'**
  String get cravingsAddLog;

  /// No description provided for @cravingsLogged.
  ///
  /// In en, this message translates to:
  /// **'Craving logged'**
  String get cravingsLogged;

  /// No description provided for @cravingsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Craving deleted'**
  String get cravingsDeleted;

  /// No description provided for @cravingsCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this craving log yet.'**
  String get cravingsCouldNotDelete;

  /// No description provided for @cravingsAddedToLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your cravings log'**
  String get cravingsAddedToLog;

  /// No description provided for @portionCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Portion Check'**
  String get portionCheckTitle;

  /// No description provided for @portionCheckAnalyzingMeal.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your meal…'**
  String get portionCheckAnalyzingMeal;

  /// No description provided for @portionCheckCouldNotAnalyzePhoto.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t analyze this photo'**
  String get portionCheckCouldNotAnalyzePhoto;

  /// No description provided for @portionCheckTakeNewPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a new photo'**
  String get portionCheckTakeNewPhoto;

  /// No description provided for @portionCheckSomethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get portionCheckSomethingWentWrong;

  /// No description provided for @portionCheckYouHitDailyLimit.
  ///
  /// In en, this message translates to:
  /// **'You\'ve hit your daily limit'**
  String get portionCheckYouHitDailyLimit;

  /// No description provided for @portionCheckYouCanEat.
  ///
  /// In en, this message translates to:
  /// **'You can eat'**
  String get portionCheckYouCanEat;

  /// No description provided for @portionCheckYouCanEatUpTo.
  ///
  /// In en, this message translates to:
  /// **'You can eat up to'**
  String get portionCheckYouCanEatUpTo;

  /// No description provided for @portionCheckTryLighterOption.
  ///
  /// In en, this message translates to:
  /// **'Try a lighter option instead or skip this one'**
  String get portionCheckTryLighterOption;

  /// No description provided for @portionCheckThisEntireMeal.
  ///
  /// In en, this message translates to:
  /// **'this entire meal'**
  String get portionCheckThisEntireMeal;

  /// No description provided for @portionCheckPctOfThisMeal.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of this meal'**
  String portionCheckPctOfThisMeal(Object percent);

  /// No description provided for @portionCheckToStayWithinGoals.
  ///
  /// In en, this message translates to:
  /// **'to stay within your daily goals.'**
  String get portionCheckToStayWithinGoals;

  /// No description provided for @portionCheckNutritionBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Nutrition breakdown'**
  String get portionCheckNutritionBreakdown;

  /// No description provided for @portionCheckTipsToBalanceMeal.
  ///
  /// In en, this message translates to:
  /// **'Tips to balance your meal'**
  String get portionCheckTipsToBalanceMeal;

  /// No description provided for @portionCheckTipsPool.
  ///
  /// In en, this message translates to:
  /// **'Eat slowly — it takes about 20 minutes for fullness signals to catch up.\nFill half your plate with vegetables.\nInclude protein at every meal.\nDrink water before meals.\nPre-portion snacks into small containers.\nPair carbs with protein or fat to stay full longer.\nChoose whole foods when possible.\nAvoid eating while distracted by screens.\nDon\'t skip meals if it makes you overeat later.\nPlan your snacks before you get hungry.'**
  String get portionCheckTipsPool;

  /// No description provided for @portionCheckRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get portionCheckRetake;

  /// No description provided for @portionCheckLogThisPortion.
  ///
  /// In en, this message translates to:
  /// **'Log this portion'**
  String get portionCheckLogThisPortion;

  /// No description provided for @portionCheckCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get portionCheckCarbs;

  /// No description provided for @portionCheckProteins.
  ///
  /// In en, this message translates to:
  /// **'Proteins'**
  String get portionCheckProteins;

  /// No description provided for @portionCheckFats.
  ///
  /// In en, this message translates to:
  /// **'Fats'**
  String get portionCheckFats;

  /// No description provided for @portionCheckFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get portionCheckFiber;

  /// No description provided for @mealLogScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get mealLogScreenTitle;

  /// No description provided for @mealLogEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit meal'**
  String get mealLogEditTitle;

  /// No description provided for @mealLogLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log meal'**
  String get mealLogLogTitle;

  /// No description provided for @mealLogSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get mealLogSaving;

  /// No description provided for @mealLogAddMealLog.
  ///
  /// In en, this message translates to:
  /// **'+ Add meal log'**
  String get mealLogAddMealLog;

  /// No description provided for @mealLogCouldNotStartRecording.
  ///
  /// In en, this message translates to:
  /// **'Could not start recording.'**
  String get mealLogCouldNotStartRecording;

  /// No description provided for @mealLogRecordingStoppedAtLimit.
  ///
  /// In en, this message translates to:
  /// **'Recording stopped at 60 seconds.'**
  String get mealLogRecordingStoppedAtLimit;

  /// No description provided for @mealLogCouldNotAnalyzeRecording.
  ///
  /// In en, this message translates to:
  /// **'Could not analyze this recording.'**
  String get mealLogCouldNotAnalyzeRecording;

  /// No description provided for @mealLogCouldNotAnalyzeText.
  ///
  /// In en, this message translates to:
  /// **'Could not analyze this text.'**
  String get mealLogCouldNotAnalyzeText;

  /// No description provided for @mealLogCouldNotAnalyzePhoto.
  ///
  /// In en, this message translates to:
  /// **'Could not analyze this photo.'**
  String get mealLogCouldNotAnalyzePhoto;

  /// No description provided for @mealLogCouldNotProcessMealPhoto.
  ///
  /// In en, this message translates to:
  /// **'Could not process this meal photo yet.'**
  String get mealLogCouldNotProcessMealPhoto;

  /// No description provided for @mealLogDiscardTitle.
  ///
  /// In en, this message translates to:
  /// **'Discard this meal?'**
  String get mealLogDiscardTitle;

  /// No description provided for @mealLogDiscardMessage.
  ///
  /// In en, this message translates to:
  /// **'You reviewed a photo but didn\'t save the entry. It won\'t be logged.'**
  String get mealLogDiscardMessage;

  /// No description provided for @mealLogDiscard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get mealLogDiscard;

  /// No description provided for @mealLogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this meal log?'**
  String get mealLogDeleteTitle;

  /// No description provided for @mealLogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get mealLogDeleteMessage;

  /// No description provided for @mealLogDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get mealLogDelete;

  /// No description provided for @mealLogDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get mealLogDeleteLog;

  /// No description provided for @mealLogCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this meal log yet.'**
  String get mealLogCouldNotSave;

  /// No description provided for @mealLogCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this meal log yet.'**
  String get mealLogCouldNotDelete;

  /// No description provided for @mealLogAnalyzing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing...'**
  String get mealLogAnalyzing;

  /// No description provided for @mealLogAnalyzeText.
  ///
  /// In en, this message translates to:
  /// **'Analyze text'**
  String get mealLogAnalyzeText;

  /// No description provided for @mealLogSendRecording.
  ///
  /// In en, this message translates to:
  /// **'Send recording'**
  String get mealLogSendRecording;

  /// No description provided for @mealLogMealDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get mealLogMealDefaultName;

  /// No description provided for @mealLogMealNameHint.
  ///
  /// In en, this message translates to:
  /// **'Meal name'**
  String get mealLogMealNameHint;

  /// No description provided for @mealLogCouldNotPrefillTitle.
  ///
  /// In en, this message translates to:
  /// **'Couldn’t prefill this meal'**
  String get mealLogCouldNotPrefillTitle;

  /// No description provided for @mealLogHowMuchDidYouEat.
  ///
  /// In en, this message translates to:
  /// **'How much did you eat?'**
  String get mealLogHowMuchDidYouEat;

  /// No description provided for @mealLogNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get mealLogNotes;

  /// No description provided for @mealLogAnythingWorthRemembering.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about this meal?'**
  String get mealLogAnythingWorthRemembering;

  /// No description provided for @mealLogAnalyzingYourMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyzing your meal'**
  String get mealLogAnalyzingYourMealTitle;

  /// No description provided for @mealLogAnalyzingYourMealBody.
  ///
  /// In en, this message translates to:
  /// **'Turning your input into nutrition fields. You can review everything before saving.'**
  String get mealLogAnalyzingYourMealBody;

  /// No description provided for @mealLogDescribeYourMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Describe your meal'**
  String get mealLogDescribeYourMealTitle;

  /// No description provided for @mealLogDescribeYourMealBody.
  ///
  /// In en, this message translates to:
  /// **'Write what you ate and any amounts you know. We’ll turn it into nutrition fields.'**
  String get mealLogDescribeYourMealBody;

  /// No description provided for @mealLogDescribeYourMealHint.
  ///
  /// In en, this message translates to:
  /// **'Example: grilled chicken salad, olive oil dressing, 1 apple, sparkling water'**
  String get mealLogDescribeYourMealHint;

  /// No description provided for @mealLogCaptureYourMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Capture your meal'**
  String get mealLogCaptureYourMealTitle;

  /// No description provided for @mealLogCaptureYourMealBody.
  ///
  /// In en, this message translates to:
  /// **'Take a photo and we’ll estimate the nutrition fields for you.'**
  String get mealLogCaptureYourMealBody;

  /// No description provided for @mealLogTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get mealLogTakePhoto;

  /// No description provided for @mealLogRecordingYourMealTitle.
  ///
  /// In en, this message translates to:
  /// **'Recording your meal'**
  String get mealLogRecordingYourMealTitle;

  /// No description provided for @mealLogRecordingReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Recording ready'**
  String get mealLogRecordingReadyTitle;

  /// No description provided for @mealLogRecordMealDescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Record a meal description'**
  String get mealLogRecordMealDescriptionTitle;

  /// No description provided for @mealLogRecordingTapStopBody.
  ///
  /// In en, this message translates to:
  /// **'Tap stop when you’re done. {remaining}s left'**
  String mealLogRecordingTapStopBody(Object remaining);

  /// No description provided for @mealLogRecordingReadyBody.
  ///
  /// In en, this message translates to:
  /// **'Send it below to analyze, or record again.'**
  String get mealLogRecordingReadyBody;

  /// No description provided for @mealLogRecordMealDescriptionBody.
  ///
  /// In en, this message translates to:
  /// **'Speak naturally about what you ate and we’ll parse it into macros.'**
  String get mealLogRecordMealDescriptionBody;

  /// No description provided for @mealLogStopRecording.
  ///
  /// In en, this message translates to:
  /// **'Stop recording'**
  String get mealLogStopRecording;

  /// No description provided for @mealLogRecordAgain.
  ///
  /// In en, this message translates to:
  /// **'Record again'**
  String get mealLogRecordAgain;

  /// No description provided for @mealLogStartRecording.
  ///
  /// In en, this message translates to:
  /// **'Start recording'**
  String get mealLogStartRecording;

  /// No description provided for @mealLogBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get mealLogBreakfast;

  /// No description provided for @mealLogLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get mealLogLunch;

  /// No description provided for @mealLogSnack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get mealLogSnack;

  /// No description provided for @mealLogDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get mealLogDinner;

  /// No description provided for @mealLogKcalUnit.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get mealLogKcalUnit;

  /// No description provided for @mealLogToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get mealLogToday;

  /// No description provided for @mealLogYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get mealLogYesterday;

  /// No description provided for @mealLogKcal.
  ///
  /// In en, this message translates to:
  /// **'{count} kcal'**
  String mealLogKcal(Object count);

  /// No description provided for @mealLogKcalLogged.
  ///
  /// In en, this message translates to:
  /// **'{count} kcal logged'**
  String mealLogKcalLogged(Object count);

  /// No description provided for @mealLogMacroLogged.
  ///
  /// In en, this message translates to:
  /// **'{amount} g {macro} logged'**
  String mealLogMacroLogged(Object amount, Object macro);

  /// No description provided for @mealLogDeleted.
  ///
  /// In en, this message translates to:
  /// **'Meal deleted'**
  String get mealLogDeleted;

  /// No description provided for @mealLogAddedToMealLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your meal log'**
  String get mealLogAddedToMealLog;

  /// No description provided for @mealLogCarbs.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get mealLogCarbs;

  /// No description provided for @mealLogProteins.
  ///
  /// In en, this message translates to:
  /// **'Proteins'**
  String get mealLogProteins;

  /// No description provided for @mealLogFats.
  ///
  /// In en, this message translates to:
  /// **'Fats'**
  String get mealLogFats;

  /// No description provided for @mealLogFiber.
  ///
  /// In en, this message translates to:
  /// **'Fiber'**
  String get mealLogFiber;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select language'**
  String get settingsLanguageDialogTitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get settingsPreferences;

  /// No description provided for @settingsHealthGoal.
  ///
  /// In en, this message translates to:
  /// **'Health goal'**
  String get settingsHealthGoal;

  /// No description provided for @settingsHealthGoalDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select health goal'**
  String get settingsHealthGoalDialogTitle;

  /// No description provided for @settingsHabitGoals.
  ///
  /// In en, this message translates to:
  /// **'Habit goals'**
  String get settingsHabitGoals;

  /// No description provided for @settingsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Disabled'**
  String get settingsDisabled;

  /// No description provided for @settingsGoalsActiveCount.
  ///
  /// In en, this message translates to:
  /// **'{count} active'**
  String settingsGoalsActiveCount(Object count);

  /// No description provided for @settingsHeight.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get settingsHeight;

  /// No description provided for @settingsAge.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get settingsAge;

  /// No description provided for @settingsGender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get settingsGender;

  /// No description provided for @settingsMeasurementUnit.
  ///
  /// In en, this message translates to:
  /// **'Measurement unit'**
  String get settingsMeasurementUnit;

  /// No description provided for @settingsReminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get settingsReminders;

  /// No description provided for @settingsDoseReminder.
  ///
  /// In en, this message translates to:
  /// **'Dose reminder'**
  String get settingsDoseReminder;

  /// No description provided for @settingsSupplementReminder.
  ///
  /// In en, this message translates to:
  /// **'Supplement reminder'**
  String get settingsSupplementReminder;

  /// No description provided for @settingsDailyReminders.
  ///
  /// In en, this message translates to:
  /// **'Daily reminders'**
  String get settingsDailyReminders;

  /// No description provided for @settingsSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get settingsSubscription;

  /// No description provided for @settingsSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsSupport;

  /// No description provided for @settingsSendFeedback.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get settingsSendFeedback;

  /// No description provided for @feedbackSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Send Feedback'**
  String get feedbackSheetTitle;

  /// No description provided for @feedbackSheetHint.
  ///
  /// In en, this message translates to:
  /// **'Tell us what you think…'**
  String get feedbackSheetHint;

  /// No description provided for @feedbackSheetSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get feedbackSheetSend;

  /// No description provided for @feedbackSheetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Thanks for your feedback!'**
  String get feedbackSheetSuccess;

  /// No description provided for @feedbackSheetError.
  ///
  /// In en, this message translates to:
  /// **'Failed to send. Please try again.'**
  String get feedbackSheetError;

  /// No description provided for @settingsTermsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get settingsTermsOfService;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal'**
  String get settingsInternal;

  /// No description provided for @settingsSubscriptionOverride.
  ///
  /// In en, this message translates to:
  /// **'Subscription override'**
  String get settingsSubscriptionOverride;

  /// No description provided for @settingsTodayInsightCard.
  ///
  /// In en, this message translates to:
  /// **'Today insight card'**
  String get settingsTodayInsightCard;

  /// No description provided for @settingsResetOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Reset onboarding'**
  String get settingsResetOnboarding;

  /// No description provided for @settingsResetShowcases.
  ///
  /// In en, this message translates to:
  /// **'Reset showcases'**
  String get settingsResetShowcases;

  /// No description provided for @settingsResetUserData.
  ///
  /// In en, this message translates to:
  /// **'Reset user data'**
  String get settingsResetUserData;

  /// No description provided for @settingsDeletingAccount.
  ///
  /// In en, this message translates to:
  /// **'Deleting account...'**
  String get settingsDeletingAccount;

  /// No description provided for @settingsDisconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get settingsDisconnect;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDisconnectProviderShort.
  ///
  /// In en, this message translates to:
  /// **'Disconnect {provider}'**
  String settingsDisconnectProviderShort(Object provider);

  /// No description provided for @settingsDisconnectProviderTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect {provider}?'**
  String settingsDisconnectProviderTitle(Object provider);

  /// No description provided for @settingsDisconnectProviderBody.
  ///
  /// In en, this message translates to:
  /// **'You will no longer be able to sign in with {provider} on this device unless you reconnect it later.'**
  String settingsDisconnectProviderBody(Object provider);

  /// No description provided for @settingsDeleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get settingsDeleteAccountTitle;

  /// No description provided for @settingsDeleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'This will permanently remove your account and all of your data. This action cannot be undone.'**
  String get settingsDeleteAccountBody;

  /// No description provided for @settingsDeleteAccountConfirmHint.
  ///
  /// In en, this message translates to:
  /// **'Type DELETE to confirm'**
  String get settingsDeleteAccountConfirmHint;

  /// No description provided for @settingsDeleteAccountError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong while deleting your account. Please contact support@layline.ventures.'**
  String get settingsDeleteAccountError;

  /// No description provided for @settingsRestartAppToSeeOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Restart app to see onboarding'**
  String get settingsRestartAppToSeeOnboarding;

  /// No description provided for @settingsShowcasesReset.
  ///
  /// In en, this message translates to:
  /// **'Showcases reset'**
  String get settingsShowcasesReset;

  /// No description provided for @settingsResetUserDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset user data?'**
  String get settingsResetUserDataTitle;

  /// No description provided for @settingsResetUserDataBody.
  ///
  /// In en, this message translates to:
  /// **'This will clear all logged records for meals, water, exercise, weight, mood, symptoms, supplements, and doses.'**
  String get settingsResetUserDataBody;

  /// No description provided for @settingsUserDataReset.
  ///
  /// In en, this message translates to:
  /// **'User data reset'**
  String get settingsUserDataReset;

  /// No description provided for @settingsDailyRemindersCouldNotBeScheduledRightNow.
  ///
  /// In en, this message translates to:
  /// **'Saved, but daily reminders could not be scheduled right now.'**
  String get settingsDailyRemindersCouldNotBeScheduledRightNow;

  /// No description provided for @settingsSubscriptionOverrideTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription override'**
  String get settingsSubscriptionOverrideTitle;

  /// No description provided for @settingsSubscriptionOverrideAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settingsSubscriptionOverrideAuto;

  /// No description provided for @settingsSubscriptionOverrideForceFree.
  ///
  /// In en, this message translates to:
  /// **'Force Free'**
  String get settingsSubscriptionOverrideForceFree;

  /// No description provided for @settingsSubscriptionOverrideForcePro.
  ///
  /// In en, this message translates to:
  /// **'Force Pro'**
  String get settingsSubscriptionOverrideForcePro;

  /// No description provided for @settingsTodayInsightCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Today insight card'**
  String get settingsTodayInsightCardTitle;

  /// No description provided for @settingsTodayInsightCardAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settingsTodayInsightCardAuto;

  /// No description provided for @settingsTodayInsightCardOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsTodayInsightCardOn;

  /// No description provided for @settingsTodayInsightCardOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsTodayInsightCardOff;

  /// No description provided for @settingsYourName.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get settingsYourName;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsSignOut;

  /// No description provided for @settingsHeightCm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get settingsHeightCm;

  /// No description provided for @settingsHeightFtIn.
  ///
  /// In en, this message translates to:
  /// **'ft/in'**
  String get settingsHeightFtIn;

  /// No description provided for @settingsHeightFt.
  ///
  /// In en, this message translates to:
  /// **'ft'**
  String get settingsHeightFt;

  /// No description provided for @settingsHeightIn.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get settingsHeightIn;

  /// No description provided for @settingsGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get settingsGenderMale;

  /// No description provided for @settingsGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get settingsGenderFemale;

  /// No description provided for @settingsGenderPreferNotToSay.
  ///
  /// In en, this message translates to:
  /// **'Prefer not to say'**
  String get settingsGenderPreferNotToSay;

  /// No description provided for @settingsGenderOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get settingsGenderOther;

  /// No description provided for @settingsYourProfile.
  ///
  /// In en, this message translates to:
  /// **'Your profile'**
  String get settingsYourProfile;

  /// No description provided for @settingsNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settingsNotSet;

  /// No description provided for @settingsYears.
  ///
  /// In en, this message translates to:
  /// **'{value} years'**
  String settingsYears(Object value);

  /// No description provided for @settingsOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsOff;

  /// No description provided for @settingsOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsOn;

  /// No description provided for @settingsNoneSet.
  ///
  /// In en, this message translates to:
  /// **'None set'**
  String get settingsNoneSet;

  /// No description provided for @settingsSupplementCount.
  ///
  /// In en, this message translates to:
  /// **'{count} supplement(s)'**
  String settingsSupplementCount(Object count);

  /// No description provided for @commonToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get commonToday;

  /// No description provided for @mainShellHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get mainShellHome;

  /// No description provided for @mainShellLog.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get mainShellLog;

  /// No description provided for @mainShellProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get mainShellProgress;

  /// No description provided for @mainShellSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get mainShellSettings;

  /// No description provided for @mainShellLogShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Track what matters daily'**
  String get mainShellLogShowcaseTitle;

  /// No description provided for @mainShellLogShowcaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Log the activities that matter most to you, every day.'**
  String get mainShellLogShowcaseDescription;

  /// No description provided for @logMoodShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Start with your mood'**
  String get logMoodShowcaseTitle;

  /// No description provided for @logMoodShowcaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Log your mood now, and keep logging the rest as you go so Glu can spot habits and patterns more accurately.'**
  String get logMoodShowcaseDescription;

  /// No description provided for @mainShellProgressShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'See your progress'**
  String get mainShellProgressShowcaseTitle;

  /// No description provided for @mainShellProgressShowcaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Check your patterns and trends to understand how your habits and weight are changing over time.'**
  String get mainShellProgressShowcaseDescription;

  /// No description provided for @progressMenuShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore your data'**
  String get progressMenuShowcaseTitle;

  /// No description provided for @progressMenuShowcaseDescription.
  ///
  /// In en, this message translates to:
  /// **'View all charts, read AI-generated insights, or create a doctor report to share with your care team.'**
  String get progressMenuShowcaseDescription;

  /// No description provided for @settingsFeedbackShowcaseTitle.
  ///
  /// In en, this message translates to:
  /// **'We\'d love your feedback'**
  String get settingsFeedbackShowcaseTitle;

  /// No description provided for @settingsFeedbackShowcaseDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap here to share what\'s working, what\'s not, or any ideas you have.'**
  String get settingsFeedbackShowcaseDescription;

  /// No description provided for @authCouldNotOpenLink.
  ///
  /// In en, this message translates to:
  /// **'Could not open link right now.'**
  String get authCouldNotOpenLink;

  /// No description provided for @authWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Glu'**
  String get authWelcomeTitle;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Secure sign-in for your wellness companion'**
  String get authSubtitle;

  /// No description provided for @authContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authContinueWithGoogle;

  /// No description provided for @authContinueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authContinueWithApple;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'name@email.com'**
  String get authEmailHint;

  /// No description provided for @authSending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get authSending;

  /// No description provided for @authResendLink.
  ///
  /// In en, this message translates to:
  /// **'Resend link'**
  String get authResendLink;

  /// No description provided for @authUseDifferentEmail.
  ///
  /// In en, this message translates to:
  /// **'Use a different email'**
  String get authUseDifferentEmail;

  /// No description provided for @habitGoalsTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit goals'**
  String get habitGoalsTitle;

  /// No description provided for @goalsProteins.
  ///
  /// In en, this message translates to:
  /// **'Proteins'**
  String get goalsProteins;

  /// No description provided for @goalsFibers.
  ///
  /// In en, this message translates to:
  /// **'Fibers'**
  String get goalsFibers;

  /// No description provided for @goalsGramsPerDay.
  ///
  /// In en, this message translates to:
  /// **'{value} g per day'**
  String goalsGramsPerDay(Object value);

  /// No description provided for @goalsWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get goalsWater;

  /// No description provided for @goalsLitersPerDay.
  ///
  /// In en, this message translates to:
  /// **'{value}L per day'**
  String goalsLitersPerDay(Object value);

  /// No description provided for @goalsExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get goalsExercise;

  /// No description provided for @goalsMinutesPerDay.
  ///
  /// In en, this message translates to:
  /// **'{value} min per day'**
  String goalsMinutesPerDay(Object value);

  /// No description provided for @goalsMeals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get goalsMeals;

  /// No description provided for @goalsCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get goalsCalories;

  /// No description provided for @goalsKcalUnit.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get goalsKcalUnit;

  /// No description provided for @goalsPerWeekSuffix.
  ///
  /// In en, this message translates to:
  /// **'per week'**
  String get goalsPerWeekSuffix;

  /// No description provided for @goalsMealsPerDay.
  ///
  /// In en, this message translates to:
  /// **'{count} meals per day'**
  String goalsMealsPerDay(Object count);

  /// No description provided for @goalsCaloriesPerDay.
  ///
  /// In en, this message translates to:
  /// **'{count} kcal per day'**
  String goalsCaloriesPerDay(Object count);

  /// No description provided for @goalsWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get goalsWeight;

  /// No description provided for @goalsAddLoggedWeightToCalculatePace.
  ///
  /// In en, this message translates to:
  /// **'Add a logged weight to calculate pace'**
  String get goalsAddLoggedWeightToCalculatePace;

  /// No description provided for @goalsAlreadyAtThisTarget.
  ///
  /// In en, this message translates to:
  /// **'You are already at this target'**
  String get goalsAlreadyAtThisTarget;

  /// No description provided for @goalsWeightPerWeekToTarget.
  ///
  /// In en, this message translates to:
  /// **'{value} {unit}/week to target'**
  String goalsWeightPerWeekToTarget(Object value, Object unit);

  /// No description provided for @goalsSetTargetForNextWeek.
  ///
  /// In en, this message translates to:
  /// **'Set the target for next week.'**
  String get goalsSetTargetForNextWeek;

  /// No description provided for @progressWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get progressWeightTitle;

  /// No description provided for @progressWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight '**
  String get progressWeightLabel;

  /// No description provided for @progressWeightUnit.
  ///
  /// In en, this message translates to:
  /// **'{unit}'**
  String progressWeightUnit(Object unit);

  /// No description provided for @progressHealthyBmi.
  ///
  /// In en, this message translates to:
  /// **'Healthy BMI'**
  String get progressHealthyBmi;

  /// No description provided for @progressTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get progressTotal;

  /// No description provided for @progressPercent.
  ///
  /// In en, this message translates to:
  /// **'Percent'**
  String get progressPercent;

  /// No description provided for @progressWeeklyAvg.
  ///
  /// In en, this message translates to:
  /// **'Weekly avg'**
  String get progressWeeklyAvg;

  /// No description provided for @progressRangeAllTime.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get progressRangeAllTime;

  /// No description provided for @progressRange1Month.
  ///
  /// In en, this message translates to:
  /// **'1 month'**
  String get progressRange1Month;

  /// No description provided for @progressRange3Months.
  ///
  /// In en, this message translates to:
  /// **'3 months'**
  String get progressRange3Months;

  /// No description provided for @progressRange6Months.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get progressRange6Months;

  /// No description provided for @progressLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get progressLow;

  /// No description provided for @progressMed.
  ///
  /// In en, this message translates to:
  /// **'Med'**
  String get progressMed;

  /// No description provided for @progressHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get progressHigh;

  /// No description provided for @progressSeverity.
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get progressSeverity;

  /// No description provided for @progressBad.
  ///
  /// In en, this message translates to:
  /// **'Bad'**
  String get progressBad;

  /// No description provided for @progressOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get progressOkay;

  /// No description provided for @progressGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get progressGood;

  /// No description provided for @progressGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get progressGreat;

  /// No description provided for @progressMostlyBad.
  ///
  /// In en, this message translates to:
  /// **'Mostly bad'**
  String get progressMostlyBad;

  /// No description provided for @progressMostlyOkay.
  ///
  /// In en, this message translates to:
  /// **'Mostly okay'**
  String get progressMostlyOkay;

  /// No description provided for @progressMostlyGood.
  ///
  /// In en, this message translates to:
  /// **'Mostly good'**
  String get progressMostlyGood;

  /// No description provided for @progressMostlyGreat.
  ///
  /// In en, this message translates to:
  /// **'Mostly great'**
  String get progressMostlyGreat;

  /// No description provided for @progressNoDose.
  ///
  /// In en, this message translates to:
  /// **'No dose'**
  String get progressNoDose;

  /// No description provided for @progressLogged.
  ///
  /// In en, this message translates to:
  /// **'Logged'**
  String get progressLogged;

  /// No description provided for @progressAllClear.
  ///
  /// In en, this message translates to:
  /// **'All clear'**
  String get progressAllClear;

  /// No description provided for @progressFreq.
  ///
  /// In en, this message translates to:
  /// **'Freq'**
  String get progressFreq;

  /// No description provided for @progressAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get progressAverage;

  /// No description provided for @progressDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get progressDaily;

  /// No description provided for @progressWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get progressWeekly;

  /// No description provided for @progressMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get progressMinutes;

  /// No description provided for @progressIntensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get progressIntensity;

  /// No description provided for @progressCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get progressCalories;

  /// No description provided for @progressByDose.
  ///
  /// In en, this message translates to:
  /// **'By dose'**
  String get progressByDose;

  /// No description provided for @progressWeightProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight progress'**
  String get progressWeightProgressTitle;

  /// No description provided for @progressWaterProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Water progress'**
  String get progressWaterProgressTitle;

  /// No description provided for @progressExerciseProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise progress'**
  String get progressExerciseProgressTitle;

  /// No description provided for @progressDoseProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose progress'**
  String get progressDoseProgressTitle;

  /// No description provided for @progressMealsProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Meals progress'**
  String get progressMealsProgressTitle;

  /// No description provided for @progressSymptomsProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms progress'**
  String get progressSymptomsProgressTitle;

  /// No description provided for @progressMoodProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Mood progress'**
  String get progressMoodProgressTitle;

  /// No description provided for @progressCravingsProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Cravings progress'**
  String get progressCravingsProgressTitle;

  /// No description provided for @progressResisted.
  ///
  /// In en, this message translates to:
  /// **'Resisted'**
  String get progressResisted;

  /// No description provided for @progressCravingsResistedSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share of logged cravings you resisted.'**
  String get progressCravingsResistedSubtitle;

  /// No description provided for @progressWeightChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight change'**
  String get progressWeightChangeTitle;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// No description provided for @progressMenuViewAllInsights.
  ///
  /// In en, this message translates to:
  /// **'View all insights'**
  String get progressMenuViewAllInsights;

  /// No description provided for @progressMenuViewAllCharts.
  ///
  /// In en, this message translates to:
  /// **'View all charts'**
  String get progressMenuViewAllCharts;

  /// No description provided for @progressMenuCreateDoctorReport.
  ///
  /// In en, this message translates to:
  /// **'Create doctor report'**
  String get progressMenuCreateDoctorReport;

  /// No description provided for @progressReportGenerating.
  ///
  /// In en, this message translates to:
  /// **'Generating your report…'**
  String get progressReportGenerating;

  /// No description provided for @progressReportError.
  ///
  /// In en, this message translates to:
  /// **'Could not generate the report. Please try again.'**
  String get progressReportError;

  /// No description provided for @progressReportPendingRetry.
  ///
  /// In en, this message translates to:
  /// **'Your report may still finish in a moment. Please try again.'**
  String get progressReportPendingRetry;

  /// No description provided for @progressReportOpenError.
  ///
  /// In en, this message translates to:
  /// **'Your report was generated, but we could not open it. Please try again.'**
  String get progressReportOpenError;

  /// No description provided for @progressReportOpenedInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Report ready. Opened in your browser.'**
  String get progressReportOpenedInBrowser;

  /// No description provided for @progressReportCopiedLink.
  ///
  /// In en, this message translates to:
  /// **'Report ready. Sharing was unavailable, so the link was copied to your clipboard.'**
  String get progressReportCopiedLink;

  /// No description provided for @progressAllProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'All progress'**
  String get progressAllProgressTitle;

  /// No description provided for @progressWeightTrendExplanation.
  ///
  /// In en, this message translates to:
  /// **'See how your weight is changing over time.'**
  String get progressWeightTrendExplanation;

  /// No description provided for @progressNoWeightLogsYet.
  ///
  /// In en, this message translates to:
  /// **'No weight logs yet'**
  String get progressNoWeightLogsYet;

  /// No description provided for @progressNoLogsYet.
  ///
  /// In en, this message translates to:
  /// **'No logs yet'**
  String get progressNoLogsYet;

  /// No description provided for @progressLogWeightToStartTrend.
  ///
  /// In en, this message translates to:
  /// **'Log weight to start tracking your trend.'**
  String get progressLogWeightToStartTrend;

  /// No description provided for @progressLogWeightAndDoseToCompareChange.
  ///
  /// In en, this message translates to:
  /// **'Log weight and dose to compare how dosage aligns with change.'**
  String get progressLogWeightAndDoseToCompareChange;

  /// No description provided for @progressEachPointColoredByLatestDose.
  ///
  /// In en, this message translates to:
  /// **'Each point is colored by the latest dose used before that weigh-in.'**
  String get progressEachPointColoredByLatestDose;

  /// No description provided for @progressNoHydrationYet.
  ///
  /// In en, this message translates to:
  /// **'No hydration yet'**
  String get progressNoHydrationYet;

  /// No description provided for @progressNoMovementYet.
  ///
  /// In en, this message translates to:
  /// **'No movement yet'**
  String get progressNoMovementYet;

  /// No description provided for @progressNoDoseLogsYet.
  ///
  /// In en, this message translates to:
  /// **'No dose logs yet'**
  String get progressNoDoseLogsYet;

  /// No description provided for @progressNoMealsLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'No meals logged yet'**
  String get progressNoMealsLoggedYet;

  /// No description provided for @progressNoSymptomsLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'No symptoms logged yet'**
  String get progressNoSymptomsLoggedYet;

  /// No description provided for @progressNoMoodLogsYet.
  ///
  /// In en, this message translates to:
  /// **'No mood logs yet'**
  String get progressNoMoodLogsYet;

  /// No description provided for @progressNoCravingsLoggedYet.
  ///
  /// In en, this message translates to:
  /// **'No cravings logged yet'**
  String get progressNoCravingsLoggedYet;

  /// No description provided for @progressFutureTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Future trend'**
  String get progressFutureTrendTitle;

  /// No description provided for @progressFutureTrendBody.
  ///
  /// In en, this message translates to:
  /// **'A beautiful timeline of your momentum'**
  String get progressFutureTrendBody;

  /// No description provided for @progressGoal.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get progressGoal;

  /// No description provided for @progressLatestLoggedWeightReadyToTrack.
  ///
  /// In en, this message translates to:
  /// **'Your latest logged weight is ready to track.'**
  String get progressLatestLoggedWeightReadyToTrack;

  /// No description provided for @progressAboutGapFromTarget.
  ///
  /// In en, this message translates to:
  /// **'About {gap} {unit} from your target.'**
  String progressAboutGapFromTarget(Object gap, Object unit);

  /// No description provided for @progressDeltaVsPreviousLog.
  ///
  /// In en, this message translates to:
  /// **'{deltaText} vs your previous log.'**
  String progressDeltaVsPreviousLog(Object deltaText);

  /// No description provided for @progressDeltaVsPreviousLogAndGap.
  ///
  /// In en, this message translates to:
  /// **'{deltaText} vs previous log. {gap} {unit} from target.'**
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit);

  /// No description provided for @progressComparedWithPreviousLogTrendVisible.
  ///
  /// In en, this message translates to:
  /// **'Compared with your previous log, the trend is now visible.'**
  String get progressComparedWithPreviousLogTrendVisible;

  /// No description provided for @progressWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get progressWaterTitle;

  /// No description provided for @manageSubscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage Subscription'**
  String get manageSubscriptionTitle;

  /// No description provided for @manageSubscriptionProPlan.
  ///
  /// In en, this message translates to:
  /// **'Pro Plan'**
  String get manageSubscriptionProPlan;

  /// No description provided for @manageSubscriptionFreePlan.
  ///
  /// In en, this message translates to:
  /// **'Free Plan'**
  String get manageSubscriptionFreePlan;

  /// No description provided for @manageSubscriptionActiveCopy.
  ///
  /// In en, this message translates to:
  /// **'Your subscription is active.'**
  String get manageSubscriptionActiveCopy;

  /// No description provided for @manageSubscriptionUpgradeCopy.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to unlock Glu Pro.'**
  String get manageSubscriptionUpgradeCopy;

  /// No description provided for @manageSubscriptionPlan.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get manageSubscriptionPlan;

  /// No description provided for @manageSubscriptionPro.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get manageSubscriptionPro;

  /// No description provided for @manageSubscriptionFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get manageSubscriptionFree;

  /// No description provided for @manageSubscriptionProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get manageSubscriptionProduct;

  /// No description provided for @manageSubscriptionRenewal.
  ///
  /// In en, this message translates to:
  /// **'Renewal'**
  String get manageSubscriptionRenewal;

  /// No description provided for @manageSubscriptionStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get manageSubscriptionStatus;

  /// No description provided for @manageSubscriptionStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get manageSubscriptionStatusActive;

  /// No description provided for @manageSubscriptionStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Not active'**
  String get manageSubscriptionStatusInactive;

  /// No description provided for @manageSubscriptionManageButton.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get manageSubscriptionManageButton;

  /// No description provided for @manageSubscriptionUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get manageSubscriptionUpgradeButton;

  /// No description provided for @manageSubscriptionOpenStoreSubscriptionSettings.
  ///
  /// In en, this message translates to:
  /// **'Open store subscription settings'**
  String get manageSubscriptionOpenStoreSubscriptionSettings;

  /// No description provided for @manageSubscriptionProBadge.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get manageSubscriptionProBadge;

  /// No description provided for @manageSubscriptionRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get manageSubscriptionRestorePurchases;

  /// No description provided for @manageSubscriptionRenewsAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Renews automatically'**
  String get manageSubscriptionRenewsAutomatically;

  /// No description provided for @manageSubscriptionLifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get manageSubscriptionLifetime;

  /// No description provided for @manageSubscriptionRenewsOn.
  ///
  /// In en, this message translates to:
  /// **'Renews on {date}'**
  String manageSubscriptionRenewsOn(Object date);

  /// No description provided for @manageSubscriptionExpiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires on {date}'**
  String manageSubscriptionExpiresOn(Object date);

  /// No description provided for @supplementReminderDayMon.
  ///
  /// In en, this message translates to:
  /// **'Mo'**
  String get supplementReminderDayMon;

  /// No description provided for @supplementReminderDayTue.
  ///
  /// In en, this message translates to:
  /// **'Tu'**
  String get supplementReminderDayTue;

  /// No description provided for @supplementReminderDayWed.
  ///
  /// In en, this message translates to:
  /// **'We'**
  String get supplementReminderDayWed;

  /// No description provided for @supplementReminderDayThu.
  ///
  /// In en, this message translates to:
  /// **'Th'**
  String get supplementReminderDayThu;

  /// No description provided for @supplementReminderDayFri.
  ///
  /// In en, this message translates to:
  /// **'Fr'**
  String get supplementReminderDayFri;

  /// No description provided for @supplementReminderDaySat.
  ///
  /// In en, this message translates to:
  /// **'Sa'**
  String get supplementReminderDaySat;

  /// No description provided for @supplementReminderDaySun.
  ///
  /// In en, this message translates to:
  /// **'Su'**
  String get supplementReminderDaySun;

  /// No description provided for @supplementReminderInDays.
  ///
  /// In en, this message translates to:
  /// **'In {count} days'**
  String supplementReminderInDays(Object count);

  /// No description provided for @supplementReminderInOneWeek.
  ///
  /// In en, this message translates to:
  /// **'In 1 week'**
  String get supplementReminderInOneWeek;

  /// No description provided for @supplementReminderInWeeks.
  ///
  /// In en, this message translates to:
  /// **'In {count} weeks'**
  String supplementReminderInWeeks(Object count);

  /// No description provided for @subscriptionDebugTitle.
  ///
  /// In en, this message translates to:
  /// **'Glu Subscriptions'**
  String get subscriptionDebugTitle;

  /// No description provided for @subscriptionDebugMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionDebugMonthly;

  /// No description provided for @subscriptionDebugYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get subscriptionDebugYearly;

  /// No description provided for @subscriptionDebugRefreshCustomerInfo.
  ///
  /// In en, this message translates to:
  /// **'Refresh Customer Info'**
  String get subscriptionDebugRefreshCustomerInfo;

  /// No description provided for @subscriptionDebugPresentPaywall.
  ///
  /// In en, this message translates to:
  /// **'Present Paywall'**
  String get subscriptionDebugPresentPaywall;

  /// No description provided for @subscriptionDebugOpenCustomerCenter.
  ///
  /// In en, this message translates to:
  /// **'Open Customer Center'**
  String get subscriptionDebugOpenCustomerCenter;

  /// No description provided for @subscriptionDebugRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get subscriptionDebugRestorePurchases;

  /// No description provided for @subscriptionDebugSyncPurchases.
  ///
  /// In en, this message translates to:
  /// **'Sync Purchases'**
  String get subscriptionDebugSyncPurchases;

  /// No description provided for @subscriptionDebugRevenuecatStatus.
  ///
  /// In en, this message translates to:
  /// **'RevenueCat Status'**
  String get subscriptionDebugRevenuecatStatus;

  /// No description provided for @subscriptionDebugConfigured.
  ///
  /// In en, this message translates to:
  /// **'Configured'**
  String get subscriptionDebugConfigured;

  /// No description provided for @subscriptionDebugBusy.
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get subscriptionDebugBusy;

  /// No description provided for @subscriptionDebugAppUserId.
  ///
  /// In en, this message translates to:
  /// **'App user ID'**
  String get subscriptionDebugAppUserId;

  /// No description provided for @subscriptionDebugAnonymous.
  ///
  /// In en, this message translates to:
  /// **'anonymous'**
  String get subscriptionDebugAnonymous;

  /// No description provided for @subscriptionDebugApiKeyAvailable.
  ///
  /// In en, this message translates to:
  /// **'API key available'**
  String get subscriptionDebugApiKeyAvailable;

  /// No description provided for @subscriptionDebugGluProActive.
  ///
  /// In en, this message translates to:
  /// **'Glu Pro active'**
  String get subscriptionDebugGluProActive;

  /// No description provided for @subscriptionDebugActiveSubscriptions.
  ///
  /// In en, this message translates to:
  /// **'Active subscriptions'**
  String get subscriptionDebugActiveSubscriptions;

  /// No description provided for @subscriptionDebugManagementUrl.
  ///
  /// In en, this message translates to:
  /// **'Management URL'**
  String get subscriptionDebugManagementUrl;

  /// No description provided for @subscriptionDebugEntitlementProduct.
  ///
  /// In en, this message translates to:
  /// **'Entitlement product'**
  String get subscriptionDebugEntitlementProduct;

  /// No description provided for @subscriptionDebugWillRenew.
  ///
  /// In en, this message translates to:
  /// **'Will renew'**
  String get subscriptionDebugWillRenew;

  /// No description provided for @subscriptionDebugExpiration.
  ///
  /// In en, this message translates to:
  /// **'Expiration'**
  String get subscriptionDebugExpiration;

  /// No description provided for @subscriptionDebugLifetime.
  ///
  /// In en, this message translates to:
  /// **'lifetime'**
  String get subscriptionDebugLifetime;

  /// No description provided for @subscriptionDebugPackageFound.
  ///
  /// In en, this message translates to:
  /// **'Package found'**
  String get subscriptionDebugPackageFound;

  /// No description provided for @subscriptionDebugProductId.
  ///
  /// In en, this message translates to:
  /// **'Product ID'**
  String get subscriptionDebugProductId;

  /// No description provided for @subscriptionDebugTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get subscriptionDebugTitleLabel;

  /// No description provided for @subscriptionDebugPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get subscriptionDebugPrice;

  /// No description provided for @subscriptionDebugPurchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase {title}'**
  String subscriptionDebugPurchase(Object title);

  /// No description provided for @progressExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get progressExerciseTitle;

  /// No description provided for @progressDoseTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get progressDoseTitle;

  /// No description provided for @progressMealsTitle.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get progressMealsTitle;

  /// No description provided for @progressSymptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get progressSymptomsTitle;

  /// No description provided for @progressMoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get progressMoodTitle;

  /// No description provided for @progressCravingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cravings'**
  String get progressCravingsTitle;

  /// No description provided for @progressTrend.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get progressTrend;

  /// No description provided for @progressTarget.
  ///
  /// In en, this message translates to:
  /// **'Target'**
  String get progressTarget;

  /// No description provided for @progressNoTrendYet.
  ///
  /// In en, this message translates to:
  /// **'No trend yet'**
  String get progressNoTrendYet;

  /// No description provided for @progressNoActivityYet.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get progressNoActivityYet;

  /// No description provided for @progressNoCheckInsYet.
  ///
  /// In en, this message translates to:
  /// **'No check-ins yet'**
  String get progressNoCheckInsYet;

  /// No description provided for @progressWeightSignatureChip.
  ///
  /// In en, this message translates to:
  /// **'Weight will become your signature chart'**
  String get progressWeightSignatureChip;

  /// No description provided for @progressWeightStartTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Start your trend with one weigh-in'**
  String get progressWeightStartTrendTitle;

  /// No description provided for @progressWeightStartTrendBody.
  ///
  /// In en, this message translates to:
  /// **'This chart is the centerpiece of your progress story. Log your first weight to unlock momentum, milestones, and a view worth sharing.'**
  String get progressWeightStartTrendBody;

  /// No description provided for @progressWeightMomentum.
  ///
  /// In en, this message translates to:
  /// **'Momentum'**
  String get progressWeightMomentum;

  /// No description provided for @progressWeightMilestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get progressWeightMilestones;

  /// No description provided for @progressWeightShareReady.
  ///
  /// In en, this message translates to:
  /// **'Share-ready'**
  String get progressWeightShareReady;

  /// No description provided for @progressWeightLogWeight.
  ///
  /// In en, this message translates to:
  /// **'Log weight'**
  String get progressWeightLogWeight;

  /// No description provided for @weightProgressUnlocksViewChip.
  ///
  /// In en, this message translates to:
  /// **'Your first weigh-in unlocks this view'**
  String get weightProgressUnlocksViewChip;

  /// No description provided for @weightProgressStartsHereTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress story starts here'**
  String get weightProgressStartsHereTitle;

  /// No description provided for @weightProgressStartsHereBody.
  ///
  /// In en, this message translates to:
  /// **'Log your first weight to unlock trends, milestones, and dose-aware insights in a view worth sharing.'**
  String get weightProgressStartsHereBody;

  /// No description provided for @weightProgressTrendView.
  ///
  /// In en, this message translates to:
  /// **'Trend view'**
  String get weightProgressTrendView;

  /// No description provided for @weightProgressDoseOverlays.
  ///
  /// In en, this message translates to:
  /// **'Dose overlays'**
  String get weightProgressDoseOverlays;

  /// No description provided for @weightProgressMilestones.
  ///
  /// In en, this message translates to:
  /// **'Milestones'**
  String get weightProgressMilestones;

  /// No description provided for @weightProgressLogWeight.
  ///
  /// In en, this message translates to:
  /// **'Log weight'**
  String get weightProgressLogWeight;

  /// No description provided for @glowUpAddBeforeAndAfterFirst.
  ///
  /// In en, this message translates to:
  /// **'Add both a before and after photo first.'**
  String get glowUpAddBeforeAndAfterFirst;

  /// No description provided for @glowUpSavedToGallery.
  ///
  /// In en, this message translates to:
  /// **'Saved to your gallery'**
  String get glowUpSavedToGallery;

  /// No description provided for @glowUpSaveToGallery.
  ///
  /// In en, this message translates to:
  /// **'Save to gallery'**
  String get glowUpSaveToGallery;

  /// No description provided for @glowUpYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get glowUpYourProgress;

  /// No description provided for @glowUpWeightChange.
  ///
  /// In en, this message translates to:
  /// **'Weight change'**
  String get glowUpWeightChange;

  /// No description provided for @glowUpTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get glowUpTime;

  /// No description provided for @glowUpShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get glowUpShare;

  /// No description provided for @glowUpBefore.
  ///
  /// In en, this message translates to:
  /// **'BEFORE'**
  String get glowUpBefore;

  /// No description provided for @glowUpAfter.
  ///
  /// In en, this message translates to:
  /// **'AFTER'**
  String get glowUpAfter;

  /// No description provided for @glowUpProgressWeightAndTime.
  ///
  /// In en, this message translates to:
  /// **'{weight} in {time}'**
  String glowUpProgressWeightAndTime(Object weight, Object time);

  /// No description provided for @glowUpTimeUnitDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get glowUpTimeUnitDaysLabel;

  /// No description provided for @glowUpTimeUnitWeeksLabel.
  ///
  /// In en, this message translates to:
  /// **'weeks'**
  String get glowUpTimeUnitWeeksLabel;

  /// No description provided for @glowUpTimeUnitMonthsLabel.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String get glowUpTimeUnitMonthsLabel;

  /// No description provided for @glowUpTimeUnitYearsLabel.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get glowUpTimeUnitYearsLabel;

  /// No description provided for @glowUpTimeValueDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String glowUpTimeValueDays(int count);

  /// No description provided for @glowUpTimeValueWeeks.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} week} other{{count} weeks}}'**
  String glowUpTimeValueWeeks(int count);

  /// No description provided for @glowUpTimeValueMonths.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} month} other{{count} months}}'**
  String glowUpTimeValueMonths(int count);

  /// No description provided for @glowUpTimeValueYears.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} year} other{{count} years}}'**
  String glowUpTimeValueYears(int count);

  /// No description provided for @commonYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get commonYesterday;

  /// No description provided for @commonSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get commonSelect;

  /// No description provided for @doseReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose reminder'**
  String get doseReminderTitle;

  /// No description provided for @doseReminderCustomDoseTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom dose'**
  String get doseReminderCustomDoseTitle;

  /// No description provided for @doseReminderCustomDoseHint.
  ///
  /// In en, this message translates to:
  /// **'Type dose in mg'**
  String get doseReminderCustomDoseHint;

  /// No description provided for @doseReminderKeepNextDoseReadyOnHome.
  ///
  /// In en, this message translates to:
  /// **'Keep your next dose ready on home.'**
  String get doseReminderKeepNextDoseReadyOnHome;

  /// No description provided for @doseReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get doseReminderTime;

  /// No description provided for @doseReminderTurnThisOnToShowNextDoseOnHome.
  ///
  /// In en, this message translates to:
  /// **'Turn this on to show the next dose on home.'**
  String get doseReminderTurnThisOnToShowNextDoseOnHome;

  /// No description provided for @doseReminderSaveReminder.
  ///
  /// In en, this message translates to:
  /// **'Save reminder'**
  String get doseReminderSaveReminder;

  /// No description provided for @loggedOn.
  ///
  /// In en, this message translates to:
  /// **'Logged on {date}'**
  String loggedOn(Object date);

  /// No description provided for @waterLogSmallGlass.
  ///
  /// In en, this message translates to:
  /// **'Small glass'**
  String get waterLogSmallGlass;

  /// No description provided for @waterLogGlass.
  ///
  /// In en, this message translates to:
  /// **'Glass'**
  String get waterLogGlass;

  /// No description provided for @waterLogBottle.
  ///
  /// In en, this message translates to:
  /// **'Bottle'**
  String get waterLogBottle;

  /// No description provided for @waterLogLargeBottle.
  ///
  /// In en, this message translates to:
  /// **'Large bottle'**
  String get waterLogLargeBottle;

  /// No description provided for @waterLogTwoLiters.
  ///
  /// In en, this message translates to:
  /// **'2 L'**
  String get waterLogTwoLiters;

  /// No description provided for @waterLogCustomPreset.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get waterLogCustomPreset;

  /// No description provided for @waterLogMlUnit.
  ///
  /// In en, this message translates to:
  /// **'ml'**
  String get waterLogMlUnit;

  /// No description provided for @waterLogOzUnit.
  ///
  /// In en, this message translates to:
  /// **'oz'**
  String get waterLogOzUnit;

  /// No description provided for @doseLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get doseLogTitle;

  /// No description provided for @doseLogEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit dose'**
  String get doseLogEditTitle;

  /// No description provided for @doseLogLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log dose'**
  String get doseLogLogTitle;

  /// No description provided for @doseLogCustomDose.
  ///
  /// In en, this message translates to:
  /// **'Custom dose'**
  String get doseLogCustomDose;

  /// No description provided for @doseLogCustomDoseBody.
  ///
  /// In en, this message translates to:
  /// **'Adjust the dose in mg for this log.'**
  String get doseLogCustomDoseBody;

  /// No description provided for @doseLogUseThisDose.
  ///
  /// In en, this message translates to:
  /// **'Use this dose'**
  String get doseLogUseThisDose;

  /// No description provided for @doseLogMedication.
  ///
  /// In en, this message translates to:
  /// **'Medication'**
  String get doseLogMedication;

  /// No description provided for @doseLogInjectionSite.
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get doseLogInjectionSite;

  /// No description provided for @doseLogNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get doseLogNotes;

  /// No description provided for @doseLogSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get doseLogSaveChanges;

  /// No description provided for @doseLogAddDose.
  ///
  /// In en, this message translates to:
  /// **'+ Log dose'**
  String get doseLogAddDose;

  /// No description provided for @doseLogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this dose log?'**
  String get doseLogDeleteTitle;

  /// No description provided for @doseLogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get doseLogDeleteMessage;

  /// No description provided for @doseLogDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get doseLogDeleteLog;

  /// No description provided for @doseLogSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get doseLogSaving;

  /// No description provided for @doseLogCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this dose log yet.'**
  String get doseLogCouldNotSave;

  /// No description provided for @doseLogCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this dose log yet.'**
  String get doseLogCouldNotDelete;

  /// No description provided for @doseLogDeleted.
  ///
  /// In en, this message translates to:
  /// **'Dose deleted'**
  String get doseLogDeleted;

  /// No description provided for @doseLogAddedToDoseLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your dose log'**
  String get doseLogAddedToDoseLog;

  /// No description provided for @doseLogAnythingWorthRemembering.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about this dose?'**
  String get doseLogAnythingWorthRemembering;

  /// No description provided for @doseLogDoseLabel.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get doseLogDoseLabel;

  /// No description provided for @exerciseLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exerciseLogTitle;

  /// No description provided for @exerciseLogEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit exercise'**
  String get exerciseLogEditTitle;

  /// No description provided for @exerciseLogLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log exercise'**
  String get exerciseLogLogTitle;

  /// No description provided for @exerciseLogActivityType.
  ///
  /// In en, this message translates to:
  /// **'Activity type'**
  String get exerciseLogActivityType;

  /// No description provided for @exerciseLogCustomActivity.
  ///
  /// In en, this message translates to:
  /// **'Custom activity'**
  String get exerciseLogCustomActivity;

  /// No description provided for @exerciseLogTypeActivity.
  ///
  /// In en, this message translates to:
  /// **'Type the activity'**
  String get exerciseLogTypeActivity;

  /// No description provided for @exerciseLogDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get exerciseLogDuration;

  /// No description provided for @exerciseLogIntensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get exerciseLogIntensity;

  /// No description provided for @exerciseLogNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get exerciseLogNotes;

  /// No description provided for @exerciseLogLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get exerciseLogLight;

  /// No description provided for @exerciseLogModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get exerciseLogModerate;

  /// No description provided for @exerciseLogIntense.
  ///
  /// In en, this message translates to:
  /// **'Intense'**
  String get exerciseLogIntense;

  /// No description provided for @exerciseLogDurationLogged.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min logged'**
  String exerciseLogDurationLogged(Object minutes);

  /// No description provided for @exerciseLogSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get exerciseLogSaveChanges;

  /// No description provided for @exerciseLogAddExercise.
  ///
  /// In en, this message translates to:
  /// **'+ Add exercise log'**
  String get exerciseLogAddExercise;

  /// No description provided for @exerciseLogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this exercise log?'**
  String get exerciseLogDeleteTitle;

  /// No description provided for @exerciseLogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get exerciseLogDeleteMessage;

  /// No description provided for @exerciseLogDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get exerciseLogDeleteLog;

  /// No description provided for @exerciseLogSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get exerciseLogSaving;

  /// No description provided for @exerciseLogCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this exercise log yet.'**
  String get exerciseLogCouldNotSave;

  /// No description provided for @exerciseLogCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this exercise log yet.'**
  String get exerciseLogCouldNotDelete;

  /// No description provided for @exerciseLogDeleted.
  ///
  /// In en, this message translates to:
  /// **'Exercise deleted'**
  String get exerciseLogDeleted;

  /// No description provided for @exerciseLogAddedToExerciseLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your exercise log'**
  String get exerciseLogAddedToExerciseLog;

  /// No description provided for @exerciseLogAnythingWorthRemembering.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about this session?'**
  String get exerciseLogAnythingWorthRemembering;

  /// No description provided for @exerciseLogWalking.
  ///
  /// In en, this message translates to:
  /// **'Walking'**
  String get exerciseLogWalking;

  /// No description provided for @exerciseLogRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get exerciseLogRunning;

  /// No description provided for @exerciseLogCycling.
  ///
  /// In en, this message translates to:
  /// **'Cycling'**
  String get exerciseLogCycling;

  /// No description provided for @exerciseLogStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get exerciseLogStrength;

  /// No description provided for @exerciseLogYoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get exerciseLogYoga;

  /// No description provided for @exerciseLogSwim.
  ///
  /// In en, this message translates to:
  /// **'Swim'**
  String get exerciseLogSwim;

  /// No description provided for @exerciseLogHiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT'**
  String get exerciseLogHiit;

  /// No description provided for @weightLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLogTitle;

  /// No description provided for @weightLogEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit weight'**
  String get weightLogEditTitle;

  /// No description provided for @weightLogLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log weight'**
  String get weightLogLogTitle;

  /// No description provided for @weightLogSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get weightLogSaveChanges;

  /// No description provided for @weightLogAddWeight.
  ///
  /// In en, this message translates to:
  /// **'+ Add weight ({label})'**
  String weightLogAddWeight(Object label);

  /// No description provided for @weightLogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this weight log?'**
  String get weightLogDeleteTitle;

  /// No description provided for @weightLogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get weightLogDeleteMessage;

  /// No description provided for @weightLogDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get weightLogDeleteLog;

  /// No description provided for @weightLogSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get weightLogSaving;

  /// No description provided for @weightLogCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this weight log yet.'**
  String get weightLogCouldNotSave;

  /// No description provided for @weightLogCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this weight log yet.'**
  String get weightLogCouldNotDelete;

  /// No description provided for @weightLogDeleted.
  ///
  /// In en, this message translates to:
  /// **'Weight deleted'**
  String get weightLogDeleted;

  /// No description provided for @weightLogAddedToWeightLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your weight log'**
  String get weightLogAddedToWeightLog;

  /// No description provided for @weightLogNoWeightForDay.
  ///
  /// In en, this message translates to:
  /// **'No weight logged for this day yet.'**
  String get weightLogNoWeightForDay;

  /// No description provided for @injectionSiteAbdomen.
  ///
  /// In en, this message translates to:
  /// **'Abdomen'**
  String get injectionSiteAbdomen;

  /// No description provided for @injectionSiteThigh.
  ///
  /// In en, this message translates to:
  /// **'Thigh'**
  String get injectionSiteThigh;

  /// No description provided for @injectionSiteUpperArm.
  ///
  /// In en, this message translates to:
  /// **'Upper arm'**
  String get injectionSiteUpperArm;

  /// No description provided for @injectionSiteButtocks.
  ///
  /// In en, this message translates to:
  /// **'Buttocks'**
  String get injectionSiteButtocks;

  /// No description provided for @injectionSiteAbdomenUpperLeft.
  ///
  /// In en, this message translates to:
  /// **'Abdomen, upper left'**
  String get injectionSiteAbdomenUpperLeft;

  /// No description provided for @injectionSiteAbdomenUpperRight.
  ///
  /// In en, this message translates to:
  /// **'Abdomen, upper right'**
  String get injectionSiteAbdomenUpperRight;

  /// No description provided for @injectionSiteAbdomenLowerRight.
  ///
  /// In en, this message translates to:
  /// **'Abdomen, lower right'**
  String get injectionSiteAbdomenLowerRight;

  /// No description provided for @injectionSiteAbdomenLowerLeft.
  ///
  /// In en, this message translates to:
  /// **'Abdomen, lower left'**
  String get injectionSiteAbdomenLowerLeft;

  /// No description provided for @injectionSiteThighUpperLeft.
  ///
  /// In en, this message translates to:
  /// **'Thigh, upper left'**
  String get injectionSiteThighUpperLeft;

  /// No description provided for @injectionSiteThighUpperRight.
  ///
  /// In en, this message translates to:
  /// **'Thigh, upper right'**
  String get injectionSiteThighUpperRight;

  /// No description provided for @injectionSiteThighLowerRight.
  ///
  /// In en, this message translates to:
  /// **'Thigh, lower right'**
  String get injectionSiteThighLowerRight;

  /// No description provided for @injectionSiteThighLowerLeft.
  ///
  /// In en, this message translates to:
  /// **'Thigh, lower left'**
  String get injectionSiteThighLowerLeft;

  /// No description provided for @injectionSiteUpperArmLeft.
  ///
  /// In en, this message translates to:
  /// **'Upper arm, left'**
  String get injectionSiteUpperArmLeft;

  /// No description provided for @injectionSiteUpperArmRight.
  ///
  /// In en, this message translates to:
  /// **'Upper arm, right'**
  String get injectionSiteUpperArmRight;

  /// No description provided for @injectionSiteButtocksUpperLeft.
  ///
  /// In en, this message translates to:
  /// **'Buttocks, upper left'**
  String get injectionSiteButtocksUpperLeft;

  /// No description provided for @injectionSiteButtocksUpperRight.
  ///
  /// In en, this message translates to:
  /// **'Buttocks, upper right'**
  String get injectionSiteButtocksUpperRight;

  /// No description provided for @doseReminderFormat.
  ///
  /// In en, this message translates to:
  /// **'Format'**
  String get doseReminderFormat;

  /// No description provided for @doseReminderInjection.
  ///
  /// In en, this message translates to:
  /// **'Injection'**
  String get doseReminderInjection;

  /// No description provided for @doseReminderPill.
  ///
  /// In en, this message translates to:
  /// **'Pill'**
  String get doseReminderPill;

  /// No description provided for @doseReminderSite.
  ///
  /// In en, this message translates to:
  /// **'Site'**
  String get doseReminderSite;

  /// No description provided for @doseReminderDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get doseReminderDate;

  /// No description provided for @supplementReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Supplement reminder'**
  String get supplementReminderTitle;

  /// No description provided for @supplementReminderAddSupplement.
  ///
  /// In en, this message translates to:
  /// **'Add supplement'**
  String get supplementReminderAddSupplement;

  /// No description provided for @supplementReminderNoSupplementsYet.
  ///
  /// In en, this message translates to:
  /// **'No supplements yet'**
  String get supplementReminderNoSupplementsYet;

  /// No description provided for @supplementReminderAddFirstBody.
  ///
  /// In en, this message translates to:
  /// **'Add your first supplement reminder to track your daily intake.'**
  String get supplementReminderAddFirstBody;

  /// No description provided for @supplementReminderSupplementFallback.
  ///
  /// In en, this message translates to:
  /// **'Supplement'**
  String get supplementReminderSupplementFallback;

  /// No description provided for @supplementReminderEveryDay.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get supplementReminderEveryDay;

  /// No description provided for @supplementReminderEveryXDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Every X days'**
  String get supplementReminderEveryXDaysLabel;

  /// No description provided for @supplementReminderEveryXDays.
  ///
  /// In en, this message translates to:
  /// **'Every {interval} days'**
  String supplementReminderEveryXDays(Object interval);

  /// No description provided for @supplementReminderNoDaysSet.
  ///
  /// In en, this message translates to:
  /// **'No days set'**
  String get supplementReminderNoDaysSet;

  /// No description provided for @supplementReminderSupplementName.
  ///
  /// In en, this message translates to:
  /// **'Supplement name'**
  String get supplementReminderSupplementName;

  /// No description provided for @supplementReminderTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get supplementReminderTime;

  /// No description provided for @supplementReminderStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get supplementReminderStartDate;

  /// No description provided for @supplementReminderRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get supplementReminderRepeat;

  /// No description provided for @supplementReminderDaysOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Days of week'**
  String get supplementReminderDaysOfWeek;

  /// No description provided for @supplementReminderSelectAtLeastOneDay.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day.'**
  String get supplementReminderSelectAtLeastOneDay;

  /// No description provided for @supplementReminderEvery.
  ///
  /// In en, this message translates to:
  /// **'Every'**
  String get supplementReminderEvery;

  /// No description provided for @supplementReminderDay.
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get supplementReminderDay;

  /// No description provided for @supplementReminderDays.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get supplementReminderDays;

  /// No description provided for @supplementReminderAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get supplementReminderAdd;

  /// No description provided for @symptomsLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get symptomsLogTitle;

  /// No description provided for @symptomsLogEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit symptoms'**
  String get symptomsLogEditTitle;

  /// No description provided for @symptomsLogLogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log symptoms'**
  String get symptomsLogLogTitle;

  /// No description provided for @symptomsLogSymptomsExperienced.
  ///
  /// In en, this message translates to:
  /// **'Symptoms experienced'**
  String get symptomsLogSymptomsExperienced;

  /// No description provided for @symptomsLogNoSymptoms.
  ///
  /// In en, this message translates to:
  /// **'No symptoms'**
  String get symptomsLogNoSymptoms;

  /// No description provided for @symptomsLogNoSymptomsToday.
  ///
  /// In en, this message translates to:
  /// **'No symptoms today'**
  String get symptomsLogNoSymptomsToday;

  /// No description provided for @symptomsLogOther.
  ///
  /// In en, this message translates to:
  /// **'Other...'**
  String get symptomsLogOther;

  /// No description provided for @symptomsLogSeverityLevel.
  ///
  /// In en, this message translates to:
  /// **'Severity level'**
  String get symptomsLogSeverityLevel;

  /// No description provided for @symptomsLogNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get symptomsLogNotes;

  /// No description provided for @symptomsLogAnxiety.
  ///
  /// In en, this message translates to:
  /// **'Anxiety'**
  String get symptomsLogAnxiety;

  /// No description provided for @symptomsLogBelching.
  ///
  /// In en, this message translates to:
  /// **'Belching'**
  String get symptomsLogBelching;

  /// No description provided for @symptomsLogBloating.
  ///
  /// In en, this message translates to:
  /// **'Bloating'**
  String get symptomsLogBloating;

  /// No description provided for @symptomsLogConstipation.
  ///
  /// In en, this message translates to:
  /// **'Constipation'**
  String get symptomsLogConstipation;

  /// No description provided for @symptomsLogDiarrhea.
  ///
  /// In en, this message translates to:
  /// **'Diarrhea'**
  String get symptomsLogDiarrhea;

  /// No description provided for @symptomsLogFatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get symptomsLogFatigue;

  /// No description provided for @symptomsLogFoodNoise.
  ///
  /// In en, this message translates to:
  /// **'Food noise'**
  String get symptomsLogFoodNoise;

  /// No description provided for @symptomsLogHairLoss.
  ///
  /// In en, this message translates to:
  /// **'Hair loss'**
  String get symptomsLogHairLoss;

  /// No description provided for @symptomsLogHeartburn.
  ///
  /// In en, this message translates to:
  /// **'Heartburn'**
  String get symptomsLogHeartburn;

  /// No description provided for @symptomsLogIndigestion.
  ///
  /// In en, this message translates to:
  /// **'Indigestion'**
  String get symptomsLogIndigestion;

  /// No description provided for @symptomsLogInjectionSiteReaction.
  ///
  /// In en, this message translates to:
  /// **'Injection site reaction'**
  String get symptomsLogInjectionSiteReaction;

  /// No description provided for @symptomsLogMetallicTaste.
  ///
  /// In en, this message translates to:
  /// **'Metallic taste'**
  String get symptomsLogMetallicTaste;

  /// No description provided for @symptomsLogHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get symptomsLogHeadache;

  /// No description provided for @symptomsLogMoodSwings.
  ///
  /// In en, this message translates to:
  /// **'Mood swings'**
  String get symptomsLogMoodSwings;

  /// No description provided for @symptomsLogNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get symptomsLogNausea;

  /// No description provided for @symptomsLogReflux.
  ///
  /// In en, this message translates to:
  /// **'Reflux'**
  String get symptomsLogReflux;

  /// No description provided for @symptomsLogStomachPain.
  ///
  /// In en, this message translates to:
  /// **'Stomach pain'**
  String get symptomsLogStomachPain;

  /// No description provided for @symptomsLogSuppressedAppetite.
  ///
  /// In en, this message translates to:
  /// **'Suppressed appetite'**
  String get symptomsLogSuppressedAppetite;

  /// No description provided for @symptomsLogVomiting.
  ///
  /// In en, this message translates to:
  /// **'Vomiting'**
  String get symptomsLogVomiting;

  /// No description provided for @symptomsLogLogged.
  ///
  /// In en, this message translates to:
  /// **'Symptoms logged'**
  String get symptomsLogLogged;

  /// No description provided for @symptomsLogMild.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get symptomsLogMild;

  /// No description provided for @symptomsLogModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get symptomsLogModerate;

  /// No description provided for @symptomsLogSevere.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get symptomsLogSevere;

  /// No description provided for @symptomsLogAnythingWorthRemembering.
  ///
  /// In en, this message translates to:
  /// **'Anything worth remembering about how you felt?'**
  String get symptomsLogAnythingWorthRemembering;

  /// No description provided for @symptomsLogSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get symptomsLogSaveChanges;

  /// No description provided for @symptomsLogAddSymptoms.
  ///
  /// In en, this message translates to:
  /// **'+ Add symptoms log'**
  String get symptomsLogAddSymptoms;

  /// No description provided for @symptomsLogDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this symptoms log?'**
  String get symptomsLogDeleteTitle;

  /// No description provided for @symptomsLogDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get symptomsLogDeleteMessage;

  /// No description provided for @symptomsLogDeleteLog.
  ///
  /// In en, this message translates to:
  /// **'Delete log'**
  String get symptomsLogDeleteLog;

  /// No description provided for @symptomsLogSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get symptomsLogSaving;

  /// No description provided for @symptomsLogCouldNotSave.
  ///
  /// In en, this message translates to:
  /// **'Could not save this symptoms log yet.'**
  String get symptomsLogCouldNotSave;

  /// No description provided for @symptomsLogCouldNotDelete.
  ///
  /// In en, this message translates to:
  /// **'Could not delete this symptoms log yet.'**
  String get symptomsLogCouldNotDelete;

  /// No description provided for @symptomsLogDeleted.
  ///
  /// In en, this message translates to:
  /// **'Symptoms deleted'**
  String get symptomsLogDeleted;

  /// No description provided for @symptomsLogAddedToSymptomsLog.
  ///
  /// In en, this message translates to:
  /// **'Added to your symptoms log'**
  String get symptomsLogAddedToSymptomsLog;

  /// No description provided for @homePercentOfDailyGoal.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of daily goal'**
  String homePercentOfDailyGoal(Object percent);

  /// No description provided for @commonDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Glu is a tracking tool, not a medical device. It does not provide medical advice, diagnosis, or treatment. Always consult your healthcare provider about your medication and health decisions.'**
  String get commonDisclaimer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'da',
        'de',
        'en',
        'es',
        'fi',
        'fr',
        'hi',
        'it',
        'nl',
        'no',
        'pt',
        'ru',
        'sv',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'no':
      return AppLocalizationsNo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'sv':
      return AppLocalizationsSv();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
