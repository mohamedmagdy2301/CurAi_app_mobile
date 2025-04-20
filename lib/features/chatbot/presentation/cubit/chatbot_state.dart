import 'package:curai_app_mobile/features/chatbot/data/models/messages_chatbot_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatBotState extends Equatable {
  const ChatBotState();

  @override
  List<Object> get props => [];
}

class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotDone extends ChatBotState {
  const ChatBotDone({required this.messagesList});
  final List<MessageModel> messagesList;

  @override
  List<Object> get props => [messagesList];
}

class ChatBotFialure extends ChatBotState {
  const ChatBotFialure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
