// ignore_for_file: inference_failure_on_instance_creation

import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
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
      backgroundColor: context.colors.appBarHome,
      elevation: 0,
      flexibleSpace: Container(color: context.colors.appBarHome),
      title: _buildTitleText(context),
      leading: _buildBackButton(context),
      iconTheme: IconThemeData(color: context.colors.bodyTextOnboarding),
      centerTitle: true,
    );
  }

  Widget _buildTitleText(BuildContext context) {
    return Text(
      isArabic() ? 'مساعدك الشخصى' : 'ChatBot Assistant',
      style: context.textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeightHelper.semiBold,
        color: context.colors.bodyTextOnboarding,
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
