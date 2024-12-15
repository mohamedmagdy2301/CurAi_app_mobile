// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/features/user/presentation/models/messages_chatbot_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

// Define states
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatDone extends ChatState {
  ChatDone({required this.messagesList});
  final List<MessageModel> messagesList;
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  // A variable to hold all messages history
  List<MessageModel> messagesList = [];

  Future<void> addNewMessage(String newMessage) async {
    // Emit loading state while waiting for the bot response
    emit(ChatLoading());

    // Create the new user message
    final newUserMessage = MessageModel(
      messageText: newMessage,
      date: DateTime.now(),
      sender: SenderType.user,
    );

    // Add the new user message to the message history
    messagesList.insert(0, newUserMessage);

    // Call Gemini API to get the bot response
    final request = await Gemini.instance.prompt(
      parts: [
        Part.text(newMessage),
      ],
    );

    final response = request?.output.toString() ?? 'No response';

    // Create the bot's response message
    final botMessage = MessageModel(
      messageText: response,
      date: DateTime.now(),
      sender: SenderType.bot,
    );

    // Add the bot's response to the message history
    messagesList.insert(0, botMessage);

    // Emit done state with updated message history
    emit(ChatDone(messagesList: List.from(messagesList)));

    await resetSuccessMessage();
  }

  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(ChatInitial());
  }
}
