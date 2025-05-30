// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/models/doctor_model/doctor_info_model.dart';
import 'package:curai_app_mobile/features/home/data/models/favorite_doctor_model/favorite_doctor.dart';
import 'package:curai_app_mobile/features/profile/presentation/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBarDetailsDoctor extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarDetailsDoctor({
    required this.doctor,
    super.key,
  });

  final DoctorInfoModel doctor;

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
          context.pushNamedAndRemoveUntil(Routes.mainScaffoldUser);
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: isFav ? Colors.red : context.onSecondaryColor,
          ),
          onPressed: () {
            final doctorHive = FavoriteDoctor.fromDoctorInfoModel(doctor);
            favoriteCubit.toggleFavorite(doctorHive);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
