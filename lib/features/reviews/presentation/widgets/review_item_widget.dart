import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/detect_language_string.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_data.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/core/utils/widgets/image_viewer_full_screen.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:curai_app_mobile/features/reviews/presentation/screens/edit_review_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class ReviewItemWidget extends StatefulWidget {
  const ReviewItemWidget({
    required this.doctorReviews,
    required this.doctorId,
    super.key,
  });

  final DoctorReviews doctorReviews;
  final int doctorId;

  @override
  State<ReviewItemWidget> createState() => _ReviewItemWidgetState();
}

class _ReviewItemWidgetState extends State<ReviewItemWidget> {
  void onUpdate() {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: context.onPrimaryColor.withAlpha(60),
      backgroundColor: context.backgroundColor,
      isScrollControlled: true,
      builder: (_) => EditReviewScreen(
        doctorReviews: widget.doctorReviews,
        doctorId: widget.doctorId,
      ).paddingBottom(MediaQuery.of(context).viewInsets.bottom),
    );
  }

  void onDelete() {
    context.read<ReviewsCubit>().deleteReviews(
          reviewId: widget.doctorReviews.id!,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isYouReview = widget.doctorReviews.patientUsername == getUsername();

    return Card(
      color: context.primaryColor.withAlpha(1),
      elevation: .02,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      shadowColor: context.onSecondaryColor.withAlpha(40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(20.r),
                onTap: () => showImageViewerFullScreen(
                  context,
                  imageUrl: widget.doctorReviews.profilePatientPicture ??
                      AppImages.avatarOnlinePatient,
                ),
                child: CustomCachedNetworkImage(
                  imgUrl: widget.doctorReviews.profilePatientPicture ??
                      AppImages.avatarOnlinePatient,
                  width: context.H * 0.05,
                  height: context.H * 0.05,
                  loadingImgPadding: 10.w,
                  errorIconSize: 20.sp,
                ).cornerRadiusWithClipRRect(1000.r),
              ),
              15.wSpace,
              SizedBox(
                width: context.W * 0.45,
                child: AutoSizeText(
                  isYouReview
                      ? context.translate(LangKeys.you)
                      : "${widget.doctorReviews.firstName?.capitalizeFirstChar ?? ""} "
                          "${widget.doctorReviews.lastName?.capitalizeFirstChar ?? ""}",
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleApp.bold20().copyWith(
                    color: context.onPrimaryColor,
                  ),
                ),
              ),
              const Spacer(),
              AutoSizeText(
                toFormattedDate(
                  context: context,
                  date: widget.doctorReviews.createdAt!,
                ),
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.regular16().copyWith(
                  color: context.onSecondaryColor.withAlpha(100),
                ),
              ),
            ],
          ),
          StarRating(
            rating: (widget.doctorReviews.rating ?? 0).toDouble(),
            size: 25.r,
            color: Colors.orangeAccent,
            mainAxisAlignment: MainAxisAlignment.end,
            filledIcon: CupertinoIcons.star_fill,
            emptyIcon: CupertinoIcons.star,
            borderColor: context.onSecondaryColor.withAlpha(50),
          ).paddingSymmetric(vertical: 5),
          if (widget.doctorReviews.comment != '')
            SizedBox(
              width: context.W * 0.9,
              child: AutoSizeText(
                widget.doctorReviews.comment!,
                maxLines: 5,
                textDirection:
                    detectLanguage(widget.doctorReviews.comment ?? '') == 'ar'
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.regular18().copyWith(
                  color: context.onSecondaryColor,
                ),
              ),
            ).paddingSymmetric(horizontal: 8, vertical: 4),
          if (isYouReview)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onUpdate,
                  icon: Icon(Icons.edit, color: context.primaryColor),
                  label: Text(
                    context.translate(LangKeys.update),
                    style: TextStyleApp.regular16().copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
                BlocConsumer<ReviewsCubit, ReviewsState>(
                  listenWhen: (previous, current) =>
                      current is DeleteReviewError ||
                      current is DeleteReviewSuccess ||
                      current is DeleteReviewLoading,
                  listener: (context, state) {
                    if (state is DeleteReviewSuccess) {
                      context.read<ReviewsCubit>().getReviews(
                            doctorId: widget.doctorId,
                          );
                    }
                    if (state is DeleteReviewError) {
                      showMessage(
                        context,
                        message: state.message,
                        type: ToastificationType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteReviewLoading) {
                      return const CustomLoadingWidget().withWidth(100.w);
                    }
                    return TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: Text(
                        context.translate(LangKeys.delete),
                        style: TextStyleApp.regular16().copyWith(
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 15),
    );
  }
}
