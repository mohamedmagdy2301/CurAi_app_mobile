import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/features/chatbot/domain/usecases/diagnosis_usecase.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/body_chatbot.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/widgets/custom_appbar_chatbot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lock_orientation_screen/lock_orientation_screen.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChatBotCubit>(
      create: (_) => ChatBotCubit(
        sl<DiagnosisUsecase>(),
        isArabic: context.isStateArabic,
      )..loadPreviousMessages(),
      child: LockOrientation(
        child: SafeArea(
          child: Container(
            constraints: const BoxConstraints.expand(),
            child: const Scaffold(
              appBar: CustomAppBarChatBot(),
              body: BodyChatbot(),
            ),
          ),
        ),
      ),
    );
  }
}
