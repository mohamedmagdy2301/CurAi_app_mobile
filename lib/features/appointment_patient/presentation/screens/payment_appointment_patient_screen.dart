// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/payment/paymob_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/payment_appointment/custom_appbar_payment_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toastification/toastification.dart';

class PaymentAppointmentScreen extends StatefulWidget {
  const PaymentAppointmentScreen({
    required this.doctorResults,
    required this.appointmentId,
    super.key,
  });
  final DoctorInfoModel doctorResults;
  final int appointmentId;

  @override
  State<PaymentAppointmentScreen> createState() =>
      _PaymentAppointmentScreenState();
}

class _PaymentAppointmentScreenState extends State<PaymentAppointmentScreen> {
  final GlobalKey<_PaymentSelectionWidgetState> _paymentSelectionKey =
      PaymentSelectionWidget.globalKey;
  bool isLoading = false;

  void _pay() {
    final priceString = widget.doctorResults.consultationPrice ?? '0';
    final price = int.tryParse(priceString.split('.').first) ?? 0;

    final selectedPayment = _paymentSelectionKey.currentState!.selectedPayment;

    switch (selectedPayment) {
      case 'Credit Card':
        setState(() {
          isLoading = true;
        });

        PaymobManager.getCreditCardPaymentKey(price).then((paymentKey) {
          if (!mounted) return;
          context.pushNamed(
            Routes.paymentGatewayScreen,
            arguments: {
              'paymentToken': paymentKey,
              'appointmentId': widget.appointmentId,
            },
          );
          setState(() {
            isLoading = false;
          });
        });
      case 'Wallet Payment':
        _showInfoDialog();
      case 'Bank Transfer':
        _showInfoDialog();
      case 'Cash':
        _showInfoDialog();
    }
  }

  void _showInfoDialog() {
    showMessage(
      context,
      message: context.isStateArabic
          ? 'قريبا سوف نضيف هذه الميزة في CurAi\nالآن يمكنك الدفع باستخدام بطاقة الائتمان'
          : 'This feature will be added soon in CurAi\nNow you can pay using Credit Card',
      type: ToastificationType.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarPaymentAppointment(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText(
            context.translate(LangKeys.paymentMethod),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          20.hSpace,
          PaymentSelectionWidget(key: PaymentSelectionWidget.globalKey),
          const Spacer(),
          CustomButton(
            title: LangKeys.payment,
            isLoading: isLoading,
            onPressed: _pay,
          ),
          10.hSpace,
          // BlocConsumer<AppointmentPatientCubit, AppointmentPatientState>(
          //   listenWhen: (previous, current) =>
          //       current is PaymentAppointmentFailure ||
          //       current is PaymentAppointmentLoading ||
          //       current is PaymentAppointmentSuccess,
          //   buildWhen: (previous, current) =>
          //       current is PaymentAppointmentLoading ||
          //       current is PaymentAppointmentSuccess ||
          //       current is PaymentAppointmentFailure,
          //   listener: (context, state) {
          //     if (state is PaymentAppointmentFailure) {
          //       Navigator.pop(context);
          //       showMessage(
          //         context,
          //         message: state.message,
          //         type: ToastificationType.error,
          //       );
          //     } else if (state is PaymentAppointmentSuccess) {
          //       Navigator.pop(context);
          //       showMessage(
          //         context,
          //         message: context.isStateArabic
          //             ? 'تم الدفع بنجاح'
          //             : 'Payment successful',
          //         type: ToastificationType.success,
          //       );
          //       context.pushNamedAndRemoveUntil(Routes.mainScaffoldUser);
          //       context
          //           .read<AppointmentPatientCubit>()
          //           .refreshMyAppointmentPatient();
          //     } else if (state is PaymentAppointmentLoading) {
          //       AdaptiveDialogs.showLoadingAlertDialog(
          //         context: context,
          //         title: context.translate(LangKeys.login),
          //       );
          //     }
          //   },
          //   builder: (context, state) {
          //     return CustomButton(
          //       title: LangKeys.bookAppointment,
          //       onPressed: () {
          //         context
          //             .read<AppointmentPatientCubit>()
          //             .simulatePaymentAppointment(
          //               appointmentId: widget.appointmentId,
          //             );
          //       },
          //     );
          //   },
          // ),
        ],
      )
          .paddingSymmetric(horizontal: 15)
          .paddingOnly(bottom: Platform.isIOS ? 17 : 10),
    );
  }
}

class PaymentSelectionWidget extends StatefulWidget {
  const PaymentSelectionWidget({super.key});
  static final GlobalKey<_PaymentSelectionWidgetState> globalKey =
      GlobalKey<_PaymentSelectionWidgetState>();

  @override
  _PaymentSelectionWidgetState createState() => _PaymentSelectionWidgetState();
}

class _PaymentSelectionWidgetState extends State<PaymentSelectionWidget> {
  String selectedPayment = 'Credit Card';
  String selectedCard = 'Master Card';

  final List<String> creditCards = [
    'Master Card',
    'Visa',
    'PayPal',
    'Apple Pay',
  ];

  final Map<String, String> cardLogos = {
    'Master Card': AppImagesSvg.mastercard,
    'Visa': AppImagesSvg.visa,
    'PayPal': AppImagesSvg.paypal,
    'Apple Pay': AppImagesSvg.applePay,
  };

  Widget _buildCardItem(String name) {
    return ListTile(
      leading: SvgPicture.asset(
        cardLogos[name]!,
        height: 24.h,
      ),
      title: AutoSizeText(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyleApp.medium16().copyWith(
          color: context.onSecondaryColor,
        ),
      ),
      onTap: () => setState(() => selectedCard = name),
      selected: selectedCard == name,
      selectedTileColor: context.primaryColor.withAlpha(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    ).paddingSymmetric(vertical: 4, horizontal: 40);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RadioListTile<String>(
          fillColor: WidgetStateProperty.all(context.primaryColor),
          title: AutoSizeText(
            context.isStateArabic ? 'بطاقة بنكية' : 'Credit Card',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          value: 'Credit Card',
          groupValue: selectedPayment,
          onChanged: (value) => setState(() => selectedPayment = value!),
        ).paddingOnly(bottom: 12),
        ...creditCards.map(_buildCardItem),
        RadioListTile<String>(
          fillColor: WidgetStateProperty.all(context.primaryColor),
          title: AutoSizeText(
            context.isStateArabic ? 'محفظة الدفع' : 'Wallet Payment',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          value: 'Wallet Payment',
          groupValue: selectedPayment,
          onChanged: (value) => setState(() => selectedPayment = value!),
        ).paddingSymmetric(vertical: 8),
        RadioListTile<String>(
          fillColor: WidgetStateProperty.all(context.primaryColor),
          title: AutoSizeText(
            context.isStateArabic ? 'تحويل بنكي' : 'Bank Transfer',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          value: 'Bank Transfer',
          groupValue: selectedPayment,
          onChanged: (value) => setState(() => selectedPayment = value!),
        ).paddingSymmetric(vertical: 8),
        RadioListTile<String>(
          fillColor: WidgetStateProperty.all(context.primaryColor),
          title: AutoSizeText(
            context.isStateArabic ? 'نقدا' : 'Cash',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          value: 'Cash',
          groupValue: selectedPayment,
          onChanged: (value) => setState(() => selectedPayment = value!),
        ).paddingOnly(bottom: 8.h),
      ],
    );
  }
}
