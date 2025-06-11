import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/data/models/favorite_doctor_model/favorite_doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class FavoritesCubit extends Cubit<List<DoctorInfoModel>> {
  FavoritesCubit({required this.userId}) : super([]);

  final int userId;
  late Box<FavoriteDoctor> _box;
  bool _isInitialized = false;

  String get _boxName => 'favoriteDoctors_$userId';

  Future<void> init() async {
    _box = await Hive.openBox<FavoriteDoctor>(_boxName);
    _isInitialized = true;
    loadFavorites();
  }

  void loadFavorites() {
    if (!_isInitialized || !_box.isOpen) return;
    final favorites = _box.values.map((e) => e.toDoctorInfoModel()).toList();
    emit(favorites);
  }

  Future<void> toggleFavorite(FavoriteDoctor doctor) async {
    if (_box.containsKey(doctor.id)) {
      await _box.delete(doctor.id);
    } else {
      await _box.put(doctor.id, doctor);
    }
    loadFavorites();
  }

  bool isFavorite(int doctorId) {
    return state.any((element) => element.id == doctorId);
  }
}
