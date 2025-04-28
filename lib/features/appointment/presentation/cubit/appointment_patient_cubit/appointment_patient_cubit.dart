import 'package:curai_app_mobile/features/appointment/data/models/add_appointment_patient/add_appointment_patient_request.dart';
import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:curai_app_mobile/features/appointment/data/models/my_appointment/my_appointment_patient_model.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/add_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_appointment_available_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/get_my_appointment_patient_usecase.dart';
import 'package:curai_app_mobile/features/appointment/domain/usecases/payment_appointment_usecase.dart';
import 'package:curai_app_mobile/features/appointment/presentation/cubit/appointment_patient_cubit/appointment_patient_state.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/domain/usecases/get_doctor_by_id_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentPatientCubit extends Cubit<AppointmentPatientState> {
  AppointmentPatientCubit(
    this._getAppointmentAvailableUsecase,
    this._addAppointmentPatientUsecase,
    this._paymentAppointmentUsecase,
    this._getMyAppointmentPatientUsecase,
    this._getDoctorByIdUsecase,
  ) : super(AppointmentPatientInitial());

  final GetAppointmentAvailableUsecase _getAppointmentAvailableUsecase;
  final AddAppointmentPatientUsecase _addAppointmentPatientUsecase;
  final PaymentAppointmentUsecase _paymentAppointmentUsecase;
  final GetMyAppointmentPatientUsecase _getMyAppointmentPatientUsecase;
  final GetDoctorByIdUsecase _getDoctorByIdUsecase;

  List<MergedDateAvailability> dates = [];
  List<ResultsMyAppointmentPatient> pendingAppointments = [];
  List<ResultsMyAppointmentPatient> paidAppointments = [];
  Map<int, DoctorResults> doctorsData = {};
  int _currentPage = 1;
  bool isLast = false;
  Future<void> getAppointmentAvailable({required int doctorId}) async {
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
          dates = mergeAndSortByDate(resulte);
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

  Future<void> addAppointmentPatient({
    required AddAppointmentPatientRequest params,
  }) async {
    emit(AddAppointmentPatientLoading());
    final result = await _addAppointmentPatientUsecase.call(params);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(AddAppointmentPatientFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;
        emit(AddAppointmentPatientSuccess(addAppointmentPatientModel: resulte));
      },
    );
  }

  Future<void> simulatePaymentAppointment({required int appointmentId}) async {
    emit(PaymentAppointmentLoading());
    final result = await _paymentAppointmentUsecase.call(appointmentId);

    result.fold(
      (errMessage) {
        if (isClosed) return;
        emit(PaymentAppointmentFailure(message: errMessage));
      },
      (resulte) {
        if (isClosed) return;
        emit(PaymentAppointmentSuccess(paymentAppointmentModel: resulte));
      },
    );
  }

  int getNextPage() {
    return _currentPage + 1;
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
      // إضافة العناصر الجديدة فقط (منع التكرار)
      for (final item in tempPending) {
        if (!pendingAppointments.any((element) => element.id == item.id)) {
          pendingAppointments.add(item);
        }
      }
      for (final item in tempPaid) {
        if (!paidAppointments.any((element) => element.id == item.id)) {
          paidAppointments.add(item);
        }
      }
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

    for (final result in results) {
      result.fold(
        (error) {},
        (doctor) {
          if (!isClosed) {
            doctorsData[doctor.id!] = doctor;
          }
        },
      );
    }
  }
}
