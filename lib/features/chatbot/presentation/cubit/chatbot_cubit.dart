// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls, inference_failure_on_function_invocation, inference_failure_on_instance_creation, missing_whitespace_between_adjacent_strings, document_ignores

import 'dart:io';

import 'package:curai_app_mobile/core/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_model.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/diagnosis_model/diagnosis_request.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/chatbot/domain/usecases/diagnosis_usecase.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit(this._diagnosisUsecase, {required this.isArabic})
      : super(ChatBotInitial());

  List<MessageBubbleModel> messagesList = [];
  final DiagnosisUsecase _diagnosisUsecase;
  final bool isArabic;
  final Box<MessageBubbleModel> _chatBox =
      Hive.box<MessageBubbleModel>('chat_messages');

  /// get the username from Cache Data Local

  /// Check if the chat box is closed
  Future<void> loadPreviousMessages() async {
    messagesList = _chatBox.values.toList().reversed.toList();
    emit(ChatBotDone(messagesList: List.from(messagesList)));

    // Add welcome only if no previous messages
    if (messagesList.isEmpty) {
      await addWelcomeMessage();
    }
  }

  /// clear the chat box
  Future<void> clearChatBot() async {
    await _chatBox.clear();
    messagesList.clear();
    emit(ChatBotInitial());
  }

  /// Add a new message to the chat box
  Future<void> addMessage(MessageBubbleModel message) async {
    messagesList.insert(0, message);
    await _chatBox.add(message);
    if (isClosed) return;
    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  /// Handle diagnosis response and display appropriate messages
  Future<void> handleDiagnosisResponse(DiagnosisModel result) async {
    if (result.prediction == '') {
      removeLoadingMessage();
      final botMessage = MessageBubbleModel(
        messageText: isArabic ? result.messageAr : result.messageEn,
        date: DateTime.now(),
        sender: SenderType.bot,
      );
      await addMessage(botMessage);
    } else {
      removeLoadingMessage();

      final botMessageDiagnosis = MessageBubbleModel(
        messageText: result.responseMessage(isArabic: isArabic),
        date: DateTime.now(),
        sender: SenderType.bot,
      );
      await addMessage(botMessageDiagnosis);

      final goodbyeMessage = MessageBubbleModel(
        messageText: isArabic
            ? 'شكرًا لك يا ${getFullName()} على استخدامك CurAi.\nنتمنى لك الشفاء العاجل!. 😊'
            : 'Thank you, ${getFullName()}, for using CurAi.\nWe wish you a speedy recovery! 😊',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
      await Future.delayed(const Duration(milliseconds: 1000));
      await addMessage(goodbyeMessage);

      final restartMessage = MessageBubbleModel(
        messageText: isArabic
            ? 'هل لديك أي أعراض أخرى تود مشاركتها؟'
            : "Any other symptoms you'd like to share?",
        date: DateTime.now(),
        sender: SenderType.bot,
      );
      await Future.delayed(const Duration(milliseconds: 1400));

      await addMessage(restartMessage);
    }
  }

  /// Add welcome and suggestion messages
  Future<void> addWelcomeMessage() async {
    MessageBubbleModel welcomeMessage;
    MessageBubbleModel startDescribingMessage;
    MessageBubbleModel suggestionsMessage;

    if (isArabic) {
      welcomeMessage = MessageBubbleModel(
        messageText: '👋 أهلاً ${getFullName()} في CurAi.'
            '\nأنا مساعدك الطبي الذكي، هنا لمساعدتك في تحليل الأعراض وتوجيهك للتخصص المناسب.',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      startDescribingMessage = MessageBubbleModel(
        messageText: 'من فضلك، ابدأ بوصف الأعراض التي تشعر بها.❗',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 جرّب تكتب أعراض زي:\n'
            '     • صداع مستمر\n'
            '     • دوخة وتعب\n'
            '     • كحة وسخونية\n'
            '     • ألم في المعدة\n'
            '     • ألم في الصدر\n'
            '     • حرارة عالية\n'
            '     • زغللة في العين\n'
            '     • خمول طول اليوم',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    } else {
      welcomeMessage = MessageBubbleModel(
        messageText: '👋 Welcome, ${getFullName()} to CurAi!'
            "\nI'm here to help analyze your symptoms and guide you to the right specialty.",
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      suggestionsMessage = MessageBubbleModel(
        messageText: '💡 Try writing symptoms like:\n'
            '     • Persistent headache\n'
            '     • Dizziness and fatigue\n'
            '     • Cough and high fever\n'
            '     • Stomach pain\n'
            '     • Chest pain\n'
            '     • High temperature\n'
            '     • Blurry vision\n'
            '     • Feeling tired all day',
        date: DateTime.now(),
        sender: SenderType.bot,
      );

      startDescribingMessage = MessageBubbleModel(
        messageText: 'Please start describing your symptoms.❗',
        date: DateTime.now(),
        sender: SenderType.bot,
      );
    }

    await Future.delayed(const Duration(milliseconds: 600));
    await addMessage(welcomeMessage);
    await Future.delayed(const Duration(milliseconds: 1000));
    await addMessage(startDescribingMessage);
    await Future.delayed(const Duration(milliseconds: 1600));
    await addMessage(suggestionsMessage);
  }

  /// Add a new user message and perform a diagnosis
  Future<void> addNewMessage({String? message, XFile? image}) async {
    Either<String, DiagnosisModel> response;
    emit(ChatBotLoading());

    String? imagePath;
    if (image != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final savedImage = await File(image.path).copy(
        '${appDir.path}/${DateTime.now().millisecondsSinceEpoch}_${image.name}',
      );
      imagePath = savedImage.path;
    }

    final newUserMessage = MessageBubbleModel(
      messageText: message ?? '',
      date: DateTime.now(),
      sender: SenderType.user,
      imagePath: imagePath,
    );

    await addMessage(newUserMessage);
    addLoadingMessage();

    if (image != null) {
      response = await _diagnosisUsecase.call(DiagnosisRequest(image: image));
    } else {
      response =
          await _diagnosisUsecase.call(DiagnosisRequest(inputText: message));
    }

    removeLoadingMessage();
    response.fold(addErrorMessage, handleDiagnosisResponse);
  }

  /// Add loading message
  void addLoadingMessage() {
    if (isArabic) {
      messagesList.insert(
        0,
        MessageBubbleModel(
          messageText: 'جاري معالجة طلبك 🔃...',
          date: DateTime.now(),
          sender: SenderType.bot,
        ),
      );
    } else {
      messagesList.insert(
        0,
        MessageBubbleModel(
          messageText: '🔃 Processing your request...',
          date: DateTime.now(),
          sender: SenderType.bot,
        ),
      );
    }
    if (isClosed) return;
    emit(ChatBotLoading());
  }

  /// Remove loading message
  void removeLoadingMessage() {
    messagesList.removeWhere(
      (message) =>
          message.messageText?.contains(
            isArabic
                ? 'جاري معالجة طلبك 🔃...'
                : '🔃 Processing your request...',
          ) ??
          false,
    );
    if (isClosed) return;
    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  /// Add error message
  void addErrorMessage(String errorMessage) {
    final errorMessageModel = MessageBubbleModel(
      messageText: errorMessage,
      date: DateTime.now(),
      sender: SenderType.bot,
    );
    removeLoadingMessage();
    messagesList.insert(0, errorMessageModel);
    if (isClosed) return;
    emit(
      ChatBotDone(messagesList: List.from(messagesList)),
    );
  }

  /// Reset success message
  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isClosed) return;
    emit(ChatBotInitial());
  }
}
