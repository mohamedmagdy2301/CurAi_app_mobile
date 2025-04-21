// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, inference_failure_on_instance_creation, missing_whitespace_between_adjacent_strings

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
        messageText: '👋 أهلاً $userName في CurAi.'
            '\nأنا مساعدك الطبي الذكي، هنا لمساعدتك في تحليل الأعراض وتوجيهك للتخصص المناسب.'
            'من فضلك، ابدأ بوصف الأعراض التي تشعر بها.',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 جرّب تكتب أعراض زي:\n'
            '- صداع مستمر\n'
            '- دوخة وتعب\n'
            '- كحة وسخونية\n'
            '- ألم في المعدة بعد الأكل\n'
            '- ألم في الصدر عند التنفس\n'
            '- صعوبة في النوم\n'
            '- وجع في الظهر\n'
            '- حرارة عالية\n'
            '- زغللة في العين\n'
            '- خمول طول اليوم\n'
            '- قيء أو غثيان\n'
            '- صعوبة في التنفس\n'
            '- رعشة في الجسم\n'
            '- فقدان شهية\n'
            '- ألم في الحلق',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    } else {
      welcomeMessage = MessageBubbleModel(
        messageText: '👋 Welcome $userName to CurAi.'
            "\nI'm your smart medical assistant, here to help analyze your symptoms and guide you to the appropriate specialty.\n"
            'Please start by describing the symptoms you are experiencing.',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 Try writing symptoms like:\n'
            '- Persistent headache\n'
            '- Dizziness and fatigue\n'
            '- Cough and high fever\n'
            '- Stomach pain after eating\n'
            '- Chest pain when breathing\n'
            '- Trouble sleeping\n'
            '- Back pain\n'
            '- High temperature\n'
            '- Blurry vision\n'
            '- Feeling tired all day\n'
            '- Nausea or vomiting\n'
            '- Shortness of breath\n'
            '- Body shivering\n'
            '- Loss of appetite\n'
            '- Sore throat',
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
