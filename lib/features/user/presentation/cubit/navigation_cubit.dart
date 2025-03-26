import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(3); // Default to the first screen (index 0)

  void updateIndex(int newIndex) {
    emit(newIndex);
  }
}
