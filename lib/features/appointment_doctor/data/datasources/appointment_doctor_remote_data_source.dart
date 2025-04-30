import 'package:curai_app_mobile/core/api/dio_consumer.dart';
import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/api/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentDoctorRemoteDataSource {
  Future<Either<Failure, List<Map<String, dynamic>>>>
      getWorkingTimeAvailableDoctor();
}

class AppointmentDoctorRemoteDataSourceImpl
    implements AppointmentDoctorRemoteDataSource {
  AppointmentDoctorRemoteDataSourceImpl({required this.dioConsumer});
  final DioConsumer dioConsumer;

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
      getWorkingTimeAvailableDoctor() async {
    final response = await dioConsumer.get(EndPoints.appointmentDoctor);

    return response.fold(
      left,
      (r) => right((r as List).cast<Map<String, dynamic>>()),
    );
  }
}
