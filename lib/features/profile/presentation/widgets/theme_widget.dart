import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/build_radio_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeWidget extends StatefulWidget {
  const ThemeWidget({super.key});

  @override
  State<ThemeWidget> createState() => _ThemeWidgetState();
}

class _ThemeWidgetState extends State<ThemeWidget> {
  var saveThemeMode =
      CacheDataHelper.getData(key: SharedPrefKey.saveThemeMode) ??
          AdaptiveThemeMode.system;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildRadioListTile<AdaptiveThemeMode>(
          labelKey: LangKeys.light,
          value: AdaptiveThemeMode.light,
          groupValue: saveThemeMode as AdaptiveThemeMode,
          onChanged: (locale) {
            selectedColor = lightColors[0];
            AdaptiveTheme.of(context).setLight();
            AdaptiveTheme.of(context).setTheme(
              light: AppThemeData.lightTheme(
                context.isStateArabic ? 'Cairo' : 'Poppins',
                selectedColor,
              ),
              dark: AppThemeData.darkTheme(
                context.isStateArabic ? 'Cairo' : 'Poppins',
                selectedColor,
              ),
            );
            setState(() {
              saveThemeMode = AdaptiveThemeMode.light;
            });
            CacheDataHelper.setData(
              key: SharedPrefKey.saveThemeMode,
              value: AdaptiveThemeMode.light,
            );
            context.pop();
          },
        ),
        BuildRadioListTile<AdaptiveThemeMode>(
          labelKey: LangKeys.dark,
          value: AdaptiveThemeMode.dark,
          groupValue: saveThemeMode as AdaptiveThemeMode,
          onChanged: (locale) {
            selectedColor = darkColors[0];
            AdaptiveTheme.of(context).setDark();
            AdaptiveTheme.of(context).setTheme(
              light: AppThemeData.lightTheme(
                context.isStateArabic ? 'Cairo' : 'Poppins',
                selectedColor,
              ),
              dark: AppThemeData.darkTheme(
                context.isStateArabic ? 'Cairo' : 'Poppins',
                selectedColor,
              ),
            );
            setState(() {
              saveThemeMode = AdaptiveThemeMode.dark;
            });
            CacheDataHelper.setData(
              key: SharedPrefKey.saveThemeMode,
              value: AdaptiveThemeMode.dark,
            );
            context.pop();
          },
        ),
        // BuildRadioListTile<AdaptiveThemeMode>(
        //   labelKey: LangKeys.systemDefault,
        //   value: AdaptiveThemeMode.system,
        //   groupValue: saveThemeMode as AdaptiveThemeMode,
        //   onChanged: (locale) {
        //     selectedColor = darkColors[0];
        //     AdaptiveTheme.of(context).setSystem();
        //     AdaptiveTheme.of(context).setTheme(
        //       light: AppThemeData.lightTheme(
        //         context.isStateArabic,
        //         selectedColor,
        //       ),
        //       dark: AppThemeData.darkTheme(
        //         context.isStateArabic,
        //         selectedColor,
        //       ),
        //     );
        //     setState(() {
        //       saveThemeMode = AdaptiveThemeMode.system;
        //     });
        //     CacheDataHelper.setData(
        //       key: SharedPrefKey.saveThemeMode,
        //       value: AdaptiveThemeMode.system,
        //     );
        //     context.pop();
        //   },
        // ),
      ],
    ).paddingSymmetric(vertical: 10.h);
  }
}
