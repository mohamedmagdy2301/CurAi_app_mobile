import 'dart:developer';

import 'package:curai_app_mobile/features/chatbot/data/models/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());

  List<MessageModel> messagesList = [];

  // Dio instance
  final Dio _dio = Dio();

  Future<void> addNewMessage(String newMessage) async {
    emit(ChatBotLoading());

    try {
      // Create the new user message
      final newUserMessage = MessageModel(
        messageText: newMessage,
        date: DateTime.now(),
        sender: SenderType.user,
      );

      // Add the new user message to the message history
      messagesList.insert(0, newUserMessage);

      // Call Model AI API to get the bot response
      final response = await _dio.post(
        'https://5305-156-199-126-246.ngrok-free.app/predict',
        data: {
          'input': newMessage,
        },
      );

      // Check if the response is successful
      if (response.statusCode == 200 && response.data['status'] == 'Success') {
        final botResponse =
            response.data['message'] + ' \n ' + response.data['prediction'];

        // Create the bot's response message
        final botMessage = MessageModel(
          messageText: botResponse as String,
          date: DateTime.now(),
          sender: SenderType.bot,
        );

        // Add the bot's response to the message history
        messagesList.insert(0, botMessage);

        // Emit done state with updated message history
        emit(ChatBotDone(messagesList: List.from(messagesList)));
      } else {
        emit(const ChatBotFialure(message: 'Failed to get bot response'));
      }

      await resetSuccessMessage();
    } on DioException catch (e) {
      log('Error: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout) {
        emit(const ChatBotFialure(message: 'Connection timeout'));
      } else if (e.type == DioExceptionType.receiveTimeout) {
        emit(const ChatBotFialure(message: 'Receive timeout'));
      } else if (e.type == DioExceptionType.sendTimeout) {
        emit(const ChatBotFialure(message: 'Send timeout'));
      } else if (e.type == DioExceptionType.badResponse) {
        emit(const ChatBotFialure(message: 'Bad response from server'));
      } else if (e.type == DioExceptionType.cancel) {
        emit(const ChatBotFialure(message: 'Request canceled'));
      }

      // Handle Dio errors (e.g., network issues, server errors)
      emit(ChatBotFialure(message: 'Error: ${e.message}'));
    } catch (e) {
      // Catch any other exceptions
      emit(ChatBotFialure(message: 'Error: $e'));
    }
  }

  Future<void> resetSuccessMessage() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(ChatBotInitial());
  }
}
