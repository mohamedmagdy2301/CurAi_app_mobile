// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
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
      flexibleSpace: Container(),
      title: _buildTitleText(context),
      leading: _buildBackButton(context),
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      context.isStateArabic ? 'مساعدك الشخصى' : 'ChatBot Assistant',
      style: context.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeightHelper.semiBold,
        // color: context.colors.bodyTextOnboarding,
      ),
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
