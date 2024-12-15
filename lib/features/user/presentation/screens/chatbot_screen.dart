import 'package:curai_app_mobile/features/user/cubit/chat_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/body_chatbot.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/custom_appbar_chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(),
      child: const SafeArea(
        child: Scaffold(
          appBar: CustomAppBarChatBot(),
          body: BodyChatbot(),
        ),
      ),
    );
  }
}
