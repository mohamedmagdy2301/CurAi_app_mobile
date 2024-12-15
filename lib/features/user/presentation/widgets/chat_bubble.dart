import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/formatted_time.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/features/user/presentation/models/messages_chatbot_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        _buildMessageBubble(context),
        SizedBox(height: 5.h),
        _buildMessageTime(context),
      ],
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    return Container(
      padding: padding(vertical: 10, horizontal: 10),
      margin: EdgeInsets.only(
        right: isUserMessage ? 0 : 40.w,
        left: isUserMessage ? 40.w : 0,
      ),
      decoration: BoxDecoration(
        color: isUserMessage
            ? context.colors.primaryColor
            : context.colors.chatBubbleIsBot,
        borderRadius: _bubbleBorderRadius(),
      ),
      child: Text(
        messageModel.messageText,
        textDirection: textDirection(messageModel.messageText),
        style: context.textTheme.bodyMedium!.copyWith(
          color: Colors.white,
        ),
      ),
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

  Widget _buildMessageTime(BuildContext context) {
    return Text(
      formattedTime(messageModel.date),
      textDirection: textDirection(messageModel.messageText),
      style: context.textTheme.bodySmall!.copyWith(
        color: context.colors.textTimeMessage,
      ),
    );
  }
}
