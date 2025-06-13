import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/your_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildYourProfileScreen extends StatefulWidget {
  const BuildYourProfileScreen({super.key});

  @override
  State<BuildYourProfileScreen> createState() => _BuildYourProfileScreenState();
}

class _BuildYourProfileScreenState extends State<BuildYourProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile(context);
  }

  int? selectedGender;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is GetProfileLoading ||
          current is GetProfileError ||
          current is GetProfileSuccess,
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          return YourProfileScreen(profileModel: state.profileModel);
        } else if (state is GetProfileError) {
          return _buildErrorContent(context, state.message);
        }
        return _buildLoadingContent();
      },
    );
  }

// Professional loading state
  Widget _buildLoadingContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CustomLoadingWidget(
          width: 40,
          height: 40,
        ),
        SizedBox(height: 24.h),
        Text(
          context.translate(LangKeys.loading),
          style: TextStyleApp.medium14().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    ).center();
  }

  // Professional error state
  Widget _buildErrorContent(BuildContext context, String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 120.w,
          height: 120.h,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(40.r),
          ),
          child: Icon(
            Icons.error_outline,
            size: 70.sp,
            color: Colors.red[300],
          ),
        ),
        24.hSpace,
        Text(
          context.isStateArabic ? 'حدث خطأ' : 'Something went wrong',
          style: TextStyleApp.bold20().copyWith(
            color: Colors.red,
          ),
        ),
        12.hSpace,
        AutoSizeText(
          message,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium18().copyWith(
            color: context.onSecondaryColor,
          ),
        ).paddingSymmetric(horizontal: 20),
        44.hSpace,
        CustomButton(
          title: LangKeys.tryAgain,
          onPressed: () {
            context.read<AuthCubit>().getProfile(context);
          },
        ).paddingSymmetric(horizontal: 20),
      ],
    ).paddingSymmetric(horizontal: 22).center();
  }
}
