import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class GetLocationLoading extends GetLocationState {}

class GetLocationSuccess extends GetLocationState {
  final LatLng location;
  final String locationInfo;
  final List<Marker> markers;

  GetLocationSuccess(this.location, this.locationInfo, this.markers);
}

class GetLocationError extends GetLocationState {
  final String error;

  GetLocationError(this.error);
}
