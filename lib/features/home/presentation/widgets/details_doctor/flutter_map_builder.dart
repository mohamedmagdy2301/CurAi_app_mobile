import 'package:curai_app_mobile/core/cubit/get_loction/get_loction_cubit.dart';
import 'package:curai_app_mobile/core/utils/constants.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class FlutterMapBuilder extends StatefulWidget {
  const FlutterMapBuilder({
    required this.points,
    required this.doctorResults,
    super.key,
  });
  final List<LatLng> points;
  final DoctorResults doctorResults;

  @override
  State<FlutterMapBuilder> createState() => _FlutterMapBuilderState();
}

class _FlutterMapBuilderState extends State<FlutterMapBuilder> {
  @override
  Widget build(BuildContext context) {
    final getLoctionCubit = context.read<GetLoctionCubit>();
    // final routeCubit = context.read<RouteCubit>();
    final markers = context.read<GetLoctionCubit>().markers;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FlutterMap(
            mapController: getLoctionCubit.mapController,
            options: MapOptions(
              initialCenter: LatLng(
                widget.doctorResults.latitude!,
                widget.doctorResults.longitude!,
                // getLoctionCubit.currentLocation!.latitude,
                // getLoctionCubit.currentLocation!.longitude,
              ),
              minZoom: 8,
              maxZoom: 20,
              initialZoom: 15.5,
            ),
            children: [
              TileLayer(
                urlTemplate: AppConstants.urlTemplate,
              ),
              MarkerLayer(
                markers: markers,
              ),
              // if (widget.points.isNotEmpty)
              //   PolylineLayer(
              //     polylines: [
              //       Polyline(
              //         points: widget.points,
              //         strokeWidth: 5,
              //         pattern: StrokePattern.dashed(segments: const [5, 5]),
              //         gradientColors: [
              //           Colors.blue.withAlpha(150),
              //           Colors.red.withAlpha(150),
              //         ],
              //         color: Colors.blue,
              //       ),
              //     ],
              //   )
              // else
              // const SizedBox(),
            ],
          ),
        ),
        Column(
          children: [
            IconButton(
              onPressed: () {
                getLoctionCubit.mapController.rotate(
                  0,
                );
                getLoctionCubit.mapController.move(
                  LatLng(
                    widget.doctorResults.latitude!,
                    widget.doctorResults.longitude!,
                  ),
                  16,
                );
              },
              icon: Icon(
                Icons.my_location,
                size: 35.sp,
                color: Colors.grey.shade700,
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     routeCubit.getDestinationRoute(
            //       context,
            //       context.read<GetLoctionCubit>().currentLocation!,
            //       const LatLng(30.564273, 30.99962),
            //       context.read<GetLoctionCubit>().markers,
            //       context.read<GetLoctionCubit>().mapController,
            //       widget.doctorResults.profilePicture,
            //     );
            //   },
            //   icon: Icon(
            //     Icons.location_on,
            //     size: 35.sp,
            //     color: Colors.grey.shade700,
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
