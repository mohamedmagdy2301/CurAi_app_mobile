import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/core/utils/helper/formatted_time.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/message_bubble_widget.dart';
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
        5.hSpace,
        _buildMessageTime(context),
      ],
    );
  }

  Widget _buildMessageTime(BuildContext context) {
    return AutoSizeText(
      formattedTime(context, messageModel.date),
      textDirection: textDirection(messageModel.messageText),
      style: TextStyleApp.regular12().copyWith(
        color: context.onSecondaryColor,
      ),
      maxLines: 1,
    );
  }
}
