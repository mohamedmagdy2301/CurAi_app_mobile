// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:home_services/core/constant/app_colors.dart';
// import 'package:home_services/core/constant/app_styles.dart';
// import 'package:home_services/core/extansions/context_system_extansions.dart';

// class CustomDropdownButton extends StatelessWidget {
//   const CustomDropdownButton({
//     super.key,
//     required this.items,
//     this.onChanged,
//     this.hint = '',
//     this.borderRadius = 16,
//     this.value,
//     this.validator,
//     this.label,
//     this.prefix,
//     this.isExpanded = true,
//   });

//   final List<String> items;
//   final void Function(String?)? onChanged;
//   final String hint;
//   final double? borderRadius;
//   final String? value;
//   final String? label;
//   final String? Function(String?)? validator;
//   final Widget? prefix;
//   final bool isExpanded;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 8.h),
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(borderRadius!),
//           border: Border.all(
//             width: .4,
//             color: AppColors.orange,
//           ),
//         ),
//         child: DropdownButtonFormField(
//           isExpanded: isExpanded,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           validator: validator,
//           dropdownColor: Colors.white,
//           icon: RotatedBox(
//             quarterTurns: context.isStateArabic ? 3 : 1,
//             child: Icon(
//               Icons.arrow_forward_ios,
//               color: AppColors.bunker,
//               size: 16.sp,
//             ),
//           ),
//           iconSize: 35.r,
//           menuMaxHeight: 160.h,
//           value: value,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             prefixIcon: prefix,
//             contentPadding:
//                 EdgeInsets.only(bottom: 4.h, top: 4.h, right: 4.w, left: 4.w),
//             focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(borderRadius!.r),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(borderRadius!.r),
//             ),
//             border: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(borderRadius!.r),
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(borderRadius!.r),
//             ),
//             errorBorder: OutlineInputBorder(
//               borderSide: const BorderSide(color: Colors.transparent),
//               borderRadius: BorderRadius.circular(borderRadius!.r),
//             ),
//           ),
//           items: items.map((String? value) {
//             return DropdownMenuItem(
//               value: value,
//               child: Text(
//                 style: AppStyles.textBody12,
//                 value ?? '',
//                 overflow: TextOverflow.ellipsis,
//               ),
//             );
//           }).toList(),
//           onChanged: onChanged,
//           hint: Text(
//             hint,
//             textAlign: TextAlign.start,
//             style: AppStyles.textBody12.copyWith(color: Colors.grey),
//           ),
//         ),
//       ),
//     );
//   }
// }
