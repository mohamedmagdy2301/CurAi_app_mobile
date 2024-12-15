import 'package:curai_app_mobile/core/styles/colors/colors_dark.dart';
import 'package:curai_app_mobile/core/styles/colors/colors_light.dart';
import 'package:flutter/material.dart';

class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.primaryColor,
    required this.textColorLight,
    required this.iconSocialBG,
    required this.onboardingBg,
    required this.bodyTextOnboarding,
    required this.border,
    required this.focusedBorder,
    required this.appBarHome,
    required this.fontColor,
    required this.secondaryFontColor,
    required this.chatBubbleIsBot,
    required this.textTimeMessage,
  });

  final Color? primaryColor;
  final Color? textColorLight;
  final Color? iconSocialBG;
  final Color? onboardingBg;
  final Color? bodyTextOnboarding;
  final Color? border;
  final Color? focusedBorder;
  final Color? appBarHome;
  final Color? fontColor;
  final Color? secondaryFontColor;
  final Color? chatBubbleIsBot;
  final Color? textTimeMessage;

  @override
  ThemeExtension<MyColors> copyWith({
    Color? primaryColor,
    Color? textColorLight,
    Color? onboardingBg,
    Color? bodyOnboarding,
    Color? border,
    Color? iconSocialBG,
    Color? focusedBorder,
    Color? appBarHome,
    Color? fontColor,
    Color? secondaryFontColor,
    Color? chatBubbleIsBot,
    Color? textTimeMessage,
  }) {
    return MyColors(
      primaryColor: primaryColor,
      textColorLight: textColorLight,
      onboardingBg: onboardingBg,
      bodyTextOnboarding: bodyOnboarding,
      border: border,
      iconSocialBG: iconSocialBG,
      focusedBorder: focusedBorder,
      appBarHome: appBarHome,
      fontColor: fontColor,
      secondaryFontColor: secondaryFontColor,
      chatBubbleIsBot: chatBubbleIsBot,
      textTimeMessage: textTimeMessage,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
    covariant ThemeExtension<MyColors>? other,
    double t,
  ) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      primaryColor: primaryColor,
      textColorLight: textColorLight,
      onboardingBg: onboardingBg,
      bodyTextOnboarding: bodyTextOnboarding,
      border: border,
      iconSocialBG: iconSocialBG,
      focusedBorder: focusedBorder,
      appBarHome: appBarHome,
      fontColor: fontColor,
      secondaryFontColor: secondaryFontColor,
      chatBubbleIsBot: chatBubbleIsBot,
      textTimeMessage: textTimeMessage,
    );
  }

  static MyColors dark = const MyColors(
    primaryColor: Color.fromARGB(255, 0, 105, 87),
    textColorLight: Color.fromARGB(255, 118, 118, 118),
    onboardingBg: Color.fromARGB(223, 42, 42, 42),
    bodyTextOnboarding: ColorsDark.textColor,
    border: Color.fromARGB(188, 153, 153, 153),
    focusedBorder: Color.fromARGB(255, 0, 128, 107),
    iconSocialBG: Color.fromARGB(206, 53, 53, 53),
    appBarHome: ColorsDark.backgroundColor,
    fontColor: Colors.white,
    secondaryFontColor: Colors.black,
    chatBubbleIsBot: Color.fromARGB(255, 63, 63, 63),
    textTimeMessage: Color.fromARGB(212, 214, 214, 214),
  );

  static MyColors light = const MyColors(
    primaryColor: ColorsLight.primaryColor,
    textColorLight: ColorsLight.textColorLight,
    onboardingBg: Color.fromARGB(158, 210, 210, 210),
    bodyTextOnboarding: ColorsLight.textColor,
    border: Color.fromARGB(183, 156, 156, 156),
    focusedBorder: ColorsLight.primaryColor,
    iconSocialBG: Color.fromARGB(255, 208, 208, 208),
    appBarHome: ColorsLight.backgroundColor,
    fontColor: Colors.black,
    secondaryFontColor: Colors.white,
    chatBubbleIsBot: Color.fromARGB(255, 227, 227, 227),
    textTimeMessage: ColorsLight.textColorLight,
  );
}
