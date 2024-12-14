import 'package:curai_app_mobile/features/user/presentation/widgets/body_chatbot.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/custom_appbar_chatbot.dart';
import 'package:flutter/material.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBarChatBot(),
        body: BodyChatbot(),
      ),
    );
  }
}
