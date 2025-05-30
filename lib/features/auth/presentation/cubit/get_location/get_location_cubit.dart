import 'dart:async';
import 'dart:developer';

import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/get_location/get_location_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:toastification/toastification.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());

  final MapController mapController = MapController();
  Position? currentLocation;
  LatLng selectedLocation = const LatLng(0, 0);
  String locationInfo = 'Tap on the map to select a location';
  List<Marker> markers = [];
  StreamSubscription<Position>? _locationStreamSubscription;

  /// Get current location and add marker
  Future<void> getCurrentLocation(BuildContext context) async {
    if (isClosed) return;

    emit(GetLocationLoading());
    try {
      final userLocation = await determinePosition(context);
      currentLocation = userLocation;
      selectedLocation = LatLng(userLocation.latitude, userLocation.longitude);
      markers = [
        Marker(
          point: selectedLocation,
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              if (kDebugMode) {
                log('Current Location Marker: $locationInfo');
              }
            },
            child: Icon(
              CupertinoIcons.pin_fill,
              color: Colors.red,
              size: 30.sp,
            ),
          ),
        ),
      ];
      mapController.move(selectedLocation, 13);
      locationInfo = await _getLocationName(selectedLocation);
      if (isClosed) return;

      emit(GetLocationSuccess(selectedLocation, locationInfo, markers));
    } on Exception catch (e) {
      if (isClosed) return;

      emit(GetLocationError(e.toString()));
    }
  }

  /// Handle map tap - Add marker and fetch address
  Future<void> onMapTap(BuildContext context, LatLng position) async {
    selectedLocation = position;

    markers = [
      Marker(
        point: position,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            showMessage(
              context,
              message: context.isStateArabic
                  ? 'تم اختيار الموقع: $locationInfo'
                  : 'You selected location: $locationInfo',
              type: ToastificationType.success,
            );
          },
          child: Icon(
            CupertinoIcons.pin_fill,
            color: Colors.red,
            size: 30.sp,
          ),
        ),
      ),
    ];
    locationInfo = await _getLocationName(position);
    if (isClosed) return;

    emit(GetLocationSuccess(position, locationInfo, markers));
  }

  /// Fetch location info (Address) from coordinates
  Future<String> _getLocationName(LatLng position) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        return '${placemarks.first.street}, ${placemarks.first.locality}, ${placemarks.first.country}';
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        log('Failed to fetch address: $e');
      }
    }
    return 'Unknown location';
  }

  /// Start listening to location updates
  void startLocationUpdates() {
    _locationStreamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      currentLocation = position;
      selectedLocation = LatLng(position.latitude, position.longitude);
      markers = [
        Marker(
          point: selectedLocation,
          alignment: Alignment.center,
          child: Icon(CupertinoIcons.pin_fill, color: Colors.red, size: 30.sp),
        ),
      ];
      mapController.move(selectedLocation, 13);
      locationInfo = _getLocationName(selectedLocation).toString();
      if (isClosed) return;

      emit(GetLocationSuccess(selectedLocation, locationInfo, markers));
    });
  }

  @override
  Future<void> close() {
    _locationStreamSubscription?.cancel();
    return super.close();
  }
}

/// Determines user location with permissions handling
Future<Position> determinePosition(BuildContext context) async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    if (!context.mounted) {
      return Future.error('Location permissions are permanently denied.');
    }
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Location Permission Required'),
        content: const Text(
          'Location access is permanently denied. Please enable it in app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await Geolocator.openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
    return Future.error('Location permissions are permanently denied.');
  }

  return Geolocator.getCurrentPosition();
}
