// ignore_for_file: lines_longer_than_80_chars, document_ignores

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/custom_appbar_privacy_policy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarPrivacyPolicy(),
      body: ListView(
        children: [
          _buildSection(
            context.isStateArabic ? 'سياسة الإلغاء' : 'Cancellation Policy',
            [
              _buildTile(
                context,
                context.isStateArabic
                    ? 'الإلغاء من قبل المرضى'
                    : 'Cancellation by Patients',
                context.isStateArabic
                    ? 'يمكن للمرضى إلغاء موعدهم قبل 24 ساعة على الأقل من الوقت المحدد لاسترداد المبلغ بالكامل. قد لا تكون الإلغاءات خلال 24 ساعة مؤهلة لاسترداد الأموال.'
                    : 'Patients can cancel their appointment at least 24 hours before the scheduled time to receive a full refund. Cancellations within 24 hours may not be eligible for a refund.',
              ),
              _buildTile(
                context,
                context.isStateArabic
                    ? 'الإلغاء من قبل الأطباء'
                    : 'Cancellation by Doctors',
                context.isStateArabic
                    ? 'يمكن للأطباء إلغاء الموعد فقط في حالات الطوارئ. سيحصل المرضى على استرداد كامل ويمكنهم إعادة تحديد موعد مع طبيب آخر متاح.'
                    : 'Doctors may cancel an appointment only in emergency situations. Patients will receive a full refund and may reschedule with another available doctor.',
              ),
              _buildTile(
                context,
                context.isStateArabic ? 'سياسة الاسترداد' : 'Refund Policy',
                context.isStateArabic
                    ? 'تتم معالجة عمليات الاسترداد في غضون 5-7 أيام عمل للإلغاءات المؤهلة. يجب رفع أي نزاعات في غضون 7 أيام من تاريخ المعاملة.'
                    : 'Refunds are processed within 5-7 business days for eligible cancellations. Any disputes must be raised within 7 days of the transaction.',
              ),
              _buildTile(
                context,
                context.isStateArabic
                    ? 'تغييرات في السياسة'
                    : 'Changes to Policy',
                context.isStateArabic
                    ? 'يجوز لنا تعديل هذه السياسة في أي وقت. يشير الاستخدام المستمر للخدمة إلى قبول التحديثات.'
                    : 'We may modify this policy at any time. Continued use of the service implies acceptance of updates.',
              ),
            ],
            context,
          ),
          _buildSection(
            context.isStateArabic ? 'الشروط والأحكام' : 'Terms & Conditions',
            [
              _buildTile(
                context,
                context.isStateArabic ? 'قبول الشروط' : 'Acceptance of Terms',
                context.isStateArabic
                    ? 'باستخدام CurAi، يوافق المستخدمون (سواء الأطباء أو المرضى) على الامتثال لهذه الشروط. نحن نحتفظ بالحق في تحديث أو تعديل هذه الشروط في أي وقت.'
                    : 'By using CurAi, users (both doctors and patients) agree to comply with these terms. We reserve the right to update or modify these terms at any time.',
              ),
              _buildTile(
                context,
                context.isStateArabic
                    ? 'مسؤوليات المرضى'
                    : 'Patient Responsibilities',
                context.isStateArabic
                    ? 'يجب على المرضى تقديم معلومات دقيقة وحضور المواعيد المحددة في الوقت المحدد. قد يؤدي الغياب المتكرر إلى تعليق الحساب.'
                    : 'Patients must provide accurate information and attend scheduled appointments on time. Repeated no-shows may result in account suspension.',
              ),
              _buildTile(
                context,
                context.isStateArabic
                    ? 'مسؤوليات الأطباء'
                    : 'Doctor Responsibilities',
                context.isStateArabic
                    ? 'يجب على الأطباء تقديم الخدمات المهنية والحفاظ على المعايير الأخلاقية. قد يؤدي الفشل في ذلك إلى تعليق الحساب.'
                    : 'Doctors must provide professional services and maintain ethical standards. Failure to do so may result in account suspension.',
              ),
              _buildTile(
                context,
                context.isStateArabic
                    ? 'حقوق الملكية الفكرية'
                    : 'Intellectual Property',
                context.isStateArabic
                    ? 'تظل جميع المحتويات والعلامات التجارية داخل CurAi ملكية حصرية للشركة. يحظر الاستخدام غير المصرح به.'
                    : 'All content and trademarks within CurAi remain the exclusive property of the company. Unauthorized use is prohibited.',
              ),
              _buildTile(
                context,
                context.isStateArabic ? 'سياسة الخصوصية' : 'Privacy Policy',
                context.isStateArabic
                    ? 'يتم جمع ومعالجة بيانات المستخدم وفقًا لسياسة الخصوصية الخاصة بنا. نحن لا نشارك معلومات المستخدم دون موافقة إلا إذا كان ذلك مطلوبًا بموجب القانون.'
                    : 'User data is collected and processed according to our privacy policy. We do not share user information without consent unless required by law.',
              ),
              _buildTile(
                context,
                context.isStateArabic ? 'القانون الحاكم' : 'Governing Law',
                context.isStateArabic
                    ? 'تحكم هذه الشروط وفقًا لقوانين جمهورية مصر العربية. سيتم حل النزاعات وفقًا للإجراءات القانونية المعمول بها.'
                    : 'These terms are governed by the laws of the Arab Republic of Egypt. Disputes will be resolved per applicable legal procedures.',
              ),
              // _buildAgreementButton(context),
            ],
            context,
          ),
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 10),
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyleApp.bold22().copyWith(
            color: context.primaryColor,
          ),
        ),
        8.hSpace,
        ...children,
        8.hSpace,
      ],
    );
  }

  Widget _buildTile(BuildContext context, String title, String content) {
    return ExpansionTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      dense: true,
      title: Text(
        title,
        style: TextStyleApp.semiBold16().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      children: [
        Text(
          content,
          style: TextStyleApp.medium16().copyWith(
            color: context.onSecondaryColor,
          ),
        ).paddingSymmetric(horizontal: 15, vertical: 5),
      ],
    );
  }

  // Widget _buildAgreementButton(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 20),
  //     child: Center(
  //       child: ElevatedButton(
  //         onPressed: () {
  //           // Implement agreement logic (e.g., store user consent)
  //         },
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: context.primaryColor,
  //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  //         ),
  //         child: Text(
  //           'Accept & Continue',
  //           style: TextStyleApp.semiBold16().copyWith(
  //             color: context.onPrimaryColor,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
