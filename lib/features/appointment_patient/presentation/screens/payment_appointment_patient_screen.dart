// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/payment/paymob_manager.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_number.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_divider.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/widgets/payment_appointment/custom_appbar_payment_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  String selectedPayment = 'Credit Card';

  bool isLoading = false;
  bool isDiscountEnabled = false;
  late int price;
  late int bonus;

  @override
  void initState() {
    super.initState();
    final priceString = widget.doctorResults.consultationPrice ?? '0';
    price = int.tryParse(priceString.split('.').first) ?? 0;
    bonus = getBonusPoints();
  }

  int _calculateTotalPrice() {
    if (!isDiscountEnabled) return price;
    final discount = bonus >= price ? price : bonus;
    return price - discount;
  }

  int _getAppliedDiscount() {
    if (!isDiscountEnabled) return 0;
    return bonus >= price ? price : bonus;
  }

  int _remainingBonusPoints() {
    if (!isDiscountEnabled) return bonus;
    final discount = bonus >= price ? price : bonus;
    return bonus - discount;
  }

  void _submitPayment() {
    switch (selectedPayment) {
      case 'Credit Card':
        setState(() {
          isLoading = true;
        });

        PaymobManager.getCreditCardPaymentKey(_calculateTotalPrice())
            .then((paymentKey) {
          if (!mounted) return;
          context.pushNamed(
            Routes.paymentGatewayScreen,
            arguments: {
              'paymentToken': paymentKey,
              'appointmentId': widget.appointmentId,
              'isDiscountEnabled': isDiscountEnabled,
              'discountApplied': isDiscountEnabled ? _getAppliedDiscount() : 0,
            },
          );
          setState(() {
            isLoading = false;
          });
        });
      case 'Cash':
        _showInfoDialog();
      case 'Wallet':
        _showInfoDialog();
    }
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
          ).paddingSymmetric(horizontal: 15, vertical: 2),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPaymentOption(
                      value: 'Credit Card',
                      title: context.isStateArabic
                          ? 'بطاقة ائتمان'
                          : 'Credit Card',
                      icon: CupertinoIcons.creditcard_fill,
                    ),
                    10.hSpace,
                    _buildPaymentOption(
                      value: 'Wallet',
                      title:
                          context.isStateArabic ? 'محفظة الكترونية' : 'Wallet',
                      icon: Icons.wallet,
                    ),
                    10.hSpace,
                    _buildPaymentOption(
                      value: 'Cash',
                      title: context.isStateArabic ? 'نقداً' : 'Cash',
                      icon: Icons.monetization_on_outlined,
                    ),
                  ],
                ),
              ],
            ).paddingSymmetric(horizontal: 15).paddingOnly(top: 15),
          ).expand(),
          _buildBottomPriceSheet(),
        ],
      ),
    );
  }

  Widget _buildBottomPriceSheet() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDark
            ? const Color.fromARGB(255, 32, 32, 32)
            : const Color.fromARGB(255, 248, 248, 248),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: [
          BoxShadow(
            color: context.onPrimaryColor.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: context.primaryColor.withAlpha(25),
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        20.h,
        20.w,
        context.paddingOf.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 3.5.h,
            width: 70.w,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: context.onSecondaryColor.withAlpha(160),
              borderRadius: BorderRadius.circular(2),
            ),
          ).center(),
          _buildDiscountToggleCard(),
          16.hSpace,
          _buildCompactPriceDetails(),
          20.hSpace,
          CustomButton(
            title: LangKeys.payment,
            isLoading: isLoading,
            isRegular: true,
            icon: Icon(
              selectedPayment == 'Credit Card'
                  ? CupertinoIcons.creditcard
                  : selectedPayment == 'Wallet'
                      ? Icons.wallet
                      : Icons.monetization_on_outlined,
              size: 20.w,
            ),
            onPressed: _submitPayment,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactPriceDetails() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.primaryColor.withAlpha(9),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.primaryColor.withAlpha(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    context.translate(LangKeys.consultationPrice),
                    style: TextStyleApp.regular16().copyWith(
                      color: context.onSecondaryColor,
                    ),
                  ),
                  AutoSizeText(
                    '${context.isStateArabic ? toArabicNumber(price.toString()) : price} '
                    '${context.translate(LangKeys.egp)}',
                    style: TextStyleApp.bold16().copyWith(
                      color: context.primaryColor,
                      decoration: isDiscountEnabled && _getAppliedDiscount() > 0
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ],
              ).expand(),
              if (isDiscountEnabled && _getAppliedDiscount() > 0) ...[
                16.wSpace,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(25),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.green.withAlpha(50),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.local_offer_rounded,
                        size: 16.w,
                        color: Colors.green,
                      ),
                      4.wSpace,
                      AutoSizeText(
                        '${context.translate(LangKeys.discount)} ${_getAppliedDiscount()}',
                        style: TextStyleApp.bold12().copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          12.hSpace,
          if (isDiscountEnabled && _calculateTotalPrice() != 0)
            const CustomDivider(),
          if (isDiscountEnabled && _calculateTotalPrice() != 0) 12.hSpace,
          if (isDiscountEnabled && _calculateTotalPrice() != 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  context.translate(LangKeys.requiredPrice),
                  style: TextStyleApp.bold16().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withAlpha(150),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: AutoSizeText(
                    '${context.isStateArabic ? toArabicNumber(_calculateTotalPrice().toString()) : _calculateTotalPrice()} '
                    '${context.translate(LangKeys.egp)}',
                    style: TextStyleApp.bold16().copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDiscountToggleCard() {
    if (bonus <= 0) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDiscountEnabled
              ? context.primaryColor.withAlpha(75)
              : context.primaryColor.withAlpha(25),
        ),
        boxShadow: [
          BoxShadow(
            color: context.onPrimaryColor.withAlpha(12),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.card_giftcard_rounded,
                color: context.primaryColor,
                size: 24.w,
              ),
              12.wSpace,
              AutoSizeText(
                context.translate(LangKeys.useOfRewardPoints),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.bold16().copyWith(
                  color: context.onPrimaryColor,
                ),
              ).expand(),
              Switch.adaptive(
                value: isDiscountEnabled,
                activeColor: context.primaryColor,
                inactiveTrackColor: context.onSecondaryColor.withAlpha(50),
                thumbColor: WidgetStateProperty.all(Colors.white),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: (value) {
                  setState(() {
                    isDiscountEnabled = value;
                  });
                },
              ),
            ],
          ),
          12.hSpace,
          Container(
            width: double.infinity,
            padding: context.padding(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: isDiscountEnabled
                  ? context.primaryColor.withAlpha(20)
                  : context.onSecondaryColor.withAlpha(15),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      context.translate(LangKeys.theRewardPointsAvailable),
                      style: TextStyleApp.regular14().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ).expand(),
                    AutoSizeText(
                      '${context.isStateArabic ? toArabicNumber(bonus.toString()) : bonus} '
                      '${context.translate(LangKeys.egp)}',
                      style: TextStyleApp.medium14().copyWith(
                        color: context.primaryColor,
                      ),
                    ),
                  ],
                ),
                if (isDiscountEnabled) ...[
                  6.hSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        context.translate(LangKeys.appliedDiscount),
                        style: TextStyleApp.regular14().copyWith(
                          color: context.onSecondaryColor,
                        ),
                      ).expand(),
                      AutoSizeText(
                        '${context.isStateArabic ? toArabicNumber(_getAppliedDiscount().toString()) : _getAppliedDiscount()} '
                        '${context.translate(LangKeys.egp)}',
                        style: TextStyleApp.medium14().copyWith(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  6.hSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        context.translate(LangKeys.remainingPoints),
                        style: TextStyleApp.regular14().copyWith(
                          color: context.onSecondaryColor,
                        ),
                      ).expand(),
                      AutoSizeText(
                        '${context.isStateArabic ? toArabicNumber(_remainingBonusPoints().toString()) : _remainingBonusPoints()} '
                        '${context.translate(LangKeys.egp)}',
                        style: TextStyleApp.medium14().copyWith(
                          color: context.onPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if (isDiscountEnabled) ...[
            8.hSpace,
            Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  color: context.primaryColor,
                  size: 16.w,
                ),
                6.wSpace,
                AutoSizeText(
                  context.translate(LangKeys.useOfRewardPointsInfo),
                  style: TextStyleApp.regular12().copyWith(
                    color: context.primaryColor,
                  ),
                ).expand(),
              ],
            ),
          ],
        ],
      ),
    );
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

  Widget _buildPaymentOption({
    required String value,
    required String title,
    required IconData icon,
  }) {
    final isSelected = selectedPayment == value;

    return InkWell(
      onTap: () => setState(() => selectedPayment = value),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? context.primaryColor : context.onSecondaryColor,
            width: isSelected ? 1 : .5,
          ),
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    context.primaryColor.withAlpha(6),
                    context.primaryColor.withAlpha(8),
                  ],
                )
              : null,
          color: isSelected ? null : context.backgroundColor,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.primaryColor.withAlpha(20),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: context.primaryColor.withAlpha(25),
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color:
                    isSelected ? context.primaryColor : context.onPrimaryColor,
              ).center(),
            ),
            16.wSpace,
            Text(
              title,
              style: TextStyleApp.semiBold18().copyWith(
                color:
                    isSelected ? context.primaryColor : context.onPrimaryColor,
              ),
            ).expand(),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? context.primaryColor
                      : context.onSecondaryColor,
                ),
                color: isSelected ? context.primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
