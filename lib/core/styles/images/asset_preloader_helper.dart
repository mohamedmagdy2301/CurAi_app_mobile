import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:flutter/widgets.dart';

class AssetPreloader {
  /// Takes a list of image paths and precaches them.
  static Future<void> preloadImages({
    required BuildContext context,
    required List<String> assetPaths,
  }) async {
    for (final path in assetPaths) {
      final imageProvider = AssetImage(path);
      await precacheImage(imageProvider, context);
    }
  }

  /// Preload a single image
  static Future<void> preloadSingleImage({
    required BuildContext context,
    required String assetPath,
  }) async {
    final imageProvider = AssetImage(assetPath);
    await precacheImage(imageProvider, context);
  }
}

class AssetImagePreloader {
  static Future<void> preloadAssetsOnboarding(
    BuildContext context,
  ) async {
    final assetPaths = <String>[
      AppImages.onboardingDoctor1,
      AppImages.onboardingDoctor2,
      AppImages.onboardingDoctor3,
      AppImages.onboardingDoctor4,
    ];

    for (final path in assetPaths) {
      await precacheImage(AssetImage(path), context);
    }
  }

  static void removeOnboardingImagesFromCache() {
    final images = [
      AppImages.onboardingDoctor1,
      AppImages.onboardingDoctor2,
      AppImages.onboardingDoctor3,
      AppImages.onboardingDoctor4,
    ];

    for (final path in images) {
      PaintingBinding.instance.imageCache.evict(AssetImage(path));
    }
  }
}
