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
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
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
  bool isDiscountEnabled = true;
  late int price;
  late int bonus;

  @override
  void initState() {
    super.initState();
    final priceString = widget.doctorResults.consultationPrice ?? '0';
    price = int.tryParse(priceString.split('.').first) ?? 0;
    bonus = getBonusPoints() - 200;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarPaymentAppointment(),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
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
                15.hSpace,
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
        color: context.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: context.primaryColor.withOpacity(0.1),
          ),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        20.w,
        20.h,
        20.w,
        MediaQuery.of(context).padding.bottom + 20.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // مؤشر السحب
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: context.primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          16.hSpace,
          _buildDiscountToggleCard(),

          16.hSpace,

          _buildCompactPriceDetails(),

          20.hSpace,

          // زر الدفع
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: isLoading ? null : _submitPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.payment_rounded,
                          size: 20.w,
                        ),
                        8.wSpace,
                        AutoSizeText(
                          selectedPayment,
                          style: TextStyleApp.bold16().copyWith(
                            color: Colors.white,
                          ),
                        ),
                        8.wSpace,
                        AutoSizeText(
                          '${_calculateTotalPrice()} ${context.translate(LangKeys.egp)}',
                          style: TextStyleApp.bold16().copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
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
        color: context.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.primaryColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        children: [
          // السعر الأساسي والخصم في صف واحد
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      context.translate(LangKeys.consultationPrice),
                      style: TextStyleApp.regular14().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
                    4.hSpace,
                    AutoSizeText(
                      '$price ${context.translate(LangKeys.egp)}',
                      style: TextStyleApp.bold16().copyWith(
                        color: context.onPrimaryColor,
                        decoration:
                            isDiscountEnabled && _getAppliedDiscount() > 0
                                ? TextDecoration.lineThrough
                                : null,
                      ),
                    ),
                  ],
                ),
              ),
              if (isDiscountEnabled && _getAppliedDiscount() > 0) ...[
                16.wSpace,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.green.withOpacity(0.2),
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
                        'خصم ${_getAppliedDiscount()}',
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

          if (isDiscountEnabled && _getAppliedDiscount() > 0) ...[
            12.hSpace,
            Container(
              height: 1,
              color: context.primaryColor.withOpacity(0.1),
            ),
            12.hSpace,
          ],

          // السعر النهائي
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'المبلغ المطلوب',
                style: TextStyleApp.bold16().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: AutoSizeText(
                  '${_calculateTotalPrice()} ${context.translate(LangKeys.egp)}',
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
              ? context.primaryColor.withOpacity(0.3)
              : context.primaryColor.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Expanded(
                child: AutoSizeText(
                  'استخدام نقاط المكافأة',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.bold16().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
              Switch.adaptive(
                value: isDiscountEnabled,
                onChanged: (value) {
                  setState(() {
                    isDiscountEnabled = value;
                  });
                },
                activeColor: context.primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
          12.hSpace,
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDiscountEnabled
                  ? context.primaryColor.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText(
                      'نقاط المكافأة المتاحة',
                      style: TextStyleApp.regular14().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
                    AutoSizeText(
                      '$bonus ${context.translate(LangKeys.egp)}',
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
                        'الخصم المطبق',
                        style: TextStyleApp.regular14().copyWith(
                          color: context.onSecondaryColor,
                        ),
                      ),
                      AutoSizeText(
                        '${_getAppliedDiscount()} ${context.translate(LangKeys.egp)}',
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
                        'النقاط المتبقية',
                        style: TextStyleApp.regular14().copyWith(
                          color: context.onSecondaryColor,
                        ),
                      ),
                      AutoSizeText(
                        '${_remainingBonusPoints()} ${context.translate(LangKeys.egp)}',
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
                  color: Colors.blue,
                  size: 16.w,
                ),
                6.wSpace,
                Expanded(
                  child: AutoSizeText(
                    'سيتم خصم نقاط المكافأة تلقائياً من إجمالي المبلغ',
                    style: TextStyleApp.regular12().copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

// ! ----------------------------------------------------------------
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
              'discountApplied': isDiscountEnabled ? _getAppliedDiscount() : 0,
              'bonusPointsUsed': isDiscountEnabled ? _getAppliedDiscount() : 0,
            },
          );
          setState(() {
            isLoading = false;
          });
        });
      case 'Cash':
        _showInfoDialog();
      case 'ًWallet':
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
