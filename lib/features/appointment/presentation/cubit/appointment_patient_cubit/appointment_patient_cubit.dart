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
  int lastPage = 1;

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

  Future<void> getMyAppointmentPatient({int? page}) async {
    if (page == 1) {
      if (isClosed) return;
      emit(GetMyAppointmentPatientLoading());
    } else {
      if (isClosed) return;
      emit(GetMyAppointmentPatientPagenationLoading());
    }
    final result = await _getMyAppointmentPatientUsecase.call(page ?? 1);

    await result.fold(
      (errMessage) {
        if (page == 1) {
          if (isClosed) return;
          emit(GetMyAppointmentPatientFailure(message: errMessage));
        } else {
          if (isClosed) return;
          emit(
            GetMyAppointmentPatientPagenationFailure(message: errMessage),
          );
        }
      },
      (resulte) async {
        lastPage = (resulte.count! / 10).ceil();

        final tempPending = resulte.results
                ?.where(
                  (appointment) => appointment.paymentStatus == 'pending',
                )
                .toList() ??
            [];

        final tempPaid = resulte.results
                ?.where((appointment) => appointment.paymentStatus == 'paid')
                .toList() ??
            [];

        await _fetchDoctorsForAppointments(tempPending);
        await _fetchDoctorsForAppointments(tempPaid);

        if (!isClosed) {
          pendingAppointments = tempPending;
          paidAppointments = tempPaid;

          emit(
            GetMyAppointmentPatientSuccess(
              myAppointmentPatientModel: resulte,
            ),
          );
        }
      },
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
