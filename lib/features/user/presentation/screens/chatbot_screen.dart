import 'package:curai_app_mobile/features/user/presentation/cubit/chat_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/body_chatbot.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/chatbot/custom_appbar_chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LockOrientation(
      child: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          child: Scaffold(
            appBar: const CustomAppBarChatBot(),
            body: BlocProvider(
              create: (_) => ChatCubit(),
              child: const BodyChatbot(),
            ),
          ),
        ),
      ),
    );
  }
}
