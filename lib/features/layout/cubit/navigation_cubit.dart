import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  void updateIndex(int newIndex) {
    if (isClosed) return;

    emit(newIndex);
  }
}
