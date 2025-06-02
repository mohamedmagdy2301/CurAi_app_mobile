// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/reviews/data/models/review_request.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class EditReviewScreen extends StatefulWidget {
  const EditReviewScreen({
    required this.doctorReviews,
    required this.doctorId,
    super.key,
  });
  final DoctorReviews doctorReviews;
  final int doctorId;

  @override
  State<EditReviewScreen> createState() => _EditReviewScreenState();
}

class _EditReviewScreenState extends State<EditReviewScreen> {
  late TextEditingController _commentController;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _commentController =
        TextEditingController(text: widget.doctorReviews.comment);
    _rating = widget.doctorReviews.rating ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReviewsCubit>(
      create: (context) => sl<ReviewsCubit>(),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            20.hSpace,
            StarRating(
              rating: _rating.toDouble(),
              size: 50.r,
              color: Colors.orangeAccent,
              borderColor: context.onSecondaryColor.withAlpha(50),
              emptyIcon: CupertinoIcons.star,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              filledIcon: CupertinoIcons.star_fill,
              onRatingChanged: (rating) {
                setState(() {
                  _rating = rating.toInt();
                });
              },
            ),
            30.hSpace,
            CustomTextFeild(
              labelText: context.translate(LangKeys.yourReview),
              hint: context.translate(LangKeys.yourReview),
              keyboardType: TextInputType.text,
              controller: _commentController,
              maxLines: 5,
            ),
            30.hSpace,
            BlocConsumer<ReviewsCubit, ReviewsState>(
              listenWhen: (previous, current) =>
                  current is UpdateReviewLoading ||
                  current is UpdateReviewSuccess ||
                  current is UpdateReviewError,
              listener: (context, state) async {
                if (state is UpdateReviewError) {
                  context.pop();

                  showMessage(
                    context,
                    message: state.message,
                    type: ToastificationType.error,
                  );

                  context.pop();
                }
                if (state is UpdateReviewSuccess) {
                  context.pop();
                  await context.read<ReviewsCubit>().getReviews(
                        doctorId: widget.doctorId,
                      );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: LangKeys.update,
                  isLoading: state is UpdateReviewLoading,
                  onPressed: () {
                    context.read<ReviewsCubit>().updateReviews(
                          reviewId: widget.doctorReviews.id!,
                          addReviewRequest: ReviewRequest(
                            doctor: widget.doctorId,
                            rating: _rating,
                            comment: _commentController.text.trim(),
                          ),
                        );

                    hideKeyboard();
                  },
                ).paddingBottom(Platform.isIOS ? 15.h : 0);
              },
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
