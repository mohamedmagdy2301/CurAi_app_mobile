import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/chatbot_markdown_bubble.dart';
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    required this.messageModel,
    super.key,
  });
  final MessageBubbleModel messageModel;
  bool get isUserMessage => messageModel.sender == SenderType.user;

  EdgeInsets _bubbleMargin(BuildContext context) {
    return isUserMessage
        ? EdgeInsets.only(
            right: context.isStateArabic ? 0 : 40,
            left: context.isStateArabic ? 40 : 0,
          )
        : EdgeInsets.only(
            right: context.isStateArabic ? 40 : 0,
            left: context.isStateArabic ? 0 : 40,
          );
  }

  BorderRadius _bubbleBorderRadius(BuildContext context) {
    return BorderRadius.only(
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomRight: isUserMessage
          ? Radius.circular(context.isStateArabic ? 0 : 10)
          : Radius.circular(context.isStateArabic ? 10 : 0),
      bottomLeft: isUserMessage
          ? Radius.circular(context.isStateArabic ? 10 : 0)
          : Radius.circular(context.isStateArabic ? 0 : 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding(vertical: 12, horizontal: 15),
      margin: _bubbleMargin(context),
      decoration: BoxDecoration(
        color: isUserMessage ? context.primaryColor : Colors.green,
        borderRadius: _bubbleBorderRadius(context),
      ),
      child: isUserMessage
          ? AutoSizeText(
              messageModel.messageText,
              textDirection: textDirection(messageModel.messageText),
              textAlign:
                  context.isStateArabic ? TextAlign.right : TextAlign.left,
              style: TextStyleApp.regular14().copyWith(
                color: context.onPrimaryColor,
                height: 1.5,
              ),
            )
          : ChatBotMarkdownBubble(messageText: messageModel.messageText),
    );
  }
}
