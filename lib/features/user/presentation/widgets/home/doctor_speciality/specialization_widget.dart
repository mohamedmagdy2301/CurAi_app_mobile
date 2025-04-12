import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/user/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class SpecializationWidget extends StatefulWidget {
  const SpecializationWidget({required this.specializationsList, super.key});
  final List<SpecializationsModel> specializationsList;

  @override
  State<SpecializationWidget> createState() => _SpecializationWidgetState();
}

class _SpecializationWidgetState extends State<SpecializationWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.H * 0.15,
      child: ListView.separated(
        itemCount: widget.specializationsList.length,
        padding: context.padding(horizontal: 10),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 16.wSpace,
        itemBuilder: (context, index) {
          return DoctorSpecialityItemWidget(
            title: specializationName(
              widget.specializationsList[index].name,
              context.isStateArabic,
            ),
            image: widget.specializationsList[index].image,
            specialityNameEn: widget.specializationsList[index].name,
          );
        },
      ),
    );
  }
}

String specializationName(String name, bool isArabic) {
  const specializationsMap = {
    'Allergist': 'أخصائي حساسية',
    'Andrologists': 'أطباء أمراض الذكورة',
    'Anesthesiologist': 'طبيب تخدير',
    'Audiologist': 'أخصائي سمعيات',
    'Cardiologist': 'طبيب قلب',
    'Dentist': 'طبيب أسنان',
    'Gynecologist': 'طبيبة نساء وتوليد',
    'Internists': 'طبيب باطنية',
    'Orthopedist': 'طبيب عظام',
    'Pediatrician': 'طبيب أطفال',
    'Surgeon': 'جراح',
    'neurologist': 'طبيب اعصاب',
  };

  if (isArabic && specializationsMap.containsKey(name)) {
    return specializationsMap[name]!;
  }

  return name[0].toUpperCase() + name.substring(1);
}
