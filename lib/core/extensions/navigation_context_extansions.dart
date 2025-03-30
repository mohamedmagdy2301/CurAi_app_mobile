import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  //! Navigation
  Future<dynamic> push(Widget screen, {Object? arguments}) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

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

  void pop() => Navigator.of(this).maybePop();

  void popWithValue<T>(T value) => Navigator.of(this).pop(value);

  void popUntil(String routeName) =>
      Navigator.of(this).popUntil(ModalRoute.withName(routeName));
}
