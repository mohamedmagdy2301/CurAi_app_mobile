// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({required this.doctorId, super.key});
  final int doctorId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _commentController = TextEditingController();
  int _rating = 1;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
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
              keyboardType: TextInputType.text,
              controller: _commentController,
              isLable: false,
              maxLines: 5,
            ),
            30.hSpace,
            BlocConsumer<ReviewsCubit, ReviewsState>(
              listenWhen: (previous, current) =>
                  current is ReviewsLoading ||
                  current is ReviewsSuccess ||
                  current is ReviewsError,
              listener: (context, state) {
                if (state is ReviewsError) {
                  Navigator.pop(context);
                  final isAlreadyRated = state.message.contains(
                    'You have already submitted a review for this doctor.',
                  );
                  final errorMessage = isAlreadyRated
                      ? (context.isStateArabic
                          ? 'لقد قمت بتقييم هذا الطبيب من قبل، يمكنك تعديل تقييمك'
                          : 'You have already rated ,You can edit your review')
                      : state.message;
                  showMessage(
                    context,
                    message: errorMessage,
                    type: isAlreadyRated
                        ? ToastificationType.info
                        : ToastificationType.error,
                  );

                  Navigator.of(context).pop();
                } else if (state is ReviewsSuccess) {
                  Navigator.pop(context);

                  showMessage(
                    context,
                    message: state.message,
                    type: ToastificationType.success,
                  );

                  Navigator.of(context).pop();
                } else if (state is ReviewsLoading) {
                  AdaptiveDialogs.showLoadingAlertDialog(
                    context: context,
                    title: context.translate(LangKeys.addReview),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: LangKeys.addReview,
                  onPressed: () {
                    if (_commentController.text.trim().isEmpty) {
                      showMessage(
                        context,
                        message: context.translate(LangKeys.pleaseEnterReview),
                        type: ToastificationType.error,
                      );
                      return;
                    }
                    context.read<ReviewsCubit>().addReviews(
                          AddReviewRequest(
                            doctor: widget.doctorId,
                            rating: _rating,
                            comment: _commentController.text.trim(),
                          ),
                        );
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
