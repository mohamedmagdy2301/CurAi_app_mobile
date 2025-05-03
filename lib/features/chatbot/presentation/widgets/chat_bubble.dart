import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/datetime_extensions.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/message_bubble_widget.dart';
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
        _buildMessageTime(context),
      ],
    ).paddingSymmetric(horizontal: 5);
  }

  Widget _buildMessageTime(BuildContext context) {
    return AutoSizeText(
      messageModel.date.toLocalizedTime(context),
      style: TextStyleApp.regular12().copyWith(
        color: context.onPrimaryColor.withAlpha(220),
      ),
      maxLines: 1,
    );
  }
}
