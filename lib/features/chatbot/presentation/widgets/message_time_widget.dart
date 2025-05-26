import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/datetime_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/chatbot/data/models/message_bubble_model.dart';
import 'package:flutter/material.dart';

class MessageTimeWidget extends StatefulWidget {
  const MessageTimeWidget({required this.messageModel, super.key});
  final MessageBubbleModel messageModel;

  @override
  State<MessageTimeWidget> createState() => _MessageTimeWidgetState();
}

class _MessageTimeWidgetState extends State<MessageTimeWidget> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoRefresh();
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final date = widget.messageModel.date;

    return AutoSizeText(
      date.isNow
          ? context.translate(LangKeys.now)
          : date.isYesterday
              ? '${context.translate(LangKeys.yesterday)} ${date.toLocalizedTime(context)}'
              : date.isToday
                  ? date.toLocalizedTime(context)
                  : date.toLocalizedDateTime(context),
      style: TextStyleApp.light12().copyWith(
        color: context.onPrimaryColor.withAlpha(200),
      ),
      maxLines: 1,
    );
  }
}
