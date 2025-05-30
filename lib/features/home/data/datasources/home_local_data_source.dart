import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  Future<void> cachePopularDoctors(List<DoctorInfoModel> doctors);
  List<DoctorInfoModel> getCachedPopularDoctors();
  void clearPopularDoctorsCache() {}
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String boxName = 'doctorsBox';

  @override
  Future<void> cachePopularDoctors(List<DoctorInfoModel> doctors) async {
    final box = await Hive.openBox<DoctorInfoModel>(boxName);
    await box.clear();
    await box.addAll(doctors);
  }

  @override
  List<DoctorInfoModel> getCachedPopularDoctors() {
    final box = Hive.box<DoctorInfoModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> clearPopularDoctorsCache() async {
    final box = await Hive.openBox<DoctorInfoModel>(boxName);
    await box.clear();
  }
}
