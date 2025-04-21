import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/core/utils/helper/regex.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            left: context.isStateArabic ? 20 : 0,
          )
        : EdgeInsets.only(
            right: context.isStateArabic ? 20 : 0,
            left: context.isStateArabic ? 0 : 20,
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
      padding: context.padding(vertical: 12, horizontal: 10),
      margin: _bubbleMargin(context),
      decoration: BoxDecoration(
        color: !isUserMessage
            ? context.primaryColor.withAlpha(120)
            : context.onPrimaryColor.withAlpha(80),
        borderRadius: _bubbleBorderRadius(context),
      ),
      child: messageModel.imagePath != null
          ? ClipRRect(
              borderRadius: _bubbleBorderRadius(context),
              child: Image.file(
                File(messageModel.imagePath!),
                width: 200.w,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            )
          : isUserMessage
              ? AutoSizeText(
                  messageModel.messageText ?? '',
                  textDirection: textDirection(messageModel.messageText ?? ''),
                  textAlign: isArabicFormat(messageModel.messageText ?? '')
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyleApp.medium16().copyWith(
                    color: Colors.white,
                    height: 1.55,
                  ),
                )
              : SelectableText(
                  messageModel.messageText ?? '',
                  textDirection: textDirection(messageModel.messageText ?? ''),
                  textAlign: isArabicFormat(messageModel.messageText ?? '')
                      ? TextAlign.right
                      : TextAlign.left,
                  style: TextStyleApp.medium16().copyWith(
                    color: Colors.white,
                    height: 1.55,
                  ),
                ),
    );
  }
}
