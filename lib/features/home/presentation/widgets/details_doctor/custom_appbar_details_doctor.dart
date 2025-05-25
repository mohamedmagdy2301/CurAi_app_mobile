// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/doctor_model.dart';
import 'package:curai_app_mobile/features/home/data/models/doctor_model/favorite_doctor.dart';
import 'package:curai_app_mobile/features/profile/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';

class CustomAppBarDetailsDoctor extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarDetailsDoctor({
    required this.doctor,
    super.key,
  });

  final DoctorResults doctor;

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = context.watch<FavoritesCubit>();
    final isFav = favoriteCubit.isFavorite(doctor.id ?? 0);

    return AppBar(
      title: AutoSizeText(
        context.translate(LangKeys.doctorDetails),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyleApp.bold20().copyWith(
          color: context.onPrimaryColor,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          context.pop();
        },
      ),
      actions: [
        LikeButton(
          isLiked: isFav,
          onTap: (bool isCurrentlyLiked) async {
            final doctorHive = FavoriteDoctor.fromDoctorResults(doctor);
            await favoriteCubit.toggleFavorite(doctorHive);
            return !isCurrentlyLiked;
          },
          animationDuration: const Duration(milliseconds: 2500),
          circleColor: const CircleColor(
            start: Color(0xff00ddff),
            end: Color(0xff0099cc),
          ),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Colors.pink,
            dotSecondaryColor: Colors.white,
          ),
          bubblesSize: 70.r,
          likeBuilder: (bool isLiked) {
            return Icon(
              isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              color: isLiked
                  ? Colors.redAccent
                  : context.onSecondaryColor.withAlpha(100),
              size: 30.sp,
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
