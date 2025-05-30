import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  Future<void> cachePopularDoctors(List<DoctorInfoModel> doctors);
  List<DoctorInfoModel> getCachedPopularDoctors();
  void clearPopularDoctorsCache() {}

  Future<void> cacheTopDoctors(List<DoctorInfoModel> doctors);
  List<DoctorInfoModel> getCachedTopDoctors();
  void clearTopDoctorsCache() {}
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String popularDoctorsBox = 'popularDoctorsBox';
  static const String topDoctorsBoxName = 'topDoctorsBox';

  @override
  Future<void> cachePopularDoctors(List<DoctorInfoModel> doctors) async {
    final box = await Hive.openBox<DoctorInfoModel>(popularDoctorsBox);
    await box.clear();
    await box.addAll(doctors);
  }

  @override
  List<DoctorInfoModel> getCachedPopularDoctors() {
    final box = Hive.box<DoctorInfoModel>(popularDoctorsBox);
    return box.values.toList();
  }

  @override
  Future<void> clearPopularDoctorsCache() async {
    final box = await Hive.openBox<DoctorInfoModel>(popularDoctorsBox);
    await box.clear();
  }

  @override
  Future<void> cacheTopDoctors(List<DoctorInfoModel> doctors) async {
    final box = await Hive.openBox<DoctorInfoModel>(topDoctorsBoxName);
    await box.clear();
    await box.addAll(doctors);
  }

  @override
  List<DoctorInfoModel> getCachedTopDoctors() {
    final box = Hive.box<DoctorInfoModel>(topDoctorsBoxName);
    return box.values.toList();
  }

  @override
  Future<void> clearTopDoctorsCache() async {
    final box = await Hive.openBox<DoctorInfoModel>(topDoctorsBoxName);
    await box.clear();
  }
}
