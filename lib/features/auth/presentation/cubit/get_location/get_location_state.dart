import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class GetLocationState {}

class GetLocationInitial extends GetLocationState {}

class GetLocationLoading extends GetLocationState {}

class GetLocationSuccess extends GetLocationState {
  GetLocationSuccess(this.location, this.locationInfo, this.markers);
  final LatLng location;
  final String locationInfo;
  final List<Marker> markers;
}

class GetLocationError extends GetLocationState {
  GetLocationError(this.error);
  final String error;
}
