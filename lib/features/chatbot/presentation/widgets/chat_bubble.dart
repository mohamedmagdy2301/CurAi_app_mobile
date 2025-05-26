import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/message_bubble_widget.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/message_time_widget.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.messageModel, super.key});

  final MessageBubbleModel messageModel;

  bool get isUserMessage => messageModel.sender == SenderType.user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        MessageBubbleWidget(messageModel: messageModel),
        5.hSpace,
        MessageTimeWidget(messageModel: messageModel),
      ],
    ).paddingSymmetric(horizontal: 5);
  }
}
