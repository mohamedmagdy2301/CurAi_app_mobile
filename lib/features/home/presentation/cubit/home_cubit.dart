// home_cubit.dart
import 'dart:async';

import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_all_doctor_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_specializations_usecase.dart';
import 'package:curai_app_mobile/features/home/presentation/cubit/home_state.dart';
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

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(
    this._getAllDoctorUsecase,
    this._getSpecializationsUsecase,
    this._getDoctorByIdUsecase,
  ) : super(HomeInitial());

  final GetAllDoctorUsecase _getAllDoctorUsecase;
  final GetDoctorByIdUsecase _getDoctorByIdUsecase;
  final GetSpecializationsUsecase _getSpecializationsUsecase;

  // Doctors list and filtering
  List<DoctorResults> allDoctorsList = [];
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

    final result = await _getAllDoctorUsecase.call(
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
        final newDoctors = data.results ?? [];
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
    final sortedList = List<DoctorResults>.from(allDoctorsList);

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

  // Get specializations
  Future<void> getSpecializations() async {
    emit(GetSpecializationsLoading());

    final result = await _getSpecializationsUsecase.call(0);
    if (isClosed) return;

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetSpecializationsFailure(message: errMessage));
      },
      (specializationsList) {
        if (isClosed) return;
        emit(
          GetSpecializationsSuccess(
            specializationsList: specializationsList,
          ),
        );
      },
    );
  }

  // Get doctor by id
  Future<void> getDoctorById({required int id}) async {
    emit(GetDoctorByIdLoading());

    final result = await _getDoctorByIdUsecase.call(id);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(GetDoctorByIdFailure(message: errMessage));
      },
      (data) {
        if (isClosed) return;
        emit(GetDoctorByIdSuccess(doctorResults: data));
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
