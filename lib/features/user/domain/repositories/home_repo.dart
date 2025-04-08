// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<String, AllDoctorModel>> getAllDoctor({
    int page,
    String? query,
  });
}
