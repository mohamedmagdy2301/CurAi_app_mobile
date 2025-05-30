import 'dart:io';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/services/text_to_speech/text_to_speech_manager.dart';
import 'package:curai_app_mobile/core/services/translation/translate_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/fonts/text_direction.dart';
import 'package:curai_app_mobile/core/utils/helper/overlay_manager.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubbleWidget extends StatefulWidget {
  const MessageBubbleWidget({required this.messageModel, super.key});
  final MessageBubbleModel messageModel;

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
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
            left: context.isStateArabic
                ? isUserMessage
                    ? 20.w
                    : null
                : isUserMessage
                    ? null
                    : 20.w,
            right: context.isStateArabic
                ? isUserMessage
                    ? null
                    : 20.w
                : isUserMessage
                    ? 20.w
                    : null,
            top: bubbleOffset.dy - 69,
            child: Material(
              color: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: 10, sigmaY: 10), // قوة التعتيم
                  child: Container(
                    padding: context.padding(horizontal: 20, vertical: 17),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      gradient: LinearGradient(
                        colors: [
                          context.onSecondaryColor.withAlpha(150),
                          context.onSecondaryColor.withAlpha(100),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 23.w,
                      children: [
                        _buildOption(
                          icon: CupertinoIcons.volume_up,
                          onTap: () {
                            final text = widget.messageModel.messageText ?? '';
                            sl<TextToSpeechManager>().textToSpeechSpeak(text);
                          },
                          isTts: true,
                        ),
                        _buildOption(
                          icon: Icons.translate,
                          onTap: () async {
                            final translated =
                                await sl<TranslateManager>().translate(
                              widget.messageModel.messageText ?? '',
                            );

                            setState(() {
                              widget.messageModel.messageText = translated;
                            });

                            OverlayManager.removeOverlay();
                          },
                        ),
                        _buildOption(
                          icon: Icons.copy,
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                text: widget.messageModel.messageText ?? '',
                              ),
                            );

                            OverlayManager.removeOverlay();
                          },
                        ),
                      ],
                    ),
                  ),
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
    bool isTts = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: isTts
          ? ValueListenableBuilder<bool>(
              valueListenable: sl<TextToSpeechManager>().isSpeaking,
              builder: (context, isSpeaking, child) {
                return isSpeaking
                    ? Image.asset(
                        'assets/images/sound.gif',
                        color: context.backgroundColor,
                        width: 28.sp,
                        height: 28.sp,
                      )
                    : Icon(
                        icon,
                        color: context.backgroundColor,
                        size: 28.sp,
                      );
              },
            )
          : Icon(icon, color: context.backgroundColor, size: 28.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress:
          widget.messageModel.imagePath != null ? null : _showOverlayMenu,
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
                  fontFamily:
                      widget.messageModel.messageText?.isArabicFormat ?? true
                          ? 'Cairo'
                          : 'Roboto',
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
          ? Radius.circular(!context.isStateArabic ? 0 : 20)
          : Radius.circular(!context.isStateArabic ? 20 : 0),
      bottomLeft: isUserMessage
          ? Radius.circular(!context.isStateArabic ? 20 : 0)
          : Radius.circular(!context.isStateArabic ? 0 : 20),
    );
  }
}
