import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyleApp {
  TextStyleApp._();
  static String fontFamily = 'Cairo';

  static TextStyle _baseTextStyle({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      color: Colors.black,
    );
  }

  static TextStyle light(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w300);
  static TextStyle regular(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w400);
  static TextStyle medium(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w500);
  static TextStyle semiBold(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w600);
  static TextStyle bold(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w700);
  static TextStyle extraBold(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w800);
  static TextStyle black(double size) =>
      _baseTextStyle(fontSize: size, fontWeight: FontWeight.w900);

  static TextStyle light8() => light(8);
  static TextStyle light10() => light(10);
  static TextStyle light12() => light(12);
  static TextStyle light14() => light(14);
  static TextStyle light16() => light(16);
  static TextStyle light18() => light(18);
  static TextStyle light20() => light(20);
  static TextStyle light22() => light(22);
  static TextStyle light24() => light(24);
  static TextStyle light26() => light(26);
  static TextStyle light28() => light(28);
  static TextStyle light30() => light(30);
  static TextStyle light32() => light(32);
  static TextStyle light34() => light(34);
  static TextStyle light36() => light(36);
  static TextStyle light38() => light(38);

  static TextStyle regular8() => regular(8);
  static TextStyle regular10() => regular(10);
  static TextStyle regular12() => regular(12);
  static TextStyle regular14() => regular(14);
  static TextStyle regular16() => regular(16);
  static TextStyle regular18() => regular(18);
  static TextStyle regular20() => regular(20);
  static TextStyle regular22() => regular(22);
  static TextStyle regular24() => regular(24);
  static TextStyle regular26() => regular(26);
  static TextStyle regular28() => regular(28);
  static TextStyle regular30() => regular(30);
  static TextStyle regular32() => regular(32);
  static TextStyle regular34() => regular(34);
  static TextStyle regular36() => regular(36);
  static TextStyle regular38() => regular(38);

  static TextStyle medium8() => medium(8);
  static TextStyle medium10() => medium(10);
  static TextStyle medium12() => medium(12);
  static TextStyle medium14() => medium(14);
  static TextStyle medium16() => medium(16);
  static TextStyle medium18() => medium(18);
  static TextStyle medium20() => medium(20);
  static TextStyle medium22() => medium(22);
  static TextStyle medium24() => medium(24);
  static TextStyle medium26() => medium(26);
  static TextStyle medium28() => medium(28);
  static TextStyle medium30() => medium(30);
  static TextStyle medium32() => medium(32);
  static TextStyle medium34() => medium(34);
  static TextStyle medium36() => medium(36);
  static TextStyle medium38() => medium(38);

  static TextStyle semiBold8() => semiBold(8);
  static TextStyle semiBold10() => semiBold(10);
  static TextStyle semiBold12() => semiBold(12);
  static TextStyle semiBold14() => semiBold(14);
  static TextStyle semiBold16() => semiBold(16);
  static TextStyle semiBold18() => semiBold(18);
  static TextStyle semiBold20() => semiBold(20);
  static TextStyle semiBold22() => semiBold(22);
  static TextStyle semiBold24() => semiBold(24);
  static TextStyle semiBold26() => semiBold(26);
  static TextStyle semiBold28() => semiBold(28);
  static TextStyle semiBold30() => semiBold(30);
  static TextStyle semiBold32() => semiBold(32);
  static TextStyle semiBold34() => semiBold(34);
  static TextStyle semiBold36() => semiBold(36);
  static TextStyle semiBold38() => semiBold(38);

  static TextStyle bold8() => bold(8);
  static TextStyle bold10() => bold(10);
  static TextStyle bold12() => bold(12);
  static TextStyle bold14() => bold(14);
  static TextStyle bold16() => bold(16);
  static TextStyle bold18() => bold(18);
  static TextStyle bold20() => bold(20);
  static TextStyle bold22() => bold(22);
  static TextStyle bold24() => bold(24);
  static TextStyle bold26() => bold(26);
  static TextStyle bold28() => bold(28);
  static TextStyle bold30() => bold(30);
  static TextStyle bold32() => bold(32);
  static TextStyle bold34() => bold(34);
  static TextStyle bold36() => bold(36);
  static TextStyle bold38() => bold(38);

  static TextStyle extraBold8() => extraBold(8);
  static TextStyle extraBold10() => extraBold(10);
  static TextStyle extraBold12() => extraBold(12);
  static TextStyle extraBold14() => extraBold(14);
  static TextStyle extraBold16() => extraBold(16);
  static TextStyle extraBold18() => extraBold(18);
  static TextStyle extraBold20() => extraBold(20);
  static TextStyle extraBold22() => extraBold(22);
  static TextStyle extraBold24() => extraBold(24);
  static TextStyle extraBold26() => extraBold(26);
  static TextStyle extraBold28() => extraBold(28);
  static TextStyle extraBold30() => extraBold(30);
  static TextStyle extraBold32() => extraBold(32);
  static TextStyle extraBold34() => extraBold(34);
  static TextStyle extraBold36() => extraBold(36);
  static TextStyle extraBold38() => extraBold(38);

  static TextStyle black8() => black(8);
  static TextStyle black10() => black(10);
  static TextStyle black12() => black(12);
  static TextStyle black14() => black(14);
  static TextStyle black16() => black(16);
  static TextStyle black18() => black(18);
  static TextStyle black20() => black(20);
  static TextStyle black22() => black(22);
  static TextStyle black24() => black(24);
  static TextStyle black26() => black(26);
  static TextStyle black28() => black(28);
  static TextStyle black30() => black(30);
  static TextStyle black32() => black(32);
  static TextStyle black34() => black(34);
  static TextStyle black36() => black(36);
  static TextStyle black38() => black(38);
}
