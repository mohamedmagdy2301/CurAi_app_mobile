// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/chatbot/domain/usecases/diagnosis_usecase.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit(this._diagnosisUsecase, {required this.isArabic})
      : super(ChatBotInitial());
  final DiagnosisUsecase _diagnosisUsecase;

  List<MessageBubbleModel> messagesList = [];

  final bool isArabic;
  Future<void> addWelcomeMessage() async {
    final userName =
        await CacheDataHelper.getData(key: SharedPrefKey.keyUserName) ?? '';
    MessageBubbleModel? welcomeMessage;
    MessageBubbleModel? suggestionsMessage;

    if (isArabic) {
      welcomeMessage = MessageBubbleModel(
        messageText: '👋 أهلاً $userName '
            'في CurAi.'
            '\n\nأنا مساعدك الطبي الذكي، هنا لمساعدتك في تحليل الأعراض وتوجيهك للتخصص المناسب.\n\n'
            'من فضلك، ابدأ بوصف الأعراض التي تشعر بها.',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 أمثلة لما يمكنك كتابته:\n'
            '- أعاني من صداع مستمر منذ عدة أيام\n'
            '- أشعر بدوخة وتعب عام\n'
            '- أعاني من كحة شديدة وسخونية\n'
            '- عندي آلام في المعدة بعد الأكل\n'
            '- أشعر بألم في الصدر عند التنفس\n'
            '- لا أستطيع النوم جيدًا خلال الليل',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    } else {
      welcomeMessage = MessageBubbleModel(
        messageText: '👋 Welcome $userName '
            'to CurAi.\n '
            "I'm your smart medical assistant, here to help analyze your symptoms and guide you to the appropriate specialty.\n"
            'Please start by describing the symptoms you are experiencing.',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 Here are some examples you can start with:\n'
            '- I have had a persistent headache for several days\n'
            '- I feel dizzy and extremely tired\n'
            '- I have a bad cough and high fever\n'
            '- I feel stomach pain after eating\n'
            '- I experience chest pain when breathing\n'
            '- I can’t sleep well at night',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    }

    messagesList
      ..insert(0, welcomeMessage)
      ..insert(0, suggestionsMessage);
    if (isClosed) return;

    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  Future<void> addNewMessage(String newMessage) async {
    emit(ChatBotLoading());
    final newUserMessage = MessageBubbleModel(
      messageText: newMessage,
      date: DateTime.now(),
      sender: SenderType.user,
    );
    messagesList.insert(0, newUserMessage);

    addLoadingMessage();

    final response =
        await _diagnosisUsecase.call(DiagnosisRequest(input: newMessage));

    removeLoadingMessage();

    response.fold(addErrorMessage, (result) {
      if (result.prediction == '') {
        final botMessage = MessageBubbleModel(
          messageText: result.message!,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        messagesList.insert(0, botMessage);
      } else {
        final botMessageDiagnosis = MessageBubbleModel(
          messageText: result.botResponse,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        final botMessageSpecialty = MessageBubbleModel(
          messageText: '',
          date: DateTime.now(),
          sender: SenderType.bot,
        );

        messagesList
          ..insert(0, botMessageDiagnosis)
          ..insert(0, botMessageSpecialty);
        if (isClosed) return;
        emit(ChatBotDone(messagesList: List.from(messagesList)));
      }
    });
    await resetSuccessMessage();
  }

  void addLoadingMessage() {
    if (isArabic) {
      messagesList.insert(
        0,
        MessageBubbleModel(
          messageText: 'جاري معالجة طلبك...',
          date: DateTime.now(),
          sender: SenderType.bot,
        ),
      );
    } else {
      messagesList.insert(
        0,
        MessageBubbleModel(
          messageText: 'Processing your request...',
          date: DateTime.now(),
          sender: SenderType.bot,
        ),
      );
    }
    if (isClosed) return;

    emit(ChatBotLoading());
  }

  void removeLoadingMessage() {
    if (isArabic) {
      messagesList.removeWhere(
        (message) => message.messageText.contains('جاري معالجة'),
      );
    } else {
      messagesList.removeWhere(
        (message) => message.messageText.contains('Processing your request'),
      );
    }
    if (isClosed) return;

    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  void addErrorMessage(String errorMessage) {
    final errorMessageModel = MessageBubbleModel(
      messageText: errorMessage,
      date: DateTime.now(),
      sender: SenderType.bot,
    );

    messagesList.insert(0, errorMessageModel);
    if (isClosed) return;

    emit(ChatBotFialure(message: errorMessage));
  }

  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isClosed) return;
    emit(ChatBotInitial());
  }
}
