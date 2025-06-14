// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:curai_app_mobile/features/reviews/presentation/screens/add_review_screen.dart';
import 'package:curai_app_mobile/features/reviews/presentation/widgets/reviews_listview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewsTap extends StatefulWidget {
  const ReviewsTap({
    required this.doctorResults,
    super.key,
  });

  final DoctorInfoModel doctorResults;

  @override
  State<ReviewsTap> createState() => _ReviewsTapState();
}

class _ReviewsTapState extends State<ReviewsTap> {
  @override
  void initState() {
    super.initState();
    loadReviewes();
  }

  Future<void> loadReviewes() async {
    if (!mounted) return;
    await context.read<ReviewsCubit>().getReviews(
          doctorId: widget.doctorResults.id!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReviewsListViewWidget(
          doctorResults: widget.doctorResults,
        ).expand(),
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
                doctorId: widget.doctorResults.id!,
              ).paddingBottom(MediaQuery.of(context).viewInsets.bottom),
            );
          },
        ),
        10.hSpace,
      ],
    );
  }
}
