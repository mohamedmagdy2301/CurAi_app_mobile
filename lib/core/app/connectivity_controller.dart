import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityController {
  ConnectivityController._();
  static final ConnectivityController instance = ConnectivityController._();

  ValueNotifier<bool> isInternetConnectedNotifier = ValueNotifier<bool>(true);
  Future<void> init() async {
    final result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen(isInternetConnected);
  }

  bool isInternetConnected(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      isInternetConnectedNotifier.value = false;
      return false;
    } else if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      isInternetConnectedNotifier.value = true;
      return true;
    }
    return false;
  }
}