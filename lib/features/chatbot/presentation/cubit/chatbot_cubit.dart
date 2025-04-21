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
  //     {
  // _initializeChatBox();
  // }

  List<MessageBubbleModel> messagesList = [];

  final DiagnosisUsecase _diagnosisUsecase;
  final bool isArabic;

  /// get the username from Cache Data Local
  String getUsername() {
    final userName =
        CacheDataHelper.getData(key: SharedPrefKey.keyUserName) ?? '';
    return userName is String ? userName : '';
  }

  /// Add welcome and suggestion messages
  Future<void> addWelcomeMessage() async {
    MessageBubbleModel? welcomeMessage;
    MessageBubbleModel? suggestionsMessage;
    MessageBubbleModel? startDescribingMessage;

    if (isArabic) {
      welcomeMessage = MessageBubbleModel(
        messageText: '👋 أهلاً ${getUsername()} في CurAi.'
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
        messageText: '👋 Welcome, ${getUsername()} to CurAi!'
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
    messagesList.insert(0, welcomeMessage);
    // await saveMessageLocally(welcomeMessage);
    if (isClosed) return;
    emit(ChatBotDone(messagesList: List.from(messagesList)));
    await Future.delayed(const Duration(milliseconds: 1000));
    messagesList.insert(0, startDescribingMessage);
    // await saveMessageLocally(
    //   startDescribingMessage,
    // );
    if (isClosed) return;
    emit(ChatBotDone(messagesList: List.from(messagesList)));
    await Future.delayed(const Duration(milliseconds: 1600));
    messagesList.insert(0, suggestionsMessage);
    // await saveMessageLocally(suggestionsMessage);

    if (isClosed) return;
    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  /// Add a new user message and perform a diagnosis
  Future<void> addNewMessage(String newMessage) async {
    emit(ChatBotLoading());
    final newUserMessage = MessageBubbleModel(
      messageText: newMessage,
      date: DateTime.now(),
      sender: SenderType.user,
    );
    messagesList.insert(0, newUserMessage);
    // await saveMessageLocally(newUserMessage);

    addLoadingMessage();

    final response = await _diagnosisUsecase.call(
      DiagnosisRequest(
        input: newMessage,
      ),
    );

    removeLoadingMessage();

    response.fold(addErrorMessage, (result) async {
      if (result.prediction == '') {
        final botMessage = MessageBubbleModel(
          messageText: result.message!,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        messagesList.insert(0, botMessage);
        // await saveMessageLocally(botMessage);
      } else {
        final botMessageDiagnosis = MessageBubbleModel(
          messageText: result.botResponse,
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        final goodbyeMessage = MessageBubbleModel(
          messageText: isArabic
              ? 'شكرًا لك يا ${getUsername()} على استخدامك CurAi.'
                  '\nنتمنى لك الشفاء العاجل!. 😊'
              : 'Thank you, ${getUsername()}, for using CurAi.'
                  '\nWe wish you a speedy recovery! 😊',
          date: DateTime.now(),
          sender: SenderType.bot,
        );
        final restartMessage = MessageBubbleModel(
          messageText: isArabic
              ? 'هل هناك أعراض أخرى تحب تخبرني بها؟'
              : "Any other symptoms you'd like to share?",
          date: DateTime.now(),
          sender: SenderType.bot,
        );

        messagesList.insert(0, botMessageDiagnosis);
        // await saveMessageLocally(botMessageDiagnosis);

        if (isClosed) return;
        emit(ChatBotDone(messagesList: List.from(messagesList)));
        await Future.delayed(const Duration(milliseconds: 1500));
        messagesList.insert(0, goodbyeMessage);
        // await saveMessageLocally(goodbyeMessage); // Save goodbye message

        if (isClosed) return;
        emit(ChatBotDone(messagesList: List.from(messagesList)));
        await Future.delayed(const Duration(milliseconds: 1500));
        messagesList.insert(0, restartMessage);
        // await saveMessageLocally(restartMessage); // Save restart message

        if (isClosed) return;
        emit(ChatBotDone(messagesList: List.from(messagesList)));
      }
    });
    await resetSuccessMessage();
  }

  // Add loading message
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

  // Remove loading message
  void removeLoadingMessage() {
    if (isArabic) {
      messagesList.removeWhere(
        (message) => message.messageText.contains('جاري معالجة طلبك 🔃...'),
      );
    } else {
      messagesList.removeWhere(
        (message) =>
            message.messageText.contains('🔃 Processing your request...'),
      );
    }
    if (isClosed) return;

    emit(ChatBotDone(messagesList: List.from(messagesList)));
  }

  // Add error message
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

  // Reset success message
  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 1));
    if (isClosed) return;
    emit(ChatBotInitial());
  }
}
 // late Box<MessageBubbleModel> chatBox;

  /// Open and initialize the chat box
  // Future<void> _initializeChatBox() async {
  //   if (!Hive.isBoxOpen('chatMessages')) {
  //     chatBox = await Hive.openBox<MessageBubbleModel>('chatMessages');
  //   } else {
  //     chatBox = Hive.box<MessageBubbleModel>('chatMessages');
  //   }
  //   await loadMessagesLocally();
  // }

  /// Save a message to Hive
  // Future<void> saveMessageLocally(MessageBubbleModel message) async {
  //   await chatBox.add(message);
  // }

  /// Load all messages from Hive
  // Future<void> loadMessagesLocally() async {
  //   if (!Hive.isBoxOpen('chatMessages')) {
  //     // Wait for initialization if not yet initialized
  //     await _initializeChatBox();
  //   }
  //   final messages = chatBox.values.toList();
  //   emit(ChatBotDone(messagesList: List.from(messages)));
  // }