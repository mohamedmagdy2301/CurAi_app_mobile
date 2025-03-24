import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/settings/circle_color_palette_widget.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/settings/settings_row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppreanceScreen extends StatefulWidget {
  const AppreanceScreen({super.key});
  static const routeName = '/settings';

  @override
  State<AppreanceScreen> createState() => _AppreanceScreenState();
}

class _AppreanceScreenState extends State<AppreanceScreen> {
  Color selectedColor = AppColors.primary;
  final List<Color> darkColors = [
    AppColors.primary,
    const Color.fromARGB(255, 99, 136, 3),
    const Color.fromARGB(255, 205, 51, 61),
    const Color.fromARGB(255, 195, 107, 107),
    const Color.fromARGB(255, 112, 166, 178),
    const Color(0xFF838073),
    const Color.fromARGB(255, 159, 162, 214),
  ];

  final List<Color> lightColors = [
    AppColors.primary,
    const Color.fromARGB(255, 99, 136, 3),
    const Color(0xFF9b151d),
    const Color(0xFFc66e59),
    const Color(0xFF496878),
    const Color.fromARGB(255, 120, 115, 73),
    const Color(0xFF14213D),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(color: context.backgroundColor),
        title: Text(context.translate(LangKeys.changeTheme)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SettingsRowItem(
            title: context.translate(LangKeys.changeTheme),
            leading: Switch.adaptive(
              value: AdaptiveTheme.of(context).mode.isDark,
              onChanged: (value) {
                if (value) {
                  selectedColor = darkColors[0];
                  AdaptiveTheme.of(context).setDark();
                  AdaptiveTheme.of(context).setTheme(
                    light: AppThemeData.lightTheme(
                      context.isStateArabic,
                      selectedColor,
                    ),
                    dark: AppThemeData.darkTheme(
                      context.isStateArabic,
                      selectedColor,
                    ),
                  );
                } else {
                  selectedColor = lightColors[0];
                  AdaptiveTheme.of(context).setLight();
                  AdaptiveTheme.of(context).setTheme(
                    light: AppThemeData.lightTheme(
                      context.isStateArabic,
                      selectedColor,
                    ),
                    dark: AppThemeData.darkTheme(
                      context.isStateArabic,
                      selectedColor,
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 140.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            color: context.backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.isStateArabic ? 'لوحة الألوان' : 'Color Palette',
                  style: TextStyleApp.regular20().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ).paddingSymmetric(horizontal: 10.w, vertical: 10.h),
                ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: (context.isDark ? darkColors : lightColors)
                      .map(
                        (color) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: CircleColorPaletteWidget(
                            color: color,
                            isSelected: selectedColor == color,
                            onSelect: (selected) {
                              setState(() {
                                selectedColor = selected;
                                AdaptiveTheme.of(context).setTheme(
                                  light: AppThemeData.lightTheme(
                                    context.isStateArabic,
                                    selected,
                                  ),
                                  dark: AppThemeData.darkTheme(
                                    context.isStateArabic,
                                    selected,
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ).expand(),
                Divider(
                  color: context.onPrimaryColor.withAlpha(120),
                  thickness: .5,
                  height: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
