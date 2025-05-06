// ignore_for_file: parameter_assignments

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/custom_appbar_all_doctor.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/custom_search_bar.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

enum SortType {
  none,
  firstName,
  speciality,
  maxPrice,
  lowPrice,
  maxRating,
  lowRating,
}

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({this.specialityName, super.key});
  final String? specialityName;

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  final List<DoctorResults> filteredDoctorsList = [];
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Timer? _debounce;
  int nextPage = 2;
  bool isLoading = false;
  bool hasReachedMax = false;
  String lastQuery = '';
  SortType currentSort = SortType.none;

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
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (hasReachedMax ||
        isLoading ||
        nextPage > context.read<HomeCubit>().lastPage) return;

    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (currentPosition >= maxScrollExtent * 0.95) {
      setState(() => isLoading = true);
      await context
          .read<HomeCubit>()
          .getAllDoctor(
            page: nextPage,
            speciality: widget.specialityName,
            query: lastQuery,
          )
          .then((_) {
        setState(() {
          isLoading = false;
          if (nextPage >= context.read<HomeCubit>().lastPage) {
            hasReachedMax = true;
          } else {
            nextPage++;
          }
        });
      });
    }
  }

  void filterDoctors(String query) {
    if (query == lastQuery) return;

    lastQuery = query;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredDoctorsList.clear();
        hasReachedMax = false;
        nextPage = 2;
      });
      context
          .read<HomeCubit>()
          .getAllDoctor(query: query, speciality: widget.specialityName);
    });
  }

  void sortDoctorsList() {
    if (currentSort == SortType.none) return;

    switch (currentSort) {
      case SortType.firstName:
        filteredDoctorsList.sort((a, b) {
          final aName = a.firstName ?? '';
          final bName = b.firstName ?? '';
          return aName.compareTo(bName);
        });

      case SortType.speciality:
        filteredDoctorsList.sort((a, b) {
          final aSpec = a.specialization ?? '';
          final bSpec = b.specialization ?? '';
          return aSpec.compareTo(bSpec);
        });

      case SortType.maxPrice:
        filteredDoctorsList.sort((a, b) {
          final aPrice = a.consultationPrice ?? '';
          final bPrice = b.consultationPrice ?? '';
          return bPrice.compareTo(aPrice);
        });

      case SortType.lowPrice:
        filteredDoctorsList.sort((a, b) {
          final aPrice = a.consultationPrice ?? '';
          final bPrice = b.consultationPrice ?? '';
          return aPrice.compareTo(bPrice);
        });

      case SortType.maxRating:
        filteredDoctorsList.sort((a, b) {
          final aRating = a.avgRating ?? 0.0;
          final bRating = b.avgRating ?? 0.0;
          return bRating.compareTo(aRating);
        });

      case SortType.lowRating:
        filteredDoctorsList.sort((a, b) {
          final aRating = a.avgRating ?? 0.0;
          final bRating = b.avgRating ?? 0.0;
          return aRating.compareTo(bRating);
        });

      case SortType.none:
        filteredDoctorsList.sort((a, b) => a.id!.compareTo(b.id!));
    }
  }

  void _resetSearch() {
    hideKeyboard();
    searchController.clear();
    setState(() {
      filteredDoctorsList.clear();
      hasReachedMax = false;
      lastQuery = '';
      nextPage = 2;
    });
    context.read<HomeCubit>().getAllDoctor(speciality: widget.specialityName);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        CustomAppBarAllDoctor(title: widget.specialityName),
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarDelegate(
            controller: searchController,
            onChanged: filterDoctors,
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(CupertinoIcons.xmark),
                    onPressed: _resetSearch,
                  )
                : null,
            onPressedSort: customShowModalBottomSheet,
          ),
        ),
        BlocConsumer<HomeCubit, HomeState>(
          buildWhen: (_, current) =>
              current is GetAllDoctorSuccess ||
              current is GetAllDoctorFailure ||
              current is GetAllDoctorPagenationLoading,
          listenWhen: (_, current) =>
              current is GetAllDoctorSuccess ||
              current is GetAllDoctorPagenationFailure,
          listener: (context, state) {
            if (state is GetAllDoctorSuccess) {
              setState(() {
                filteredDoctorsList.addAll(
                  state.doctorResults.where(
                    (newDoctor) => !filteredDoctorsList
                        .any((existing) => existing.id == newDoctor.id),
                  ),
                );
              });

              sortDoctorsList();
            }
            if (state is GetAllDoctorPagenationFailure) {
              showMessage(
                context,
                type: SnackBarType.error,
                message: state.errMessage,
              );
            }
          },
          builder: (context, state) {
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
            }

            if (state is GetAllDoctorLoading) {
              return SliverList.builder(
                itemCount: doctorsListDome.length,
                itemBuilder: (context, index) {
                  return Skeletonizer(
                    effect: shimmerEffect(context),
                    child: PopularDoctorItemWidget(
                      doctorResults: doctorsListDome[index],
                    ),
                  );
                },
              );
            }

            if (filteredDoctorsList.isEmpty &&
                (state is GetAllDoctorSuccess ||
                    state is GetAllDoctorPagenationLoading)) {
              return SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    80.hSpace,
                    SvgPicture.asset(
                      SvgImages.searchEmpty,
                      width: 200.w,
                      height: 200.h,
                    ),
                    40.hSpace,
                    AutoSizeText(
                      context.isStateArabic
                          ? 'لا توجد اطباء بعد'
                          : 'No Doctors found',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyleApp.regular26().copyWith(
                        color: context.onSecondaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            return SliverList.builder(
              itemCount: filteredDoctorsList.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < filteredDoctorsList.length) {
                  if (filteredDoctorsList[index].id == null ||
                      (filteredDoctorsList[index].firstName == null &&
                          filteredDoctorsList[index].lastName == null) ||
                      filteredDoctorsList[index].consultationPrice == null ||
                      filteredDoctorsList[index].specialization == null) {
                    return const SizedBox();
                  }
                  return PopularDoctorItemWidget(
                    doctorResults: filteredDoctorsList[index],
                  );
                } else {
                  return Skeletonizer(
                    effect: shimmerEffect(context),
                    child: PopularDoctorItemWidget(
                      doctorResults: doctorsListDome[0],
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  void customShowModalBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      backgroundColor: context.backgroundColor,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.hSpace,
            Row(
              children: [
                5.wSpace,
                Icon(
                  CupertinoIcons.line_horizontal_3_decrease,
                  color: context.primaryColor,
                  size: 30.sp,
                ),
                20.wSpace,
                AutoSizeText(
                  context.isStateArabic
                      ? 'اختيار ترتيب الأطباء'
                      : 'Sort Doctors',
                  style: TextStyleApp.medium24().copyWith(
                    color: context.primaryColor,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            16.hSpace,
            Divider(
              color: context.onSecondaryColor.withAlpha(120),
              thickness: .5,
            ),
            8.hSpace,
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildSortItem(
                  SortType.none,
                  CupertinoIcons.clear,
                  context.isStateArabic ? 'بدون ترتيب' : 'No Sorting',
                ),
                buildSortItem(
                  SortType.firstName,
                  CupertinoIcons.person,
                  context.isStateArabic ? 'الاسم الاول' : 'Name A-Z',
                ),
                buildSortItem(
                  SortType.speciality,
                  Icons.medical_services,
                  context.isStateArabic ? 'التخصص الطبي' : 'Medical Speciality',
                ),
                buildSortItem(
                  SortType.maxPrice,
                  CupertinoIcons.arrow_up,
                  context.isStateArabic ? 'السعر الاقصى' : 'Max Price',
                ),
                buildSortItem(
                  SortType.lowPrice,
                  CupertinoIcons.arrow_down,
                  context.isStateArabic ? 'السعر الادنى' : 'Min Price',
                ),
                buildSortItem(
                  SortType.maxRating,
                  CupertinoIcons.star_fill,
                  context.isStateArabic ? 'التقييم الاقصى' : 'Max Rating',
                ),
                buildSortItem(
                  SortType.lowRating,
                  CupertinoIcons.star,
                  context.isStateArabic ? 'التقييم الادنى' : 'Min Rating',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildSortItem(
    SortType type,
    IconData icon,
    String label,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          currentSort = type;
        });
        sortDoctorsList();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: currentSort == type
              ? context.primaryColor.withAlpha(20)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: currentSort == type
                ? context.primaryColor
                : context.onPrimaryColor,
          ),
          trailing: currentSort == type
              ? Icon(
                  CupertinoIcons.checkmark_alt,
                  color: context.primaryColor,
                )
              : null,
          title: AutoSizeText(
            label.trim(),
            style: TextStyleApp.medium16().copyWith(
              color: currentSort == type
                  ? context.primaryColor
                  : context.onPrimaryColor,
            ),
          ),
          selected: currentSort == type,
        ),
      ),
    );
  }
}
