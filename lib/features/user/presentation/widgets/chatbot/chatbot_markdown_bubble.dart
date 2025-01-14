import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatBotMarkdownBubble extends StatelessWidget {
  const ChatBotMarkdownBubble({
    required this.messageText,
    super.key,
  });
  final String messageText;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          isArabicFormat(messageText) ? TextDirection.rtl : TextDirection.ltr,
      child: Markdown(
        data: messageText,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        styleSheet: _buildChatGPTStyleSheet(
          context,
        ),
      ),
    );
  }

  MarkdownStyleSheet _buildChatGPTStyleSheet(
    BuildContext context,
  ) {
    final isDark = context.isStateDark;
    return MarkdownStyleSheet(
      p: context.textTheme.bodyMedium!.copyWith(
        fontSize: 16.sp,
        height: 1.5.h,
        color: isDark ? Colors.white : Colors.black87,
      ),
      h1: context.textTheme.headlineMedium!.copyWith(
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.cyanAccent : Colors.blueAccent,
      ),
      h2: context.textTheme.headlineSmall!.copyWith(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.tealAccent : Colors.teal,
      ),
      h3: context.textTheme.bodyLarge!.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: isDark ? Colors.greenAccent : Colors.green,
      ),
      blockquote: context.textTheme.bodyMedium!.copyWith(
        fontStyle: FontStyle.italic,
        fontSize: 16.sp,
        height: 1.4.h,
        color: isDark ? Colors.grey[300] : Colors.grey[600],
        backgroundColor:
            isDark ? const Color(0xFF404040) : const Color(0xFFEFEFEF),
      ),
      code: context.textTheme.bodyMedium!.copyWith(
        fontSize: 14.sp,
        color: isDark ? Colors.amberAccent : Colors.deepOrange,
        backgroundColor:
            isDark ? const Color(0xFF3C3C3C) : const Color(0xFFEAEAEA),
      ),
      listBullet: context.textTheme.bodyMedium!.copyWith(
        fontSize: 16.sp,
        height: 1.6.h,
        color: isDark ? Colors.lightGreenAccent : Colors.blueAccent,
      ),
      tableHead: context.textTheme.bodyMedium!.copyWith(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
        color: isDark ? Colors.white : Colors.black,
        backgroundColor: isDark ? Colors.blueGrey[900] : Colors.blueGrey[100],
      ),
      tableBody: context.textTheme.bodySmall!.copyWith(
        fontSize: 12.sp,
        color: isDark ? Colors.grey[300] : Colors.grey[800],
      ),
    );
  }
}
