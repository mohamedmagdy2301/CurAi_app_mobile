import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/settings/circle_color_palette_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PalettListViewWidget extends StatefulWidget {
  const PalettListViewWidget({super.key});

  @override
  State<PalettListViewWidget> createState() => _PalettListViewWidgetState();
}

class _PalettListViewWidgetState extends State<PalettListViewWidget> {
  dynamic saveThemeMode =
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
    return ListView(
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
                    CacheDataHelper.setData(
                      key: SharedPrefKey.keyThemeColor,
                      value: selected,
                    );
                  });
                },
              ),
            ),
          )
          .toList(),
    ).expand();
  }
}
