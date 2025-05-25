part of 'route_cubit.dart';

class RouteState {}

class RouteInitial extends RouteState {}

class DestinationRouteLoaded extends RouteState {}

class DirectionRouteLoaded extends RouteState {
  DirectionRouteLoaded(this.routePoints);
  final List<LatLng> routePoints;
}

class RouteError extends RouteState {}

class ClearRouteSuccess extends RouteState {}
