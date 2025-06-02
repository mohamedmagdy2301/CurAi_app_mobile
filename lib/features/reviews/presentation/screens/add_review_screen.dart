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
                  current is AddReviewLoading ||
                  current is AddReviewSuccess ||
                  current is AddReviewError,
              listener: (context, state) async {
                if (state is AddReviewError) {
                  context.pop();
                  final isAlreadyRated = state.message.contains(
                    'You have already submitted a review for this doctor.',
                  );
                  final errorMessage = isAlreadyRated
                      ? context.translate(LangKeys.alreadyRated)
                      : state.message;
                  showMessage(
                    context,
                    message: errorMessage,
                    type: isAlreadyRated
                        ? ToastificationType.info
                        : ToastificationType.error,
                  );
                }

                if (state is AddReviewSuccess) {
                  context.pop();
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: LangKeys.addReview,
                  isLoading: state is AddReviewLoading,
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
                          ReviewRequest(
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
