// import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
//     as int_ext;
// import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
// import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
// import 'package:curai_app_mobile/core/language/lang_keys.dart';
// import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
// import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
// // import 'package:flutter/material.dart';

// class DoctorDetailsScreen extends StatelessWidget {
//   const DoctorDetailsScreen({required this.DoctorResults, super.key});

//   final DoctorResults DoctorResults;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(context.isStateArabic ? DoctorResults.nameAr : DoctorResults.nameEn),
//       //   centerTitle: true,
//       // ),
//       body:
//           //  Hero(
//           //   tag: DoctorResults.id.toString(),
//           //   child:
//           Image.asset(
//         DoctorResults.imageUrl,
//         height: 395,
//         width: double.infinity,
//         fit: BoxFit.fill,
//       ),
//       // ),
//       bottomSheet: Container(
//         height: context.H - 380,
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           // color: context.colors.appBarHome,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(18),
//             topRight: Radius.circular(18),
//           ),
//         ),
//         child: Padding(
//           padding: context.padding(horizontal: 20, vertical: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               20.hSpace,
//               FittedBox(
//                 child: Text(
//                   context.isStateArabic
//                       ? DoctorResults.nameAr
//                       : DoctorResults.nameEn,
//                   style: TextStyleApp.bold24().copyWith(
//                     color: context.onPrimaryColor,
//                   ),
//                 ),
//               ),
//               10.hSpace,
//               FittedBox(
//                 child: Text(
//                   context.isStateArabic
//                       ? DoctorResults.locationAr
//                       : DoctorResults.locationEn,
//                   style: TextStyleApp.bold24().copyWith(
//                     color: context.onPrimaryColor,
//                   ),
//                 ),
//               ),
//               10.hSpace,
//               FittedBox(
//                 child: Row(
//                   spacing: 5,
//                   children: [
//                     Row(
//                       spacing: 3,
//                       children: List.generate(
//                         int.parse(DoctorResults.ratingEn.split('.').first),
//                         (index) => const Icon(
//                           Icons.star,
//                           color: Colors.yellow,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       context.isStateArabic
//                           ? DoctorResults.ratingAr
//                           : DoctorResults.ratingEn,
//                       style: TextStyleApp.bold24().copyWith(
//                         color: context.onPrimaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const Spacer(),
//               Image.asset(
//                 'assets/images/Map.png',
//                 height: 140,
//                 width: double.infinity,
//                 fit: BoxFit.fill,
//               ),
//               const Spacer(),
//               CustomButton(
//                 title: LangKeys.appName,
//                 onPressed: () {},
//               ),
//               10.hSpace,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
