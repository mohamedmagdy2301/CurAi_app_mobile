// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class PortraitScreen extends StatefulWidget {
//   const PortraitScreen({required this.child, super.key});

//   final Widget child;

//   @override
//   State<PortraitScreen> createState() => _PortraitScreenState();
// }

// class _PortraitScreenState extends State<PortraitScreen> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
//     );
//   }

//   @override
//   void dispose() {
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }
