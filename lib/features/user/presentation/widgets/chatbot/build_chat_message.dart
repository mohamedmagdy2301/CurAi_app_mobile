import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildChatMessage extends StatelessWidget {
  const BuildChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) async {
        if (state is ChatFialure) {
          showMessage(
            context,
            type: SnackBarType.error,
            message: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is ChatDone) {
          return _buildStatusMessage(
            context,
            context.isStateArabic ? 'تم التحقق' : 'Successful',
            Colors.green,
          );
        } else if (state is ChatLoading) {
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
      height: 25,
      child: Text(
        message,
        style: TextStyleApp.semiBold12().copyWith(
          color: color,
        ),
      ),
    );
  }
}
