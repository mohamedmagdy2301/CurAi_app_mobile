import 'package:flutter/material.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations.dart';
import 'package:smartcare_app_mobile/core/styles/themes/assets_extension.dart';
import 'package:smartcare_app_mobile/core/styles/themes/color_extension.dart';

extension ContextExt on BuildContext {
  //! MediaQuery
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  bool get isSytemDark =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;

  //! Theme
  MyAssets get assets => Theme.of(this).extension<MyAssets>()!;
  MyColors get colors => Theme.of(this).extension<MyColors>()!;
  TextTheme get textTheme => Theme.of(this).textTheme;

  //! Localization translation
  String translate(String langKey) =>
      AppLocalizations.of(this)!.translate(langKey).toString();

  //! Navigation
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  void pop() => Navigator.of(this).pop();
}
