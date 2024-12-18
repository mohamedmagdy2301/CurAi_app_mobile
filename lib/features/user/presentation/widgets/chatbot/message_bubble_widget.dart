import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/features/user/models/chatbot_model/messages_chatbot_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/chatbot_markdown_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubbleWidget extends StatelessWidget {
  const MessageBubbleWidget({
    required this.messageModel,
    super.key,
  });
  final MessageModel messageModel;
  bool get isUserMessage => messageModel.sender == SenderType.user;

  EdgeInsets _bubbleMargin() {
    return isUserMessage
        ? EdgeInsets.only(
            right: isArabic() ? 0 : 40.w,
            left: isArabic() ? 40.w : 0,
          )
        : EdgeInsets.only(
            right: isArabic() ? 40.w : 0,
            left: isArabic() ? 0 : 40.w,
          );
  }

  BorderRadius _bubbleBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(10.r),
      topRight: Radius.circular(10.r),
      bottomRight: isUserMessage
          ? Radius.circular(isArabic() ? 0 : 10.r)
          : Radius.circular(isArabic() ? 10.r : 0),
      bottomLeft: isUserMessage
          ? Radius.circular(isArabic() ? 10.r : 0)
          : Radius.circular(isArabic() ? 0 : 10.r),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding(vertical: 12, horizontal: 15),
      margin: _bubbleMargin(),
      decoration: BoxDecoration(
        color: isUserMessage
            ? context.colors.primaryColor
            : context.colors.chatBubbleIsBot,
        borderRadius: _bubbleBorderRadius(),
      ),
      child: isUserMessage
          ? Text(
              messageModel.messageText,
              textDirection: textDirection(messageModel.messageText),
              textAlign: isArabic() ? TextAlign.right : TextAlign.left,
              style: context.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
                height: 1.5.h,
              ),
            )
          : ChatBotMarkdownBubble(messageText: messageModel.messageText),
    );
  }
}
