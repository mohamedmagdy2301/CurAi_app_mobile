import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          const NoReviewsWidget(),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}

class ReviewsListViewWidget extends StatefulWidget {
  const ReviewsListViewWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorResults doctorResults;

  @override
  State<ReviewsListViewWidget> createState() => _ReviewsListViewWidgetState();
}

class _ReviewsListViewWidgetState extends State<ReviewsListViewWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.doctorResults.reviews!.length,
      itemBuilder: (context, index) {
        return ReviewsItemWidget(
          doctorResults: widget.doctorResults,
          index: index,
        );
      },
    ).paddingSymmetric(
      vertical: 10.h,
    );
  }
}

class ReviewsItemWidget extends StatefulWidget {
  const ReviewsItemWidget({
    required this.doctorResults,
    required this.index,
    super.key,
  });
  final DoctorResults doctorResults;
  final int index;

  @override
  State<ReviewsItemWidget> createState() => _ReviewsItemWidgetState();
}

class _ReviewsItemWidgetState extends State<ReviewsItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(1000.r),
              child: CustomCachedNetworkImage(
                imgUrl:
                    // widget.doctorResults.profilePicture ??
                    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                width: context.H * 0.05,
                height: context.H * 0.05,
                loadingImgPadding: 50.w,
                errorIconSize: 50.sp,
              ),
            ),
            15.wSpace,
            SizedBox(
              width: context.W * 0.7,
              child: AutoSizeText(
                widget.doctorResults.reviews![widget.index].patientUsername ??
                    '',
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyleApp.bold20().copyWith(
                  color: context.onPrimaryColor,
                ),
              ),
            ),
          ],
        ),
        StarRating(
          rating: (widget.doctorResults.reviews![widget.index].rating ?? 0)
              .toDouble(),
          size: 20.r,
          color: Colors.orangeAccent,
          mainAxisAlignment: MainAxisAlignment.start,
          filledIcon: CupertinoIcons.star_fill,
          // onRatingChanged: (rating) => setState(() => this.rating = rating),
        ).paddingSymmetric(horizontal: 55, vertical: 6),
        SizedBox(
          width: context.W * 0.9,
          child: AutoSizeText(
            widget.doctorResults.reviews![widget.index].comment ?? '',
            maxLines: 4,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.regular18().copyWith(
              color: context.onSecondaryColor,
            ),
          ),
        ).paddingOnly(
          left: context.isStateArabic ? 0 : 55,
          right: context.isStateArabic ? 55 : 0,
        ),
      ],
    ).paddingSymmetric(horizontal: 10, vertical: 12);
  }
}

class NoReviewsWidget extends StatelessWidget {
  const NoReviewsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (context.H * 0.08).hSpace,
        Icon(
          CupertinoIcons.star_slash_fill,
          size: 150.sp,
          color: context.onSecondaryColor.withAlpha(40),
        ),
        10.hSpace,
        AutoSizeText(
          context.isStateArabic ? 'لا توجد تقييمات بعد' : 'No Reviews Yet',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.regular18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
        10.hSpace,
        AutoSizeText(
          context.isStateArabic
              ? 'سيكون لديك الفرصة لتقييم الطبيب بعد الانتهاء من الاستشارة'
              : 'You will have the opportunity to rate the doctor after the consultation is over',
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.regular18().copyWith(
            color: context.onSecondaryColor,
          ),
        ),
      ],
    ).center();
  }
}
