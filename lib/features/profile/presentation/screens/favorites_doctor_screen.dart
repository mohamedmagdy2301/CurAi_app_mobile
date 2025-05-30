import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_cached_network_image.dart';
import 'package:curai_app_mobile/features/home/data/models/favorite_doctor_model/favorite_doctor.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/specialization_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/favorites_doctor/custom_appbar_favorites.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/favorites_doctor/favorite_doctor_empty_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteDoctorsScreen extends StatelessWidget {
  const FavoriteDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesCubit>().state;

    return Scaffold(
      appBar: const CustomAppBarFavorites(),
      body: favorites.isEmpty
          ? const FavoriteDoctorEmptyWidget()
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final doctor = favorites[index];

                return Dismissible(
                  key: Key(doctor.id.toString()),
                  direction: DismissDirection.endToStart,
                  background: Card(
                    margin: context.padding(vertical: 10),
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    color: Colors.red,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            context.translate(LangKeys.swipeToDelete),
                            style: TextStyleApp.regular18().copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Icon(
                            CupertinoIcons.trash,
                            color: Colors.white,
                            size: 30.sp,
                          ).paddingSymmetric(horizontal: 14),
                        ],
                      ),
                    ),
                  ),
                  onDismissed: (direction) async {
                    final doctorHive =
                        FavoriteDoctor.fromDoctorInfoModel(doctor);
                    await context
                        .read<FavoritesCubit>()
                        .toggleFavorite(doctorHive);
                  },
                  child: Card(
                    margin: context.padding(vertical: 10),
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    color: context.isDark
                        ? Colors.black45
                        : const Color.fromARGB(255, 243, 242, 242),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ListTile(
                      contentPadding: context.padding(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      leading: CustomCachedNetworkImage(
                        imgUrl: doctor.profilePicture ??
                            AppImages.avatarOnlineDoctor,
                        width: context.H * 0.07,
                        height: context.H * 0.07,
                        loadingImgPadding: 40.sp,
                        errorIconSize: 50.sp,
                      ).cornerRadiusWithClipRRect(1000),
                      title: AutoSizeText(
                        '${doctor.firstName?.capitalizeFirstChar ?? ''} '
                        '${doctor.lastName?.capitalizeFirstChar ?? ''}',
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleApp.medium24().copyWith(
                          color: context.onPrimaryColor,
                        ),
                      ),
                      subtitle: AutoSizeText(
                        specializationName(
                          doctor.specialization ?? '',
                          isArabic: context.isStateArabic,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleApp.regular18().copyWith(
                          color: context.onSecondaryColor.withAlpha(90),
                        ),
                      ),
                      trailing: Icon(
                        context.isStateArabic
                            ? CupertinoIcons.chevron_forward
                            : CupertinoIcons.chevron_left,
                        color: context.onSecondaryColor.withAlpha(90),
                        size: 30.sp,
                      ),
                    ),
                  ),
                );
              },
            ).paddingSymmetric(horizontal: 20),
    );
  }
}
