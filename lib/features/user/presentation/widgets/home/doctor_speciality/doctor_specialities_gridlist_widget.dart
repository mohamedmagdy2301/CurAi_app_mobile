import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class DoctorSpecialitiesGridList extends StatelessWidget {
  const DoctorSpecialitiesGridList({
    required this.filteredItems,
    super.key,
  });

  final List<SpecializationsModel> filteredItems;

  @override
  Widget build(BuildContext context) {
    if (filteredItems.isEmpty) {
      return Column(
        children: [
          AutoSizeText(
            context.isStateArabic ? 'لا يوجد تخصصات' : 'No Specialities',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold26().copyWith(
              color: context.onSecondaryColor.withAlpha(60),
            ),
            maxLines: 1,
          ),
          10.hSpace,
          AutoSizeText(
            context.isStateArabic ? ' ابدأ بالبــحث 🔎' : ' Start Searching 🔎',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyleApp.bold28().copyWith(
              color: context.onSecondaryColor.withAlpha(50),
            ),
            maxLines: 2,
          ).paddingSymmetric(horizontal: 40),
        ],
      ).paddingTop(80);
    }
    return GridView.builder(
      itemCount: filteredItems.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return DoctorSpecialityItemWidget(
          title: filteredItems[index].name,
          image: filteredItems[index].image,
        );
      },
    ).paddingSymmetric(horizontal: 10, vertical: 10);
  }
}
