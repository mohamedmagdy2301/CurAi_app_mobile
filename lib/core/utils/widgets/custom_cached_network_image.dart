import 'package:cached_network_image/cached_network_image.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    required this.imgUrl,
    required this.width,
    required this.height,
    required this.errorIconSize,
    super.key,
    this.loadingImgPadding = 0,
    this.fit = BoxFit.cover,
  });

  final String imgUrl;
  final double width;
  final double height;
  final double errorIconSize;
  final double loadingImgPadding;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInCurve: Curves.linear,
      fadeInDuration: const Duration(seconds: 1),
      imageUrl: imgUrl,
      height: height,
      width: width,
      fit: fit,
      placeholder: (context, url) => Center(
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Opacity(
            opacity: 0.2,
            child: Padding(
              padding: EdgeInsets.all(loadingImgPadding.w),
              child: Image.asset(
                AppImages.loading,
                width: width,
              ),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(),
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
          size: errorIconSize,
        ),
      ),
    );
  }
}

class CustomCachedNetworkImage2 extends StatelessWidget {
  const CustomCachedNetworkImage2({
    required this.imgUrl,
    required this.width,
    required this.height,
    required this.errorIconSize,
    super.key,
    this.loadingImgPadding = 20,
    this.fit = BoxFit.cover,
  });

  final String imgUrl;
  final double width;
  final double height;
  final double errorIconSize;
  final double loadingImgPadding;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: const Duration(seconds: 1),
      imageUrl: imgUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: -5,
              blurRadius: 10,
            ),
          ],
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Opacity(
              opacity: 0.2,
              child: Padding(
                padding: EdgeInsets.all(loadingImgPadding.w),
                child: Image.asset(
                  AppImages.loading,
                  width: width,
                ),
              ),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: -5,
                blurRadius: 10,
              ),
            ],
          ),
          child: Icon(
            Icons.error_outline,
            color: Colors.red,
            size: errorIconSize,
          ),
        ),
      ),
    );
  }
}
