import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/formatted_time.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/features/user/models/chatbot_model/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/message_bubble_widget.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.messageModel,
    super.key,
  });

  final MessageModel messageModel;

  bool get isUserMessage => messageModel.sender == SenderType.user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isUserMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        MessageBubbleWidget(messageModel: messageModel),
        context.spaceHeight(5),
        _buildMessageTime(context),
      ],
    );
  }

  Widget _buildMessageTime(BuildContext context) {
    return AutoSizeText(
      formattedTime(context, messageModel.date),
      textDirection: textDirection(messageModel.messageText),
      style: context.styleRegular12.copyWith(
        color: context.color.onSecondary,
      ),
      maxLines: 1,
    );
  }
}
