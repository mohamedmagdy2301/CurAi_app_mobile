import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/constants.dart' as AppConstant;
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/get_location/get_location_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/get_location/get_location_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

class OSMdata {
  OSMdata({
    required this.displayname,
    required this.lat,
    required this.lon,
  });
  final String displayname;
  final double lat;
  final double lon;
}

class MapsCardAddNewAddress extends StatefulWidget {
  const MapsCardAddNewAddress({super.key});

  @override
  State<MapsCardAddNewAddress> createState() => _MapsCardAddNewAddressState();
}

class _MapsCardAddNewAddressState extends State<MapsCardAddNewAddress> {
  final MapController mapController = MapController();
  http.Client client = http.Client();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLocationCubit, GetLocationState>(
      builder: (context, state) {
        final cubit = context.read<GetLocationCubit>();
        return SizedBox(
          height: context.H * 0.25,
          child: Stack(
            children: [
              FlutterMap(
                mapController: cubit.mapController,
                options: MapOptions(
                  keepAlive: true,
                  initialCenter: cubit.selectedLocation,
                  minZoom: 9,
                  maxZoom: 20,
                  onTap: (tapPosition, latLng) {
                    cubit.onMapTap(latLng);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: AppConstant.urlTemplate,
                  ),
                  if (state is GetLocationSuccess)
                    MarkerLayer(markers: state.markers),
                ],
              ),
              Positioned(
                right: 5.w,
                bottom: 5.h,
                child: state is GetLocationLoading
                    ? const CustomLoadingWidget().paddingAll(5)
                    : IconButton(
                        onPressed: () {
                          cubit.mapController.move(cubit.selectedLocation, 13);
                        },
                        icon: Icon(
                          CupertinoIcons.location_circle_fill,
                          color: context.primaryColor,
                          size: 45.sp,
                        ),
                      ),
              ),
            ],
          ),
        ).cornerRadiusWithClipRRect(10);
        // 12.hSpace,
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   child: state is GetLocationSuccess
        //       ? Text(
        //           state.locationInfo,
        //           textAlign: TextAlign.center,
        //           style: TextStyle(
        //             fontSize: 16.sp,
        //             fontWeight: FontWeight.bold,
        //             color: context.onSecondaryColor,
        //           ),
        //         )
        //       : Image.asset(
        //           'assets/images/loading.gif',
        //           height: 45.h,
        //           width: 45.w,
        //         ),
        // ),
      },
    );
  }
}
