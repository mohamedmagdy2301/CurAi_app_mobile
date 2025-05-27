import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

part 'get_loction_state.dart';

class GetLoctionCubit extends Cubit<GetLoctionState> {
  GetLoctionCubit() : super(GetLoctionInitial());
  final MapController mapController = MapController();

  Position? currentLocation;
  List<Marker> markers = [];

  Future<void> getCurrentLocation({
    required String? image,
    required LatLng doctorPostion,
  }) async {
    // final userLocation = await determinePosition();
    // currentLocation = userLocation;
    markers.add(
      Marker(
        point: doctorPostion,
        // LatLng(
        //   userLocation.latitude,
        //   userLocation.longitude,
        // ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000.r),
          child: CustomCachedNetworkImage(
            imgUrl: image ?? AppImages.avatarOnlineDoctor,
            width: 20.w,
            height: 20.h,
            loadingImgPadding: 5.w,
            errorIconSize: 20.sp,
          ),
        ),
      ),
    );

    if (isClosed) return;
    emit(GetLoctionSuccess());
  }
}

Future<Position> determinePosition() async {
  final serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  var permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently '
      'denied, we cannot request permissions.',
    );
  }

  return Geolocator.getCurrentPosition();
}
