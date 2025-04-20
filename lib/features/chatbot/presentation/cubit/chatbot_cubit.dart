// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation

import 'package:curai_app_mobile/features/chatbot/data/models/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit({required this.isArabic}) : super(ChatBotInitial());

  List<MessageModel> messagesList = [];

  final bool isArabic;
  // Dio instance
  final Dio _dio = Dio();

  // إضافة رسالة الترحيب مع أمثلة الأسئلة أو الأعراض
  void addWelcomeMessage() {
    MessageModel? welcomeMessage;
    MessageModel? suggestionsMessage;
    if (isArabic) {
      welcomeMessage = MessageModel(
        messageText:
            '👋 أهلاً بيك في CurAi\nأنا مساعدك الطبي الذكي.\nمن فضلك، احكيلي عن الأعراض اللي حاسس بيها علشان أساعدك بالتشخيص المناسب 🩺',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    } else {
      welcomeMessage = MessageModel(
        messageText:
            '👋 Welcome to CurAi\nI am your smart medical assistant.\nPlease tell me about the symptoms you are feeling so I can help you with the appropriate diagnosis 🩺',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    }
    if (isArabic) {
      suggestionsMessage = MessageModel(
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
      suggestionsMessage = MessageModel(
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
        MessageModel(
          messageText: 'جاري معالجة طلبك...',
          date: DateTime.now(),
          sender: SenderType.bot,
        ),
      );
    } else {
      messagesList.insert(
        0,
        MessageModel(
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
    final errorMessageModel = MessageModel(
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

    try {
      final newUserMessage = MessageModel(
        messageText: newMessage,
        date: DateTime.now(),
        sender: SenderType.user,
      );
      messagesList.insert(0, newUserMessage);
      addLoadingMessage();
      // الاتصال بالـ API
      final response = await _dio.post(
        'https://aa6c-156-199-179-208.ngrok-free.app/predict',
        data: {'input': newMessage},
      );

      // إزالة رسالة "جاري المعالجة..."
      removeLoadingMessage();

      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final diagnosisParts =
            (response.data['prediction'] as String).split(' - ');
        final diagnosis = diagnosisParts.first.trim();
        final specialty = diagnosisParts.length > 1
            ? diagnosisParts.last.replaceFirst('Specialization:', '').trim()
            : 'Not specified';

        final botResponseDiagnosis = '🧠 Diagnosis: $diagnosis';

        final botResponseSpecialty = '🏥 Recommended Specialty: $specialty';

        final botMessageDiagnosis = MessageModel(
          messageText: botResponseDiagnosis,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        final botMessageSpecialty = MessageModel(
          messageText: botResponseSpecialty,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        final botMessage = MessageModel(
          messageText: response.data['message'] as String,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        if (response.data['prediction'] == '') {
          messagesList.insert(0, botMessage);
        } else {
          messagesList
            ..insert(0, botMessageDiagnosis)
            ..insert(0, botMessageSpecialty);
        }
        if (isClosed) return;

        emit(ChatBotDone(messagesList: List.from(messagesList)));
      } else {
        addLoadingMessage();
        addErrorMessage('❌ فشل في الحصول على الرد من البوت.');
      }

      await resetSuccessMessage();
    } on DioException catch (e) {
      messagesList
          .removeWhere((msg) => msg.messageText.contains('جاري معالجة'));
      var errorText = 'حدث خطأ: ${e.message}';

      if (e.type == DioExceptionType.connectionTimeout) {
        errorText = '⏱ انتهى وقت الاتصال';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorText = '📡 انتهى وقت الاستقبال';
      } else if (e.type == DioExceptionType.sendTimeout) {
        errorText = '📤 انتهى وقت الإرسال';
      } else if (e.type == DioExceptionType.badResponse) {
        errorText = '❌ خطأ في الرد من السيرفر';
      } else if (e.type == DioExceptionType.cancel) {
        errorText = '🚫 تم إلغاء الطلب';
      }

      addErrorMessage(errorText);
    } catch (e) {
      messagesList
          .removeWhere((msg) => msg.messageText.contains('جاري معالجة'));
      addErrorMessage('⚠️ حصل استثناء: $e');
    }
  }

  // إعادة الرسالة الأصلية بعد النجاح
  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 3));
    if (isClosed) return;
    emit(ChatBotInitial());
  }
}
