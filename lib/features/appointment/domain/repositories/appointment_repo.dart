// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/appointment/data/models/appointment_available/appointment_available_model.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepo {
  Future<Either<String, AppointmentAvailableModel>> getAppointmentAvailable({
    required int doctorId,
  });
}
