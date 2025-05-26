import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/core/utils/helper/overlay_manager.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class MessageBubbleWidget extends StatefulWidget {
  const MessageBubbleWidget({required this.messageModel, super.key});
  final MessageBubbleModel messageModel;

  @override
  _MessageBubbleWidgetState createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  final GlobalKey _bubbleKey = GlobalKey();

  bool get isUserMessage => widget.messageModel.sender == SenderType.user;

  void _showOverlayMenu() {
    final renderBox =
        _bubbleKey.currentContext!.findRenderObject()! as RenderBox;
    final bubbleOffset = renderBox.localToGlobal(Offset.zero);

    final overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: OverlayManager.removeOverlay,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
          Positioned(
            left: isUserMessage ? null : 20.w,
            right: isUserMessage ? 20.w : null,
            top: bubbleOffset.dy - 55,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: context.padding(horizontal: 15, vertical: 15),
                decoration: BoxDecoration(
                  color: context.onPrimaryColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 20.w,
                  children: [
                    _buildOption(
                      icon: Icons.translate,
                      onTap: OverlayManager.removeOverlay,
                    ),
                    _buildOption(
                      icon: Icons.volume_up,
                      onTap: OverlayManager.removeOverlay,
                    ),
                    _buildOption(
                      icon: Icons.copy,
                      onTap: () {
                        Clipboard.setData(
                          ClipboardData(
                            text: widget.messageModel.messageText ?? '',
                          ),
                        );
                        showMessage(
                          context,
                          message: context.isStateArabic
                              ? 'تم النسخ إلى الحافظة'
                              : 'Copied to clipboard',
                          type: ToastificationType.success,
                        );
                        OverlayManager.removeOverlay();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    OverlayManager.showOverlay(overlayEntry, context);
  }

  Widget _buildOption({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Icon(icon, color: context.backgroundColor, size: 22.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: _showOverlayMenu,
      child: Container(
        key: _bubbleKey,
        padding: context.padding(vertical: 13, horizontal: 13),
        margin: _bubbleMargin(context),
        decoration: BoxDecoration(
          color: !isUserMessage
              ? context.primaryColor
              : const Color.fromARGB(255, 102, 102, 102),
          borderRadius: _bubbleBorderRadius(context),
        ),
        child: widget.messageModel.imagePath != null
            ? ClipRRect(
                borderRadius: _bubbleBorderRadius(context),
                child: Image.file(
                  File(widget.messageModel.imagePath!),
                  width: context.W * 0.5,
                  height: context.H * 0.25,
                  fit: BoxFit.cover,
                ),
              )
            : AutoSizeText(
                widget.messageModel.messageText ?? '',
                textDirection:
                    widget.messageModel.messageText!.contains('أهلاً')
                        ? TextDirection.rtl
                        : textDirection(widget.messageModel.messageText ?? ''),
                textAlign:
                    widget.messageModel.messageText?.isArabicFormat ?? true
                        ? TextAlign.right
                        : TextAlign.left,
                style: TextStyleApp.medium16().copyWith(
                  color: Colors.white,
                  height: 1.55,
                ),
              ),
      ),
    );
  }

  EdgeInsets _bubbleMargin(BuildContext context) {
    return isUserMessage
        ? EdgeInsets.only(
            right: !context.isStateArabic ? 0 : 40,
            left: !context.isStateArabic ? 20 : 0,
          )
        : EdgeInsets.only(
            right: !context.isStateArabic ? 20 : 0,
            left: !context.isStateArabic ? 0 : 20,
          );
  }

  BorderRadius _bubbleBorderRadius(BuildContext context) {
    return BorderRadius.only(
      topLeft: const Radius.circular(10),
      topRight: const Radius.circular(10),
      bottomRight: isUserMessage
          ? Radius.circular(!context.isStateArabic ? 0 : 25)
          : Radius.circular(!context.isStateArabic ? 25 : 0),
      bottomLeft: isUserMessage
          ? Radius.circular(!context.isStateArabic ? 25 : 0)
          : Radius.circular(!context.isStateArabic ? 0 : 25),
    );
  }
}
