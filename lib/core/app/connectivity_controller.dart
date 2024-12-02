import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

class ConnectivityController {
  ValueNotifier<bool> isInternetNotifier = ValueNotifier<bool>(true);
  Future<void> connectivityControllerInit() async {
    final result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen(isInternetConnected);
  }

  bool isInternetConnected(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      isInternetNotifier.value = false;
      return false;
    } else if (result.contains(ConnectivityResult.wifi) ||
        result.contains(ConnectivityResult.mobile)) {
      isInternetNotifier.value = true;
      return true;
    }
    return false;
  }
}
