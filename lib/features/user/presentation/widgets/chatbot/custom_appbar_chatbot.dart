// ignore_for_file: inference_failure_on_instance_creation

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/style_text_context_ext.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBarChatBot extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.color.surface),
      title: _buildTitleText(context),
      leading: _buildBackButton(context),
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
