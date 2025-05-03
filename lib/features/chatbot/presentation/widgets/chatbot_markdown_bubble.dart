import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
    final isDark = context.isDark;
    return MarkdownStyleSheet(
      p: TextStyleApp.medium16().copyWith(
        height: 1.5,
        color: isDark ? Colors.white : Colors.black87,
      ),
      h1: TextStyleApp.bold22().copyWith(
        color: isDark ? Colors.cyanAccent : Colors.blueAccent,
      ),
      h2: TextStyleApp.semiBold20().copyWith(
        color: isDark ? Colors.tealAccent : Colors.teal,
      ),
      h3: TextStyleApp.medium18().copyWith(
        color: isDark ? Colors.greenAccent : Colors.green,
      ),
      blockquote: TextStyleApp.medium16().copyWith(
        fontStyle: FontStyle.italic,
        height: 1.4,
        color: isDark ? Colors.grey[300] : Colors.grey[600],
        backgroundColor:
            isDark ? const Color(0xFF404040) : const Color(0xFFEFEFEF),
      ),
      code: TextStyleApp.medium14().copyWith(
        color: isDark ? Colors.amberAccent : Colors.deepOrange,
        backgroundColor:
            isDark ? const Color(0xFF3C3C3C) : const Color(0xFFEAEAEA),
      ),
      listBullet: TextStyleApp.medium16().copyWith(
        height: 1.6,
        color: isDark ? Colors.lightGreenAccent : Colors.blueAccent,
      ),
      tableHead: TextStyleApp.bold14().copyWith(
        color: isDark ? Colors.white : Colors.black,
        backgroundColor: isDark ? Colors.blueGrey[900] : Colors.blueGrey[100],
      ),
      tableBody: TextStyleApp.medium12().copyWith(
        color: isDark ? Colors.grey[300] : Colors.grey[800],
      ),
    );
  }
}
