import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/appointment_patient_available/appointment_patient_available_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/my_appointment_patient/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment_patient/data/models/schedule_appointment_patient/schedule_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/delete_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/discount_payment_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/get_my_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/payment_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/reschedule_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/domain/usecases/schedule_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment_patient/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPatientCubit extends Cubit<AppointmentPatientState> {
  AppointmentPatientCubit(
    this._getAppointmentAvailableUsecase,
    this._scheduleAppointmentPatientUsecase,
    this._paymentAppointmentUsecase,
    this._getMyAppointmentPatientUsecase,
    this._getDoctorByIdUsecase,
    this._deleteAppointmentPatientUsecase,
    this._rescheduleAppointmentPatientUsecase,
    this._discountPaymentUsecase,
  ) : super(AppointmentPatientInitial());

  final GetAppointmentPatientAvailableUsecase _getAppointmentAvailableUsecase;
  final ScheduleAppointmentPatientUsecase _scheduleAppointmentPatientUsecase;
  final RescheduleAppointmentPatientUsecase
      _rescheduleAppointmentPatientUsecase;
  final PaymentAppointmentPatientUsecase _paymentAppointmentUsecase;
  final GetMyAppointmentPatientUsecase _getMyAppointmentPatientUsecase;
  final GetDoctorByIdUsecase _getDoctorByIdUsecase;
  final DeleteAppointmentPatientUsecase _deleteAppointmentPatientUsecase;
  final DiscountPaymentUsecase _discountPaymentUsecase;

  List<MergedDateAvailabilityForPatient> dates = [];
  List<ResultsMyAppointmentPatient> pendingAppointments = [];
  List<ResultsMyAppointmentPatient> paidAppointments = [];
  Map<int, DoctorInfoModel> doctorsData = {};
  AppointmentPatientAvailableModel? appointmentAvailableModel;

  int _currentPage = 1;
  bool isLast = false;
  Future<void> getAppointmentPatientAvailable({required int doctorId}) async {
    if (isClosed) return;
    emit(AppointmentPatientAvailableLoading());

    final result = await _getAppointmentAvailableUsecase.call(doctorId);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(AppointmentPatientAvailableFailure(message: errMessage));
      },
      (resulte) {
        if (resulte.doctorAvailability!.isEmpty) {
          if (isClosed) return;
          emit(AppointmentPatientAvailableEmpty());
        } else {
          dates = mergeAndSortByDate(resulte).toList();
          appointmentAvailableModel = resulte;
          if (isClosed) return;
          emit(
            AppointmentPatientAvailableSuccess(
              appointmentAvailableModel: resulte,
            ),
          );
        }
      },
    );
  }

  Future<void> scheduleAppointmentPatient({
    required ScheduleAppointmentPatientRequest params,
  }) async {
    if (isClosed) return;
    emit(ScheduleAppointmentPatientLoading());
    final result = await _scheduleAppointmentPatientUsecase.call(params);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(ScheduleAppointmentPatientFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;
        emit(
          ScheduleAppointmentPatientSuccess(
            scheduleAppointmentPatientModel: resulte,
          ),
        );
      },
    );
  }

  Future<void> rescheduleAppointmentPatient({
    required int appointmentId,
    required ScheduleAppointmentPatientRequest params,
  }) async {
    if (isClosed) return;
    emit(RescheduleAppointmentPatientLoading());
    final result =
        await _rescheduleAppointmentPatientUsecase.call(appointmentId, params);

    result.fold(
      (errMessage) {
        if (isClosed) return;

        emit(RescheduleAppointmentPatientFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;

        emit(RescheduleAppointmentPatientSuccess());
      },
    );
  }

  Future<void> simulatePaymentAppointment({required int appointmentId}) async {
    if (isClosed) return;
    emit(PaymentAppointmentLoading());
    final result = await _paymentAppointmentUsecase.call(appointmentId);

    result.fold(
      (errMessage) {
        if (isClosed) return;

        emit(PaymentAppointmentFailure(message: errMessage));
      },
      (resulte) {
        di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyBonusPoints);
        di.sl<CacheDataManager>().setData(
              key: SharedPrefKey.keyBonusPoints,
              value: resulte.newBonus,
            );
        if (isClosed) return;
        emit(PaymentAppointmentSuccess(paymentAppointmentModel: resulte));
      },
    );
  }

  Future<void> discountPaymentAppointment({required int point}) async {
    if (isClosed) return;
    emit(DiscountPaymentLoading());
    final result = await _discountPaymentUsecase.call(point);

    result.fold(
      (errMessage) {
        if (isClosed) return;

        emit(DiscountPaymentFailure(message: errMessage));
      },
      (resulte) {
        di.sl<CacheDataManager>().removeData(key: SharedPrefKey.keyBonusPoints);
        di.sl<CacheDataManager>().setData(
              key: SharedPrefKey.keyBonusPoints,
              value: resulte['remaining_bonus'],
            );
        if (isClosed) return;
        emit(DiscountPaymentSuccess());
      },
    );
  }

  Future<void> deleteAppointmentPatient({required int appointmentId}) async {
    if (isClosed) return;
    emit(DeleteAppointmentPatientLoading());
    final result = await _deleteAppointmentPatientUsecase.call(appointmentId);

    result.fold(
      (errMessage) {
        if (isClosed) return;

        emit(DeleteAppointmentPatientFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;

        emit(DeleteAppointmentPatientSuccess());
      },
    );
  }

  int getNextPage() {
    return _currentPage + 1;
  }

  Future<void> refreshMyAppointmentPatient() async {
    _currentPage = 1;
    isLast = false;
    await getMyAppointmentPatient();
  }

  Future<void> getMyAppointmentPatient({int? page}) async {
    try {
      if (page != null) {
        _currentPage = page;
        isLast = false;
      }

      final isInitialLoad = _currentPage == 1;

      if (isInitialLoad) {
        if (isClosed) return;

        emit(GetMyAppointmentPatientLoading());
      } else {
        if (isClosed) return;

        emit(GetMyAppointmentPatientPaginationLoading());
      }

      final result = await _getMyAppointmentPatientUsecase.call(_currentPage);

      result.fold(
        (errMessage) =>
            emitErrorState(errMessage, isInitialLoad: isInitialLoad),
        (result) async =>
            handleSuccessResponse(result, isInitialLoad: isInitialLoad),
      );
    } on Exception {
      if (isClosed) return;
      if (isClosed) return;
      emit(GetMyAppointmentPatientFailure(message: 'حدث خطأ غير متوقع'));
    }
  }

  Future<void> handleSuccessResponse(
    MyAppointmentPatientModel result, {
    required bool isInitialLoad,
  }) async {
    isLast = result.next == null;

    final tempPending = result.results
            ?.where((appointment) => appointment.paymentStatus == 'pending')
            .toList() ??
        [];

    final tempPaid = result.results
            ?.where((appointment) => appointment.paymentStatus == 'paid')
            .toList() ??
        [];

    if (isInitialLoad) {
      paidAppointments = tempPaid;
      pendingAppointments = tempPending;
    } else {
      pendingAppointments = [
        ...pendingAppointments,
        ...tempPending
            .where((item) => !pendingAppointments.any((e) => e.id == item.id)),
      ];

      paidAppointments = [
        ...paidAppointments,
        ...tempPaid
            .where((item) => !paidAppointments.any((e) => e.id == item.id)),
      ];
    }

    await Future.wait([
      _fetchDoctorsForAppointments(tempPending),
      _fetchDoctorsForAppointments(tempPaid),
    ]);

    if (!isLast) _currentPage++;
    if (isClosed) return;

    emit(GetMyAppointmentPatientSuccess(myAppointmentPatientModel: result));
  }

  void emitErrorState(String errMessage, {required bool isInitialLoad}) {
    if (isClosed) return;

    emit(
      isInitialLoad
          ? GetMyAppointmentPatientFailure(message: errMessage)
          : GetMyAppointmentPatientPaginationFailure(message: errMessage),
    );
  }

  Future<void> _fetchDoctorsForAppointments(
    List<ResultsMyAppointmentPatient> appointments,
  ) async {
    if (isClosed) return;
    final doctorIds = appointments
        .map((appointment) => appointment.doctorId)
        .whereType<int>()
        .toSet()
        .where((id) => !doctorsData.containsKey(id))
        .toList();

    if (doctorIds.isEmpty) return;

    final results = await Future.wait(
      doctorIds.map(_getDoctorByIdUsecase.call),
    );
    if (isClosed) return;
    for (final result in results) {
      result.fold(
        (error) {},
        (doctor) {
          if (isClosed) return;
          doctorsData[doctor.id!] = doctor;
        },
      );
    }
  }
}
