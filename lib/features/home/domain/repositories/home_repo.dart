// ignore_for_file: one_member_abstracts, document_ignores

import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<String, List<DoctorInfoModel>>> getPopularDoctor();
  Future<Either<String, List<DoctorInfoModel>>> getTopDoctor();
  Future<Either<String, DoctorInfoModel>> getDoctorById({int? id});
  Future<Either<String, List<SpecializationsModel>>> getSpecializations();
}
