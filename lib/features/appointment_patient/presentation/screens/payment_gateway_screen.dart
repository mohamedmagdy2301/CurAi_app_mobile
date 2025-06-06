import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/payment/end_points_payment.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_cubit.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/payment_cubit/payment_patient_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class PaymentGatewayScreen extends StatefulWidget {
  const PaymentGatewayScreen({
    required this.paymentToken,
    required this.appointmentId,
    required this.discountApplied,
    required this.isDiscountEnabled,
    super.key,
  });
  final String paymentToken;
  final int appointmentId;
  final int discountApplied;
  final bool isDiscountEnabled;

  @override
  State<PaymentGatewayScreen> createState() => _PaymentGatewayScreenState();
}

class _PaymentGatewayScreenState extends State<PaymentGatewayScreen> {
  late final PaymentCubit _paymentCubit;
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _paymentCubit = PaymentCubit();
  }

  @override
  void dispose() {
    _paymentCubit.close();
    super.dispose();
  }

  void _startPayment() {
    _paymentCubit.startLoading();
    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          '${EndPointsPayment.getIframe}?payment_token=${widget.paymentToken}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppbarPaymentAppointment(),
      body: BlocBuilder<PaymentCubit, PaymentState>(
        bloc: _paymentCubit,
        builder: (context, state) {
          if (state.status == PaymentStatus.failure) {
            return _buildErrorWidget(context);
          }
          return Stack(
            children: [
              InAppWebView(
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                  _startPayment();
                },
                onLoadStop: (controller, url) async {
                  if (!mounted) return;
                  _paymentCubit.loadSuccess();

                  if (url != null &&
                      url.queryParameters.containsKey('success')) {
                    final isSuccess = url.queryParameters['success'] == 'true';

                    if (isSuccess) {
                      final appointmentCubit =
                          context.read<AppointmentPatientCubit>();

                      await appointmentCubit.simulatePaymentAppointment(
                        appointmentId: widget.appointmentId,
                      );

                      final currentState = appointmentCubit.state;

                      if (currentState is PaymentAppointmentSuccess) {
                        if (widget.isDiscountEnabled) {
                          await appointmentCubit.discountPaymentAppointment(
                            point: widget.discountApplied,
                          );

                          final discountState = appointmentCubit.state;

                          if (discountState is DiscountPaymentFailure) {
                            if (!context.mounted) return;
                            showMessage(
                              context,
                              message: discountState.message,
                              type: ToastificationType.error,
                            );
                            if (context.mounted) context.pop();
                            return;
                          }
                        }

                        if (!context.mounted) return;
                        await context.pushNamed(Routes.mainScaffoldUser);
                      } else if (currentState is PaymentAppointmentFailure) {
                        if (!context.mounted) return;
                        showMessage(
                          context,
                          message: currentState.message,
                          type: ToastificationType.error,
                        );
                        if (context.mounted) context.pop();
                      } else {
                        if (context.mounted) context.pop();
                      }
                    }
                  }
                },
                onReceivedError: (controller, request, error) {
                  if (!mounted) return;
                  _paymentCubit.loadFailure(error.toString());
                },
              ),
              if (state.status == PaymentStatus.loading)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomLoadingWidget(height: 40.h, width: 40.w),
                    24.hSpace,
                    AutoSizeText(
                      context.translate(LangKeys.loading),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyleApp.medium16().copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ).center(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.warning_rounded,
          color: Colors.red,
          size: 100.sp,
        ),
        16.hSpace,
        AutoSizeText(
          context.isStateArabic
              ? 'حدث خطأ أثناء تحميل بوابة الدفع'
              : 'An error occurred while loading the payment page',
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.medium16().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
        25.hSpace,
        CustomButton(
          title: context.isStateArabic ? 'إعادة المحاولة' : 'Retry',
          isNoLang: true,
          onPressed: _startPayment,
        ),
      ],
    ).center().paddingSymmetric(horizontal: 16);
  }
}
