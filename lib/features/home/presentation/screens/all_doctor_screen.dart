// ignore_for_file: parameter_assignments

import 'dart:async';

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/helper/shimmer_effect.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/custom_appbar_all_doctor.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/all_doctor/custom_search_bar.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({this.specialityName, super.key});
  final String? specialityName;

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  List<DoctorResults> filteredDoctorsList = [];
  Timer? _debounce;
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int nextPage = 1;
  bool isLoading = false;
  bool hasReachedMax = false;

  @override
  void initState() {
    super.initState();
    nextPage = 2;
    context.read<HomeCubit>().getAllDoctor(speciality: widget.specialityName);
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (hasReachedMax ||
        isLoading ||
        nextPage > context.read<HomeCubit>().lastPage) return;

    final currentPosition = _scrollController.position.pixels;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;

    if (currentPosition >= maxScrollExtent * 0.95) {
      setState(() {
        isLoading = true;
      });
      await context
          .read<HomeCubit>()
          .getAllDoctor(page: nextPage, speciality: widget.specialityName)
          .then((_) {
        setState(() {
          if (nextPage >= context.read<HomeCubit>().lastPage) {
            hasReachedMax = true;
          } else {
            nextPage++;
          }
          isLoading = false;
        });
      });
    }
  }

  String lastQuery = '';

  void filterDoctors(String query) {
    if (query == lastQuery) return;
    lastQuery = query;

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredDoctorsList = [];
        hasReachedMax = false;
        nextPage = 2;
      });
      context
          .read<HomeCubit>()
          .getAllDoctor(query: query, speciality: widget.specialityName);
    });
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
            onChanged: filterDoctors,
            controller: searchController,
            suffixIcon: searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      hideKeyboard();
                      searchController.clear();
                      setState(() {
                        filteredDoctorsList = [];
                        hasReachedMax = false;
                        lastQuery = '';
                        nextPage = 2;
                      });
                      context
                          .read<HomeCubit>()
                          .getAllDoctor(speciality: widget.specialityName);
                    },
                  )
                : null,
          ),
        ),
        BlocConsumer<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is GetAllDoctorSuccess ||
              current is GetAllDoctorFailure ||
              current is GetAllDoctorPagenationFailure ||
              current is GetAllDoctorPagenationLoading,
          listenWhen: (previous, current) =>
              current is GetAllDoctorSuccess ||
              current is GetAllDoctorFailure ||
              current is GetAllDoctorPagenationFailure ||
              current is GetAllDoctorPagenationLoading,
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
              showMessage(
                context,
                type: SnackBarType.success,
                message: '${state.doctorResults.length} Doctors found',
              );
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
            } else if (state is GetAllDoctorSuccess ||
                state is GetAllDoctorPagenationLoading) {
              return filteredDoctorsList.isEmpty
                  ? SliverToBoxAdapter(
                      child: Text(
                        'No Doctors found',
                        textAlign: TextAlign.center,
                        style: TextStyleApp.regular26().copyWith(
                          color: context.onSecondaryColor,
                        ),
                      ),
                    )
                  : SliverList.builder(
                      itemCount:
                          filteredDoctorsList.length + (isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < filteredDoctorsList.length) {
                          return PopularDoctorItemWidget(
                            doctorResults: filteredDoctorsList[index],
                          );
                        } else {
                          return PopularDoctorItemWidget(
                            doctorResults: doctorsListDome[0],
                          );
                        }
                      },
                    );
            }
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
          },
        ),
      ],
    );
  }
}

List<DoctorResults> doctorsListDome = List.generate(
  5,
  (index) => DoctorResults(
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
