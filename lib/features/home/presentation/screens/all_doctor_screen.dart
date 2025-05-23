// ignore_for_file: parameter_assignments, use_build_context_synchronously

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/bottom_sheet_sort_doctors.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_refreah_header.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/all_doctor_empty_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/all_doctor_listview_widget.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/custom_appbar_all_doctor.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/custom_search_bar.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({this.specialityName, super.key});
  final String? specialityName;

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getAllDoctor(speciality: widget.specialityName);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  // Handle scroll for pagination
  void _scrollListener() {
    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (currentPosition >= maxScrollExtent * 0.95) {
      context.read<HomeCubit>().loadMoreDoctors();
    }
  }

  // Reset search handler
  void _resetSearch() {
    hideKeyboard();
    searchController.clear();
    setState(() {});
    context.read<HomeCubit>().resetSearch();
  }

  // Handle refresh
  Future<void> _onRefresh() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 800));

      // Refresh data
      await context.read<HomeCubit>().getAllDoctor(
            speciality: widget.specialityName,
          );
      _refreshController.refreshCompleted();
    } on Exception {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: const CustomRefreahHeader(),
      onRefresh: _onRefresh,
      child: CustomScrollView(
        controller: _scrollController,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        slivers: [
          CustomAppBarAllDoctor(title: widget.specialityName),
          SliverPersistentHeader(
            pinned: true,
            delegate: SearchBarDelegate(
              controller: searchController,
              onChanged: (value) {
                // Update UI to show/hide clear button
                setState(() {
                  context.read<HomeCubit>().searchDoctors(value);
                });
              },
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(CupertinoIcons.xmark),
                      onPressed: _resetSearch,
                    )
                  : null,
              onPressedSort: () => customBottomSheetSortingDoctors(context),
            ),
          ),
          BlocConsumer<HomeCubit, HomeState>(
            buildWhen: (_, current) =>
                current is GetAllDoctorSuccess ||
                current is GetAllDoctorFailure ||
                current is GetAllDoctorLoading ||
                current is GetAllDoctorPagenationLoading,
            listenWhen: (_, current) =>
                current is GetAllDoctorSuccess ||
                current is GetAllDoctorPagenationFailure,
            listener: (context, state) {
              if (state is GetAllDoctorPagenationFailure) {
                showMessage(
                  context,
                  type: ToastificationType.error,
                  message: state.errMessage,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              final doctorsList = cubit.allDoctorsList;

              if (state is GetAllDoctorFailure) {
                return SliverToBoxAdapter(
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyleApp.regular26().copyWith(
                      color: context.onSecondaryColor,
                    ),
                  ).center().paddingSymmetric(vertical: 45),
                );
              } else if (state is GetAllDoctorLoading) {
                return SliverList.builder(
                  itemCount: doctorsListDome.length,
                  itemBuilder: (context, index) {
                    return Skeletonizer(
                      effect: shimmerEffect(context),
                      child: DoctorItemWidget(
                        doctorResults: doctorsListDome[index],
                      ),
                    );
                  },
                );
              } else if (doctorsList.isEmpty &&
                  (state is GetAllDoctorSuccess ||
                      state is GetAllDoctorPagenationLoading)) {
                return const AllDoctorEmptyWidget();
              }
              return AllDoctorListviewWidget(
                doctorsList: doctorsList,
                cubit: cubit,
              );
            },
          ),
        ],
      ),
    );
  }
}
