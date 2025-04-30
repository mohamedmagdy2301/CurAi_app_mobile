import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/availability_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbarWorkingTimeAppointmentDoctor extends StatefulWidget
    implements PreferredSizeWidget {
  const CustomAppbarWorkingTimeAppointmentDoctor({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppbarWorkingTimeAppointmentDoctor> createState() =>
      _CustomAppbarWorkingTimeAppointmentDoctorState();
}

class _CustomAppbarWorkingTimeAppointmentDoctorState
    extends State<CustomAppbarWorkingTimeAppointmentDoctor> {
  Future<void> showAvailabilityBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AvailabilityBottomSheet(),
    );

    if (result != null) {
      setState(() {
        showMessage(
          context,
          type: SnackBarType.success,
          message: (result['days_of_week'] +
              '\n' +
              result['available_from'] +
              ' - ' +
              result['available_to']) as String,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        context.translate(LangKeys.workingTime),
        maxLines: 1,
        style: TextStyleApp.medium24().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () => showAvailabilityBottomSheet(context),
          icon: Icon(
            CupertinoIcons.add_circled,
            color: context.onPrimaryColor,
            size: 30.sp,
          ),
        ),
      ],
    );
  }
}
