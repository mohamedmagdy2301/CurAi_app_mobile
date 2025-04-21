// ignore_for_file: inference_failure_on_instance_creation

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/features/chatbot/presentation/cubit/chatbot_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBarChatBot extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: _buildTitleText(context),
      leading: _buildBackButton(context),
      actions: [
        IconButton(
          icon: const Icon(CupertinoIcons.add_circled_solid),
          onPressed: () {
            AdaptiveDialogs.showOkAlertDialog(
              context: context,
              title: context.isStateArabic
                  ? 'بدء محادثة جديدة'
                  : 'Start a new conversation',
              message: context.isStateArabic
                  ? Text(
                      'هل تريد بدء محادثة جديدة؟'
                      '\nسوف يتم حذف المحادثة الحالية',
                      style: TextStyleApp.regular16().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    )
                  : Text(
                      'Do you want to start a new conversation?'
                      '\nThe current conversation will be deleted',
                      style: TextStyleApp.regular16().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
              onPressed: () {
                hideKeyboard();
                context.read<ChatBotCubit>().clearChatBot();
                context.pop();
                context.read<ChatBotCubit>().loadPreviousMessages();
              },
            );
          },
        ),
      ],
      centerTitle: true,
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return AutoSizeText(
      context.isStateArabic ? 'مساعدك الشخصى' : 'ChatBot Assistant',
      maxLines: 1,
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () {
        hideKeyboard();
        context.read<NavigationCubit>().updateIndex(0);
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
