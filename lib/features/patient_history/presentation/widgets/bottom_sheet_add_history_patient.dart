// تحويل DialogAddHistory إلى BottomSheetAddHistory
import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/patient_history/presentation/cubit/patient_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class BottomSheetAddHistoryPatient extends StatefulWidget {
  const BottomSheetAddHistoryPatient({
    required this.patientId,
    super.key,
  });
  final int patientId;

  @override
  State<BottomSheetAddHistoryPatient> createState() =>
      _BottomSheetAddHistoryPatientState();
}

class _BottomSheetAddHistoryPatientState
    extends State<BottomSheetAddHistoryPatient> {
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PatientHistoryCubit>(),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: EdgeInsets.all(20.sp),
          decoration: BoxDecoration(
            color: context.backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: context.W * 0.2,
                height: context.H * 0.003,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: context.onSecondaryColor.withAlpha(100),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ).center(),
              AutoSizeText(
                context.translate(LangKeys.addNewNote),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyleApp.bold20().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              20.hSpace,
              CustomTextFeild(
                labelText: context.translate(LangKeys.addNote),
                hint: context.translate(LangKeys.writeNoteHere),
                controller: _noteController,
                isValidator: false,
                maxLines: 4,
              ),
              20.hSpace,
              Row(
                children: [
                  CustomButton(
                    title: LangKeys.cancel,
                    isHalf: true,
                    colorBackground: context.backgroundColor,
                    colorBorder: context.primaryColor,
                    colorText: context.primaryColor,
                    onPressed: () => context.pop(),
                  ).expand(),
                  12.wSpace,
                  BlocConsumer<PatientHistoryCubit, PatientHistoryState>(
                    buildWhen: (previous, current) =>
                        current is AddPatientHistoryError ||
                        current is AddPatientHistorySuccess ||
                        current is AddPatientHistoryLoading,
                    listener: (context, state) {
                      if (state is AddPatientHistoryError) {
                        showMessage(
                          context,
                          message: state.message,
                          type: ToastificationType.error,
                        );
                      }
                      if (state is AddPatientHistorySuccess) {
                        _noteController.clear();
                        context.pushReplacementNamed(
                          Routes.patientHistoryScreen,
                          arguments: {'patientId': widget.patientId},
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        title: LangKeys.add,
                        isHalf: true,
                        isLoading: state is AddPatientHistoryLoading,
                        onPressed: () {
                          if (_noteController.text.trim().isNotEmpty) {
                            context
                                .read<PatientHistoryCubit>()
                                .addPatientHistory(
                                  patientId: widget.patientId,
                                  noteHistory: _noteController.text.trim(),
                                );
                          }
                        },
                      );
                    },
                  ).expand(),
                ],
              ),
              10.hSpace,
            ],
          ),
        ),
      ),
    );
  }
}
