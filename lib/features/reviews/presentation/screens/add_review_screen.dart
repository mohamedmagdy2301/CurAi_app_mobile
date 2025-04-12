import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/reviews/data/models/add_review/add_review_request.dart';
import 'package:curai_app_mobile/features/reviews/presentation/cubit/reviews_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({required this.doctorId, super.key});
  final int doctorId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReviewsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Review'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(' Add Review doctor Id $doctorId'),
            ),
            BlocConsumer<ReviewsCubit, ReviewsState>(
              listenWhen: (previous, current) =>
                  current is ReviewsLoading ||
                  current is ReviewsSuccess ||
                  current is ReviewsError,
              listener: (context, state) {
                if (state is ReviewsError) {
                  Navigator.pop(context);
                  showMessage(
                    context,
                    message: state.message,
                    type: SnackBarType.error,
                  );
                } else if (state is ReviewsSuccess) {
                  Navigator.pop(context);
                  showMessage(
                    context,
                    message: state.message,
                    type: SnackBarType.success,
                  );
                  Navigator.pop(context);
                } else if (state is ReviewsLoading) {
                  AdaptiveDialogs.shoLoadingAlertDialog(
                    context: context,
                    title: context.translate(LangKeys.register),
                  );
                }
              },
              builder: (context, state) {
                return CustomButton(
                  title: LangKeys.addReview,
                  onPressed: () {
                    context.read<ReviewsCubit>().addReviews(
                          AddReviewRequest(
                            doctor: doctorId,
                            rating: 5,
                            comment: 'test comment',
                          ),
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
