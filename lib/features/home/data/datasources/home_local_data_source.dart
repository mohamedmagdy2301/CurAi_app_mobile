import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  Future<void> cachePopularDoctors(List<DoctorInfoModel> doctors);
  List<DoctorInfoModel> getCachedPopularDoctors();
  Future<void> clearPopularDoctorsCache();

  Future<void> cacheTopDoctors(List<DoctorInfoModel> doctors);
  List<DoctorInfoModel> getCachedTopDoctors();
  Future<void> clearTopDoctorsCache();

  Future<void> cacheSpecializations(List<SpecializationsModel> specializations);
  List<SpecializationsModel> getCachedSpecializations();
  Future<void> clearSpecializationsCache();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const String popularDoctorsBox = 'popularDoctorsBox';
  static const String topDoctorsBoxName = 'topDoctorsBox';
  static const String specializationsBox = 'specializationsBox';

  @override
  Future<void> cachePopularDoctors(List<DoctorInfoModel> doctors) async {
    try {
      final box = await Hive.openBox<DoctorInfoModel>(popularDoctorsBox);
      await box.clear();
      await box.addAll(doctors);
    } on Exception catch (_) {}
  }

  @override
  List<DoctorInfoModel> getCachedPopularDoctors() {
    try {
      if (!Hive.isBoxOpen(popularDoctorsBox)) {
        return [];
      }
      final box = Hive.box<DoctorInfoModel>(popularDoctorsBox);
      return box.values.toList();
    } on Exception catch (_) {
      return [];
    }
  }

  @override
  Future<void> clearPopularDoctorsCache() async {
    try {
      final box = await Hive.openBox<DoctorInfoModel>(popularDoctorsBox);
      await box.clear();
    } on Exception catch (_) {}
  }

  @override
  Future<void> cacheTopDoctors(List<DoctorInfoModel> doctors) async {
    try {
      final box = await Hive.openBox<DoctorInfoModel>(topDoctorsBoxName);
      await box.clear();
      await box.addAll(doctors);
    } on Exception catch (_) {}
  }

  @override
  List<DoctorInfoModel> getCachedTopDoctors() {
    try {
      if (!Hive.isBoxOpen(topDoctorsBoxName)) {
        return [];
      }
      final box = Hive.box<DoctorInfoModel>(topDoctorsBoxName);
      return box.values.toList();
    } on Exception catch (_) {
      return [];
    }
  }

  @override
  Future<void> clearTopDoctorsCache() async {
    try {
      final box = await Hive.openBox<DoctorInfoModel>(topDoctorsBoxName);
      await box.clear();
    } on Exception catch (_) {}
  }

  @override
  Future<void> cacheSpecializations(
    List<SpecializationsModel> specializations,
  ) async {
    try {
      final box = await Hive.openBox<SpecializationsModel>(specializationsBox);
      await box.clear();
      await box.addAll(specializations);
    } on Exception catch (_) {}
  }

  @override
  List<SpecializationsModel> getCachedSpecializations() {
    try {
      if (!Hive.isBoxOpen(specializationsBox)) {
        return [];
      }
      final box = Hive.box<SpecializationsModel>(specializationsBox);
      return box.values.toList();
    } on Exception catch (_) {
      return [];
    }
  }

  @override
  Future<void> clearSpecializationsCache() async {
    try {
      final box = await Hive.openBox<SpecializationsModel>(specializationsBox);
      await box.clear();
    } on Exception catch (_) {}
  }

  Future<void> dispose() async {
    try {
      if (Hive.isBoxOpen(popularDoctorsBox)) {
        await Hive.box<DoctorInfoModel>(popularDoctorsBox).close();
      }
      if (Hive.isBoxOpen(topDoctorsBoxName)) {
        await Hive.box<DoctorInfoModel>(topDoctorsBoxName).close();
      }
      if (Hive.isBoxOpen(specializationsBox)) {
        await Hive.box<SpecializationsModel>(specializationsBox).close();
      }
    } on Exception catch (e) {
      throw Exception('An unexpected error occurred while disposing: $e');
    }
  }
}
