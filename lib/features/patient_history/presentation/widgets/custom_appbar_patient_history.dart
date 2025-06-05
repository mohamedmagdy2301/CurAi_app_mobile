import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/widgets/bottom_sheet_add_history_patient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarPatientHistory extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarPatientHistory({
    required this.patientId,
    super.key,
  });

  final int patientId;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        context.translate(LangKeys.historyPatient),
        maxLines: 1,
        style: TextStyleApp.bold22().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          context.pushNamedAndRemoveUntil(Routes.mainScaffoldUser);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.add,
            size: 30.sp,
          ),
          onPressed: () => showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return BottomSheetAddHistoryPatient(
                patientId: patientId,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
