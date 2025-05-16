import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/favorite_doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class FavoritesCubit extends Cubit<List<DoctorResults>> {
  FavoritesCubit() : super([]) {
    loadFavorites();
  }

  final String _boxName = 'favoriteDoctors';

  Future<void> loadFavorites() async {
    final box = await Hive.openBox<FavoriteDoctor>(_boxName);
    final favorites = box.values.map((e) => e.toDoctorResults()).toList();
    emit(favorites);
  }

  Future<void> toggleFavorite(FavoriteDoctor doctor) async {
    final box = await Hive.openBox<FavoriteDoctor>(_boxName);
    if (box.containsKey(doctor.id)) {
      await box.delete(doctor.id);
    } else {
      await box.put(doctor.id, doctor);
    }
    await loadFavorites();
  }

  bool isFavorite(int doctorId) {
    final current = state;
    return current.any((element) => element.id == doctorId);
  }
}
