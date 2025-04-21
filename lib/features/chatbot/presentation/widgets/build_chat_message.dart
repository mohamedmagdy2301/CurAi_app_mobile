import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildChatMessage extends StatefulWidget {
  const BuildChatMessage({super.key});

  @override
  State<BuildChatMessage> createState() => _BuildChatMessageState();
}

class _BuildChatMessageState extends State<BuildChatMessage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBotCubit, ChatBotState>(
      builder: (context, state) {
        if (state is ChatBotLoading) {
          return _buildStatusMessage(
            context,
            context.isStateArabic ? 'جاري التحقق...' : 'Wait a moment...',
            Colors.green,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildStatusMessage(
    BuildContext context,
    String message,
    Color color,
  ) {
    return SizedBox(
      height: 25.h,
      child: Text(
        message,
        style: TextStyleApp.semiBold12().copyWith(
          color: color,
        ),
      ),
    );
  }
}
