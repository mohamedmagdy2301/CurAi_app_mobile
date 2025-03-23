// import 'package:flutter/cupertino.dart';

// class SizeProvider extends InheritedWidget {
//   const SizeProvider({
//     required super.child,
//     required this.width,
//     required this.height,
//     required this.baseSize,
//     super.key,
//   });
//   final double width;
//   final double height;
//   final Size baseSize;

//   static SizeProvider of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<SizeProvider>()!;
//   }

//   @override
//   bool updateShouldNotify(covariant SizeProvider oldWidget) {
//     return baseSize != oldWidget.baseSize ||
//         width != oldWidget.width ||
//         height != oldWidget.height ||
//         child != oldWidget.child;
//   }
// }
