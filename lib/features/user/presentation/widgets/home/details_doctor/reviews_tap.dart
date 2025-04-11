import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart'
    as int_ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/to_arabic_data.dart';
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
    );
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
        ).paddingOnly(
          top: index == 0 ? context.H * 0.015 : 0,
          bottom: index == widget.doctorResults.reviews!.length - 1
              ? context.H * 0.07
              : 0,
        );
      },
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
  late Reviews review;
  @override
  void initState() {
    review = widget.doctorResults.reviews![widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              ClipRRect(
                borderRadius: BorderRadius.circular(1000.r),
                child: CustomCachedNetworkImage(
                  imgUrl:
                      // widget.doctorResults.profilePicture ??
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
                  width: context.H * 0.045,
                  height: context.H * 0.045,
                  loadingImgPadding: 10.w,
                  errorIconSize: 20.sp,
                ),
              ),
              15.wSpace,
              SizedBox(
                width: context.W * 0.45,
                child: AutoSizeText(
                  review.patientUsername ?? '',
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
                  date: review.createdAt!,
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
            rating: (review.rating ?? 0).toDouble(),
            size: 20.r,
            color: Colors.orangeAccent,
            mainAxisAlignment: MainAxisAlignment.start,
            filledIcon: CupertinoIcons.star_fill,
            // onRatingChanged: (rating) => setState(() => this.rating = rating),
          ).paddingSymmetric(horizontal: 50, vertical: 10),
          SizedBox(
            width: context.W * 0.9,
            child: AutoSizeText(
              review.comment ?? '',
              maxLines: 5,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyleApp.regular18().copyWith(
                color: context.onSecondaryColor,
              ),
            ),
          ).paddingOnly(
            left: context.isStateArabic ? 0 : 50,
            right: context.isStateArabic ? 50 : 0,
          ),
        ],
      ).paddingSymmetric(horizontal: 15, vertical: 15),
    );
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
          style: TextStyleApp.extraBold34().copyWith(
            color: context.onSecondaryColor.withAlpha(40),
          ),
        ),
        8.hSpace,
        AutoSizeText(
          context.isStateArabic
              ? 'سيكون لديك الفرصة لتقييم الطبيب بعد الانتهاء من الاستشارة'
              : 'You will have the opportunity to rate the doctor after the consultation is over',
          maxLines: 3,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyleApp.regular18().copyWith(
            color: context.onSecondaryColor.withAlpha(60),
          ),
        ).paddingSymmetric(horizontal: context.W * 0.1),
      ],
    ).center();
  }
}
