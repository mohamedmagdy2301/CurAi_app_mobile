// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctors_model.dart';
import 'package:dartz/dartz.dart';

abstract class SearchRepo {
  Future<Either<String, DoctorsModel>> getDoctors({
    int page,
    String? query,
    String? speciality,
  });
}
