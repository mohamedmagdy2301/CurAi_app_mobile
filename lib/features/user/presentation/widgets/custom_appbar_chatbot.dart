import 'package:curai_app_mobile/core/extensions/context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/styles/fonts/font_weight_helper.dart';
import 'package:curai_app_mobile/features/user/cubit/chat_cubit.dart';
import 'package:curai_app_mobile/features/user/cubit/navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarChatBot extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.appBarHome,
      elevation: 0,
      flexibleSpace: Container(color: context.colors.appBarHome),
      title: Column(
        children: [
          _buildTitleText(context),
          _buildChatStatus(context),
        ],
      ),
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

  Widget _buildChatStatus(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatDone) {
          return _buildStatusMessage(
            context,
            isArabic() ? 'تم التحقق' : 'Successful',
            Colors.green,
          );
        } else if (state is ChatLoading) {
          return _buildStatusMessage(
            context,
            isArabic() ? 'جاري التحقق...' : 'Wait a moment...',
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
    return Text(
      message,
      style: context.textTheme.bodySmall!.copyWith(
        fontWeight: FontWeightHelper.semiBold,
        color: color,
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new),
      onPressed: () => context.read<NavigationCubit>().updateIndex(0),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
