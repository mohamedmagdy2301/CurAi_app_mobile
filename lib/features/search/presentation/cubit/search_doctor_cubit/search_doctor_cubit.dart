// home_cubit.dart
import 'dart:async';

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/search/domain/usecases/get_doctors_usecase.dart';
import 'package:curai_app_mobile/features/search/presentation/cubit/search_doctor_cubit/search_doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SortType {
  none,
  firstName,
  speciality,
  maxPrice,
  lowPrice,
  maxRating,
  lowRating,
}

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  SearchDoctorCubit(
    this._getDoctorsUsecase,
  ) : super(SearchDoctorInitial());

  final GetDoctorsUsecase _getDoctorsUsecase;

  // Doctors list and filtering
  List<DoctorInfoModel> allDoctorsList = [];
  String currentQuery = '';
  String? currentSpeciality;
  int lastPage = 1;
  int nextPage = 2;
  bool isLoading = false;
  bool hasReachedMax = false;
  SortType currentSortType = SortType.none;
  Timer? _debounce;

  // Get all doctors with optional filtering and pagination
  Future<void> getAllDoctor({
    int page = 1,
    String? query,
    String? speciality,
  }) async {
    if (page == 1) {
      // Reset pagination data on fresh search
      nextPage = 2;
      hasReachedMax = false;
      allDoctorsList = [];

      if (query != null) {
        currentQuery = query;
      }

      if (speciality != null) {
        currentSpeciality = speciality;
      }

      if (isClosed) return;
      emit(GetAllDoctorLoading());
    } else {
      if (isClosed) return;
      isLoading = true;
      emit(GetAllDoctorPagenationLoading());
    }

    final result = await _getDoctorsUsecase.call(
      page,
      query ?? currentQuery,
      speciality ?? currentSpeciality,
    );

    if (isClosed) return;

    result.fold(
      (errMessage) {
        isLoading = false;
        if (page == 1) {
          if (isClosed) return;
          emit(GetAllDoctorFailure(message: errMessage));
        } else {
          if (isClosed) return;
          emit(GetAllDoctorPagenationFailure(errMessage: errMessage));
        }
      },
      (data) {
        isLoading = false;
        lastPage = (data.count! / 10).ceil();

        // Add new doctors to the list (avoiding duplicates)
        final newDoctors = _filterValidDoctors(data.results ?? []);
        if (page == 1) {
          allDoctorsList = newDoctors;
        } else {
          allDoctorsList.addAll(
            newDoctors.where(
              (newDoctor) => !allDoctorsList.any(
                (existing) => existing.id == newDoctor.id,
              ),
            ),
          );
        }

        // Check if we've reached the last page
        if (page >= lastPage) {
          hasReachedMax = true;
        } else {
          nextPage = page + 1;
        }

        // Apply current sort
        sortDoctorsList(currentSortType);

        if (isClosed) return;
        emit(GetAllDoctorSuccess(doctorResults: allDoctorsList));
      },
    );
  }

  List<DoctorInfoModel> _filterValidDoctors(List<DoctorInfoModel> doctors) {
    return doctors
        .where(
          (doctor) =>
              doctor.id != null &&
              (doctor.firstName != null || doctor.lastName != null) &&
              doctor.consultationPrice != null &&
              doctor.specialization != null,
        )
        .toList();
  }

  // Handle search with debounce
  void searchDoctors(String query) {
    if (query == currentQuery) return;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      getAllDoctor(query: query);
    });
  }

  // Handle sorting
  void sortDoctorsList(SortType sortType) {
    // Always store the current sort type
    currentSortType = sortType;

    if (allDoctorsList.isEmpty) return;

    // Create a copy of the list to avoid direct mutation
    final sortedList = List<DoctorInfoModel>.from(allDoctorsList);

    switch (sortType) {
      case SortType.firstName:
        sortedList.sort((a, b) {
          final aName = a.firstName ?? '';
          final bName = b.firstName ?? '';
          return aName.compareTo(bName);
        });

      case SortType.speciality:
        sortedList.sort((a, b) {
          final aSpec = a.specialization ?? '';
          final bSpec = b.specialization ?? '';
          return aSpec.compareTo(bSpec);
        });

      case SortType.maxPrice:
        sortedList.sort((a, b) {
          final aPrice = double.tryParse(a.consultationPrice ?? '0') ?? 0;
          final bPrice = double.tryParse(b.consultationPrice ?? '0') ?? 0;
          return bPrice.compareTo(aPrice);
        });

      case SortType.lowPrice:
        sortedList.sort((a, b) {
          final aPrice = double.tryParse(a.consultationPrice ?? '0') ?? 0;
          final bPrice = double.tryParse(b.consultationPrice ?? '0') ?? 0;
          return aPrice.compareTo(bPrice);
        });

      case SortType.maxRating:
        sortedList.sort((a, b) {
          final aRating = a.avgRating ?? 0.0;
          final bRating = b.avgRating ?? 0.0;
          return bRating.compareTo(aRating);
        });

      case SortType.lowRating:
        sortedList.sort((a, b) {
          final aRating = a.avgRating ?? 0.0;
          final bRating = b.avgRating ?? 0.0;
          return aRating.compareTo(bRating);
        });

      case SortType.none:
        sortedList.sort((a, b) => (a.id ?? 0).compareTo(b.id ?? 0));
    }

    // Update the list with the sorted copy
    allDoctorsList = sortedList;

    // Always emit a new state to trigger UI update
    emit(GetAllDoctorSuccess(doctorResults: allDoctorsList));
  }

  // Reset search/filters
  void resetSearch() {
    currentQuery = '';
    nextPage = 2;
    hasReachedMax = false;

    // Also reset sorting when search is reset
    currentSortType = SortType.none;

    // Get doctors with only speciality filter
    getAllDoctor(speciality: currentSpeciality);
  }

  // Load more doctors (pagination)
  Future<void> loadMoreDoctors() async {
    if (hasReachedMax || isLoading || nextPage > lastPage) return;

    await getAllDoctor(
      page: nextPage,
      query: currentQuery,
      speciality: currentSpeciality,
    );
  }
}
