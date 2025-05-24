// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<String, AllDoctorModel>> getAllDoctor({
    int page,
    String? query,
    String? speciality,
  });
  Future<Either<String, List<DoctorResults>>> getTopDoctor();
  Future<Either<String, DoctorResults>> getDoctorById({
    int? id,
  });
  Future<Either<String, List<SpecializationsModel>>> getSpecializations();
}
