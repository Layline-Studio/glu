// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Glu';

  @override
  String get startupWakingUp => 'Acordando...';

  @override
  String get startupFailed => 'Falha ao iniciar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonSaving => 'Salvando...';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonNotNow => 'Agora não';

  @override
  String get commonNow => 'Agora';

  @override
  String get commonTomorrow => 'Amanhã';

  @override
  String get noteTriggerAddNote => 'Adicionar nota';

  @override
  String get noteTriggerCancelNote => 'Cancelar nota';

  @override
  String homeDoseReminderInDays(Object count) {
    return 'Em $count dias';
  }

  @override
  String get homeDoseReminderInOneWeek => 'Em 1 semana';

  @override
  String homeDoseReminderInWeeks(Object count) {
    return 'Em $count semanas';
  }

  @override
  String get homeDoseReminderDueOneDayAgo => 'Há 1 dia';

  @override
  String homeDoseReminderDueDaysAgo(Object count) {
    return 'Há $count dias';
  }

  @override
  String get homeDoseReminderDueOneWeekAgo => 'Há 1 semana';

  @override
  String homeDoseReminderDueWeeksAgo(Object count) {
    return 'Há $count semanas';
  }

  @override
  String get bmiIndicatorYourBmi => 'Seu IMC';

  @override
  String get bmiIndicatorCurrentBmi => 'Seu IMC atual';

  @override
  String get bmiIndicatorUnderweight => 'Abaixo do peso';

  @override
  String get bmiIndicatorNormal => 'Normal';

  @override
  String get bmiIndicatorOverweight => 'Sobrepeso';

  @override
  String get bmiIndicatorObesity => 'Obesidade';

  @override
  String get heightRulerCmUnit => 'cm';

  @override
  String get heightRulerFtUnit => 'pés';

  @override
  String get heightRulerInUnit => 'pol';

  @override
  String get heightRulerFtInUnit => 'pés/pol';

  @override
  String get weightDialKgUnit => 'kg';

  @override
  String get weightDialLbUnit => 'lb';

  @override
  String get logNoteIndicatorHasNote => 'Tem nota';

  @override
  String get paywallTitle => 'Desbloqueie o Glu Pro';

  @override
  String get paywallSubtitle => 'Sem o Pro, é isso que você perde:';

  @override
  String get paywallMonthlyTitle => 'Mensal';

  @override
  String get paywallMonthlySubtitle => 'Sem teste';

  @override
  String get paywallYearlyTitle => 'Anual';

  @override
  String get paywallYearlySubtitle => 'Teste grátis de 7 dias';

  @override
  String get paywallNoCommitment => 'Sem compromisso';

  @override
  String get paywallCancelAnytime => 'Cancele quando quiser';

  @override
  String get paywallContinue => 'Continuar';

  @override
  String get paywallRestore => 'Restaurar';

  @override
  String get paywallTerms => 'Termos';

  @override
  String get paywallPrivacy => 'Privacidade';

  @override
  String get paywallSeparator => '•';

  @override
  String paywallSavePercent(Object percent) {
    return 'Economize $percent%';
  }

  @override
  String get paywallCouldNotOpenLink => 'Não foi possível abrir o link agora.';

  @override
  String get paywallAlreadySubscribed => 'Você já tem o Glu Pro.';

  @override
  String get paywallPurchaseSuccess => 'Bem-vindo ao Glu Pro!';

  @override
  String get paywallPurchaseIncomplete =>
      'A compra não foi concluída. Tente novamente.';

  @override
  String get paywallPurchaseFailed => 'Falha na compra. Tente novamente.';

  @override
  String paywallPurchaseFailedWithCode(Object errorCode) {
    return 'Falha na compra: $errorCode';
  }

  @override
  String get paywallRestoreSuccess => 'Assinatura restaurada!';

  @override
  String get paywallRestoreNoSubscription =>
      'Nenhuma assinatura ativa encontrada.';

  @override
  String get paywallRestoreFailed => 'Falha ao restaurar. Tente novamente.';

  @override
  String get paywallBenefitReminders => 'Doses esquecidas sem lembretes';

  @override
  String get paywallBenefitShareProgress =>
      'Mais difícil compartilhar seu progresso';

  @override
  String get paywallBenefitSpotRegain =>
      'Sinais de reganho passam despercebidos';

  @override
  String get paywallBenefitInsights =>
      'Seus padrões diários passam despercebidos';

  @override
  String get paywallBenefitWeeklyGoals => 'Perde sua estrutura semanal';

  @override
  String get paywallBenefitHealthyHabits => 'Hábitos enfraquecem sem apoio';

  @override
  String get onboardingWelcomeTitle => 'Mantenha o peso sob controle';

  @override
  String get onboardingWelcomeSubtitle =>
      'O Glu ajuda você a proteger seu progresso com o tratamento, metas e hábitos semanais.';

  @override
  String get onboardingWelcomeBullet1 =>
      'Combina com seu tratamento e suas metas';

  @override
  String get onboardingWelcomeBullet2 => 'Apoio simples e realista';

  @override
  String get onboardingWelcomeBullet3 =>
      'Perceba cedo os sinais de reganho de peso';

  @override
  String get onboardingWelcomeBullet4 => 'Continue sem começar do zero';

  @override
  String get onboardingMedicationStatusQuestion =>
      'Você está tomando algum medicamento em caneta ou comprimido para emagrecer?';

  @override
  String get onboardingMedicationStatusExplainer =>
      'Usamos isso para mostrar orientações que combinam com sua fase atual.';

  @override
  String get onboardingMedicationStatusUsing => 'Sim, estou tomando';

  @override
  String get onboardingMedicationStatusWeaningOff => 'Sim, estou reduzindo';

  @override
  String get onboardingMedicationStatusNotTaking => 'Não, não estou tomando';

  @override
  String get onboardingMedicationStatusStartingSoon =>
      'Não, vou começar em breve';

  @override
  String get onboardingMedicationStatusRecentlyStopped =>
      'Não, parei recentemente';

  @override
  String get onboardingMedicationMethodQuestion =>
      'Como você toma seu medicamento?';

  @override
  String get onboardingMedicationMethodExplainer =>
      'Usamos isso para adaptar instruções e lembretes ao formato do seu medicamento.';

  @override
  String get onboardingMedicationMethodInjection => 'Injeção';

  @override
  String get onboardingMedicationMethodPill => 'Comprimido';

  @override
  String get onboardingMedicationMethodUnknown => 'Ainda não sei';

  @override
  String get onboardingMedicationNameQuestion =>
      'Qual medicamento você está tomando?';

  @override
  String get onboardingMedicationNameExplainer =>
      'Usamos isso para personalizar o acompanhamento de dose e orientações específicas.';

  @override
  String get onboardingCurrentDoseQuestion => 'Qual é a sua dose atual?';

  @override
  String get onboardingCurrentDoseExplainer =>
      'Usamos isso para personalizar o acompanhamento da dose e revisões futuras.';

  @override
  String get onboardingMedicationCustomDose => 'Personalizada';

  @override
  String get onboardingDeviceTypeQuestion =>
      'Que dispositivo você usa para tomar o medicamento?';

  @override
  String get onboardingDeviceTypeExplainer =>
      'Usamos isso para deixar lembretes e dicas de acordo com a forma como você toma.';

  @override
  String get onboardingDeviceSinglePen => 'Caneta única';

  @override
  String get onboardingDeviceAutoInjector => 'Auto-injetor';

  @override
  String get onboardingDeviceSyringeAndVial => 'Seringa e frasco';

  @override
  String get onboardingOther => 'Outro';

  @override
  String get onboardingTypeYourDevice => 'Digite seu dispositivo';

  @override
  String get onboardingMedicationFrequencyQuestion =>
      'Com que frequência você toma o medicamento?';

  @override
  String get onboardingMedicationFrequencyExplainer =>
      'Usamos isso para ajustar os lembretes e o suporte à rotina ao seu horário.';

  @override
  String get onboardingEveryDay => 'Todos os dias';

  @override
  String get onboardingEvery7Days => 'A cada 7 dias';

  @override
  String get onboardingEvery14Days => 'A cada 14 dias';

  @override
  String get onboardingCustom => 'Personalizado';

  @override
  String get onboardingDaysBetweenDoses => 'Dias entre doses';

  @override
  String get onboardingPrimaryGoalQuestion =>
      'Qual é sua meta principal agora?';

  @override
  String get onboardingPrimaryGoalExplainerWithMedication =>
      'Usamos isso para focar seu plano, lembretes e progresso no que mais importa para você.';

  @override
  String get onboardingPrimaryGoalExplainerWithoutMedication =>
      'Usamos isso para moldar seu plano desde o começo.';

  @override
  String get onboardingPrimaryGoalExplainerDefault =>
      'Usamos isso para apoiar sua próxima fase e ajudar você a manter o ritmo.';

  @override
  String get onboardingGoalLoseWeight => 'Perder peso';

  @override
  String get onboardingGoalMaintainWeight => 'Manter meu peso';

  @override
  String get onboardingGoalManageDiabetes => 'Controlar meu diabetes';

  @override
  String get onboardingGoalManagePcos => 'Controlar minha SOP';

  @override
  String get onboardingGoalImproveHeartHealth =>
      'Melhorar minha saúde do coração';

  @override
  String get onboardingAgeQuestion => 'Qual é a sua idade?';

  @override
  String get onboardingAgeExplainer =>
      'Usamos isso para ajustar as orientações e os cálculos de saúde de forma mais adequada.';

  @override
  String get onboardingHeightQuestion => 'Qual é a sua altura?';

  @override
  String get onboardingHeightExplainer =>
      'Usamos isso junto com seu peso para calcular IMC e faixas saudáveis.';

  @override
  String get onboardingWeightQuestion => 'Qual é o seu peso atual?';

  @override
  String get onboardingWeightExplainer =>
      'Usamos isso como ponto de partida para progresso, metas e estimativas de saúde.';

  @override
  String get onboardingMedicationStartedQuestionStopped =>
      'Quando você parou o medicamento?';

  @override
  String get onboardingMedicationStartedQuestionWeaning =>
      'Quando você começou a reduzir o medicamento?';

  @override
  String get onboardingMedicationStartedQuestionStarted =>
      'Quando você começou o medicamento?';

  @override
  String get onboardingMedicationStartedExplainerStopped =>
      'Usamos isso para entender seu histórico recente e a próxima fase.';

  @override
  String get onboardingMedicationStartedExplainerWeaning =>
      'Usamos isso para entender sua fase de transição e apoiar os hábitos mais importantes agora.';

  @override
  String get onboardingMedicationStartedExplainerStarted =>
      'Usamos isso para entender há quanto tempo você está em tratamento e acompanhar a evolução.';

  @override
  String get onboardingGoalWeightQuestion => 'Qual é o seu peso-alvo?';

  @override
  String get onboardingGoalWeightExplainer =>
      'Usamos isso para enquadrar o progresso e mostrar uma faixa de IMC alvo para você.';

  @override
  String get onboardingBenefitsQuestion =>
      'O que o Glu vai te ajudar a fazer a seguir';

  @override
  String get onboardingBenefitsExplainer =>
      'O Glu transforma o que você compartilhou em lembretes, apoio e estrutura que combinam com sua rotina.';

  @override
  String get onboardingBenefitsHeroMaintainWeightTitle =>
      'Veja como o Glu pode ajudar você a manter seu progresso';

  @override
  String get onboardingBenefitsHeroDiabetesTitle =>
      'Veja como o Glu pode apoiar sua rotina de diabetes';

  @override
  String get onboardingBenefitsHeroPcosTitle =>
      'Veja como o Glu pode apoiar sua rotina de SOP';

  @override
  String get onboardingBenefitsHeroHeartTitle =>
      'Veja como o Glu pode apoiar sua saúde do coração';

  @override
  String get onboardingBenefitsHeroWeightLossTitle =>
      'Veja como o Glu pode ajudar você a emagrecer';

  @override
  String get onboardingBenefitsHeroMaintainWeightBody =>
      'Veja como o Glu ajuda você a proteger seu peso atual e perceber o reganho cedo.';

  @override
  String get onboardingBenefitsHeroDiabetesBody =>
      'Veja como o Glu ajuda você a manter refeições, peso e rotina mais estáveis semana a semana.';

  @override
  String get onboardingBenefitsHeroPcosBody =>
      'Veja como o Glu ajuda você a ficar mais estável com sintomas, peso e rotina.';

  @override
  String get onboardingBenefitsHeroHeartBody =>
      'Veja como o Glu ajuda você a manter hábitos que apoiam a saúde do coração.';

  @override
  String get onboardingBenefitsHeroWeightLossBody =>
      'Veja como o Glu ajuda você a notar os padrões que mantêm o peso em movimento para baixo.';

  @override
  String get onboardingBenefitsSpecificMaintainWeight =>
      'Sem estrutura, o reganho pode crescer em silêncio. O Glu ajuda você a perceber isso antes e manter a estabilidade.';

  @override
  String get onboardingBenefitsSpecificDiabetes =>
      'Sem estrutura, refeições e peso ficam mais difíceis de interpretar. O Glu deixa os sinais mais claros.';

  @override
  String get onboardingBenefitsSpecificPcos =>
      'Sem estrutura, sintomas e rotina podem oscilar mais. O Glu ajuda você a ficar mais estável.';

  @override
  String get onboardingBenefitsSpecificHeart =>
      'Sem estrutura, hábitos saudáveis se perdem. O Glu ajuda você a manter atividade e peso no caminho certo.';

  @override
  String get onboardingBenefitsSpecificWeightLoss =>
      'Sem estrutura, o peso pode estagnar ou subir. O Glu ajuda a manter o progresso na direção certa.';

  @override
  String get onboardingBenefitsAxisWeight => 'Peso';

  @override
  String get onboardingBenefitsAxisMealsWeight => 'Refeições e peso';

  @override
  String get onboardingBenefitsAxisSymptomsWeight => 'Sintomas e peso';

  @override
  String get onboardingBenefitsAxisExerciseWeight => 'Exercício e peso';

  @override
  String get onboardingNotificationsQuestion =>
      'Ative lembretes que apoiam sua meta';

  @override
  String get onboardingNotificationsExplainer =>
      'Usaremos notificações para ajudar você a manter consistência, preparo e ritmo.';

  @override
  String get onboardingNotificationsHeadline =>
      'Prepare o Glu para ajudar no momento certo.';

  @override
  String get onboardingNotificationsBody =>
      'Ative notificações para o Glu reforçar os hábitos que apoiam sua meta.';

  @override
  String get onboardingNotificationsDaily =>
      'Lembretes no horário que combinam com sua rotina diária de medicação';

  @override
  String get onboardingNotificationsEvery14Days =>
      'Lembretes com mais antecedência para a dose não te pegar de surpresa';

  @override
  String get onboardingNotificationsCustom =>
      'Lembretes moldados ao seu horário personalizado';

  @override
  String get onboardingNotificationsWeekly =>
      'Lembretes de dose alinhados à sua rotina semanal';

  @override
  String get onboardingNotificationsSupportive =>
      'Lembretes de apoio que mantêm sua rotina visível quando a motivação cai';

  @override
  String get onboardingNotificationsProgress =>
      'Lembretes oportunos sobre progresso, hábitos e as metas que você disse que importam';

  @override
  String get onboardingNotificationsHelpful =>
      'Lembretes úteis que deixam o Glu mais presente nos momentos em que você precisa';

  @override
  String get onboardingDailyRoutineQuestion => 'Como é sua rotina diária?';

  @override
  String get onboardingDailyRoutineExplainer =>
      'Usamos isso para deixar seu plano mais realista para o seu dia a dia.';

  @override
  String get onboardingRoutineSedentary => 'Sedentário';

  @override
  String get onboardingRoutineSedentaryDescription =>
      'Muito tempo sentado, trabalho de mesa e quase nenhum exercício intencional.';

  @override
  String get onboardingRoutineLightlyActive => 'Levemente ativo';

  @override
  String get onboardingRoutineLightlyActiveDescription =>
      'Caminhadas, tarefas do dia a dia ou treinos leves algumas vezes por semana.';

  @override
  String get onboardingRoutineActive => 'Ativo';

  @override
  String get onboardingRoutineActiveDescription =>
      'Movimento frequente ou exercícios, como caminhadas diárias, academia ou trabalho ativo.';

  @override
  String get onboardingRoutineVeryActive => 'Muito ativo';

  @override
  String get onboardingRoutineVeryActiveDescription =>
      'Treinos intensos, trabalho fisicamente exigente ou muita atividade na maioria dos dias.';

  @override
  String get onboardingSymptomConcernsQuestion =>
      'Com quais sintomas você mais se preocupa, se houver?';

  @override
  String get onboardingSymptomConcernsExplainerWithMedication =>
      'Usamos isso para priorizar dicas e orientações sobre os sintomas que mais importam para você.';

  @override
  String get onboardingSymptomConcernsExplainerDefault =>
      'Usamos isso para focar nos sintomas que você quer monitorar com antecedência.';

  @override
  String get onboardingGenderQuestion => 'Como você descreve seu gênero?';

  @override
  String get onboardingGenderExplainer =>
      'Usamos isso para orientações mais relevantes e personalização futura.';

  @override
  String get onboardingGenderFemale => 'Feminino';

  @override
  String get onboardingGenderMale => 'Masculino';

  @override
  String get onboardingGenderPreferNotToSay => 'Prefiro não dizer';

  @override
  String get onboardingTypeYourGender => 'Digite seu gênero';

  @override
  String get onboardingPreferredNameQuestion => 'Como devemos te chamar?';

  @override
  String get onboardingPreferredNameExplainer =>
      'Usamos isso para deixar o Glu mais pessoal quando falamos com você.';

  @override
  String get onboardingPreferredNameHint => 'Alex';

  @override
  String get onboardingSetupSummaryQuestion => 'Montando seu plano';

  @override
  String get onboardingSetupSummaryExplainer =>
      'Estamos transformando o que você compartilhou em um plano que o Glu já pode apoiar.';

  @override
  String get onboardingSetupSummaryMaintainStep1 =>
      'Definindo metas de manutenção de peso...';

  @override
  String get onboardingSetupSummaryMaintainStep2 =>
      'Criando pontos de atenção para reganho...';

  @override
  String get onboardingSetupSummaryMaintainStep3 =>
      'Ajustando lembretes à sua rotina...';

  @override
  String get onboardingSetupSummaryMaintainStep4 =>
      'Preparando um plano semanal mais estável...';

  @override
  String get onboardingSetupSummaryDiabetesStep1 =>
      'Definindo padrões de refeições e peso...';

  @override
  String get onboardingSetupSummaryDiabetesStep2 =>
      'Configurando apoio à hidratação...';

  @override
  String get onboardingSetupSummaryDiabetesStep3 =>
      'Preparando lembretes de consistência...';

  @override
  String get onboardingSetupSummaryDiabetesStep4 =>
      'Criando uma estrutura diária mais clara...';

  @override
  String get onboardingSetupSummaryPcosStep1 =>
      'Organizando o apoio aos sintomas...';

  @override
  String get onboardingSetupSummaryPcosStep2 =>
      'Definindo metas semanais de movimento...';

  @override
  String get onboardingSetupSummaryPcosStep3 =>
      'Criando pontos de apoio para hidratação e rotina...';

  @override
  String get onboardingSetupSummaryPcosStep4 =>
      'Preparando um plano mais estável...';

  @override
  String get onboardingSetupSummaryHeartStep1 =>
      'Definindo metas de atividade...';

  @override
  String get onboardingSetupSummaryHeartStep2 =>
      'Configurando apoio à hidratação...';

  @override
  String get onboardingSetupSummaryHeartStep3 =>
      'Preparando lembretes semanais de hábito...';

  @override
  String get onboardingSetupSummaryHeartStep4 =>
      'Construindo uma rotina para o coração...';

  @override
  String get onboardingSetupSummaryWeightLossStep1 =>
      'Definindo limites de calorias...';

  @override
  String get onboardingSetupSummaryWeightLossStep2 =>
      'Configurando quantidades de água...';

  @override
  String get onboardingSetupSummaryWeightLossStep3 =>
      'Criando metas de exercício...';

  @override
  String get onboardingSetupSummaryWeightLossStep4 =>
      'Preparando seu plano semanal...';

  @override
  String get onboardingSetupSummaryHeadline => 'Seu plano no Glu está pronto.';

  @override
  String get onboardingSetupLoadingTitle => 'Montando seu plano';

  @override
  String get onboardingSetupSummaryMaintainBody =>
      'O Glu está pronto para ajudar você a proteger seu progresso com mais estrutura e sinais mais cedo de reganho.';

  @override
  String get onboardingSetupSummaryDiabetesBody =>
      'O Glu está pronto para apoiar refeições mais estáveis, acompanhamento de peso e hábitos que importam no dia a dia.';

  @override
  String get onboardingSetupSummaryPcosBody =>
      'O Glu está pronto para apoiar rotinas mais estáveis em torno de sintomas, tratamento e progresso.';

  @override
  String get onboardingSetupSummaryHeartBody =>
      'O Glu está pronto para reforçar os hábitos que apoiam sua saúde do coração a longo prazo.';

  @override
  String get onboardingSetupSummaryWeightLossBody =>
      'O Glu está pronto para apoiar as rotinas que ajudam você a manter o peso.';

  @override
  String get onboardingSetupSummaryLabel => 'Resumo';

  @override
  String get onboardingSetupAdjustLater =>
      'Você pode ajustar qualquer coisa depois em Configurações.';

  @override
  String get onboardingSummaryGoal => 'Meta';

  @override
  String get onboardingSummaryCurrentWeight => 'Peso atual';

  @override
  String get onboardingSummaryMedication => 'Medicamento';

  @override
  String get onboardingSummaryCurrentDose => 'Dose atual';

  @override
  String get onboardingSummaryCadence => 'Frequência';

  @override
  String get onboardingSummaryStarted => 'Início';

  @override
  String get onboardingSummaryTargetWeight => 'Peso-alvo';

  @override
  String get onboardingSummaryRoutine => 'Rotina';

  @override
  String get onboardingSummaryFocus => 'Foco';

  @override
  String get onboardingFrequencyEveryDay => 'Todos os dias';

  @override
  String get onboardingFrequencyEveryWeek => 'Toda semana';

  @override
  String get onboardingFrequencyEvery2Weeks => 'A cada 2 semanas';

  @override
  String get onboardingFrequencyCustomSchedule => 'Agenda personalizada';

  @override
  String get onboardingTapOptionContinue =>
      'Toque em uma opção para continuar.';

  @override
  String get onboardingTypeGenderContinue =>
      'Digite seu gênero para continuar.';

  @override
  String get onboardingTypeDeviceContinue =>
      'Digite seu dispositivo para continuar.';

  @override
  String get onboardingTypeMedicationContinue =>
      'Digite seu medicamento para continuar.';

  @override
  String get onboardingEnterDaysBetweenDosesContinue =>
      'Digite os dias entre doses para continuar.';

  @override
  String get onboardingChooseScheduleContinue =>
      'Escolha uma frequência para continuar.';

  @override
  String get onboardingScrollChooseAge => 'Role para escolher sua idade.';

  @override
  String get onboardingDragOrTapHeight =>
      'Arraste ou toque na régua para escolher sua altura.';

  @override
  String get onboardingDragTapOrUseWeight =>
      'Arraste, toque ou use os botões para escolher o peso.';

  @override
  String get onboardingPickDateAndWeight =>
      'Escolha uma data e um peso para continuar.';

  @override
  String get onboardingSelectSymptoms =>
      'Selecione os sintomas nos quais o Glu deve focar.';

  @override
  String get onboardingTypeName => 'Digite o nome que você quer que o Glu use.';

  @override
  String get onboardingSaving => 'Salvando...';

  @override
  String get onboardingLetsBegin => 'Vamos começar';

  @override
  String get onboardingContinueWithGlu => 'Continuar com o Glu';

  @override
  String get onboardingKeepGoing => 'Continuar';

  @override
  String get onboardingTurnOnNotifications => 'Ativar notificações';

  @override
  String get onboardingFinish => 'Finalizar';

  @override
  String get onboardingTargetBmiTitle => 'Seu IMC alvo';

  @override
  String get onboardingChartToday => 'Hoje';

  @override
  String get onboardingChartOverTime => 'Ao longo do tempo';

  @override
  String get onboardingChartWithoutGlu => 'Sem Glu';

  @override
  String get onboardingChartWithGlu => 'Com Glu';

  @override
  String get onboardingReviewQuestion =>
      'As pessoas usam o Glu para se manterem estáveis e apoiadas';

  @override
  String get onboardingReviewExplainer =>
      'Uma avaliação rápida ajuda mais pessoas a encontrar um apoio que parece tão simples.';

  @override
  String get onboardingReviewBody =>
      'As pessoas usam o Glu para se sentir mais apoiadas, mais consistentes e menos sozinhas no processo.';

  @override
  String get onboardingTypeYourMedication => 'Digite seu medicamento';

  @override
  String get onboardingSelectStartDate => 'Selecione a data de início';

  @override
  String get goalsSaveDialogTitle => 'Salvar metas?';

  @override
  String get goalsSaveDialogMessage =>
      'Você tem alterações nas metas sem salvar. Quer salvá-las antes de sair desta aba?';

  @override
  String get commonLater => 'Mais tarde';

  @override
  String get homeGreetingAnonymous => 'Olá';

  @override
  String homeGreetingWithName(Object name) {
    return 'Olá, $name';
  }

  @override
  String get homeInsightEmptyTitle =>
      'Registre hoje para ver \nsua análise diária';

  @override
  String get homeInsightEmptyBody =>
      'Registre algo hoje e você verá sua análise esta noite.';

  @override
  String get homeInsightLogTodayTitle => 'Toque para ver seu insight';

  @override
  String get homeInsightMoreLogsVariant1Title =>
      'Toque para ver o insight de hoje';

  @override
  String get homeInsightMoreLogsVariant1Body =>
      'Seus registros já estão começando a mostrar um padrão — toque para ver.';

  @override
  String get homeInsightMoreLogsVariant2Title => 'Toque para ver seu insight';

  @override
  String get homeInsightMoreLogsVariant2Body =>
      'Mais alguns registros podem deixar o quadro muito mais claro — toque quando quiser.';

  @override
  String get homeInsightMoreLogsVariant3Title =>
      'Toque para descobrir o insight de hoje';

  @override
  String get homeInsightMoreLogsVariant3Body =>
      'Talvez já exista um padrão escondido no seu dia — toque para ver.';

  @override
  String get homeInsightLogTodayBodyNoLogs =>
      'Registre algo hoje e depois toque para ver o que isso revela.';

  @override
  String get homeInsightExpandedTitle => 'Foi útil?';

  @override
  String get homeInsightExpandedBody =>
      'Uma avaliação rápida ajuda o Glu a aprender o que importa mais para você.';

  @override
  String get homeInsightReasonHint => 'O que poderia ser melhor? (opcional)';

  @override
  String get homeInsightReasonSubmit => 'Enviar';

  @override
  String get homeInsightLearningMessage => 'Vou aprender com isso.';

  @override
  String get homeInsightChecking => 'Verificando o insight de hoje...';

  @override
  String get homeInsightGenerating => 'Carregando o insight de hoje...';

  @override
  String get homeInsightTryAgain => 'Tentar novamente';

  @override
  String get homeSeeAllInsights => 'Ver todos os insights';

  @override
  String get insightsProgressTitle => 'Todos os insights';

  @override
  String get insightsProgressEmptyState =>
      'Seus insights aparecerão aqui assim que forem gerados.';

  @override
  String get homeDoseReminderTitle => 'Lembrete de dose';

  @override
  String homeTileInteractionPlaceholder(Object label) {
    return 'Registro de interação de $label vai aqui.';
  }

  @override
  String get homeCalorieGoalRequiredTitle => 'Meta de calorias necessária';

  @override
  String get homeCalorieGoalRequiredBody =>
      'O Controle de porção precisa de uma meta de Refeições definida como Calorias para estimar sua porção. Defina uma em Metas para começar.';

  @override
  String get homeSetGoal => 'Definir meta';

  @override
  String get homeYourProgress => 'Seu progresso';

  @override
  String get homeRemindersShowcaseTitle => 'Mantenha o ritmo';

  @override
  String get homeRemindersShowcaseDescription =>
      'Configure lembretes para manter doses e suplementos em dia.';

  @override
  String get homePickNextDoseDate => 'Escolha a data da próxima dose';

  @override
  String get homeSetReminder => 'Definir lembrete';

  @override
  String get homeSupplementReminders => 'Lembretes de suplemento';

  @override
  String get homeNoUpcomingSupplements => 'Nenhum suplemento próximo';

  @override
  String get homeNoMoreUpcomingSupplements => 'Nenhum outro próximo';

  @override
  String get homeSetUpYourSupplements => 'Configure seus suplementos';

  @override
  String get homeSetUp => 'Configurar';

  @override
  String get homeSupplementFallback => 'Suplemento';

  @override
  String get doseReminderNotificationTitle => 'Pronto para sua dose?';

  @override
  String get doseReminderFallbackBody =>
      'Abra o Glu para revisar sua próxima dose.';

  @override
  String get supplementReminderNotificationTitle => 'Hora do seu suplemento';

  @override
  String supplementReminderBody(Object name, Object daypart) {
    return '$name · $daypart';
  }

  @override
  String get supplementReminderThisMorning => 'Nesta manhã';

  @override
  String get supplementReminderThisAfternoon => 'Nesta tarde';

  @override
  String get supplementReminderTonight => 'Hoje à noite';

  @override
  String get dailyReminderMorningTitle => 'Check-in da manhã';

  @override
  String get dailyReminderMorningBodies =>
      'Missão da manhã: dê ao Glu um pouco de dados para brincar.\nComece o dia com um registro rápido e boa energia.\nAcorde e registre. Seu eu do futuro vai agradecer.\nComece o dia com uma pequena atualização e uma grande vantagem.\nDê ao Glu uma pista da manhã e siga em frente.\nUm registro rápido agora pode deixar o dia bem mais interessante.\nVamos fazer a manhã valer com um check-in rápido.';

  @override
  String get dailyReminderMiddayTitle => 'Check-in do meio-dia';

  @override
  String get dailyReminderMiddayBodies =>
      'Parada do meio-dia: faça um registro rápido e siga em frente.\nAlmoço? Momento perfeito para atualizar o Glu.\nMetade do caminho. Dê ao Glu uma pista rápida.\nUm pequeno registro no meio do dia pode manter a história andando.\nFaça um check-in agora e mantenha o dia em movimento.\nDê um empurrãozinho ao seu dia com uma atualização rápida.\nMantenha a energia com um toque rápido ao meio-dia.';

  @override
  String get dailyReminderAfternoonTitle => 'Check-in da tarde';

  @override
  String get dailyReminderAfternoonBodies =>
      'Quase no fim. Dê ao Glu mais uma pista.\nUm registro rápido à tarde pode deixar o insight da noite mais interessante.\nFeche o dia com uma pequena atualização e uma grande vitória.\nMais um registro antes de o dia acabar?\nAjude o Glu a conectar os pontos com um check-in rápido à tarde.\nFeche o ciclo com um registro pequeno e mantenha a mágica acontecendo.\nUm toque final agora pode deixar o insight da noite muito melhor.';

  @override
  String get homePortionCheckTitle => 'Controle de porção';

  @override
  String get homePortionCheckBody => 'Saiba quanto comer em cada refeição';

  @override
  String get homeGlowUpTitle => 'Mostre sua mudança';

  @override
  String get homeGlowUpBody => 'Crie sua história de antes e depois';

  @override
  String get homeDoctorReportTitle => 'Relatório médico';

  @override
  String get homeDoctorReportBody => 'Compartilhe seu progresso com seu médico';

  @override
  String get doctorReportViewerRenderError =>
      'Não foi possível exibir o relatório. Tente novamente.';

  @override
  String get doctorReportViewerShare => 'Compartilhar';

  @override
  String get homeGoalsStatusTitle => 'Metas de hoje';

  @override
  String get homeGoalsStatusViewAll => 'Ver todas';

  @override
  String get homeWaterTitle => 'Água';

  @override
  String get homeWeightTitle => 'Peso';

  @override
  String get homeExerciseTitle => 'Exercício';

  @override
  String get homeMealsTitle => 'Refeições';

  @override
  String get homeCaloriesTitle => 'Calorias';

  @override
  String get homeProteinsTitle => 'Proteínas';

  @override
  String get homeFibersTitle => 'Fibras';

  @override
  String get homeSymptomsTitle => 'Sintomas';

  @override
  String get homeMoodTitle => 'Humor';

  @override
  String get homeCravingsTitle => 'Desejos';

  @override
  String get homeDoseTitle => 'Dose';

  @override
  String get homeMedicationLevelTitle => 'Nível estimado do medicamento';

  @override
  String get homeMedicationLevelInfoTitle => 'Como ler este gráfico';

  @override
  String get homeMedicationLevelInfoBody =>
      'Este gráfico estima quanto do seu medicamento ainda pode estar ativo com base nas doses registradas e na meia-vida do medicamento.\n\nPontos mais altos geralmente significam uma dose mais recente ou maior. A linha desce ao longo do tempo à medida que o medicamento é eliminado do seu organismo.\n\nUse isso como uma visualização de tendência, não como uma medição exata ou recomendação médica.';

  @override
  String get homeMedicationLevelInfoDismiss => 'Entendi';

  @override
  String get homeMedicationLevelEmptyBody =>
      'Registre suas doses para que o Glu possa estimar quanto medicamento ainda está ativo no seu organismo.';

  @override
  String get homeMedicationLevelOfRecentPeak => 'do pico recente';

  @override
  String get homeMedicationLevelActiveNow => 'Ativo agora';

  @override
  String get homeMedicationLevelHalfLife => 'Meia-vida';

  @override
  String get homeMedicationLevelLastDose => 'Última dose';

  @override
  String get homeStartHydration => 'Comece a hidratação';

  @override
  String get homeLogFirstSession => 'Registre sua primeira sessão';

  @override
  String get homeLogTodayWeight => 'Registre o peso de hoje';

  @override
  String get homeAtYourTarget => 'Você está no seu alvo';

  @override
  String get homeLogMealsToTrackCalories =>
      'Registre refeições para acompanhar calorias';

  @override
  String get homeLogFirstMeal => 'Registre sua primeira refeição';

  @override
  String get homeTrackProteinFromMeals => 'Acompanhe proteína das refeições';

  @override
  String get homeTrackFiberFromMeals => 'Acompanhe fibras das refeições';

  @override
  String get homeAllClear => 'Tudo certo';

  @override
  String get homeTrackSymptoms => 'Acompanhe sintomas';

  @override
  String get homeGreat => 'Ótimo';

  @override
  String get homeGood => 'Bom';

  @override
  String get homeBad => 'Ruim';

  @override
  String get homeOkay => 'Ok';

  @override
  String get homeLogHowYouFeel => 'Registre como você se sente';

  @override
  String get homeLogACraving => 'Registrar um desejo';

  @override
  String get homeLogTodaysDose => 'Registre a dose de hoje';

  @override
  String get homeTaken => 'Tomado';

  @override
  String get homeStartHereTitle => 'Comece aqui';

  @override
  String get homeStartHereBody =>
      'Comece com este card, depois expanda para os outros. À medida que o Glu aprende mais sobre sua jornada, ele pode mostrar padrões e insights melhores ao longo do tempo.';

  @override
  String get waterLogTitle => 'Hidratação';

  @override
  String get waterLogEditTitle => 'Editar hidratação';

  @override
  String get waterLogLogTitle => 'Registrar água';

  @override
  String waterLogAddDrink(Object amount) {
    return '+ Adicionar bebida ($amount)';
  }

  @override
  String get waterLogSaving => 'Salvando...';

  @override
  String get waterLogCustomDrinkTitle => 'Bebida personalizada';

  @override
  String get waterLogCustomDrinkBody =>
      'Escolha a quantidade que você quer adicionar agora.';

  @override
  String get waterLogUseThisAmount => 'Confirmar';

  @override
  String waterLogAddedToHydrationLog(Object amount) {
    return '$amount adicionado ao seu registro de hidratação';
  }

  @override
  String get waterLogCouldNotSave =>
      'Ainda não foi possível salvar este registro de água.';

  @override
  String get waterLogDeleteTitle => 'Excluir este registro de hidratação?';

  @override
  String get waterLogDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get waterLogCouldNotDelete =>
      'Ainda não foi possível excluir este registro de hidratação.';

  @override
  String get waterLogDeleteLog => 'Excluir registro';

  @override
  String get waterLogDeleted => 'Hidratação excluída';

  @override
  String get moodLogTitle => 'Humor';

  @override
  String get moodEditTitle => 'Editar humor';

  @override
  String get moodHowYouFeel => 'Como você se sente';

  @override
  String get moodBad => 'Ruim';

  @override
  String get moodOkay => 'Ok';

  @override
  String get moodGood => 'Bom';

  @override
  String get moodGreat => 'Ótimo';

  @override
  String get moodNotes => 'Notas';

  @override
  String get moodAnythingWorthRemembering =>
      'Algo importante para lembrar sobre seu humor?';

  @override
  String get moodCouldNotSave =>
      'Ainda não foi possível salvar este registro de humor.';

  @override
  String get moodDeleteTitle => 'Excluir este registro de humor?';

  @override
  String get moodDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get moodDeleteLog => 'Excluir registro';

  @override
  String get moodSaving => 'Salvando...';

  @override
  String get moodAddMoodLog => '+ Adicionar registro de humor';

  @override
  String get moodLogged => 'Humor registrado';

  @override
  String get moodDeleted => 'Humor excluído';

  @override
  String get moodCouldNotDelete =>
      'Ainda não foi possível excluir este registro de humor.';

  @override
  String get moodAddedToMoodLog => 'Adicionado ao seu registro de humor';

  @override
  String get cravingsLogTitle => 'Desejos';

  @override
  String get cravingsEditTitle => 'Editar desejo';

  @override
  String get cravingsWhatsGoingOn => 'O que está acontecendo';

  @override
  String get cravingsTypeGeneral => 'Vontade de comer';

  @override
  String get cravingsTypeSweet => 'Algo doce';

  @override
  String get cravingsTypeSalty => 'Algo salgado';

  @override
  String get cravingsIntensityLabel => 'Intensidade (opcional)';

  @override
  String get cravingsIntensityMild => 'Leve';

  @override
  String get cravingsIntensityModerate => 'Moderada';

  @override
  String get cravingsIntensityStrong => 'Forte';

  @override
  String get cravingsOutcomeLabel => 'O que aconteceu (opcional)';

  @override
  String get cravingsOutcomeResisted => 'Resisti';

  @override
  String get cravingsOutcomeGaveIn => 'Cedi';

  @override
  String get cravingsNotes => 'Notas';

  @override
  String get cravingsAnythingWorthRemembering =>
      'Algo importante para lembrar sobre esse desejo?';

  @override
  String get cravingsCouldNotSave =>
      'Ainda não foi possível salvar este registro de desejo.';

  @override
  String get cravingsDeleteTitle => 'Excluir este registro de desejo?';

  @override
  String get cravingsDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get cravingsDeleteLog => 'Excluir registro';

  @override
  String get cravingsSaving => 'Salvando...';

  @override
  String get cravingsAddLog => '+ Registrar desejo';

  @override
  String get cravingsLogged => 'Desejo registrado';

  @override
  String get cravingsDeleted => 'Desejo excluído';

  @override
  String get cravingsCouldNotDelete =>
      'Ainda não foi possível excluir este registro de desejo.';

  @override
  String get cravingsAddedToLog => 'Adicionado ao seu registro de desejos';

  @override
  String get portionCheckTitle => 'Controle de porção';

  @override
  String get portionCheckAnalyzingMeal => 'Analisando sua refeição…';

  @override
  String get portionCheckCouldNotAnalyzePhoto =>
      'Não foi possível analisar esta foto';

  @override
  String get portionCheckTakeNewPhoto => 'Tirar uma nova foto';

  @override
  String get portionCheckSomethingWentWrong => 'Algo deu errado.';

  @override
  String get portionCheckYouHitDailyLimit => 'Você atingiu seu limite diário';

  @override
  String get portionCheckYouCanEat => 'Você pode comer';

  @override
  String get portionCheckYouCanEatUpTo => 'Você pode comer até';

  @override
  String get portionCheckTryLighterOption =>
      'Tente uma opção mais leve ou pule esta';

  @override
  String get portionCheckThisEntireMeal => 'esta refeição inteira';

  @override
  String portionCheckPctOfThisMeal(Object percent) {
    return '$percent% desta refeição';
  }

  @override
  String get portionCheckToStayWithinGoals =>
      'para ficar dentro das suas metas diárias.';

  @override
  String get portionCheckNutritionBreakdown => 'Detalhamento nutricional';

  @override
  String get portionCheckTipsToBalanceMeal =>
      'Dicas para equilibrar sua refeição';

  @override
  String get portionCheckTipsPool =>
      'Coma devagar — a saciedade leva cerca de 20 minutos para chegar.\nEncha metade do prato com vegetais.\nInclua proteína em todas as refeições.\nBeba água antes das refeições.\nPorcione os lanches em potes pequenos.\nCombine carboidratos com proteína ou gordura para ficar satisfeito por mais tempo.\nDê preferência a alimentos integrais quando possível.\nEvite comer distraído por telas.\nNão pule refeições se isso fizer você exagerar depois.\nPlaneje seus lanches antes de sentir fome.';

  @override
  String get portionCheckRetake => 'Tirar novamente';

  @override
  String get portionCheckLogThisPortion => 'Registrar esta porção';

  @override
  String get portionCheckCarbs => 'Carbo';

  @override
  String get portionCheckProteins => 'Proteínas';

  @override
  String get portionCheckFats => 'Gorduras';

  @override
  String get portionCheckFiber => 'Fibras';

  @override
  String get mealLogScreenTitle => 'Refeições';

  @override
  String get mealLogEditTitle => 'Editar refeição';

  @override
  String get mealLogLogTitle => 'Registrar refeição';

  @override
  String get mealLogSaving => 'Salvando...';

  @override
  String get mealLogAddMealLog => '+ Adicionar registro de refeição';

  @override
  String get mealLogCouldNotStartRecording =>
      'Não foi possível iniciar a gravação.';

  @override
  String get mealLogRecordingStoppedAtLimit =>
      'A gravação foi interrompida aos 60 segundos.';

  @override
  String get mealLogCouldNotAnalyzeRecording =>
      'Não foi possível analisar esta gravação.';

  @override
  String get mealLogCouldNotAnalyzeText =>
      'Não foi possível analisar este texto.';

  @override
  String get mealLogCouldNotAnalyzePhoto =>
      'Não foi possível analisar esta foto.';

  @override
  String get mealLogCouldNotProcessMealPhoto =>
      'Ainda não foi possível processar esta foto da refeição.';

  @override
  String get mealLogDiscardTitle => 'Descartar esta refeição?';

  @override
  String get mealLogDiscardMessage =>
      'Você revisou uma foto, mas não salvou a entrada. Ela não será registrada.';

  @override
  String get mealLogDiscard => 'Descartar';

  @override
  String get mealLogDeleteTitle => 'Excluir este registro de refeição?';

  @override
  String get mealLogDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get mealLogDelete => 'Excluir';

  @override
  String get mealLogDeleteLog => 'Excluir registro';

  @override
  String get mealLogCouldNotSave =>
      'Ainda não foi possível salvar este registro de refeição.';

  @override
  String get mealLogCouldNotDelete =>
      'Ainda não foi possível excluir este registro de refeição.';

  @override
  String get mealLogAnalyzing => 'Analisando...';

  @override
  String get mealLogAnalyzeText => 'Analisar texto';

  @override
  String get mealLogSendRecording => 'Enviar gravação';

  @override
  String get mealLogMealDefaultName => 'Refeição';

  @override
  String get mealLogMealNameHint => 'Nome da refeição';

  @override
  String get mealLogCouldNotPrefillTitle =>
      'Não foi possível preencher esta refeição';

  @override
  String get mealLogHowMuchDidYouEat => 'Quanto você comeu?';

  @override
  String get mealLogNotes => 'Notas';

  @override
  String get mealLogAnythingWorthRemembering =>
      'Algo importante para lembrar sobre esta refeição?';

  @override
  String get mealLogAnalyzingYourMealTitle => 'Analisando sua refeição';

  @override
  String get mealLogAnalyzingYourMealBody =>
      'Transformando o que você informou em campos nutricionais. Você pode revisar tudo antes de salvar.';

  @override
  String get mealLogDescribeYourMealTitle => 'Descreva sua refeição';

  @override
  String get mealLogDescribeYourMealBody =>
      'Escreva o que você comeu e qualquer quantidade que você saiba. Vamos transformar isso em campos nutricionais.';

  @override
  String get mealLogDescribeYourMealHint =>
      'Exemplo: salada de frango grelhado, molho de azeite, 1 maçã, água com gás';

  @override
  String get mealLogCaptureYourMealTitle => 'Capture sua refeição';

  @override
  String get mealLogCaptureYourMealBody =>
      'Tire uma foto e estimaremos os campos nutricionais para você.';

  @override
  String get mealLogTakePhoto => 'Tirar foto';

  @override
  String get mealLogRecordingYourMealTitle => 'Gravando sua refeição';

  @override
  String get mealLogRecordingReadyTitle => 'Gravação pronta';

  @override
  String get mealLogRecordMealDescriptionTitle =>
      'Grave uma descrição da refeição';

  @override
  String mealLogRecordingTapStopBody(Object remaining) {
    return 'Toque em parar quando terminar. Restam ${remaining}s';
  }

  @override
  String get mealLogRecordingReadyBody =>
      'Envie abaixo para analisar, ou grave novamente.';

  @override
  String get mealLogRecordMealDescriptionBody =>
      'Fale naturalmente sobre o que você comeu e vamos transformar em macros.';

  @override
  String get mealLogStopRecording => 'Parar gravação';

  @override
  String get mealLogRecordAgain => 'Gravar novamente';

  @override
  String get mealLogStartRecording => 'Começar gravação';

  @override
  String get mealLogBreakfast => 'Café da manhã';

  @override
  String get mealLogLunch => 'Almoço';

  @override
  String get mealLogSnack => 'Lanche';

  @override
  String get mealLogDinner => 'Jantar';

  @override
  String get mealLogKcalUnit => 'kcal';

  @override
  String get mealLogToday => 'Hoje';

  @override
  String get mealLogYesterday => 'Ontem';

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
    return '$amount g de $macro registradas';
  }

  @override
  String get mealLogDeleted => 'Refeição excluída';

  @override
  String get mealLogAddedToMealLog => 'Adicionado ao seu registro de refeições';

  @override
  String get mealLogCarbs => 'Carbo';

  @override
  String get mealLogProteins => 'Proteínas';

  @override
  String get mealLogFats => 'Gorduras';

  @override
  String get mealLogFiber => 'Fibras';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsLanguageDialogTitle => 'Selecionar idioma';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsPreferences => 'Preferências';

  @override
  String get settingsHealthGoal => 'Meta de saúde';

  @override
  String get settingsHealthGoalDialogTitle => 'Selecionar meta de saúde';

  @override
  String get settingsHabitGoals => 'Metas de hábito';

  @override
  String get settingsDisabled => 'Desativado';

  @override
  String settingsGoalsActiveCount(Object count) {
    return '$count ativas';
  }

  @override
  String get settingsHeight => 'Altura';

  @override
  String get settingsAge => 'Idade';

  @override
  String get settingsGender => 'Gênero';

  @override
  String get settingsMeasurementUnit => 'Unidade de medida';

  @override
  String get settingsReminders => 'Lembretes';

  @override
  String get settingsDoseReminder => 'Lembrete de dose';

  @override
  String get settingsSupplementReminder => 'Lembrete de suplemento';

  @override
  String get settingsDailyReminders => 'Lembretes diários';

  @override
  String get settingsSubscription => 'Assinatura';

  @override
  String get settingsSupport => 'Suporte';

  @override
  String get settingsSendFeedback => 'Enviar feedback';

  @override
  String get feedbackSheetTitle => 'Enviar feedback';

  @override
  String get feedbackSheetHint => 'Conte o que você acha…';

  @override
  String get feedbackSheetSend => 'Enviar';

  @override
  String get feedbackSheetSuccess => 'Obrigado pelo seu feedback!';

  @override
  String get feedbackSheetError => 'Não foi possível enviar. Tente novamente.';

  @override
  String get settingsTermsOfService => 'Termos de uso';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidade';

  @override
  String get settingsInternal => 'Interno';

  @override
  String get settingsSubscriptionOverride => 'Substituição da assinatura';

  @override
  String get settingsTodayInsightCard => 'Cartão de insight de hoje';

  @override
  String get settingsResetOnboarding => 'Redefinir onboarding';

  @override
  String get settingsResetShowcases => 'Redefinir apresentações';

  @override
  String get settingsResetUserData => 'Redefinir dados do usuário';

  @override
  String get settingsDeletingAccount => 'Excluindo conta...';

  @override
  String get settingsDisconnect => 'Desconectar';

  @override
  String get settingsDeleteAccount => 'Excluir conta';

  @override
  String settingsDisconnectProviderShort(Object provider) {
    return 'Desconectar $provider';
  }

  @override
  String settingsDisconnectProviderTitle(Object provider) {
    return 'Desconectar $provider?';
  }

  @override
  String settingsDisconnectProviderBody(Object provider) {
    return 'Você não poderá mais entrar com $provider neste dispositivo, a menos que o reconecte depois.';
  }

  @override
  String get settingsDeleteAccountTitle => 'Excluir conta?';

  @override
  String get settingsDeleteAccountBody =>
      'Isso removerá permanentemente sua conta e todos os seus dados. Esta ação não pode ser desfeita.';

  @override
  String get settingsDeleteAccountConfirmHint => 'Digite DELETE para confirmar';

  @override
  String get settingsDeleteAccountError =>
      'Algo deu errado ao excluir sua conta. Entre em contato com support@layline.ventures.';

  @override
  String get settingsRestartAppToSeeOnboarding =>
      'Reinicie o app para ver o onboarding';

  @override
  String get settingsShowcasesReset => 'Apresentações redefinidas';

  @override
  String get settingsResetUserDataTitle => 'Redefinir dados do usuário?';

  @override
  String get settingsResetUserDataBody =>
      'Isso limpará todos os registros de refeições, água, exercício, peso, humor, sintomas, suplementos e doses.';

  @override
  String get settingsUserDataReset => 'Dados do usuário redefinidos';

  @override
  String get settingsDailyRemindersCouldNotBeScheduledRightNow =>
      'Salvo, mas os lembretes diários não puderam ser agendados agora.';

  @override
  String get settingsSubscriptionOverrideTitle => 'Substituição da assinatura';

  @override
  String get settingsSubscriptionOverrideAuto => 'Automático';

  @override
  String get settingsSubscriptionOverrideForceFree => 'Forçar gratuito';

  @override
  String get settingsSubscriptionOverrideForcePro => 'Forçar Pro';

  @override
  String get settingsTodayInsightCardTitle => 'Cartão de insight de hoje';

  @override
  String get settingsTodayInsightCardAuto => 'Automático';

  @override
  String get settingsTodayInsightCardOn => 'Ativado';

  @override
  String get settingsTodayInsightCardOff => 'Desativado';

  @override
  String get settingsYourName => 'Seu nome';

  @override
  String get settingsSignOut => 'Sair';

  @override
  String get settingsHeightCm => 'cm';

  @override
  String get settingsHeightFtIn => 'pés/pol';

  @override
  String get settingsHeightFt => 'pés';

  @override
  String get settingsHeightIn => 'pol';

  @override
  String get settingsGenderMale => 'Masculino';

  @override
  String get settingsGenderFemale => 'Feminino';

  @override
  String get settingsGenderPreferNotToSay => 'Prefiro não informar';

  @override
  String get settingsGenderOther => 'Outro';

  @override
  String get settingsYourProfile => 'Seu perfil';

  @override
  String get settingsNotSet => 'Não definido';

  @override
  String settingsYears(Object value) {
    return '$value anos';
  }

  @override
  String get settingsOff => 'Desligado';

  @override
  String get settingsOn => 'Ligado';

  @override
  String get settingsNoneSet => 'Nenhum definido';

  @override
  String settingsSupplementCount(Object count) {
    return '$count suplemento(s)';
  }

  @override
  String get commonToday => 'Hoje';

  @override
  String get mainShellHome => 'Início';

  @override
  String get mainShellLog => 'Registros';

  @override
  String get mainShellProgress => 'Progresso';

  @override
  String get mainShellSettings => 'Config';

  @override
  String get mainShellLogShowcaseTitle =>
      'Registre o que importa todos os dias';

  @override
  String get mainShellLogShowcaseDescription =>
      'Registre as atividades que mais importam para você, todos os dias.';

  @override
  String get logMoodShowcaseTitle => 'Comece pelo seu humor';

  @override
  String get logMoodShowcaseDescription =>
      'Registre seu humor agora e, conforme for avançando, continue com o resto para que o Glu identifique hábitos e padrões com mais precisão.';

  @override
  String get mainShellProgressShowcaseTitle => 'Veja seu progresso';

  @override
  String get mainShellProgressShowcaseDescription =>
      'Veja seus padrões e tendências para entender como seus hábitos e peso estão mudando ao longo do tempo.';

  @override
  String get progressMenuShowcaseTitle => 'Explore seus dados';

  @override
  String get progressMenuShowcaseDescription =>
      'Veja todos os gráficos, leia insights gerados por IA ou crie um relatório médico para compartilhar com sua equipe de saúde.';

  @override
  String get settingsFeedbackShowcaseTitle =>
      'Adoraríamos receber seu feedback';

  @override
  String get settingsFeedbackShowcaseDescription =>
      'Toque aqui para compartilhar o que está funcionando, o que não está ou qualquer ideia que você tenha.';

  @override
  String get authCouldNotOpenLink => 'Não foi possível abrir o link agora.';

  @override
  String get authWelcomeTitle => 'Bem-vindo ao Glu';

  @override
  String get authSubtitle =>
      'Acesso seguro para o seu companheiro de bem-estar';

  @override
  String get authContinueWithGoogle => 'Continuar com Google';

  @override
  String get authContinueWithApple => 'Continuar com Apple';

  @override
  String get authEmailHint => 'nome@email.com';

  @override
  String get authSending => 'Enviando...';

  @override
  String get authResendLink => 'Reenviar link';

  @override
  String get authUseDifferentEmail => 'Usar outro email';

  @override
  String get habitGoalsTitle => 'Metas de hábito';

  @override
  String get goalsProteins => 'Proteínas';

  @override
  String get goalsFibers => 'Fibras';

  @override
  String goalsGramsPerDay(Object value) {
    return '$value g por dia';
  }

  @override
  String get goalsWater => 'Água';

  @override
  String goalsLitersPerDay(Object value) {
    return '${value}L por dia';
  }

  @override
  String get goalsExercise => 'Exercício';

  @override
  String goalsMinutesPerDay(Object value) {
    return '$value min por dia';
  }

  @override
  String get goalsMeals => 'Refeições';

  @override
  String get goalsCalories => 'Calorias';

  @override
  String get goalsKcalUnit => 'kcal';

  @override
  String get goalsPerWeekSuffix => 'por semana';

  @override
  String goalsMealsPerDay(Object count) {
    return '$count refeições por dia';
  }

  @override
  String goalsCaloriesPerDay(Object count) {
    return '$count kcal por dia';
  }

  @override
  String get goalsWeight => 'Peso';

  @override
  String get goalsAddLoggedWeightToCalculatePace =>
      'Adicione um peso registrado para calcular o ritmo';

  @override
  String get goalsAlreadyAtThisTarget => 'Você já está nessa meta';

  @override
  String goalsWeightPerWeekToTarget(Object value, Object unit) {
    return '$value $unit/semana até a meta';
  }

  @override
  String get goalsSetTargetForNextWeek =>
      'Defina a meta para a próxima semana.';

  @override
  String get progressWeightTitle => 'Peso';

  @override
  String get progressWeightLabel => 'Peso ';

  @override
  String progressWeightUnit(Object unit) {
    return '$unit';
  }

  @override
  String get progressHealthyBmi => 'IMC saudável';

  @override
  String get progressTotal => 'Total';

  @override
  String get progressPercent => 'Percentual';

  @override
  String get progressWeeklyAvg => 'Média semanal';

  @override
  String get progressRangeAllTime => 'Todo';

  @override
  String get progressRange1Month => '1 mês';

  @override
  String get progressRange3Months => '3 meses';

  @override
  String get progressRange6Months => '6 meses';

  @override
  String get progressLow => 'Baixo';

  @override
  String get progressMed => 'Médio';

  @override
  String get progressHigh => 'Alto';

  @override
  String get progressSeverity => 'Severidade';

  @override
  String get progressBad => 'Ruim';

  @override
  String get progressOkay => 'Ok';

  @override
  String get progressGood => 'Bom';

  @override
  String get progressGreat => 'Ótimo';

  @override
  String get progressMostlyBad => 'Majoritariamente ruim';

  @override
  String get progressMostlyOkay => 'Majoritariamente ok';

  @override
  String get progressMostlyGood => 'Majoritariamente bom';

  @override
  String get progressMostlyGreat => 'Majoritariamente ótimo';

  @override
  String get progressNoDose => 'Sem dose';

  @override
  String get progressLogged => 'Registrado';

  @override
  String get progressAllClear => 'Tudo certo';

  @override
  String get progressFreq => 'Freq.';

  @override
  String get progressAverage => 'Média';

  @override
  String get progressDaily => 'Diário';

  @override
  String get progressWeekly => 'Semanal';

  @override
  String get progressMinutes => 'Minutos';

  @override
  String get progressIntensity => 'Intensidade';

  @override
  String get progressCalories => 'Calorias';

  @override
  String get progressByDose => 'Por dose';

  @override
  String get progressWeightProgressTitle => 'Progresso do peso';

  @override
  String get progressWaterProgressTitle => 'Progresso da água';

  @override
  String get progressExerciseProgressTitle => 'Progresso do exercício';

  @override
  String get progressDoseProgressTitle => 'Progresso da dose';

  @override
  String get progressMealsProgressTitle => 'Progresso das refeições';

  @override
  String get progressSymptomsProgressTitle => 'Progresso dos sintomas';

  @override
  String get progressMoodProgressTitle => 'Progresso do humor';

  @override
  String get progressCravingsProgressTitle => 'Progresso de desejos';

  @override
  String get progressResisted => 'Resistidos';

  @override
  String get progressCravingsResistedSubtitle =>
      'Proporção de desejos registrados que você resistiu.';

  @override
  String get progressWeightChangeTitle => 'Mudança de peso';

  @override
  String get progressTitle => 'Progresso';

  @override
  String get progressMenuViewAllInsights => 'Ver todos os insights';

  @override
  String get progressMenuViewAllCharts => 'Ver todos os gráficos';

  @override
  String get progressMenuCreateDoctorReport => 'Criar relatório médico';

  @override
  String get progressReportGenerating => 'Gerando seu relatório…';

  @override
  String get progressReportError =>
      'Não foi possível gerar o relatório. Tente novamente.';

  @override
  String get progressReportPendingRetry =>
      'Seu relatório ainda pode ser concluído em instantes. Tente novamente.';

  @override
  String get progressReportOpenError =>
      'Seu relatório foi gerado, mas não conseguimos abri-lo. Tente novamente.';

  @override
  String get progressAllProgressTitle => 'Todo o progresso';

  @override
  String get progressWeightTrendExplanation =>
      'Veja como seu peso está mudando ao longo do tempo.';

  @override
  String get progressNoWeightLogsYet => 'Ainda não há registros de peso';

  @override
  String get progressNoLogsYet => 'Ainda não há registros';

  @override
  String get progressLogWeightToStartTrend =>
      'Registre o peso para começar a acompanhar sua tendência.';

  @override
  String get progressLogWeightAndDoseToCompareChange =>
      'Registre peso e dose para comparar como a dosagem se relaciona com a mudança.';

  @override
  String get progressEachPointColoredByLatestDose =>
      'Cada ponto é colorido pela última dose usada antes dessa pesagem.';

  @override
  String get progressNoHydrationYet => 'Ainda não há hidratação';

  @override
  String get progressNoMovementYet => 'Ainda não há movimento';

  @override
  String get progressNoDoseLogsYet => 'Ainda não há registros de dose';

  @override
  String get progressNoMealsLoggedYet => 'Ainda não há refeições registradas';

  @override
  String get progressNoSymptomsLoggedYet => 'Ainda não há sintomas registrados';

  @override
  String get progressNoMoodLogsYet => 'Ainda não há registros de humor';

  @override
  String get progressNoCravingsLoggedYet => 'Ainda não há desejos registrados';

  @override
  String get progressFutureTrendTitle => 'Tendência futura';

  @override
  String get progressFutureTrendBody =>
      'Uma linha do tempo bonita do seu progresso';

  @override
  String get progressGoal => 'Meta';

  @override
  String get progressLatestLoggedWeightReadyToTrack =>
      'Seu último peso registrado está pronto para ser acompanhado.';

  @override
  String progressAboutGapFromTarget(Object gap, Object unit) {
    return 'Cerca de $gap $unit do seu objetivo.';
  }

  @override
  String progressDeltaVsPreviousLog(Object deltaText) {
    return '$deltaText em relação ao seu registro anterior.';
  }

  @override
  String progressDeltaVsPreviousLogAndGap(
      Object deltaText, Object gap, Object unit) {
    return '$deltaText em relação ao registro anterior. $gap $unit do objetivo.';
  }

  @override
  String get progressComparedWithPreviousLogTrendVisible =>
      'Comparado ao seu registro anterior, a tendência agora está visível.';

  @override
  String get progressWaterTitle => 'Água';

  @override
  String get manageSubscriptionTitle => 'Gerenciar assinatura';

  @override
  String get manageSubscriptionProPlan => 'Plano Pro';

  @override
  String get manageSubscriptionFreePlan => 'Plano gratuito';

  @override
  String get manageSubscriptionActiveCopy => 'Sua assinatura está ativa.';

  @override
  String get manageSubscriptionUpgradeCopy =>
      'Atualize para desbloquear o Glu Pro.';

  @override
  String get manageSubscriptionPlan => 'Plano';

  @override
  String get manageSubscriptionPro => 'Pro';

  @override
  String get manageSubscriptionFree => 'Gratuito';

  @override
  String get manageSubscriptionProduct => 'Produto';

  @override
  String get manageSubscriptionRenewal => 'Renovação';

  @override
  String get manageSubscriptionStatus => 'Status';

  @override
  String get manageSubscriptionStatusActive => 'Ativo';

  @override
  String get manageSubscriptionStatusInactive => 'Não ativo';

  @override
  String get manageSubscriptionManageButton => 'Gerenciar assinatura';

  @override
  String get manageSubscriptionUpgradeButton => 'Atualizar para Pro';

  @override
  String get manageSubscriptionOpenStoreSubscriptionSettings =>
      'Abrir configurações da assinatura na loja';

  @override
  String get manageSubscriptionProBadge => 'PRO';

  @override
  String get manageSubscriptionRestorePurchases => 'Restaurar compras';

  @override
  String get manageSubscriptionRenewsAutomatically => 'Renova automaticamente';

  @override
  String get manageSubscriptionLifetime => 'Vitalícia';

  @override
  String manageSubscriptionRenewsOn(Object date) {
    return 'Renova em $date';
  }

  @override
  String manageSubscriptionExpiresOn(Object date) {
    return 'Expira em $date';
  }

  @override
  String get supplementReminderDayMon => 'Seg';

  @override
  String get supplementReminderDayTue => 'Ter';

  @override
  String get supplementReminderDayWed => 'Qua';

  @override
  String get supplementReminderDayThu => 'Qui';

  @override
  String get supplementReminderDayFri => 'Sex';

  @override
  String get supplementReminderDaySat => 'Sáb';

  @override
  String get supplementReminderDaySun => 'Dom';

  @override
  String supplementReminderInDays(Object count) {
    return 'Em $count dias';
  }

  @override
  String get supplementReminderInOneWeek => 'Em 1 semana';

  @override
  String supplementReminderInWeeks(Object count) {
    return 'Em $count semanas';
  }

  @override
  String get subscriptionDebugTitle => 'Assinaturas do Glu';

  @override
  String get subscriptionDebugMonthly => 'Mensal';

  @override
  String get subscriptionDebugYearly => 'Anual';

  @override
  String get subscriptionDebugRefreshCustomerInfo =>
      'Atualizar info do cliente';

  @override
  String get subscriptionDebugPresentPaywall => 'Exibir paywall';

  @override
  String get subscriptionDebugOpenCustomerCenter => 'Abrir Central do Cliente';

  @override
  String get subscriptionDebugRestorePurchases => 'Restaurar compras';

  @override
  String get subscriptionDebugSyncPurchases => 'Sincronizar compras';

  @override
  String get subscriptionDebugRevenuecatStatus => 'Status do RevenueCat';

  @override
  String get subscriptionDebugConfigured => 'Configurado';

  @override
  String get subscriptionDebugBusy => 'Ocupado';

  @override
  String get subscriptionDebugAppUserId => 'ID do usuário do app';

  @override
  String get subscriptionDebugAnonymous => 'anônimo';

  @override
  String get subscriptionDebugApiKeyAvailable => 'chave da API disponível';

  @override
  String get subscriptionDebugGluProActive => 'Glu Pro ativo';

  @override
  String get subscriptionDebugActiveSubscriptions => 'Assinaturas ativas';

  @override
  String get subscriptionDebugManagementUrl => 'URL de gerenciamento';

  @override
  String get subscriptionDebugEntitlementProduct => 'Produto do entitlement';

  @override
  String get subscriptionDebugWillRenew => 'Renova';

  @override
  String get subscriptionDebugExpiration => 'Expiração';

  @override
  String get subscriptionDebugLifetime => 'vitalícia';

  @override
  String get subscriptionDebugPackageFound => 'Pacote encontrado';

  @override
  String get subscriptionDebugProductId => 'ID do produto';

  @override
  String get subscriptionDebugTitleLabel => 'Título';

  @override
  String get subscriptionDebugPrice => 'Preço';

  @override
  String subscriptionDebugPurchase(Object title) {
    return 'Comprar $title';
  }

  @override
  String get progressExerciseTitle => 'Exercício';

  @override
  String get progressDoseTitle => 'Dose';

  @override
  String get progressMealsTitle => 'Refeições';

  @override
  String get progressSymptomsTitle => 'Sintomas';

  @override
  String get progressMoodTitle => 'Humor';

  @override
  String get progressCravingsTitle => 'Desejos';

  @override
  String get progressTrend => 'Tendência';

  @override
  String get progressTarget => 'Meta';

  @override
  String get progressNoTrendYet => 'Ainda sem tendência';

  @override
  String get progressNoActivityYet => 'Ainda sem atividade';

  @override
  String get progressNoCheckInsYet => 'Ainda sem check-ins';

  @override
  String get progressWeightSignatureChip =>
      'O peso vai se tornar seu gráfico principal';

  @override
  String get progressWeightStartTrendTitle =>
      'Comece sua tendência com a primeira pesagem';

  @override
  String get progressWeightStartTrendBody =>
      'Este gráfico é a peça central da sua história de progresso. Registre seu primeiro peso para desbloquear impulso, marcos e uma visão digna de compartilhamento.';

  @override
  String get progressWeightMomentum => 'Impulso';

  @override
  String get progressWeightMilestones => 'Marcos';

  @override
  String get progressWeightShareReady => 'Pronto para compartilhar';

  @override
  String get progressWeightLogWeight => 'Registrar peso';

  @override
  String get weightProgressUnlocksViewChip =>
      'Sua primeira pesagem libera esta visão';

  @override
  String get weightProgressStartsHereTitle =>
      'Sua história de progresso começa aqui';

  @override
  String get weightProgressStartsHereBody =>
      'Registre seu primeiro peso para desbloquear tendências, marcos e insights sensíveis à dose em uma visão digna de compartilhamento.';

  @override
  String get weightProgressTrendView => 'Visão de tendência';

  @override
  String get weightProgressDoseOverlays => 'Sobreposições de dose';

  @override
  String get weightProgressMilestones => 'Marcos';

  @override
  String get weightProgressLogWeight => 'Registrar peso';

  @override
  String get glowUpAddBeforeAndAfterFirst =>
      'Adicione primeiro uma foto de antes e outra de depois.';

  @override
  String get glowUpSavedToGallery => 'Salvo na sua galeria';

  @override
  String get glowUpSaveToGallery => 'Salvar na galeria';

  @override
  String get glowUpYourProgress => 'Seu progresso';

  @override
  String get glowUpWeightChange => 'Mudança de peso';

  @override
  String get glowUpTime => 'Tempo';

  @override
  String get glowUpShare => 'Compartilhar';

  @override
  String get glowUpBefore => 'ANTES';

  @override
  String get glowUpAfter => 'DEPOIS';

  @override
  String glowUpProgressWeightAndTime(Object weight, Object time) {
    return '$weight em $time';
  }

  @override
  String get glowUpTimeUnitDaysLabel => 'dias';

  @override
  String get glowUpTimeUnitWeeksLabel => 'semanas';

  @override
  String get glowUpTimeUnitMonthsLabel => 'meses';

  @override
  String get glowUpTimeUnitYearsLabel => 'anos';

  @override
  String glowUpTimeValueDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dias',
      one: '$count dia',
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
      one: '$count mês',
    );
    return '$_temp0';
  }

  @override
  String glowUpTimeValueYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count anos',
      one: '$count ano',
    );
    return '$_temp0';
  }

  @override
  String get commonYesterday => 'Ontem';

  @override
  String get commonSelect => 'Selecionar';

  @override
  String get doseReminderTitle => 'Lembrete de dose';

  @override
  String get doseReminderCustomDoseTitle => 'Dose personalizada';

  @override
  String get doseReminderCustomDoseHint => 'Digite a dose em mg';

  @override
  String get doseReminderKeepNextDoseReadyOnHome =>
      'Mantenha sua próxima dose pronta na tela inicial.';

  @override
  String get doseReminderTime => 'Hora';

  @override
  String get doseReminderTurnThisOnToShowNextDoseOnHome =>
      'Ative para mostrar a próxima dose na tela inicial.';

  @override
  String get doseReminderSaveReminder => 'Salvar lembrete';

  @override
  String loggedOn(Object date) {
    return 'Registrado em $date';
  }

  @override
  String get waterLogSmallGlass => 'Copo pequeno';

  @override
  String get waterLogGlass => 'Copo';

  @override
  String get waterLogBottle => 'Garrafa';

  @override
  String get waterLogLargeBottle => 'Garrafa grande';

  @override
  String get waterLogTwoLiters => '2 L';

  @override
  String get waterLogCustomPreset => 'Personalizado';

  @override
  String get waterLogMlUnit => 'ml';

  @override
  String get waterLogOzUnit => 'oz';

  @override
  String get doseLogTitle => 'Dose';

  @override
  String get doseLogEditTitle => 'Editar dose';

  @override
  String get doseLogLogTitle => 'Registrar dose';

  @override
  String get doseLogCustomDose => 'Dose personalizada';

  @override
  String get doseLogCustomDoseBody => 'Ajuste a dose em mg para este registro.';

  @override
  String get doseLogUseThisDose => 'Usar esta dose';

  @override
  String get doseLogMedication => 'Medicamento';

  @override
  String get doseLogInjectionSite => 'Local';

  @override
  String get doseLogNotes => 'Notas';

  @override
  String get doseLogSaveChanges => 'Salvar alterações';

  @override
  String get doseLogAddDose => '+ Registrar dose';

  @override
  String get doseLogDeleteTitle => 'Excluir este registro de dose?';

  @override
  String get doseLogDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get doseLogDeleteLog => 'Excluir registro';

  @override
  String get doseLogSaving => 'Salvando...';

  @override
  String get doseLogCouldNotSave =>
      'Ainda não foi possível salvar este registro de dose.';

  @override
  String get doseLogCouldNotDelete =>
      'Ainda não foi possível excluir este registro de dose.';

  @override
  String get doseLogDeleted => 'Dose excluída';

  @override
  String get doseLogAddedToDoseLog => 'Adicionado ao seu registro de doses';

  @override
  String get doseLogAnythingWorthRemembering =>
      'Algo que valha lembrar sobre esta dose?';

  @override
  String get doseLogDoseLabel => 'Dose';

  @override
  String get exerciseLogTitle => 'Exercício';

  @override
  String get exerciseLogEditTitle => 'Editar exercício';

  @override
  String get exerciseLogLogTitle => 'Registrar exercício';

  @override
  String get exerciseLogActivityType => 'Tipo de atividade';

  @override
  String get exerciseLogCustomActivity => 'Personalizado';

  @override
  String get exerciseLogTypeActivity => 'Digite a atividade';

  @override
  String get exerciseLogDuration => 'Duração';

  @override
  String get exerciseLogIntensity => 'Intensidade';

  @override
  String get exerciseLogNotes => 'Notas';

  @override
  String get exerciseLogLight => 'Leve';

  @override
  String get exerciseLogModerate => 'Moderado';

  @override
  String get exerciseLogIntense => 'Intenso';

  @override
  String exerciseLogDurationLogged(Object minutes) {
    return '$minutes min registrados';
  }

  @override
  String get exerciseLogSaveChanges => 'Salvar alterações';

  @override
  String get exerciseLogAddExercise => '+ Adicionar registro de exercício';

  @override
  String get exerciseLogDeleteTitle => 'Excluir este registro de exercício?';

  @override
  String get exerciseLogDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get exerciseLogDeleteLog => 'Excluir registro';

  @override
  String get exerciseLogSaving => 'Salvando...';

  @override
  String get exerciseLogCouldNotSave =>
      'Ainda não foi possível salvar este registro de exercício.';

  @override
  String get exerciseLogCouldNotDelete =>
      'Ainda não foi possível excluir este registro de exercício.';

  @override
  String get exerciseLogDeleted => 'Exercício excluído';

  @override
  String get exerciseLogAddedToExerciseLog =>
      'Adicionado ao seu registro de exercício';

  @override
  String get exerciseLogAnythingWorthRemembering =>
      'Algo que valha lembrar sobre esta sessão?';

  @override
  String get exerciseLogWalking => 'Caminhada';

  @override
  String get exerciseLogRunning => 'Corrida';

  @override
  String get exerciseLogCycling => 'Ciclismo';

  @override
  String get exerciseLogStrength => 'Força';

  @override
  String get exerciseLogYoga => 'Yoga';

  @override
  String get exerciseLogSwim => 'Natação';

  @override
  String get exerciseLogHiit => 'HIIT';

  @override
  String get weightLogTitle => 'Peso';

  @override
  String get weightLogEditTitle => 'Editar peso';

  @override
  String get weightLogLogTitle => 'Registrar peso';

  @override
  String get weightLogSaveChanges => 'Salvar alterações';

  @override
  String weightLogAddWeight(Object label) {
    return '+ Adicionar peso ($label)';
  }

  @override
  String get weightLogDeleteTitle => 'Excluir este registro de peso?';

  @override
  String get weightLogDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get weightLogDeleteLog => 'Excluir registro';

  @override
  String get weightLogSaving => 'Salvando...';

  @override
  String get weightLogCouldNotSave =>
      'Ainda não foi possível salvar este registro de peso.';

  @override
  String get weightLogCouldNotDelete =>
      'Ainda não foi possível excluir este registro de peso.';

  @override
  String get weightLogDeleted => 'Peso excluído';

  @override
  String get weightLogAddedToWeightLog => 'Adicionado ao seu registro de peso';

  @override
  String get weightLogNoWeightForDay =>
      'Ainda não há peso registrado para este dia.';

  @override
  String get injectionSiteAbdomen => 'Abdômen';

  @override
  String get injectionSiteThigh => 'Coxa';

  @override
  String get injectionSiteUpperArm => 'Parte superior do braço';

  @override
  String get injectionSiteButtocks => 'Glúteos';

  @override
  String get injectionSiteAbdomenUpperLeft => 'Abdômen, superior esquerdo';

  @override
  String get injectionSiteAbdomenUpperRight => 'Abdômen, superior direito';

  @override
  String get injectionSiteAbdomenLowerRight => 'Abdômen, inferior direito';

  @override
  String get injectionSiteAbdomenLowerLeft => 'Abdômen, inferior esquerdo';

  @override
  String get injectionSiteThighUpperLeft => 'Coxa, superior esquerda';

  @override
  String get injectionSiteThighUpperRight => 'Coxa, superior direita';

  @override
  String get injectionSiteThighLowerRight => 'Coxa, inferior direita';

  @override
  String get injectionSiteThighLowerLeft => 'Coxa, inferior esquerda';

  @override
  String get injectionSiteUpperArmLeft => 'Parte superior do braço, esquerda';

  @override
  String get injectionSiteUpperArmRight => 'Parte superior do braço, direita';

  @override
  String get injectionSiteButtocksUpperLeft => 'Glúteos, superior esquerdo';

  @override
  String get injectionSiteButtocksUpperRight => 'Glúteos, superior direito';

  @override
  String get doseReminderFormat => 'Formato';

  @override
  String get doseReminderInjection => 'Injeção';

  @override
  String get doseReminderPill => 'Comprimido';

  @override
  String get doseReminderSite => 'Local';

  @override
  String get doseReminderDate => 'Data';

  @override
  String get supplementReminderTitle => 'Lembrete de suplemento';

  @override
  String get supplementReminderAddSupplement => 'Adicionar suplemento';

  @override
  String get supplementReminderNoSupplementsYet => 'Ainda não há suplementos';

  @override
  String get supplementReminderAddFirstBody =>
      'Adicione seu primeiro lembrete de suplemento para acompanhar sua ingestão diária.';

  @override
  String get supplementReminderSupplementFallback => 'Suplemento';

  @override
  String get supplementReminderEveryDay => 'Todos os dias';

  @override
  String get supplementReminderEveryXDaysLabel => 'A cada X dias';

  @override
  String supplementReminderEveryXDays(Object interval) {
    return 'A cada $interval dias';
  }

  @override
  String get supplementReminderNoDaysSet => 'Nenhum dia definido';

  @override
  String get supplementReminderSupplementName => 'Nome do suplemento';

  @override
  String get supplementReminderTime => 'Hora';

  @override
  String get supplementReminderStartDate => 'Data de início';

  @override
  String get supplementReminderRepeat => 'Repetir';

  @override
  String get supplementReminderDaysOfWeek => 'Dias da semana';

  @override
  String get supplementReminderSelectAtLeastOneDay =>
      'Selecione pelo menos um dia.';

  @override
  String get supplementReminderEvery => 'A cada';

  @override
  String get supplementReminderDay => 'dia';

  @override
  String get supplementReminderDays => 'dias';

  @override
  String get supplementReminderAdd => 'Adicionar';

  @override
  String get symptomsLogTitle => 'Sintomas';

  @override
  String get symptomsLogEditTitle => 'Editar sintomas';

  @override
  String get symptomsLogLogTitle => 'Registrar sintomas';

  @override
  String get symptomsLogSymptomsExperienced => 'Sintomas sentidos';

  @override
  String get symptomsLogNoSymptoms => 'Sem sintomas';

  @override
  String get symptomsLogNoSymptomsToday => 'Sem sintomas hoje';

  @override
  String get symptomsLogOther => 'Outros...';

  @override
  String get symptomsLogSeverityLevel => 'Nível de intensidade';

  @override
  String get symptomsLogNotes => 'Notas';

  @override
  String get symptomsLogAnxiety => 'Ansiedade';

  @override
  String get symptomsLogBelching => 'Arrotos';

  @override
  String get symptomsLogBloating => 'Inchaço';

  @override
  String get symptomsLogConstipation => 'Constipação';

  @override
  String get symptomsLogDiarrhea => 'Diarreia';

  @override
  String get symptomsLogFatigue => 'Fadiga';

  @override
  String get symptomsLogFoodNoise => 'Fome mental';

  @override
  String get symptomsLogHairLoss => 'Queda de cabelo';

  @override
  String get symptomsLogHeartburn => 'Azia';

  @override
  String get symptomsLogIndigestion => 'Indigestão';

  @override
  String get symptomsLogInjectionSiteReaction => 'Reação no local da injeção';

  @override
  String get symptomsLogMetallicTaste => 'Sabor metálico';

  @override
  String get symptomsLogHeadache => 'Dor de cabeça';

  @override
  String get symptomsLogMoodSwings => 'Oscilações de humor';

  @override
  String get symptomsLogNausea => 'Náusea';

  @override
  String get symptomsLogReflux => 'Refluxo';

  @override
  String get symptomsLogStomachPain => 'Dor de estômago';

  @override
  String get symptomsLogSuppressedAppetite => 'Apetite reduzido';

  @override
  String get symptomsLogVomiting => 'Vômito';

  @override
  String get symptomsLogLogged => 'Sintomas registrados';

  @override
  String get symptomsLogMild => 'Leve';

  @override
  String get symptomsLogModerate => 'Moderado';

  @override
  String get symptomsLogSevere => 'Severo';

  @override
  String get symptomsLogAnythingWorthRemembering =>
      'Algo que valha lembrar sobre como você se sentiu?';

  @override
  String get symptomsLogSaveChanges => 'Salvar alterações';

  @override
  String get symptomsLogAddSymptoms => '+ Adicionar registro de sintomas';

  @override
  String get symptomsLogDeleteTitle => 'Excluir este registro de sintomas?';

  @override
  String get symptomsLogDeleteMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get symptomsLogDeleteLog => 'Excluir registro';

  @override
  String get symptomsLogSaving => 'Salvando...';

  @override
  String get symptomsLogCouldNotSave =>
      'Ainda não foi possível salvar este registro de sintomas.';

  @override
  String get symptomsLogCouldNotDelete =>
      'Ainda não foi possível excluir este registro de sintomas.';

  @override
  String get symptomsLogDeleted => 'Sintomas excluídos';

  @override
  String get symptomsLogAddedToSymptomsLog =>
      'Adicionado ao seu registro de sintomas';

  @override
  String homePercentOfDailyGoal(Object percent) {
    return '$percent% da meta diária';
  }

  @override
  String get commonDisclaimer =>
      'O Glu é uma ferramenta de acompanhamento, não um dispositivo médico. Ele não fornece orientação, diagnóstico ou tratamento médico. Sempre converse com seu profissional de saúde sobre medicamentos e decisões de saúde.';
}
