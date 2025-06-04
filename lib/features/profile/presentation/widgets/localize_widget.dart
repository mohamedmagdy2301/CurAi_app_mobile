import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_cubit.dart';
import 'package:curai_app_mobile/core/language/localization_cubit/localization_state.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EnhancedLocalizeWidget extends StatefulWidget {
  const EnhancedLocalizeWidget({super.key});

  @override
  State<EnhancedLocalizeWidget> createState() => _EnhancedLocalizeWidgetState();
}

class _EnhancedLocalizeWidgetState extends State<EnhancedLocalizeWidget> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LocalizationCubit>();
    final state = context.read<LocalizationCubit>().state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 3.5.h,
          width: 70.w,
          margin: EdgeInsets.only(bottom: 8.h),
          decoration: BoxDecoration(
            color: context.onSecondaryColor.withAlpha(160),
            borderRadius: BorderRadius.circular(2),
          ),
        ).center(),
        20.hSpace,
        // Language Options with enhanced design
        _buildEnhancedLanguageOption(
          context: context,
          cubit: cubit,
          state: state,
          locale: LocalizationStateEnum.ar,
          title: context.translate(LangKeys.arabic),
          subtitle: 'العربية',
          flag: '🇪🇬',
          fontFamily: 'Cairo',
        ),

        20.hSpace,

        _buildEnhancedLanguageOption(
          context: context,
          cubit: cubit,
          state: state,
          locale: LocalizationStateEnum.en,
          title: context.translate(LangKeys.english),
          subtitle: 'English',
          flag: '🇺🇸',
          fontFamily: 'Poppins',
        ),

        20.hSpace,
      ],
    ).paddingSymmetric(horizontal: 16, vertical: 16);
  }

  Widget _buildEnhancedLanguageOption({
    required BuildContext context,
    required LocalizationCubit cubit,
    required LocalizationState state,
    required LocalizationStateEnum locale,
    required String title,
    required String subtitle,
    required String flag,
    required String fontFamily,
  }) {
    final isSelected = state.locale == locale;

    return GestureDetector(
      onTap: () => _onLanguageSelected(cubit, locale, fontFamily, context),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? context.primaryColor : context.onSecondaryColor,
            width: isSelected ? 1.5 : 1,
          ),
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    context.primaryColor.withAlpha(10),
                    context.primaryColor.withAlpha(12),
                  ],
                )
              : null,
          color: isSelected ? null : context.backgroundColor,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.primaryColor.withAlpha(30),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.primaryColor.withAlpha(25),
              ),
              child: Text(
                flag,
                style: TextStyleApp.bold22().copyWith(
                  color: context.primaryColor,
                ),
              ).center(),
            ),
            16.wSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleApp.semiBold18().copyWith(
                    color: isSelected
                        ? context.primaryColor
                        : context.onPrimaryColor,
                  ),
                ),
                2.hSpace,
                Text(
                  subtitle,
                  style: TextStyleApp.medium14().copyWith(
                    color: context.onPrimaryColor.withAlpha(140),
                  ),
                ),
              ],
            ).expand(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? context.primaryColor
                      : context.onSecondaryColor,
                ),
                color: isSelected ? context.primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void _onLanguageSelected(
    LocalizationCubit cubit,
    LocalizationStateEnum locale,
    String fontFamily,
    BuildContext context,
  ) {
    // Add haptic feedback
    HapticFeedback.selectionClick();

    cubit.setLocale(locale);
    TextStyleApp.fontFamily = fontFamily;

    context.pop();
  }
}
