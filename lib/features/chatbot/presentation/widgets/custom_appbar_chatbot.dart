// ignore_for_file: inference_failure_on_instance_creation, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/features/chatbot/data/datasources/chatbot_remote_data_source.dart';
import 'package:curai_app_mobile/features/layout/cubit/navigation_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarChatBot extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBarChatBot> createState() => _CustomAppBarChatBotState();
}

class _CustomAppBarChatBotState extends State<CustomAppBarChatBot> {
  TextEditingController controllerServerAddress = TextEditingController(
    text: serverAddress.isNotEmpty
        ? serverAddress
        : 'https://-156-199-179-208.ngrok-free.app',
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor:
          context.isDark ? const Color(0xff113746) : const Color(0xffe8f1f5),
      flexibleSpace: Container(
        color:
            context.isDark ? const Color(0xff113746) : const Color(0xffe8f1f5),
      ),
      title: _buildTitleText(context),
      leading: _buildBackButton(context),
      actions: [
        if (serverAddress == '')
          IconButton(
            icon: Icon(
              CupertinoIcons.add,
              size: 27.sp,
              color: context.onPrimaryColor,
            ),
            onPressed: () {
              AdaptiveDialogs.showAlertDialogWithWidget(
                context: context,
                title: context.isStateArabic
                    ? 'أدخل عنوان السيرفر'
                    : 'Enter server address',
                widget: Column(
                  children: [
                    CustomTextFeild(
                      labelText: context.isStateArabic
                          ? 'عنوان السيرفر'
                          : 'Server Address',
                      controller: controllerServerAddress,
                    ),
                    10.hSpace,
                    CustomButton(
                      title: LangKeys.send,
                      onPressed: () {
                        setState(() {
                          serverAddress = controllerServerAddress.text.trim();
                        });
                        hideKeyboard();
                        context.pop();
                      },
                    ),
                  ],
                ),
              );
            },
          )
        else
          const SizedBox(),
      ],
      centerTitle: true,
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor:
              serverAddress == '' ? context.onSecondaryColor : Colors.green,
          radius: 5.r,
        ),
        6.wSpace,
        SizedBox(
          width: context.W * 0.47,
          child: AutoSizeText(
            context.isStateArabic ? 'مساعدك الشخصى' : 'ChatBot Assistant',
            maxLines: 1,
          ),
        ),
      ],
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
}
