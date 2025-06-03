import 'package:curai_app_mobile/core/cubit/get_loction/get_loction_cubit.dart';
import 'package:curai_app_mobile/core/utils/constants.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
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
  final DoctorInfoModel doctorResults;

  @override
  State<FlutterMapBuilder> createState() => _FlutterMapBuilderState();
}

class _FlutterMapBuilderState extends State<FlutterMapBuilder> {
  @override
  Widget build(BuildContext context) {
    final getLoctionCubit = context.read<GetLoctionCubit>();
    final markers = context.read<GetLoctionCubit>().markers;
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
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
          ],
        ),
      ],
    );
  }
}
