// import 'package:adaptive_theme/adaptive_theme.dart';
// import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
// import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
// import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
// import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
// import 'package:curai_app_mobile/core/language/lang_keys.dart';
// import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
// import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
// import 'package:curai_app_mobile/core/styles/colors/app_colors.dart';
// import 'package:curai_app_mobile/core/styles/themes/app_theme_data.dart';
// import 'package:curai_app_mobile/features/profile/presentation/widgets/build_radio_listtile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class ThemeWidget extends StatefulWidget {
//   const ThemeWidget({super.key});

//   @override
//   State<ThemeWidget> createState() => _ThemeWidgetState();
// }

// class _ThemeWidgetState extends State<ThemeWidget> {
//   AdaptiveThemeMode _saveThemeMode = AdaptiveThemeMode.system;
//   late Color _selectedColor;
//   bool _isLoading = true;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _loadThemeSettings();
//   }

//   Future<void> _loadThemeSettings() async {
//     final savedMode =
//         await CacheDataHelper.getData(key: SharedPrefKey.saveThemeMode);
//     final savedColorValue =
//         await CacheDataHelper.getData(key: SharedPrefKey.keyThemeColor);

//     final isDarkMode = context.isDark;
//     final colors = isDarkMode ? darkColors : lightColors;

//     setState(() {
//       _saveThemeMode = _getThemeModeFromString(savedMode as String?);
//       _selectedColor = (savedColorValue != null && savedColorValue is int)
//           ? Color(savedColorValue)
//           : colors.first;
//       _isLoading = false;
//     });
//   }

//   AdaptiveThemeMode _getThemeModeFromString(String? value) {
//     switch (value) {
//       case 'light':
//         return AdaptiveThemeMode.light;
//       case 'dark':
//         return AdaptiveThemeMode.dark;
//       default:
//         return AdaptiveThemeMode.system;
//     }
//   }

//   Future<void> _updateThemeMode(AdaptiveThemeMode mode) async {
//     final colors = mode == AdaptiveThemeMode.dark ? darkColors : lightColors;
//     final newColor = colors.first;

//     AdaptiveTheme.of(context).setTheme(
//       light: AppThemeData.lightTheme(
//         context.isStateArabic ? 'Cairo' : 'Poppins',
//         newColor,
//       ),
//       dark: AppThemeData.darkTheme(
//         context.isStateArabic ? 'Cairo' : 'Poppins',
//         newColor,
//       ),
//     );

//     await CacheDataHelper.setData(
//       key: SharedPrefKey.saveThemeMode,
//       value: mode,
//     );
//     await CacheDataHelper.setData(
//       key: SharedPrefKey.keyThemeColor,
//       value: newColor.value,
//     );

//     setState(() {
//       _saveThemeMode = mode;
//       _selectedColor = newColor;
//     });

//     context.pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BuildRadioListTile<AdaptiveThemeMode>(
//           labelKey: LangKeys.light,
//           value: AdaptiveThemeMode.light,
//           groupValue: _saveThemeMode,
//           onChanged: (t) => _updateThemeMode(t!),
//         ),
//         BuildRadioListTile<AdaptiveThemeMode>(
//           labelKey: LangKeys.dark,
//           value: AdaptiveThemeMode.dark,
//           groupValue: _saveThemeMode,
//           onChanged: (t) => _updateThemeMode(t!),
//         ),
//       ],
//     ).paddingSymmetric(vertical: 10.h);
//   }
// }
