import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:curai_app_mobile/core/styles/colors/colors_light.dart';
import 'package:flutter/material.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });
  final Color primary;
  final Color secondary;
  final Color tertiary;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
  }) {
    return MyColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) return this;
    return MyColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
    );
  }

  static Map<ThemeModeState, Map<ColorsPalleteState, MyColors>>
      themeExtensions = {
    ThemeModeState.light: {
      ColorsPalleteState.blue: MyColors(
        primary: lightPalettes[ColorsPalleteState.blue]!.primary,
        secondary: lightPalettes[ColorsPalleteState.blue]!.secondary,
        tertiary: lightPalettes[ColorsPalleteState.blue]!.tertiary,
      ),
      ColorsPalleteState.green: MyColors(
        primary: lightPalettes[ColorsPalleteState.green]!.primary,
        secondary: lightPalettes[ColorsPalleteState.green]!.secondary,
        tertiary: lightPalettes[ColorsPalleteState.green]!.tertiary,
      ),
    },
    ThemeModeState.dark: {
      ColorsPalleteState.blue: MyColors(
        primary: darkPalettes[ColorsPalleteState.blue]!.primary,
        secondary: darkPalettes[ColorsPalleteState.blue]!.secondary,
        tertiary: darkPalettes[ColorsPalleteState.blue]!.tertiary,
      ),
      ColorsPalleteState.green: MyColors(
        primary: darkPalettes[ColorsPalleteState.green]!.primary,
        secondary: darkPalettes[ColorsPalleteState.green]!.secondary,
        tertiary: darkPalettes[ColorsPalleteState.green]!.tertiary,
      ),
    },
    ThemeModeState.system: {
      ColorsPalleteState.blue: MyColors(
        primary: lightPalettes[ColorsPalleteState.blue]!.primary,
        secondary: lightPalettes[ColorsPalleteState.blue]!.secondary,
        tertiary: lightPalettes[ColorsPalleteState.blue]!.tertiary,
      ),
      ColorsPalleteState.green: MyColors(
        primary: lightPalettes[ColorsPalleteState.green]!.primary,
        secondary: lightPalettes[ColorsPalleteState.green]!.secondary,
        tertiary: lightPalettes[ColorsPalleteState.green]!.tertiary,
      ),
    },
  };
}
