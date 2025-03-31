import 'dart:async';

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/all_doctor/custom_appbar_all_doctor.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/all_doctor/custom_search_bar.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({super.key});

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  List<DoctorModel> filteredDoctorsList = [];
  List<DoctorModel> allDoctorsList = [];
  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int nextPage = 1;
  bool isLoading = false;
  bool hasMoreData = true;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchDoctors();
  }

  void _scrollListener() {
    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (currentPosition >= 0.7 * maxScrollExtent && !isLoading && hasMoreData) {
      if (nextPage > 2) return;
      _fetchDoctors();
    }
  }

  Future<void> _fetchDoctors() async {
    setState(() => isLoading = true);

    await context.read<HomeCubit>().getAllDoctor(page: nextPage).then((_) {
      setState(() {
        isLoading = false;
        nextPage++;
      });
    }).catchError((_) {
      setState(() => isLoading = false);
    });
  }

  void filterDoctors(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      setState(() => isSearching = true);

      context.read<HomeCubit>().getAllDoctor(query: query).then((_) {
        setState(() {
          filteredDoctorsList = context.read<HomeCubit>().filteredDoctorsList;
          isSearching = false;
        });
      }).catchError((_) {
        setState(() => isSearching = false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const CustomAppBarAllDoctor(),
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarDelegate(
            onChanged: filterDoctors,
            controller: searchController,
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      hideKeyboard();
                      searchController.clear();
                      setState(() {
                        filteredDoctorsList = allDoctorsList;
                      });
                    },
                  )
                : null,
          ),
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listenWhen: (previous, current) =>
              current is GetAllDoctorSuccess ||
              current is GetAllDoctorFailure ||
              current is GetAllDoctorPagenationFailure ||
              current is GetAllDoctorPagenationLoading,
          listener: (context, state) {
            if (state is GetAllDoctorSuccess) {
              if (state.doctorModel.isEmpty) {
                hasMoreData = false;
              } else {
                if (isSearching) {
                  filteredDoctorsList = state.doctorModel;
                } else {
                  allDoctorsList.addAll(state.doctorModel);
                  filteredDoctorsList = allDoctorsList;
                }
              }
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
            if (filteredDoctorsList.isEmpty && !isLoading) {
              return SliverToBoxAdapter(
                child: Text(
                  context.translate(LangKeys.noData),
                  textAlign: TextAlign.center,
                  style: TextStyleApp.regular26().copyWith(
                    color: context.onSecondaryColor,
                  ),
                ).center().paddingSymmetric(vertical: 200),
              );
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < filteredDoctorsList.length) {
                    return PopularDoctorItemWidget(
                      doctorModel: filteredDoctorsList[index],
                    );
                  } else if (isLoading) {
                    return Skeletonizer(
                      effect: shimmerEffect(context),
                      child: PopularDoctorItemWidget(
                        doctorModel: doctorsListDome[0],
                      ),
                    );
                  }
                  return null;
                },
                childCount: filteredDoctorsList.length + (isLoading ? 1 : 0),
              ),
            );
          },
        ),
      ],
    );
  }
}

List<DoctorModel> doctorsListDome = List.generate(
  5,
  (index) => DoctorModel(
    id: index,
    username: 'محمد محمsa دمحمد',
    profilePicture:
        'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    consultationPrice: index.toString(),
    email: 'nsjka bjba',
    location: 'msabnj hjdgav hdgah',
    specialization: 'sdnaj sadkldbn ',
    reviews: List.generate(
      5,
      (index) => Reviews(
        id: index,
        rating: index,
      ),
    ),
  ),
);
