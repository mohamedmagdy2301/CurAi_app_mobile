// import 'package:curai_app_mobile/core/app/cubit/localization_cubit.dart'
//     show LocalizationCubit;
// import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
// import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
// import 'package:curai_app_mobile/core/language/lang_keys.dart';
// import 'package:curai_app_mobile/features/user/presentation/widgets/settings/localize_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LocaizationScreen extends StatelessWidget {
//   const LocaizationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<LocalizationCubit>();
//     final state = context.read<LocalizationCubit>().state;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(context.translate(LangKeys.changeLanguage)),
//         centerTitle: true,
//         flexibleSpace: Container(color: context.backgroundColor),
//       ),
//       body: Center(
//         child: LocalizeWidget(cubit: cubit, state: state),
//       ),
//     );
//   }
// }
