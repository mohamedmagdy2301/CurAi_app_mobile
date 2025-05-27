// ignore_for_file: use_build_context_synchronously, avoid_dynamic_calls, document_ignores, lines_longer_than_80_chars

import 'dart:convert';

import 'package:curai_app_mobile/core/app/env_variables.dart';
import 'package:curai_app_mobile/core/cubit/get_loction/get_loction_cubit.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

part 'route_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteCubit() : super(RouteInitial());

  List<LatLng> routePoints = [];

  List<dynamic> coords = [];

  LatLng? pointDestination;
  double zoomLevel = 15;

  Future<void> getDestinationRoute(
    BuildContext context,
    Position currentLocation,
    LatLng destination,
    List<Marker> markers,
    MapController mapController,
    String? image,
  ) async {
    routePoints = [];
    pointDestination = destination;
    if (markers.length > 1) markers.removeRange(1, markers.length);

    markers.add(
      Marker(
        point: destination,
        alignment: Alignment.center,
        child: Icon(
          CupertinoIcons.pin_fill,
          color: Colors.red,
          size: 30.sp,
        ),
      ),
    );

    if (isClosed) return;
    emit(DestinationRouteLoaded());
  }

  Future<void> getDiractionesRouteFromApi(
    BuildContext context,
    Position currentLocation,
    LatLng destination,
    List<Marker> markers,
    MapController mapController,
    String? image,
  ) async {
    final response = await http.get(
      Uri.parse(
        '${AppConstants.orsApiUrl}?api_key=${sl<AppEnvironment>().orsApiKey}'
        '&start=${currentLocation.longitude},${currentLocation.latitude}'
        '&end=${destination.longitude},${destination.latitude}',
      ),
    );
    await getDestinationRoute(
      context,
      currentLocation,
      destination,
      markers,
      mapController,
      image,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['features'][0];
      coords = data['geometry']['coordinates'] as List<dynamic>;

      routePoints = coords
          .map((coord) => LatLng(coord[1] as double, coord[0] as double))
          .toList();

      if (isClosed) return;
      emit(DirectionRouteLoaded(routePoints));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to fetch route data'),
        ),
      );
      if (isClosed) return;
      emit(RouteError());
    }
  }

  void clearRoute(
    BuildContext context,
    GetLoctionCubit getLoctionCubit,
    List<Marker> markers,
  ) {
    routePoints.clear();
    if (markers.length > 1) markers.removeRange(1, markers.length);
    Navigator.pop(context);
    getLoctionCubit.mapController.move(
      LatLng(
        getLoctionCubit.currentLocation!.latitude,
        getLoctionCubit.currentLocation!.longitude,
      ),
      15,
    );
    if (isClosed) return;
    emit(ClearRouteSuccess());
  }
}
