// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, inference_failure_on_instance_creation

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
  // Dio instance

  // إضافة رسالة الترحيب مع أمثلة الأسئلة أو الأعراض
  void addWelcomeMessage() {
    MessageBubbleModel? welcomeMessage;
    MessageBubbleModel? suggestionsMessage;
    if (isArabic) {
      welcomeMessage = MessageBubbleModel(
        messageText:
            '👋 أهلاً بيك في CurAi\nأنا مساعدك الطبي الذكي.\nمن فضلك، احكيلي عن الأعراض اللي حاسس بيها علشان أساعدك بالتشخيص المناسب 🩺',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    } else {
      welcomeMessage = MessageBubbleModel(
        messageText:
            '👋 Welcome to CurAi\nI am your smart medical assistant.\nPlease tell me about the symptoms you are feeling so I can help you with the appropriate diagnosis 🩺',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    }
    if (isArabic) {
      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 يمكنك تبدء بـ:\n'
            '- عندي صداع مستمر\n'
            '- بحس بدوخة وتعب\n'
            '- عندي كحة وسخونية\n'
            '- بطني بتوجعني بعد الأكل\n'
            '- عندي ألم في الصدر\n'
            '- مش قادر أنام كويس',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    } else {
      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 You can start with:\n'
            '- I have a persistent headache\n'
            '- I feel dizzy and tired\n'
            '- I have a cough and fever\n'
            '- My stomach hurts after eating\n'
            '- I have chest pain\n'
            "- I can't sleep well",
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    }

    // إضافة الرسائل للقائمة
    messagesList
      ..insert(0, welcomeMessage)
      ..insert(0, suggestionsMessage);
    if (isClosed) return;

    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  // إضافة رسالة تحميل
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

  //  إزالة رسالة التحميل
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

  // إضافة رسالة خطأ
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

  // إضافة رسالة جديدة من المستخدم
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
          messageText: result.botResponseDiagnosis,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        final botMessageSpecialty = MessageBubbleModel(
          messageText: result.botResponseSpecialty,
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

  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isClosed) return;
    emit(ChatBotInitial());
  }
}
