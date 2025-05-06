import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/circle_color_palette_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PalettListViewWidget extends StatefulWidget {
  const PalettListViewWidget({super.key});

  @override
  State<PalettListViewWidget> createState() => _PalettListViewWidgetState();
}

class _PalettListViewWidgetState extends State<PalettListViewWidget> {
  late Color selectedColor;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSelectedColor();
  }

  Future<void> _loadSelectedColor() async {
    if (!mounted) return;

    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    final savedColorValue =
        await CacheDataHelper.getData(key: SharedPrefKey.keyThemeColor);

    if (mounted) {
      setState(() {
        selectedColor = (savedColorValue != null && savedColorValue is int)
            ? Color(savedColorValue)
            : colors.first;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CustomLoadingWidget().paddingSymmetric(vertical: 5);
    }

    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final colors = isDark ? darkColors : lightColors;

    return SizedBox(
      height: 80.h,
      width: double.infinity,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: colors
            .map(
              (color) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: CircleColorPaletteWidget(
                  color: color,
                  isSelected: selectedColor.toARGB32() == color.toARGB32(),
                  onSelect: (selected) async {
                    await _updateSelectedColor(selected, context);
                  },
                ),
              ),
            )
            .toList(),
      ).paddingSymmetric(horizontal: 30),
    );
  }

  Future<void> _updateSelectedColor(
    Color selected,
    BuildContext context,
  ) async {
    if (!mounted) return;

    setState(() {
      selectedColor = selected;
    });

    await CacheDataHelper.setData(
      key: SharedPrefKey.keyThemeColor,
      value: selected.toARGB32(),
    );

    if (context.mounted) {
      AdaptiveTheme.of(context).setTheme(
        light: AppThemeData.lightTheme(
          context.isStateArabic ? 'Cairo' : 'Poppins',
          selected,
        ),
        dark: AppThemeData.darkTheme(
          context.isStateArabic ? 'Cairo' : 'Poppins',
          selected,
        ),
      );
    }
  }
}
