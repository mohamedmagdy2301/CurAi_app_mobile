// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/reviews/presentation/screens/add_review_screen.dart';
import 'package:curai_app_mobile/features/reviews/presentation/widgets/no_reviews_widget.dart';
import 'package:curai_app_mobile/features/reviews/presentation/widgets/reviews_widget.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter/material.dart';

class ReviewsTap extends StatelessWidget {
  const ReviewsTap({
    required this.doctorResults,
    super.key,
  });

  final DoctorResults doctorResults;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (doctorResults.reviews!.isNotEmpty)
          ReviewsListViewWidget(
            doctorResults: doctorResults,
          ).expand()
        else
          const NoReviewsWidget().expand(),
        5.hSpace,
        CustomButton(
          title: LangKeys.addReview,
          colorBackground: context.backgroundColor,
          colorBorder: context.primaryColor,
          colorText: context.primaryColor,
          onPressed: () {
            showModalBottomSheet(
              context: context,
              barrierColor: context.onPrimaryColor.withAlpha(60),
              backgroundColor: context.backgroundColor,
              isScrollControlled: true,
              builder: (_) => AddReviewScreen(
                doctorId: doctorResults.id!,
              ).paddingBottom(MediaQuery.of(context).viewInsets.bottom),
            );
          },
        ),
        10.hSpace,
      ],
    );
  }
}
