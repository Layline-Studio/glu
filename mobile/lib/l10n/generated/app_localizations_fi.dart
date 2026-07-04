// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Herätään...';

  @override
  String get startupFailed => 'Käynnistys epäonnistui';

  @override
  String get commonCancel => 'Peruuta';

  @override
  String get commonSave => 'Tallenna';

  @override
  String get commonSaving => 'Tallennetaan...';

  @override
  String get commonContinue => 'Jatka';

  @override
  String get commonSkip => 'Ohita';

  @override
  String get commonDelete => 'Poista';

  @override
  String get commonNotNow => 'Ei nyt';

  @override
  String get commonNow => 'Nyt';

  @override
  String get commonTomorrow => 'Huomenna';

  @override
  String get noteTriggerAddNote => 'Lisää huomio';

  @override
  String get noteTriggerCancelNote => 'Peruuta huomio';

  @override
  String homeDoseReminderInDays(Object count) {
    return '$count päivän päästä';
  }

  @override
  String get homeDoseReminderInOneWeek => '1 viikon päästä';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return '$count viikon päästä';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => '1 päivä myöhässä';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return '$count päivää myöhässä';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => '1 viikko myöhässä';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return '$count viikkoa myöhässä';
  }

  @override
  String get bmiIndicatorYourBmi => 'Painoindeksi (BMI)';

  @override
  String get bmiIndicatorCurrentBmi => 'Nykyinen painoindeksisi (BMI)';

  @override
  String get bmiIndicatorUnderweight => 'Alipaino';

  @override
  String get bmiIndicatorNormal => 'Normaali';

  @override
  String get bmiIndicatorOverweight => 'Ylipaino';

  @override
  String get bmiIndicatorObesity => 'Lihavuus';

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
  String get logNoteIndicatorHasNote => 'Muistiinpano';

  @override
  String get paywallTitle => 'Avaa Glu Pro';

  @override
  String get paywallSubtitle =>
      'Suojaa edistymisesi ja vältä painon palautuminen.';

  @override
  String get paywallMonthlyTitle => 'Kuukausi';

  @override
  String get paywallMonthlySubtitle => 'Ei kokeilujaksoa';

  @override
  String get paywallYearlyTitle => 'Vuosi';

  @override
  String get paywallYearlySubtitle => '7 päivän ilmainen kokeilu';

  @override
  String get paywallNoCommitment => 'Ei sitoutumista';

  @override
  String get paywallCancelAnytime => 'Peruuta milloin tahansa';

  @override
  String get paywallContinue => 'Jatka';

  @override
  String get paywallRestore => 'Palauta';

  @override
  String get paywallTerms => 'Ehdot';

  @override
  String get paywallPrivacy => 'Tietosuoja';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Säästä $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Linkkiä ei voitu avata juuri nyt.';

  @override
  String get paywallAlreadySubscribed => 'Sinulla on jo Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Tervetuloa Glu Prohon!';

  @override
  String get paywallPurchaseIncomplete =>
      'Osto ei valmistunut. Yritä uudelleen.';

  @override
  String get paywallPurchaseFailed => 'Osto epäonnistui. Yritä uudelleen.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Osto epäonnistui: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Tilaus palautettu!';

  @override
  String get paywallRestoreNoSubscription => 'Aktiivista tilausta ei löytynyt.';

  @override
  String get paywallRestoreFailed => 'Palautus epäonnistui. Yritä uudelleen.';

  @override
  String get paywallBenefitReminders =>
      'Muistutuksia annoksista ja lisäravinteista';

  @override
  String get paywallBenefitShareProgress => 'Jaa edistymisesi helposti';

  @override
  String get paywallBenefitSpotRegain => 'Huomaa painon palautuminen ajoissa';

  @override
  String get paywallBenefitInsights => 'Näe päivittäiset analyysit ja trendit';

  @override
  String get paywallBenefitWeeklyGoals =>
      'Pidä kiinni yksinkertaisista viikkotavoitteista';

  @override
  String get paywallBenefitHealthyHabits =>
      'Tee terveiden tapojen ylläpitämisestä helpompaa';

  @override
  String get onboardingWelcomeTitle => 'Pidä paino poissa';

  @override
  String get onboardingWelcomeSubtitle =>
      'Glu auttaa suojaamaan edistymistäsi hoidon, tavoitteiden ja viikkotottumusten ympärillä.';

  @override
  String get onboardingWelcomeBullet1 => 'Sopii hoitoosi ja tavoitteisiisi';

  @override
  String get onboardingWelcomeBullet2 => 'Yksinkertainen ja realistinen tuki';

  @override
  String get onboardingWelcomeBullet3 =>
      'Havaitse helposti painon palautumisen varhaiset merkit';

  @override
  String get onboardingWelcomeBullet4 => 'Jatka aloittamatta alusta';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Käytätkö tällä hetkellä painonpudotuslääkettä?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Käytämme tätä näyttääksemme ohjeita, jotka vastaavat tämänhetkistä tilannettasi.';

  @override
  String get onboardingMedicationStatusUsing => 'Kyllä, käytän sitä nyt';

  @override
  String get onboardingMedicationStatusWeaningOff =>
      'Kyllä, olen lopettelemassa sitä';

  @override
  String get onboardingMedicationStatusNotTaking => 'Ei, en käytä sitä';

  @override
  String get onboardingMedicationStatusStartingSoon => 'Ei, aloitan pian';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Ei, lopetin hiljattain';

  @override
  String get onboardingMedicationMethodQuestion => 'Miten otat lääkkeesi?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Käytämme tätä räätälöidäksemme ohjeet ja muistutukset lääkemuotosi mukaan.';

  @override
  String get onboardingMedicationMethodInjection => 'Pistos';

  @override
  String get onboardingMedicationMethodPill => 'Pilleri';

  @override
  String get onboardingMedicationMethodUnknown => 'En vielä tiedä';

  @override
  String get onboardingMedicationNameQuestion => 'Mitä lääkettä käytät?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Käytämme tätä annosseurannan ja lääkekohtaisten ohjeiden personointiin.';

  @override
  String get onboardingCurrentDoseQuestion => 'Mikä on nykyinen annoksesi?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Käytämme tätä annosseurannan ja tulevien edistymistarkistusten räätälöintiin.';

  @override
  String get onboardingMedicationCustomDose => 'Mukautettu';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Mitä laitetta käytät lääkkeen ottamiseen?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Käytämme tätä, jotta muistutukset ja vinkit sopivat tapaan, jolla otat lääkkeesi.';

  @override
  String get onboardingDeviceSinglePen => 'Yksittäinen kynä';

  @override
  String get onboardingDeviceAutoInjector => 'Automaatti-injektori';

  @override
  String get onboardingDeviceSyringeAndVial => 'Ruisku ja ampulli';

  @override
  String get onboardingOther => 'Muu';

  @override
  String get onboardingTypeYourDevice => 'Kirjoita laitteesi';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Kuinka usein otat lääkkeesi?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Käytämme tätä ajoittaaksemme muistutukset ja rutiinitukesi aikatauluusi.';

  @override
  String get onboardingEveryDay => 'Joka päivä';

  @override
  String get onboardingEvery7Days => '7 päivän välein';

  @override
  String get onboardingEvery14Days => '14 päivän välein';

  @override
  String get onboardingCustom => 'Mukautettu';

  @override
  String get onboardingDaysBetweenDoses => 'Päiviä annosten välillä';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'Mikä on tärkein tavoitteesi juuri nyt?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Käytämme tätä keskittääksemme suunnitelmasi, muistutukset ja edistymisen siihen, mikä on sinulle tärkeintä.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Käytämme tätä muotoillaksemme suunnitelmasi aivan alusta alkaen.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Käytämme tätä tukemaan seuraavaa vaihettasi ja auttamaan sinua pysymään raiteilla.';

  @override
  String get onboardingGoalLoseWeight => 'Pudota painoa';

  @override
  String get onboardingGoalMaintainWeight => 'Ylläpidä painoani';

  @override
  String get onboardingGoalManageDiabetes => 'Hallitse diabetestani';

  @override
  String get onboardingGoalManagePcos => 'Hallitse PCOS:ääni';

  @override
  String get onboardingGoalImproveHeartHealth => 'Paranna sydänterveyttäni';

  @override
  String get onboardingAgeQuestion => 'Kuinka vanha olet?';

  @override
  String get onboardingAgeExplainer =>
      'Käytämme tätä säätääksemme ohjeita ja terveyslaskelmia tarkemmin.';

  @override
  String get onboardingHeightQuestion => 'Kuinka pitkä olet?';

  @override
  String get onboardingHeightExplainer =>
      'Käytämme tätä yhdessä painosi kanssa painoindeksin (BMI) ja terveiden vaihteluvälien laskemiseen.';

  @override
  String get onboardingWeightQuestion => 'Mikä on nykyinen painosi?';

  @override
  String get onboardingWeightExplainer =>
      'Käytämme tätä lähtökohtanasi edistymiselle, tavoitteille ja terveysarvioille.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Milloin lopetit lääkityksen?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Milloin aloitit lääkityksen lopettamisen?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Milloin aloitit lääkityksen?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Käytämme tätä ymmärtääksemme viimeaikaisen hoitohistoriasi ja seuraavan vaiheesi.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Käytämme tätä ymmärtääksemme siirtymävaiheesi ja tukeaksemme juuri nyt tärkeimpiä tapoja.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Käytämme tätä ymmärtääksemme, kuinka kauan olet ollut hoidossa ja seurataksemme muutosta ajan myötä.';

  @override
  String get onboardingGoalWeightQuestion => 'Mikä on tavoitepainosi?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Käytämme tätä kehystämään edistymistäsi ja näyttämään sinulle tavoitepainoindeksi-alueen (BMI).';

  @override
  String get onboardingBenefitsQuestion =>
      'Mitä Glu auttaa sinua tekemään seuraavaksi';

  @override
  String get onboardingBenefitsExplainer =>
      'Glu muuttaa jakamasi tiedot muistutuksiksi, tueksi ja rakenteeksi, jotka sopivat rutiiniisi.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Näin Glu voi auttaa sinua ylläpitämään edistymistäsi';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Näin Glu voi tukea diabeteksen hallintaa';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Näin Glu voi tukea PCOS-rutiiniasi';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Näin Glu voi tukea sydänterveyttäsi';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Näin Glu voi auttaa sinua pudottamaan painoa';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Näe, miten Glu auttaa sinua suojaamaan nykyisen painosi ja havaitsemaan palautumisen ajoissa.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Näe, miten Glu auttaa sinua pitämään ateriat, painon ja rutiinit vakaampina viikko viikolta.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Näe, miten Glu auttaa sinua pysymään vakaampana oireiden, painon ja rutiinin ympärillä.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Näe, miten Glu auttaa sinua pysymään johdonmukaisena sydänterveyttä tukevissa tavoissa.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Näe, miten Glu auttaa sinua havaitsemaan kaavat, jotka pitävät painon laskussa.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Ilman rakennetta palautuminen voi hiipiä hiljaa. Glu auttaa sinua huomaamaan sen aiemmin ja pysymään vakaana.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Ilman rakennetta ateria- ja painokaavat muuttuvat epäselviksi. Glu pitää signaalit selkeämpinä.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Ilman rakennetta oireet ja rutiinit voivat vaihdella enemmän. Glu auttaa sinua pysymään vakaampana.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Ilman rakennetta terveelliset tavat lipsuvat. Glu auttaa pitämään aktiivisuuden ja painon raiteilla.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Ilman rakennetta paino voi jumittua tai alkaa nousta. Glu auttaa pitämään edistyksen oikeaan suuntaan.';

  @override
  String get onboardingBenefitsAxisWeight => 'Paino';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Ateriat ja paino';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Oireet ja paino';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Liikunta ja paino';

  @override
  String get onboardingNotificationsQuestion =>
      'Ota käyttöön muistutukset, jotka tukevat tavoitettasi';

  @override
  String get onboardingNotificationsExplainer =>
      'Käytämme ilmoituksia auttaaksemme sinua pysymään johdonmukaisena, valmistautuneena ja raiteilla.';

  @override
  String get onboardingNotificationsHeadline =>
      'Aseta Glu auttamaan oikealla hetkellä.';

  @override
  String get onboardingNotificationsBody =>
      'Ota ilmoitukset käyttöön, jotta Glu voi vahvistaa tavoitteitasi tukevia tapoja.';

  @override
  String get onboardingNotificationsDaily =>
      'Ajastetut muistutukset, jotka sopivat päivittäiseen lääkerytmiisi';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Pidemmän aikavälin muistutukset, jotta annospäivät eivät yllätä sinua';

  @override
  String get onboardingNotificationsCustom =>
      'Muistutukset, jotka on muotoiltu mukautettuun aikatauluusi';

  @override
  String get onboardingNotificationsWeekly =>
      'Annosmuistutukset, jotka pysyvät viikkorytmisi mukana';

  @override
  String get onboardingNotificationsSupportive =>
      'Tukevat muistutukset, jotka pitävät rutiinisi näkyvillä motivaation laskiessa';

  @override
  String get onboardingNotificationsProgress =>
      'Ajoitetut tönäisyt edistymisen, tapojen ja tärkeimpien tavoitteidesi ympärillä';

  @override
  String get onboardingNotificationsHelpful =>
      'Hyödylliset kehotukset, jotka tekevät Glu:sta hyödyllisemmän juuri silloin kun sitä tarvitset';

  @override
  String get onboardingDailyRoutineQuestion => 'Millainen on päivärutiinisi?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Käytämme tätä, jotta suunnitelmasi tuntuisi realistiselta arkeesi.';

  @override
  String get onboardingRoutineSedentary => 'Sedentary';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Enimmäkseen istumista, toimistotyötä ja hyvin vähän tarkoituksellista liikuntaa.';

  @override
  String get onboardingRoutineLightlyActive => 'Kevyesti aktiivinen';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Regular walking, errands, or light workouts a few times a week.';

  @override
  String get onboardingRoutineActive => 'Aktiivinen';

  @override
  String get onboardingRoutineActiveDescription =>
      'Usein liikettä tai liikuntaa, kuten päivittäisiä kävelyjä, salia tai aktiivista työtä.';

  @override
  String get onboardingRoutineVeryActive => 'Erittäin aktiivinen';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Hard training, physically demanding work, or high activity most days.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Mistä oireista olet eniten huolissasi, jos mistään?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Käytämme tätä priorisoidaksemme vinkkejä ja ohjeita oireiden ympärillä, joista välität eniten.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Käytämme tätä keskittyäksemme oireisiin, joita haluat ennakoida.';

  @override
  String get onboardingGenderQuestion => 'Miten kuvaat sukupuoltasi?';

  @override
  String get onboardingGenderExplainer =>
      'Käytämme tätä osuvampiin ohjeisiin ja tulevaan personointiin.';

  @override
  String get onboardingGenderFemale => 'Nainen';

  @override
  String get onboardingGenderMale => 'Mies';

  @override
  String get onboardingGenderPreferNotToSay => 'En halua sanoa';

  @override
  String get onboardingTypeYourGender => 'Kirjoita sukupuolesi';

  @override
  String get onboardingPreferredNameQuestion =>
      'Miten meidän pitäisi kutsua sinua?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Käytämme tätä, jotta Glu tuntuu henkilökohtaisemmalta puhuessamme sinulle.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Valmistellaan suunnitelmaasi';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Muunnetaan jakamasi tiedot suunnitelmaksi, jota Glu voi tukea heti.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Kiinnitetään painon ylläpitotavoitteet...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Setting up regain watchpoints...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Säädetään muistutukset rutiinisi ympärille...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Valmistellaan vakaampi viikkosuunnitelma...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Määritellään ateria- ja painokaavat...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 => 'Asetetaan nesteystuki...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Valmistellaan johdonmukaisuusmuistutuksia...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Rakennetaan selkeämpi päivärakenne...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Järjestellään oireiden tuki...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Määritellään viikoittaiset liikkumistavoitteet...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Setting hydration and routine anchors...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Valmistellaan vakaampi suunnitelma...';

  @override
  String get onboardingSetupSummaryHeartStep1 => 'Setting activity targets...';

  @override
  String get onboardingSetupSummaryHeartStep2 => 'Määritellään nesteystuki...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Valmistellaan viikoittaisia tapa-muistutuksia...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Building a heart-health routine...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Defining calorie boundaries...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Setting water amounts...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Rakennetaan liikuntatavoitteita...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Valmistellaan viikkosuunnitelmaasi...';

  @override
  String get onboardingSetupSummaryHeadline => 'Glu-asetuksesi on valmis.';

  @override
  String get onboardingSetupLoadingTitle => 'Rakennetaan asetuksiasi';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'Glu on valmis auttamaan sinua suojaamaan edistymistäsi selkeämmällä rakenteella ja aiemmilla palautumissignaaleilla.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'Glu on valmis tukemaan vakaampia aterioita, painonseurantaa ja arjen kannalta tärkeitä tapoja.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'Glu on valmis tukemaan vakaampia rutiineja oireiden, hoidon ja edistymisen ympärillä.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'Glu on valmis vahvistamaan sydänterveyttäsi tukevia tapoja.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'Glu on valmis tukemaan rutiineja, jotka auttavat pitämään painon poissa.';

  @override
  String get onboardingSetupSummaryLabel => 'Summary';

  @override
  String get onboardingSetupAdjustLater =>
      'Voit säätää näitä myöhemmin Asetuksissa.';

  @override
  String get onboardingSummaryGoal => 'Tavoite';

  @override
  String get onboardingSummaryCurrentWeight => 'Nykyinen paino';

  @override
  String get onboardingSummaryMedication => 'Lääkitys';

  @override
  String get onboardingSummaryCurrentDose => 'Nykyinen annos';

  @override
  String get onboardingSummaryCadence => 'Cadence';

  @override
  String get onboardingSummaryStarted => 'Aloitettu';

  @override
  String get onboardingSummaryTargetWeight => 'Tavoitepaino';

  @override
  String get onboardingSummaryRoutine => 'Rutiini';

  @override
  String get onboardingSummaryFocus => 'Fokus';

  @override
  String get onboardingFrequencyEveryDay => 'Every day';

  @override
  String get onboardingFrequencyEveryWeek => 'Every week';

  @override
  String get onboardingFrequencyEvery2Weeks => 'Every 2 weeks';

  @override
  String get onboardingFrequencyCustomSchedule => 'Mukautettu aikataulu';

  @override
  String get onboardingTapOptionContinue => 'Tap an option to continue.';

  @override
  String get onboardingTypeGenderContinue =>
      'Kirjoita sukupuolesi jatkaaksesi.';

  @override
  String get onboardingTypeDeviceContinue => 'Kirjoita laitteesi jatkaaksesi.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Kirjoita lääkkeesi jatkaaksesi.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Syötä annosten välisten päivien määrä jatkaaksesi.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Valitse aikataulu jatkaaksesi.';

  @override
  String get onboardingScrollChooseAge => 'Selaa valitaksesi ikäsi.';

  @override
  String get onboardingDragOrTapHeight =>
      'Vedä tai napauta viivainta valitaksesi pituutesi.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Vedä, napauta tai käytä askelpainikkeita valitaksesi painon.';

  @override
  String get onboardingPickDateAndWeight =>
      'Valitse päivämäärä ja paino jatkaaksesi.';

  @override
  String get onboardingSelectSymptoms =>
      'Valitse oireet, joihin haluat Glu:n keskittyvän.';

  @override
  String get onboardingTypeName => 'Kirjoita nimi, jota Glu käyttää.';

  @override
  String get onboardingSaving => 'Tallennetaan...';

  @override
  String get onboardingLetsBegin => 'Aloitetaan';

  @override
  String get onboardingContinueWithGlu => 'Jatka Glun kanssa';

  @override
  String get onboardingKeepGoing => 'Jatka';

  @override
  String get onboardingTurnOnNotifications => 'Ota ilmoitukset käyttöön';

  @override
  String get onboardingFinish => 'Valmis';

  @override
  String get onboardingTargetBmiTitle => 'Tavoitepainoindeksi (BMI)';

  @override
  String get onboardingChartToday => 'Tänään';

  @override
  String get onboardingChartOverTime => 'Ajan myötä';

  @override
  String get onboardingChartWithoutGlu => 'Ilman Glua';

  @override
  String get onboardingChartWithGlu => 'Glu:n kanssa';

  @override
  String get onboardingReviewQuestion =>
      'Ihmiset käyttävät Glua pysyäkseen vakaana ja tuettuna';

  @override
  String get onboardingReviewExplainer =>
      'Nopea arvio auttaa useampia ihmisiä löytämään tukea, joka tuntuu näin helpolta.';

  @override
  String get onboardingReviewBody =>
      'Ihmiset käyttävät Glua tunteakseen olonsa tuetummaksi, johdonmukaisemmaksi ja vähemmän yksin prosessissa.';

  @override
  String get onboardingTypeYourMedication => 'Kirjoita lääkkeesi';

  @override
  String get onboardingSelectStartDate => 'Valitse aloituspäivä';

  @override
  String get goalsSaveDialogTitle => 'Tallennetaanko tavoitteet?';

  @override
  String get goalsSaveDialogMessage =>
      'Sinulla on tallentamattomia tavoitemuutoksia. Tallennetaanko ne ennen tämän välilehden sulkemista?';

  @override
  String get commonLater => 'Myöhemmin';

  @override
  String get homeGreetingAnonymous => 'Hi';

  @override
  String homeGreetingWithName(Object name) {
    return 'Hi, $name';
  }

  @override
  String get homeInsightEmptyTitle => 'Kirjaa tänään nähdäksesi analyysin';

  @override
  String get homeInsightEmptyBody =>
      'Kirjaa jotain tänään, niin näet analyysisi illalla.';

  @override
  String get homeInsightLogTodayTitle => 'Muunna kirjaukset analyysiksi';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Lisää kirjauksia, parempi näkemys';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Kirjauksesi alkavat jo näyttää mallia.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Näkemyksesi on hahmottumassa';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Muutama kirjauksia lisää voisi tehdä kuvasta paljon selkeämmän.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Mitä tämän päivän kirjaukset vihjaavat';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Päivässäsi saattaa jo piillä jokin kaava.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Kirjaa vähintään kerran tänään, niin näet selkeämmän kuvan edistymisestäsi.';

  @override
  String get homeInsightExpandedTitle => 'Oliko tästä hyötyä?';

  @override
  String get homeInsightExpandedBody =>
      'Nopea arvio auttaa Glua oppimaan, mikä on sinulle tärkeintä.';

  @override
  String get homeInsightReasonHint => 'Mitä voisi olla paremmin? (valinnainen)';

  @override
  String get homeInsightReasonSubmit => 'Lähetä';

  @override
  String get homeInsightLearningMessage => 'Opin tästä.';

  @override
  String get homeInsightChecking => 'Tarkistetaan tämän päivän analyysiä...';

  @override
  String get homeInsightGenerating => 'Ladataan tämän päivän analyysiä...';

  @override
  String get homeInsightTryAgain => 'Yritä uudelleen';

  @override
  String get homeSeeAllInsights => 'Näytä kaikki analyysit';

  @override
  String get insightsProgressTitle => 'Kaikki analyysit';

  @override
  String get insightsProgressEmptyState =>
      'Analyysisi ilmestyvät tähän, kun ne on luotu.';

  @override
  String get homeDoseReminderTitle => 'Annosmuistutus';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Kirjaa $label -toiminto tähän.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Kaloritavoite tarvitaan';

  @override
  String get homeCalorieGoalRequiredBody =>
      'Annoskoko tarvitsee Ateria-tavoitteen asetettuna kaloreihin arvioidakseen annoksesi. Aseta se Tavoitteissa aloittaaksesi.';

  @override
  String get homeSetGoal => 'Aseta tavoite';

  @override
  String get homeYourProgress => 'Edistymisesi';

  @override
  String get homeRemindersShowcaseTitle => 'Pysy rytmissä';

  @override
  String get homeRemindersShowcaseDescription =>
      'Aseta muistutukset, jotta annokset ja lisäravinteet pysyvät ajallaan.';

  @override
  String get homePickNextDoseDate => 'Valitse seuraava annospäivä';

  @override
  String get homeSetReminder => 'Aseta muistutus';

  @override
  String get homeSupplementReminders => 'Lisäravinnemuistutukset';

  @override
  String get homeNoUpcomingSupplements => 'Ei tulevia lisäravinteita';

  @override
  String get homeNoMoreUpcomingSupplements => 'Ei enää tulevia';

  @override
  String get homeSetUpYourSupplements => 'Aseta lisäravinteesi';

  @override
  String get homeSetUp => 'Aseta';

  @override
  String get homeSupplementFallback => 'Lisäravinne';

  @override
  String get doseReminderNotificationTitle => 'Valmis annoksesi kanssa?';

  @override
  String get doseReminderFallbackBody =>
      'Avaa Glu tarkistaaksesi seuraavan annoksesi.';

  @override
  String get supplementReminderNotificationTitle => 'Aika ravintolisällesi';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Tänä aamuna';

  @override
  String get supplementReminderThisAfternoon => 'Tänä iltapäivänä';

  @override
  String get supplementReminderTonight => 'Tänä iltana';

  @override
  String get dailyReminderMorningTitle => 'Aamun tarkistus';

  @override
  String get dailyReminderMorningBodies =>
      'Aamutehtävä: anna Glulle vähän dataa tutkittavaksi.\nAloita päivä pikaisella kirjauksella ja hyvällä vauhdilla.\nNouse ja kirjaa. Tuleva minäsi kiittää.\nAloita päivä pienellä päivityksellä ja suurella etumatkalla.\nAnna Glulle aamun vihje ja jatka eteenpäin.\nNopea kirjaus nyt voi tehdä tästä päivästä paljon kiinnostavamman.\nTehdään aamusta merkityksellinen nopealla tarkistuksella.';

  @override
  String get dailyReminderMiddayTitle => 'Päivän tarkistus';

  @override
  String get dailyReminderMiddayBodies =>
      'Päivän puoliväli: tee nopea kirjaus ja jatka matkaa.\nLounastauko? Täydellinen hetki antaa Glulle päivitys.\nPuolivälissä jo. Anna Glulle nopea vihje.\nPieni keskipäivän kirjaus voi pitää tarinan liikkeessä.\nTarkista nyt ja pidä päivä rullaamassa.\nAnna päivällesi pieni tönäisy nopealla päivityksellä.\nPidä energia yllä nopealla keskipäivän napautuksella.';

  @override
  String get dailyReminderAfternoonTitle => 'Iltapäivän tarkistus';

  @override
  String get dailyReminderAfternoonBodies =>
      'Melkein valmista. Anna Glulle vielä yksi vihje.\nNopea iltapäiväkirjaus voi tehdä illan analyysistä terävämmän.\nPäätä päivä pienellä päivityksellä ja suurella voitolla.\nYksi kirjaus lisää ennen kuin päivä päättyy?\nAuta Glua yhdistämään pisteet nopealla iltapäivän tarkistuksella.\nSulje silmukka pienellä kirjauksella ja pidä taika käynnissä.\nViimeinen napautus nyt voi tehdä illan analyysistä paljon paremman.';

  @override
  String get homePortionCheckTitle => 'Annoskoko';

  @override
  String get homePortionCheckBody =>
      'Tiedä, kuinka paljon syödä jokaisella aterialla';

  @override
  String get homeGlowUpTitle => 'Tee muutos näkyväksi';

  @override
  String get homeGlowUpBody => 'Luo ennen-jälkeen-tarinasi';

  @override
  String get homeGoalsStatusTitle => 'Tämän päivän tavoitteet';

  @override
  String get homeGoalsStatusViewAll => 'Näytä kaikki';

  @override
  String get homeWaterTitle => 'Vesi';

  @override
  String get homeWeightTitle => 'Paino';

  @override
  String get homeExerciseTitle => 'Liikunta';

  @override
  String get homeMealsTitle => 'Ateriat';

  @override
  String get homeCaloriesTitle => 'Kalorit';

  @override
  String get homeProteinsTitle => 'Proteiinit';

  @override
  String get homeFibersTitle => 'Kuidut';

  @override
  String get homeSymptomsTitle => 'Oireet';

  @override
  String get homeMoodTitle => 'Mieli';

  @override
  String get homeDoseTitle => 'Annos';

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
  String get homeStartHydration => 'Aloita nesteytys';

  @override
  String get homeLogFirstSession => 'Kirjaa ensimmäinen sessio';

  @override
  String get homeLogTodayWeight => 'Kirjaa paino tänään';

  @override
  String get homeAtYourTarget => 'Olet tavoitteessasi';

  @override
  String get homeLogMealsToTrackCalories =>
      'Kirjaa ateriat seurataksesi kaloreita';

  @override
  String get homeLogFirstMeal => 'Kirjaa ensimmäinen ateriasi';

  @override
  String get homeTrackProteinFromMeals => 'Seuraa proteiinia aterioista';

  @override
  String get homeTrackFiberFromMeals => 'Seuraa kuitua aterioista';

  @override
  String get homeAllClear => 'All clear';

  @override
  String get homeTrackSymptoms => 'Seuraa oireita';

  @override
  String get homeGreat => 'Great';

  @override
  String get homeGood => 'Good';

  @override
  String get homeBad => 'Bad';

  @override
  String get homeOkay => 'Okay';

  @override
  String get homeLogHowYouFeel => 'Kirjaa miltä sinusta tuntuu';

  @override
  String get homeLogTodaysDose => 'Kirjaa tämän päivän annos';

  @override
  String get homeTaken => 'Taken';

  @override
  String get homeStartHereTitle => 'Aloita tästä';

  @override
  String get homeStartHereBody =>
      'Aloita tästä kortista ja laajenna myöhemmin. Mitä enemmän Glu oppii matkastasi, sitä parempia kaavoja ja analyysia se voi näyttää ajan myötä.';

  @override
  String get waterLogTitle => 'Vesi';

  @override
  String get waterLogEditTitle => 'Muokkaa vettä';

  @override
  String get waterLogLogTitle => 'Vesikirjaus';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Lisää juoma ($amount)';
  }

  @override
  String get waterLogSaving => 'Tallennetaan...';

  @override
  String get waterLogCustomDrinkTitle => 'Mukautettu juoma';

  @override
  String get waterLogCustomDrinkBody => 'Valitse tämä vesimäärä.';

  @override
  String get waterLogUseThisAmount => 'Käytä tätä määrää';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount lisätty nesteytyslokiin';
  }

  @override
  String get waterLogCouldNotSave =>
      'Tätä vesikirjausta ei voitu tallentaa vielä.';

  @override
  String get waterLogDeleteTitle => 'Poistetaanko tämä nesteytyskirjaus?';

  @override
  String get waterLogDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get waterLogCouldNotDelete =>
      'Tätä nesteytyskirjausta ei voitu poistaa vielä.';

  @override
  String get waterLogDeleteLog => 'Poista kirjaus';

  @override
  String get waterLogDeleted => 'Hydration deleted';

  @override
  String get moodLogTitle => 'Mieli';

  @override
  String get moodEditTitle => 'Muokkaa mielialaa';

  @override
  String get moodHowYouFeel => 'Miltä sinusta tuntuu';

  @override
  String get moodBad => 'Bad';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodGood => 'Good';

  @override
  String get moodGreat => 'Great';

  @override
  String get moodNotes => 'Muistiinpanot';

  @override
  String get moodAnythingWorthRemembering =>
      'Onko mielialassasi jotain muistettavaa?';

  @override
  String get moodCouldNotSave =>
      'Tätä mielialakirjausta ei voitu tallentaa vielä.';

  @override
  String get moodDeleteTitle => 'Poistetaanko tämä mielialakirjaus?';

  @override
  String get moodDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get moodDeleteLog => 'Poista kirjaus';

  @override
  String get moodSaving => 'Tallennetaan...';

  @override
  String get moodAddMoodLog => '+ Lisää mielialakirjaus';

  @override
  String get moodLogged => 'Mieliala kirjattu';

  @override
  String get moodDeleted => 'Mieliala poistettu';

  @override
  String get moodCouldNotDelete =>
      'Tätä mielialakirjausta ei voitu poistaa vielä.';

  @override
  String get moodAddedToMoodLog => 'Lisätty mielialalokiisi';

  @override
  String get portionCheckTitle => 'Annoskoko';

  @override
  String get portionCheckAnalyzingMeal => 'Analysoidaan ateriaasi…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Tätä kuvaa ei voitu analysoida';

  @override
  String get portionCheckTakeNewPhoto => 'Take a new photo';

  @override
  String get portionCheckSomethingWentWrong => 'Something went wrong.';

  @override
  String get portionCheckYouHitDailyLimit =>
      'Päivittäinen rajasi on tullut täyteen';

  @override
  String get portionCheckYouCanEat => 'Voit syödä';

  @override
  String get portionCheckYouCanEatUpTo => 'Voit syödä enintään';

  @override
  String get portionCheckTryLighterOption =>
      'Kokeile sen sijaan kevyempää vaihtoehtoa tai jätä tämä väliin';

  @override
  String get portionCheckThisEntireMeal => 'tämä koko ateria';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% tästä ateriasta';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'pysyäksesi päivittäisten tavoitteidesi sisällä.';

  @override
  String get portionCheckNutritionBreakdown => 'Nutrition breakdown';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Vinkkejä aterian tasapainottamiseen';

  @override
  String get portionCheckTipsPool =>
      'Syö hitaasti — kylläisyyden tunne tulee perässä noin 20 minuutissa.\nTäytä puolet lautasesta kasviksilla.\nLisää proteiinia jokaiselle aterialle.\nJuo vettä ennen aterioita.\nJaa välipalat valmiiksi pieniin rasioihin.\nYhdistä hiilihydraatit proteiiniin tai rasvaan, jotta pysyt kylläisenä pidempään.\nValitse mahdollisuuksien mukaan vähän prosessoituja ruokia.\nVältä syömistä ruutujen häiriöissä.\nÄlä jätä aterioita väliin, jos se saa sinut syömään myöhemmin enemmän.\nSuunnittele välipalat ennen kuin tulee nälkä.';

  @override
  String get portionCheckRetake => 'Retake';

  @override
  String get portionCheckLogThisPortion => 'Kirjaa tämä annos';

  @override
  String get portionCheckCarbs => 'Carbs';

  @override
  String get portionCheckProteins => 'Proteiinit';

  @override
  String get portionCheckFats => 'Fats';

  @override
  String get portionCheckFiber => 'Kuitu';

  @override
  String get mealLogScreenTitle => 'Meals';

  @override
  String get mealLogEditTitle => 'Edit meal';

  @override
  String get mealLogLogTitle => 'Kirjaa ateria';

  @override
  String get mealLogSaving => 'Tallennetaan...';

  @override
  String get mealLogAddMealLog => '+ Lisää ateriakirjaus';

  @override
  String get mealLogCouldNotStartRecording => 'Tallennusta ei voitu aloittaa.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'Recording stopped at 60 seconds.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Tätä tallennetta ei voitu analysoida.';

  @override
  String get mealLogCouldNotAnalyzeText => 'Tätä tekstiä ei voitu analysoida.';

  @override
  String get mealLogCouldNotAnalyzePhoto => 'Tätä kuvaa ei voitu analysoida.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Tätä aterian kuvaa ei voitu vielä käsitellä.';

  @override
  String get mealLogDiscardTitle => 'Hylätäänkö tämä ateria?';

  @override
  String get mealLogDiscardMessage =>
      'Tarkistit kuvan, mutta et tallentanut merkintää. Sitä ei kirjata.';

  @override
  String get mealLogDiscard => 'Discard';

  @override
  String get mealLogDeleteTitle => 'Poistetaanko tämä ateriakirjaus?';

  @override
  String get mealLogDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get mealLogDelete => 'Poista';

  @override
  String get mealLogDeleteLog => 'Poista kirjaus';

  @override
  String get mealLogCouldNotSave =>
      'Tätä ateriakirjausta ei voitu tallentaa vielä.';

  @override
  String get mealLogCouldNotDelete =>
      'Tätä ateriakirjausta ei voitu poistaa vielä.';

  @override
  String get mealLogAnalyzing => 'Analyzing...';

  @override
  String get mealLogAnalyzeText => 'Analysoi teksti';

  @override
  String get mealLogSendRecording => 'Send recording';

  @override
  String get mealLogMealDefaultName => 'Meal';

  @override
  String get mealLogMealNameHint => 'Meal name';

  @override
  String get mealLogCouldNotPrefillTitle => 'Tätä ateriaa ei voitu esitäyttää';

  @override
  String get mealLogHowMuchDidYouEat => 'Kuinka paljon söit?';

  @override
  String get mealLogNotes => 'Muistiinpanot';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Onko tästä ateriasta jotain muistettavaa?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analysoidaan ateriaasi';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Muunnetaan syötteesi ravintokentiksi. Voit tarkistaa kaiken ennen tallennusta.';

  @override
  String get mealLogDescribeYourMealTitle => 'Kuvaile ateriasi';

  @override
  String get mealLogDescribeYourMealBody =>
      'Kirjoita mitä söit ja kaikki määrät jotka tiedät. Muutamme ne ravintokentiksi.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Example: grilled chicken salad, olive oil dressing, 1 apple, sparkling water';

  @override
  String get mealLogCaptureYourMealTitle => 'Tallenna ateriasi';

  @override
  String get mealLogCaptureYourMealBody =>
      'Ota kuva, niin arvioimme ravintokentät puolestasi.';

  @override
  String get mealLogTakePhoto => 'Take photo';

  @override
  String get mealLogRecordingYourMealTitle => 'Tallennetaan ateriaa';

  @override
  String get mealLogRecordingReadyTitle => 'Tallennus valmis';

  @override
  String get mealLogRecordMealDescriptionTitle => 'Record a meal description';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Napauta stop kun olet valmis. ${remaining}s jäljellä';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Lähetä se alla analysoitavaksi tai tallenna uudelleen.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Kerro luonnollisesti mitä söit, niin jäsennämme sen makroiksi.';

  @override
  String get mealLogStopRecording => 'Stop recording';

  @override
  String get mealLogRecordAgain => 'Record again';

  @override
  String get mealLogStartRecording => 'Aloita tallennus';

  @override
  String get mealLogBreakfast => 'Breakfast';

  @override
  String get mealLogLunch => 'Lunch';

  @override
  String get mealLogSnack => 'Snack';

  @override
  String get mealLogDinner => 'Dinner';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'Tänään';

  @override
  String get mealLogYesterday => 'Eilen';

  @override
  String mealLogKcal(Object count) {
    return '$count kcal';
  }

  @override
  String mealLogKcalLogged(Object count) {
    return '$count kcal kirjattu';
  }

  @override
  String mealLogMacroLogged(Object amount, Object macro) {
    return '$amount g $macro kirjattu';
  }

  @override
  String get mealLogDeleted => 'Ateria poistettu';

  @override
  String get mealLogAddedToMealLog => 'Lisätty aterialokiin';

  @override
  String get mealLogCarbs => 'Carbs';

  @override
  String get mealLogProteins => 'Proteiinit';

  @override
  String get mealLogFats => 'Fats';

  @override
  String get mealLogFiber => 'Kuitu';

  @override
  String get settingsLanguage => 'Kieli';

  @override
  String get settingsLanguageDialogTitle => 'Valitse kieli';

  @override
  String get settingsTitle => 'Asetukset';

  @override
  String get settingsPreferences => 'Asetukset';

  @override
  String get settingsHealthGoal => 'Terveystavoite';

  @override
  String get settingsHealthGoalDialogTitle => 'Valitse terveystavoite';

  @override
  String get settingsHabitGoals => 'Tapatavoitteet';

  @override
  String get settingsDisabled => 'Disabled';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count aktiivista';
  }

  @override
  String get settingsHeight => 'Pituus';

  @override
  String get settingsAge => 'Ikä';

  @override
  String get settingsGender => 'Sukupuoli';

  @override
  String get settingsMeasurementUnit => 'Measurement unit';

  @override
  String get settingsReminders => 'Muistutukset';

  @override
  String get settingsDoseReminder => 'Annosmuistutus';

  @override
  String get settingsSupplementReminder => 'Lisäravinnemuistutus';

  @override
  String get settingsDailyReminders => 'Päivittäiset muistutukset';

  @override
  String get settingsSubscription => 'Tilaus';

  @override
  String get settingsSupport => 'Tuki';

  @override
  String get settingsSendFeedback => 'Lähetä palautetta';

  @override
  String get feedbackSheetTitle => 'Lähetä palautetta';

  @override
  String get feedbackSheetHint => 'Kerro, mitä mieltä olet…';

  @override
  String get feedbackSheetSend => 'Lähetä';

  @override
  String get feedbackSheetSuccess => 'Kiitos palautteestasi!';

  @override
  String get feedbackSheetError => 'Lähetys epäonnistui. Yritä uudelleen.';

  @override
  String get settingsTermsOfService => 'Käyttöehdot';

  @override
  String get settingsPrivacyPolicy => 'Tietosuojakäytäntö';

  @override
  String get settingsInternal => 'Sisäinen';

  @override
  String get settingsSubscriptionOverride => 'Tilauksen ohitus';

  @override
  String get settingsTodayInsightCard => 'Päivän analyysikortti';

  @override
  String get settingsResetOnboarding => 'Nollaa aloitus';

  @override
  String get settingsResetShowcases => 'Nollaa esittelyt';

  @override
  String get settingsResetUserData => 'Nollaa käyttäjätiedot';

  @override
  String get settingsDeletingAccount => 'Deleting account...';

  @override
  String get settingsDisconnect => 'Disconnect';

  @override
  String get settingsDeleteAccount => 'Poista tili';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Irrota $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Irrota $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Et voi enää kirjautua tällä laitteella käyttäen $provider-tunnusta, ellet yhdistä sitä uudelleen myöhemmin.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Poistetaanko tili?';

  @override
  String get settingsDeleteAccountBody =>
      'Tämä poistaa tilisi ja kaikki tietosi pysyvästi. Tätä toimintoa ei voi perua.';

  @override
  String get settingsDeleteAccountConfirmHint =>
      'Kirjoita DELETE vahvistaaksesi';

  @override
  String get settingsDeleteAccountError =>
      'Tilisi poistamisessa tapahtui virhe. Ota yhteyttä osoitteeseen support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Restart app to see onboarding';

  @override
  String get settingsShowcasesReset => 'Esittelyt nollattu';

  @override
  String get settingsResetUserDataTitle => 'Nollataanko käyttäjätiedot?';

  @override
  String get settingsResetUserDataBody =>
      'Tämä poistaa kaikki kirjaukset aterioista, vedestä, liikunnasta, painosta, mielialasta, oireista, lisäravinteista ja annoksista.';

  @override
  String get settingsUserDataReset => 'Käyttäjätiedot nollattu';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Tallennettu, mutta päivittäisiä muistutuksia ei voitu ajoittaa juuri nyt.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Tilauksen ohitus';

  @override
  String get settingsSubscriptionOverrideAuto => 'Automaattinen';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Pakota ilmainen';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Pakota Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Päivän analyysikortti';

  @override
  String get settingsTodayInsightCardAuto => 'Automaattinen';

  @override
  String get settingsTodayInsightCardOn => 'Päällä';

  @override
  String get settingsTodayInsightCardOff => 'Pois';

  @override
  String get settingsYourName => 'Nimesi';

  @override
  String get settingsSignOut => 'Kirjaudu ulos';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'ft/in';

  @override
  String get settingsHeightFt => 'ft';

  @override
  String get settingsHeightIn => 'in';

  @override
  String get settingsGenderMale => 'Mies';

  @override
  String get settingsGenderFemale => 'Nainen';

  @override
  String get settingsGenderPreferNotToSay => 'En halua sanoa';

  @override
  String get settingsGenderOther => 'Muu';

  @override
  String get settingsYourProfile => 'Profiilisi';

  @override
  String get settingsNotSet => 'Ei asetettu';

  @override
  String settingsYears(Object value) {
    return '$value vuotta';
  }

  @override
  String get settingsOff => 'Pois';

  @override
  String get settingsOn => 'Päällä';

  @override
  String get settingsNoneSet => 'Ei mitään asetettu';

  @override
  String settingsSupplementCount(Object count) {
    return '$count lisäravinne';
  }

  @override
  String get commonToday => 'Tänään';

  @override
  String get mainShellHome => 'Koti';

  @override
  String get mainShellLog => 'Kirjaus';

  @override
  String get mainShellProgress => 'Edistyminen';

  @override
  String get mainShellSettings => 'Asetukset';

  @override
  String get mainShellLogShowcaseTitle => 'Kirjaukset';

  @override
  String get mainShellLogShowcaseDescription =>
      'Napauta tästä avataksesi kirjaukset ja seurataksesi sinulle tärkeitä asioita.';

  @override
  String get logWaterShowcaseTitle => 'Aloita vedestä';

  @override
  String get logWaterShowcaseDescription =>
      'Kirjaa vesi nyt ja jatka muiden asioiden kirjaamista päivän mittaan, jotta Glu voi havaita tavat ja kaavat tarkemmin.';

  @override
  String get mainShellProgressShowcaseTitle => 'Näe edistymisesi';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Tarkista kaavat ja trendit ymmärtääksesi, miten tapasi ja painosi muuttuvat ajan myötä.';

  @override
  String get progressMenuShowcaseTitle => 'Tutustu tietoihisi';

  @override
  String get progressMenuShowcaseDescription =>
      'Näe kaikki kaaviot, lue tekoälyn luomia oivalluksia tai luo lääkäriraportti ja jaa se hoitotiimillesi.';

  @override
  String get settingsFeedbackShowcaseTitle => 'Haluamme kuulla palautteesi';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Napauta tästä jaaaksesi, mikä toimii, mikä ei tai mitä ideoita sinulla on.';

  @override
  String get authCouldNotOpenLink => 'Linkkiä ei voitu avata juuri nyt.';

  @override
  String get authWelcomeTitle => 'Tervetuloa Gluun';

  @override
  String get authSubtitle =>
      'Turvallinen kirjautuminen terveyskaveriisi ja analytiikkaasi';

  @override
  String get authContinueWithGoogle => 'Jatka Googlella';

  @override
  String get authContinueWithApple => 'Jatka Applella';

  @override
  String get authEmailHint => 'name@email.com';

  @override
  String get authSending => 'Lähetetään...';

  @override
  String get authResendLink => 'Lähetä linkki uudelleen';

  @override
  String get authUseDifferentEmail => 'Käytä eri sähköpostia';

  @override
  String get habitGoalsTitle => 'Tapatavoitteet';

  @override
  String get goalsProteins => 'Proteiinit';

  @override
  String get goalsFibers => 'Kuidut';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g päivässä';
  }

  @override
  String get goalsWater => 'Vesi';

  @override
  String goalsLitersPerDay(Object value) {
    return '$value l päivässä';
  }

  @override
  String get goalsExercise => 'Liikunta';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min päivässä';
  }

  @override
  String get goalsMeals => 'Ateriat';

  @override
  String get goalsCalories => 'Kalorit';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'viikossa';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count ateriaa päivässä';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal päivässä';
  }

  @override
  String get goalsWeight => 'Paino';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Kirjaa paino ja annos laskeaksesi tahdin.';

  @override
  String get goalsAlreadyAtThisTarget => 'Olet jo tässä tavoitteessa';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/viikko tavoitteeseen';
  }

  @override
  String get goalsSetTargetForNextWeek => 'Aseta tavoite seuraavalle viikolle.';

  @override
  String get progressWeightTitle => 'Paino';

  @override
  String get progressWeightLabel => 'Paino ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'Terve painoindeksi (BMI)';

  @override
  String get progressTotal => 'Yhteensä';

  @override
  String get progressPercent => 'Prosentti';

  @override
  String get progressWeeklyAvg => 'Viikkokeskiarvo';

  @override
  String get progressRangeAllTime => 'Koko aika';

  @override
  String get progressRange1Month => '1 kuukausi';

  @override
  String get progressRange3Months => '3 kuukautta';

  @override
  String get progressRange6Months => '6 kuukautta';

  @override
  String get progressLow => 'Matala';

  @override
  String get progressMed => 'Keskitaso';

  @override
  String get progressHigh => 'Korkea';

  @override
  String get progressSeverity => 'Vakavuus';

  @override
  String get progressBad => 'Huono';

  @override
  String get progressOkay => 'Ok';

  @override
  String get progressGood => 'Hyvä';

  @override
  String get progressGreat => 'Loistava';

  @override
  String get progressMostlyBad => 'Enimmäkseen huono';

  @override
  String get progressMostlyOkay => 'Enimmäkseen ok';

  @override
  String get progressMostlyGood => 'Enimmäkseen hyvä';

  @override
  String get progressMostlyGreat => 'Enimmäkseen loistava';

  @override
  String get progressNoDose => 'Ei annosta';

  @override
  String get progressLogged => 'Kirjattu';

  @override
  String get progressAllClear => 'Kaikki kunnossa';

  @override
  String get progressFreq => 'Useus';

  @override
  String get progressAverage => 'Keskiarvo';

  @override
  String get progressDaily => 'Päivittäin';

  @override
  String get progressWeekly => 'Viikoittain';

  @override
  String get progressMinutes => 'Minuutit';

  @override
  String get progressIntensity => 'Intensiteetti';

  @override
  String get progressCalories => 'Kalorit';

  @override
  String get progressByDose => 'Annoskohtaisesti';

  @override
  String get progressWeightProgressTitle => 'Painon edistyminen';

  @override
  String get progressWaterProgressTitle => 'Veden edistyminen';

  @override
  String get progressExerciseProgressTitle => 'Liikunnan edistyminen';

  @override
  String get progressDoseProgressTitle => 'Annosten edistyminen';

  @override
  String get progressMealsProgressTitle => 'Aterioiden edistyminen';

  @override
  String get progressSymptomsProgressTitle => 'Oireiden edistyminen';

  @override
  String get progressMoodProgressTitle => 'Mielen edistyminen';

  @override
  String get progressWeightChangeTitle => 'Painon muutos';

  @override
  String get progressTitle => 'Edistyminen';

  @override
  String get progressMenuViewAllInsights => 'Näytä kaikki analyysit';

  @override
  String get progressMenuViewAllCharts => 'Näytä kaikki kaaviot';

  @override
  String get progressMenuCreateDoctorReport => 'Luo lääkäriraportti';

  @override
  String get progressReportGenerating => 'Raporttiasi luodaan…';

  @override
  String get progressReportError =>
      'Raportin luominen epäonnistui. Yritä uudelleen.';

  @override
  String get progressReportPendingRetry =>
      'Raporttisi saattaa valmistua aivan pian. Yritä uudelleen.';

  @override
  String get progressReportOpenError =>
      'Raporttisi luotiin, mutta emme voineet avata sitä. Yritä uudelleen.';

  @override
  String get progressReportOpenedInBrowser =>
      'Raportti on valmis. Avattu selaimessasi.';

  @override
  String get progressReportCopiedLink =>
      'Raportti on valmis. Jakaminen ei ollut käytettävissä, joten linkki kopioitiin leikepöydällesi.';

  @override
  String get progressAllProgressTitle => 'Kaikki edistyminen';

  @override
  String get progressWeightTrendExplanation =>
      'Näe, miten painosi muuttuu ajan myötä.';

  @override
  String get progressNoWeightLogsYet => 'Painokirjauksia ei vielä ole';

  @override
  String get progressNoLogsYet => 'Kirjauksia ei vielä ole';

  @override
  String get progressLogWeightToStartTrend =>
      'Kirjaa paino aloittaaksesi trendin.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Kirjaa paino ja annos vertaillaksesi muutosta.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Jokainen piste on väritetty viimeisimmän annoksen mukaan.';

  @override
  String get progressNoHydrationYet => 'Nesteytyskirjauksia ei vielä ole';

  @override
  String get progressNoMovementYet => 'Liikuntakirjauksia ei vielä ole';

  @override
  String get progressNoDoseLogsYet => 'Annoskirjauksia ei vielä ole';

  @override
  String get progressNoMealsLoggedYet => 'Ateriakirjauksia ei vielä ole';

  @override
  String get progressNoSymptomsLoggedYet => 'Oirekirjauksia ei vielä ole';

  @override
  String get progressNoMoodLogsYet => 'Mielialakirjauksia ei vielä ole';

  @override
  String get progressFutureTrendTitle => 'Tuleva trendi';

  @override
  String get progressFutureTrendBody => 'Kaunis aikajana vauhdillesi';

  @override
  String get progressGoal => 'Tavoite';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Viimeisin kirjattu paino on valmis seurantaan.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Noin $gap $unit tavoitteesta.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText verrattuna edelliseen kirjaukseen.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText verrattuna edelliseen kirjaukseen. $gap $unit tavoitteeseen.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Verrattuna edelliseen kirjaukseen trendi on nyt selvä.';

  @override
  String get progressWaterTitle => 'Vesi';

  @override
  String get manageSubscriptionTitle => 'Hallitse tilausta';

  @override
  String get manageSubscriptionProPlan => 'Pro-tilaus';

  @override
  String get manageSubscriptionFreePlan => 'Ilmainen tilaus';

  @override
  String get manageSubscriptionActiveCopy => 'Tilauksesi on aktiivinen.';

  @override
  String get manageSubscriptionUpgradeCopy => 'Päivitä avataksesi Glu Pro:n.';

  @override
  String get manageSubscriptionPlan => 'Tilaus';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Ilmainen';

  @override
  String get manageSubscriptionProduct => 'Tuote';

  @override
  String get manageSubscriptionRenewal => 'Uusiminen';

  @override
  String get manageSubscriptionStatus => 'Tila';

  @override
  String get manageSubscriptionStatusActive => 'Aktiivinen';

  @override
  String get manageSubscriptionStatusInactive => 'Ei aktiivinen';

  @override
  String get manageSubscriptionManageButton => 'Hallitse tilausta';

  @override
  String get manageSubscriptionUpgradeButton => 'Päivitä Prohon';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Avaa kaupan tilausasetukset';

  @override
  String get manageSubscriptionProBadge => 'Pro';

  @override
  String get manageSubscriptionRestorePurchases => 'Palauta ostokset';

  @override
  String get manageSubscriptionRenewsAutomatically =>
      'Uusiutuu automaattisesti';

  @override
  String get manageSubscriptionLifetime => 'Elinikäinen';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Uusiutuu $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Päättyy $date';
  }

  @override
  String get supplementReminderDayMon => 'Ma';

  @override
  String get supplementReminderDayTue => 'Ti';

  @override
  String get supplementReminderDayWed => 'Ke';

  @override
  String get supplementReminderDayThu => 'To';

  @override
  String get supplementReminderDayFri => 'Pe';

  @override
  String get supplementReminderDaySat => 'La';

  @override
  String get supplementReminderDaySun => 'Su';

  @override
  String supplementReminderInDays(Object count) {
    return '$count päivän päästä';
  }

  @override
  String get supplementReminderInOneWeek => '1 viikon päästä';

  @override
  String supplementReminderInWeeks(Object count) {
    return '$count viikon päästä';
  }

  @override
  String get subscriptionDebugTitle => 'Glu-tilauksen vianetsintä';

  @override
  String get subscriptionDebugMonthly => 'Kuukausi';

  @override
  String get subscriptionDebugYearly => 'Vuosi';

  @override
  String get subscriptionDebugRefreshCustomerInfo => 'Päivitä asiakastiedot';

  @override
  String get subscriptionDebugPresentPaywall => 'Näytä maksuseinä';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Avaa asiakaskeskus';

  @override
  String get subscriptionDebugRestorePurchases => 'Palauta ostokset';

  @override
  String get subscriptionDebugSyncPurchases => 'Synkronoi ostokset';

  @override
  String get subscriptionDebugRevenuecatStatus => 'RevenueCatin tila';

  @override
  String get subscriptionDebugConfigured => 'Määritetty';

  @override
  String get subscriptionDebugBusy => 'Varattu';

  @override
  String get subscriptionDebugAppUserId => 'Sovelluksen käyttäjä-ID';

  @override
  String get subscriptionDebugAnonymous => 'nimetön';

  @override
  String get subscriptionDebugApiKeyAvailable => 'API-avain saatavilla';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro aktiivinen';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Aktiiviset tilaukset';

  @override
  String get subscriptionDebugManagementUrl => 'Hallinta-URL';

  @override
  String get subscriptionDebugEntitlementProduct => 'Oikeustuote';

  @override
  String get subscriptionDebugWillRenew => 'Uusiutuu';

  @override
  String get subscriptionDebugExpiration => 'Vanhentuminen';

  @override
  String get subscriptionDebugLifetime => 'elinikäinen';

  @override
  String get subscriptionDebugPackageFound => 'Paketti löytyi';

  @override
  String get subscriptionDebugProductId => 'Tuotetunnus';

  @override
  String get subscriptionDebugTitleLabel => 'Otsikko';

  @override
  String get subscriptionDebugPrice => 'Hinta';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Osta $title';
  }

  @override
  String get progressExerciseTitle => 'Liikunta';

  @override
  String get progressDoseTitle => 'Annos';

  @override
  String get progressMealsTitle => 'Ateriat';

  @override
  String get progressSymptomsTitle => 'Oireet';

  @override
  String get progressMoodTitle => 'Mieli';

  @override
  String get progressTrend => 'Trendi';

  @override
  String get progressTarget => 'Tavoite';

  @override
  String get progressNoTrendYet => 'Trenditietoa ei vielä ole';

  @override
  String get progressNoActivityYet => 'Toimintaa ei vielä ole';

  @override
  String get progressNoCheckInsYet => 'Tarkistuksia ei vielä ole';

  @override
  String get progressWeightSignatureChip => 'Painosta tulee tunnuskaaviosi';

  @override
  String get progressWeightStartTrendTitle =>
      'Aloita trendi ensimmäisellä painomittauksella';

  @override
  String get progressWeightStartTrendBody =>
      'Tämä kaavio on edistymistarinasi keskipiste. Kirjaa ensimmäinen painosi avataksesi vauhdin, virstanpylväät ja jaettavan näkymän.';

  @override
  String get progressWeightMomentum => 'Painon vauhti';

  @override
  String get progressWeightMilestones => 'Virstanpylväät';

  @override
  String get progressWeightShareReady => 'Valmis jaettavaksi';

  @override
  String get progressWeightLogWeight => 'Kirjaa paino';

  @override
  String get weightProgressUnlocksViewChip =>
      'Ensimmäinen painomittaus avaa tämän näkymän';

  @override
  String get weightProgressStartsHereTitle => 'Edistymistarinasi alkaa tästä';

  @override
  String get weightProgressStartsHereBody =>
      'Kirjaa ensimmäinen painosi avataksesi trendit, virstanpylväät ja annostietoiset analyysit jaettavassa näkymässä.';

  @override
  String get weightProgressTrendView => 'Trendinäkymä';

  @override
  String get weightProgressDoseOverlays => 'Annoskerrokset';

  @override
  String get weightProgressMilestones => 'Virstanpylväät';

  @override
  String get weightProgressLogWeight => 'Kirjaa paino';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Lisää ensin sekä ennen- että jälkeen-kuva.';

  @override
  String get glowUpSavedToGallery => 'Tallennettu galleriaasi';

  @override
  String get glowUpSaveToGallery => 'Tallenna galleriaan';

  @override
  String get glowUpYourProgress => 'Edistymisesi';

  @override
  String get glowUpWeightChange => 'Painon muutos';

  @override
  String get glowUpTime => 'Aika';

  @override
  String get glowUpShare => 'Share';

  @override
  String get glowUpBefore => 'BEFORE';

  @override
  String get glowUpAfter => 'AFTER';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight $time aikana';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'päivät';

  @override
  String get glowUpTimeUnitWeeksLabel => 'viikot';

  @override
  String get glowUpTimeUnitMonthsLabel => 'kuukaudet';

  @override
  String get glowUpTimeUnitYearsLabel => 'vuodet';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count päivää',
      one: '$count päivä',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueWeeks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count viikkoa',
      one: '$count viikko',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kuukautta',
      one: '$count kuukausi',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count vuotta',
      one: '$count vuosi',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Eilen';

  @override
  String get commonSelect => 'Valitse';

  @override
  String get doseReminderTitle => 'Annosmuistutus';

  @override
  String get doseReminderCustomDoseTitle => 'Mukautettu annos';

  @override
  String get doseReminderCustomDoseHint => 'Kirjoita annos mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Pidä seuraava annoksesi valmiina etusivulla.';

  @override
  String get doseReminderTime => 'Aika';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Ota tämä käyttöön näyttääksesi seuraavan annoksen etusivulla.';

  @override
  String get doseReminderSaveReminder => 'Tallenna muistutus';

  @override
  String loggedOn(Object date) {
    return 'Kirjattu $date';
  }

  @override
  String get waterLogSmallGlass => 'Pieni lasi';

  @override
  String get waterLogGlass => 'Lasi';

  @override
  String get waterLogBottle => 'Pullo';

  @override
  String get waterLogLargeBottle => 'Iso pullo';

  @override
  String get waterLogTwoLiters => '2 l';

  @override
  String get waterLogCustomPreset => 'Mukautettu';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Annos';

  @override
  String get doseLogEditTitle => 'Muokkaa annosta';

  @override
  String get doseLogLogTitle => 'Kirjaa annos';

  @override
  String get doseLogCustomDose => 'Mukautettu annos';

  @override
  String get doseLogCustomDoseBody =>
      'Säädä tämän kirjauksen annos milligrammoina.';

  @override
  String get doseLogUseThisDose => 'Käytä tätä annosta';

  @override
  String get doseLogMedication => 'Lääkitys';

  @override
  String get doseLogInjectionSite => 'Kohta';

  @override
  String get doseLogNotes => 'Muistiinpanot';

  @override
  String get doseLogSaveChanges => 'Tallenna muutokset';

  @override
  String get doseLogAddDose => '+ Kirjaa annos';

  @override
  String get doseLogDeleteTitle => 'Poistetaanko tämä annoskirjaus?';

  @override
  String get doseLogDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get doseLogDeleteLog => 'Poista kirjaus';

  @override
  String get doseLogSaving => 'Tallennetaan...';

  @override
  String get doseLogCouldNotSave =>
      'Tätä annoskirjausta ei voitu tallentaa nyt.';

  @override
  String get doseLogCouldNotDelete =>
      'Tätä annoskirjausta ei voitu poistaa nyt.';

  @override
  String get doseLogDeleted => 'Annos poistettu';

  @override
  String get doseLogAddedToDoseLog => 'Lisätty annoslokiin';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Onko tästä annoksesta jotain muistettavaa?';

  @override
  String get doseLogDoseLabel => 'Annos';

  @override
  String get exerciseLogTitle => 'Liikunta';

  @override
  String get exerciseLogEditTitle => 'Muokkaa liikuntaa';

  @override
  String get exerciseLogLogTitle => 'Liikuntakirjaus';

  @override
  String get exerciseLogActivityType => 'Aktiviteetin tyyppi';

  @override
  String get exerciseLogCustomActivity => 'Mukautettu aktiviteetti';

  @override
  String get exerciseLogTypeActivity => 'Kirjoita aktiviteetti';

  @override
  String get exerciseLogDuration => 'Kesto';

  @override
  String get exerciseLogIntensity => 'Intensiteetti';

  @override
  String get exerciseLogNotes => 'Muistiinpanot';

  @override
  String get exerciseLogLight => 'Kevyt';

  @override
  String get exerciseLogModerate => 'Keskitaso';

  @override
  String get exerciseLogIntense => 'Rasittava';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes minuuttia kirjattu';
  }

  @override
  String get exerciseLogSaveChanges => 'Tallenna muutokset';

  @override
  String get exerciseLogAddExercise => '+ Lisää liikuntakirjaus';

  @override
  String get exerciseLogDeleteTitle => 'Poistetaanko tämä liikuntakirjaus?';

  @override
  String get exerciseLogDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get exerciseLogDeleteLog => 'Poista kirjaus';

  @override
  String get exerciseLogSaving => 'Tallennetaan...';

  @override
  String get exerciseLogCouldNotSave =>
      'Tätä liikuntakirjausta ei voitu tallentaa nyt.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Tätä liikuntakirjausta ei voitu poistaa nyt.';

  @override
  String get exerciseLogDeleted => 'Aktiviteetti poistettu';

  @override
  String get exerciseLogAddedToExerciseLog => 'Lisätty liikuntalokiin';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Onko tästä harjoituksesta jotain muistettavaa?';

  @override
  String get exerciseLogWalking => 'Kävely';

  @override
  String get exerciseLogRunning => 'Juoksu';

  @override
  String get exerciseLogCycling => 'Pyöräily';

  @override
  String get exerciseLogStrength => 'Voima';

  @override
  String get exerciseLogYoga => 'Jooga';

  @override
  String get exerciseLogSwim => 'Uinti';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Paino';

  @override
  String get weightLogEditTitle => 'Muokkaa painoa';

  @override
  String get weightLogLogTitle => 'Painokirjaus';

  @override
  String get weightLogSaveChanges => 'Tallenna muutokset';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Lisää paino ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Poistetaanko tämä painokirjaus?';

  @override
  String get weightLogDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get weightLogDeleteLog => 'Poista kirjaus';

  @override
  String get weightLogSaving => 'Tallennetaan...';

  @override
  String get weightLogCouldNotSave =>
      'Tätä painokirjausta ei voitu tallentaa nyt.';

  @override
  String get weightLogCouldNotDelete =>
      'Tätä painokirjausta ei voitu poistaa nyt.';

  @override
  String get weightLogDeleted => 'Paino poistettu';

  @override
  String get weightLogAddedToWeightLog => 'Lisätty painolokiin';

  @override
  String get weightLogNoWeightForDay =>
      'Tälle päivälle ei ole vielä kirjattu painoa.';

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
  String get injectionSiteAbdomenUpperRight => 'Abdomen, upper right';

  @override
  String get injectionSiteAbdomenLowerRight => 'Abdomen, lower right';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Abdomen, lower left';

  @override
  String get injectionSiteThighUpperLeft => 'Thigh, upper left';

  @override
  String get injectionSiteThighUpperRight => 'Thigh, upper right';

  @override
  String get injectionSiteThighLowerRight => 'Thigh, lower right';

  @override
  String get injectionSiteThighLowerLeft => 'Thigh, lower left';

  @override
  String get injectionSiteUpperArmLeft => 'Upper arm, left';

  @override
  String get injectionSiteUpperArmRight => 'Upper arm, right';

  @override
  String get injectionSiteButtocksUpperLeft => 'Buttocks, upper left';

  @override
  String get injectionSiteButtocksUpperRight => 'Buttocks, upper right';

  @override
  String get doseReminderFormat => 'Muoto';

  @override
  String get doseReminderInjection => 'Pistos';

  @override
  String get doseReminderPill => 'Pilleri';

  @override
  String get doseReminderSite => 'Kohta';

  @override
  String get doseReminderDate => 'Päivämäärä';

  @override
  String get supplementReminderTitle => 'Lisäravinnemuistutus';

  @override
  String get supplementReminderAddSupplement => 'Lisää lisäravinne';

  @override
  String get supplementReminderNoSupplementsYet => 'Ei vielä lisäravinteita';

  @override
  String get supplementReminderAddFirstBody =>
      'Lisää ensimmäinen lisäravinnemuistutuksesi seurataksesi päivittäistä saantia.';

  @override
  String get supplementReminderSupplementFallback => 'Lisäravinne';

  @override
  String get supplementReminderEveryDay => 'Joka päivä';

  @override
  String get supplementReminderEveryXDaysLabel => 'Joka X. päivä';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'Joka $interval. päivä';
  }

  @override
  String get supplementReminderNoDaysSet => 'Päiviä ei asetettu';

  @override
  String get supplementReminderSupplementName => 'Lisäravinteen nimi';

  @override
  String get supplementReminderTime => 'Aika';

  @override
  String get supplementReminderStartDate => 'Aloituspäivä';

  @override
  String get supplementReminderRepeat => 'Toista';

  @override
  String get supplementReminderDaysOfWeek => 'Viikonpäivät';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Valitse ainakin yksi päivä.';

  @override
  String get supplementReminderEvery => 'Joka';

  @override
  String get supplementReminderDay => 'päivä';

  @override
  String get supplementReminderDays => 'päivää';

  @override
  String get supplementReminderAdd => 'Lisää';

  @override
  String get symptomsLogTitle => 'Oireet';

  @override
  String get symptomsLogEditTitle => 'Muokkaa oireita';

  @override
  String get symptomsLogLogTitle => 'Oirekirjaus';

  @override
  String get symptomsLogSymptomsExperienced => 'Kokemasi oireet';

  @override
  String get symptomsLogNoSymptoms => 'Ei oireita';

  @override
  String get symptomsLogNoSymptomsToday => 'Ei oireita tänään';

  @override
  String get symptomsLogOther => 'Muu...';

  @override
  String get symptomsLogSeverityLevel => 'Vakavuustaso';

  @override
  String get symptomsLogNotes => 'Muistiinpanot';

  @override
  String get symptomsLogAnxiety => 'Ahdistus';

  @override
  String get symptomsLogBelching => 'Röyhtäily';

  @override
  String get symptomsLogBloating => 'Turvotus';

  @override
  String get symptomsLogConstipation => 'Ummetus';

  @override
  String get symptomsLogDiarrhea => 'Ripuli';

  @override
  String get symptomsLogFatigue => 'Väsymys';

  @override
  String get symptomsLogFoodNoise => 'Ruokahäly';

  @override
  String get symptomsLogHairLoss => 'Hiustenlähtö';

  @override
  String get symptomsLogHeartburn => 'Närästys';

  @override
  String get symptomsLogIndigestion => 'Ruuansulatusvaivat';

  @override
  String get symptomsLogInjectionSiteReaction => 'Pistoskohdan reaktio';

  @override
  String get symptomsLogMetallicTaste => 'Metallinen maku';

  @override
  String get symptomsLogHeadache => 'Päänsärky';

  @override
  String get symptomsLogMoodSwings => 'Mielialan vaihtelut';

  @override
  String get symptomsLogNausea => 'Pahoinvointi';

  @override
  String get symptomsLogReflux => 'Refluksi';

  @override
  String get symptomsLogStomachPain => 'Vatsakipu';

  @override
  String get symptomsLogSuppressedAppetite => 'Heikentynyt ruokahalu';

  @override
  String get symptomsLogVomiting => 'Oksentelu';

  @override
  String get symptomsLogLogged => 'Oire kirjattu';

  @override
  String get symptomsLogMild => 'Lievä';

  @override
  String get symptomsLogModerate => 'Keskivaikea';

  @override
  String get symptomsLogSevere => 'Vaikea';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Onko tuntemuksissasi jotain muistettavaa?';

  @override
  String get symptomsLogSaveChanges => 'Tallenna muutokset';

  @override
  String get symptomsLogAddSymptoms => '+ Lisää oirekirjaus';

  @override
  String get symptomsLogDeleteTitle => 'Poistetaanko tämä oirekirjaus?';

  @override
  String get symptomsLogDeleteMessage => 'Tätä toimintoa ei voi perua.';

  @override
  String get symptomsLogDeleteLog => 'Poista kirjaus';

  @override
  String get symptomsLogSaving => 'Tallennetaan...';

  @override
  String get symptomsLogCouldNotSave =>
      'Tätä oirekirjausta ei voitu tallentaa nyt.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Tätä oirekirjausta ei voitu poistaa nyt.';

  @override
  String get symptomsLogDeleted => 'Oire poistettu';

  @override
  String get symptomsLogAddedToSymptomsLog => 'Lisätty oirelokiin';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% päivittäisestä tavoitteesta';
  }

  @override
  String get commonDisclaimer =>
      'Glu on seurantasovellus, ei lääkinnällinen laite. Se ei anna lääketieteellistä neuvontaa, diagnoosia tai hoitoa. Kysy aina lääkäriltäsi lääkityksestäsi ja terveyteen liittyvistä päätöksistä.';
}
