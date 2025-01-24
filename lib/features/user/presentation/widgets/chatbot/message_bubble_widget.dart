import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/features/user/models/chatbot_model/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/chatbot_markdown_bubble.dart';
import 'package:flutter/material.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    required this.messageModel,
    super.key,
  });
  final MessageModel messageModel;
  bool get isUserMessage => messageModel.sender == SenderType.user;

  EdgeInsets _bubbleMargin(BuildContext context) {
    return isUserMessage
        ? EdgeInsets.only(
            right: context.isStateArabic ? 0 : context.setW(40),
            left: context.isStateArabic ? context.setW(40) : 0,
          )
        : EdgeInsets.only(
            right: context.isStateArabic ? context.setW(40) : 0,
            left: context.isStateArabic ? 0 : context.setW(40),
          );
  }

  BorderRadius _bubbleBorderRadius(BuildContext context) {
    return BorderRadius.only(
      topLeft: Radius.circular(context.setR(10)),
      topRight: Radius.circular(context.setR(10)),
      bottomRight: isUserMessage
          ? Radius.circular(context.isStateArabic ? 0 : context.setR(10))
          : Radius.circular(context.isStateArabic ? context.setR(10) : 0),
      bottomLeft: isUserMessage
          ? Radius.circular(context.isStateArabic ? context.setR(10) : 0)
          : Radius.circular(context.isStateArabic ? 0 : context.setR(10)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.padding(vertical: 12, horizontal: 15),
      margin: _bubbleMargin(context),
      decoration: BoxDecoration(
        color: isUserMessage ? context.colors.primary : Colors.green,
        borderRadius: _bubbleBorderRadius(context),
      ),
      child: isUserMessage
          ? AutoSizeText(
              messageModel.messageText,
              textDirection: textDirection(messageModel.messageText),
              textAlign:
                  context.isStateArabic ? TextAlign.right : TextAlign.left,
              style: context.styleRegular16.copyWith(
                color: context.color.onPrimary,
                height: context.setH(1.5),
              ),
            )
          : ChatBotMarkdownBubble(messageText: messageModel.messageText),
    );
  }
}
