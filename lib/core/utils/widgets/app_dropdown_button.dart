// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AppDropDownButton extends StatelessWidget {
//   const AppDropDownButton({
//     required this.hintText,
//     required this.onChanged,
//     required this.items,
//     super.key,
//     this.value,
//   });

//   final String hintText;
//   final void Function(String?) onChanged;
//   final List<Map<String, String>> items;
//   final String? value;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: DropdownButtonFormField2<String>(
//         value: value,
//         onChanged: onChanged,
//         style: StyleText.medium16().copyWith(color: Colors.white),
//         dropdownStyleData: DropdownStyleData(
//           maxHeight: 300.h,
//           width: 200.w,
//           padding: const EdgeInsets.only(top: 20),
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 57, 57, 57),
//             // border: Border.all(style: BorderStyle.solid),
//             borderRadius: BorderRadius.all(Radius.circular(20.r)),
//           ),
//         ),
//         alignment: Alignment.center,
//         decoration: secondryFormFieldDecoration(),
//         iconStyleData: const IconStyleData(iconEnabledColor: Colors.white),
//         isExpanded: true,
//         hint: Text(
//           hintText,
//           style: StyleText.medium16().copyWith(
//             color: Colors.white,
//             height: 1.2,
//           ),
//         ),
//         items: items.map((item) {
//           return DropdownMenuItem<String>(
//             value: item['value'],
//             child: Text(
//               item['name']!,
//               style: StyleText.medium16().copyWith(color: Colors.white),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

// InputDecoration secondryFormFieldDecoration({
//   String? hintText,
//   Widget? suffixIcon,
//   Widget? prefixIcon,
//   Color? borderColor,
// }) {
//   return InputDecoration(
//     hintText: hintText,
//     border: InputBorder.none,
//     enabledBorder: InputBorder.none,
//     focusedBorder: InputBorder.none,
//     filled: false,
//     errorBorder: InputBorder.none,
//     disabledBorder: InputBorder.none,
//     focusedErrorBorder: InputBorder.none,
//     contentPadding: const EdgeInsets.all(1).w,
//     prefixIcon: prefixIcon,
//     suffixIcon: suffixIcon,
//   );
// }
