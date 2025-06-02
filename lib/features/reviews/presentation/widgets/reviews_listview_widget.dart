import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:curai_app_mobile/features/reviews/presentation/widgets/no_reviews_widget.dart';
import 'package:curai_app_mobile/features/reviews/presentation/widgets/review_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

class ReviewsListViewWidget extends StatefulWidget {
  const ReviewsListViewWidget({
    required this.doctorResults,
    super.key,
  });
  final DoctorInfoModel doctorResults;

  @override
  State<ReviewsListViewWidget> createState() => _ReviewsListViewWidgetState();
}

class _ReviewsListViewWidgetState extends State<ReviewsListViewWidget> {
  late final RefreshController _refreshController;

  List<DoctorReviews> reviews = [];
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    reviews = widget.doctorResults.reviews ?? [];
  }

  Future<void> _onRefresh() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      await context.read<ReviewsCubit>().getReviews(
            doctorId: widget.doctorResults.id!,
          );
      _refreshController.refreshCompleted();
    } on Exception {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewsCubit, ReviewsState>(
      listenWhen: (previous, current) =>
          current is GetReviewsSuccess ||
          current is GetReviewsError ||
          current is GetReviewsLoading,
      buildWhen: (previous, current) =>
          current is GetReviewsSuccess ||
          current is GetReviewsError ||
          current is GetReviewsLoading,
      listener: (context, state) {
        if (state is GetReviewsSuccess) {
          setState(() {
            reviews = state.reviewsList;
          });
        }

        if (state is GetReviewsError) {
          _refreshController.refreshFailed();
          showMessage(
            context,
            message: state.message,
            type: ToastificationType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is GetReviewsLoading) {
          return Skeletonizer(
            effect: shimmerEffect(context),
            child: ListView.builder(
              itemCount: doctorReviewsListDome.length,
              itemBuilder: (context, index) {
                return ReviewItemWidget(
                  doctorId: widget.doctorResults.id!,
                  doctorReviews: doctorReviewsListDome[index],
                ).paddingOnly(
                  top: index == 0 ? context.H * 0.015 : 0,
                  bottom: index == reviews.length - 1 ? context.H * 0.01 : 0,
                );
              },
            ),
          );
        }
        return SmartRefresher(
          onRefresh: _onRefresh,
          controller: _refreshController,
          header: const CustomRefreahHeader(),
          child: reviews.isEmpty
              ? const NoReviewsWidget()
              : ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ReviewItemWidget(
                      doctorId: widget.doctorResults.id!,
                      doctorReviews: reviews[index],
                    ).paddingOnly(
                      top: index == 0 ? context.H * 0.015 : 0,
                      bottom:
                          index == reviews.length - 1 ? context.H * 0.01 : 0,
                    );
                  },
                ),
        );
      },
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
