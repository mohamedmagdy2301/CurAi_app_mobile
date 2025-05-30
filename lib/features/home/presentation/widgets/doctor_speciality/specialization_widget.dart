import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/doctor_speciality_item_widget.dart';
import 'package:flutter/material.dart';

class SpecializationWidget extends StatefulWidget {
  const SpecializationWidget({
    required this.specializationsList,
    super.key,
    this.isLoading,
  });
  final List<SpecializationsModel> specializationsList;
  final bool? isLoading;

  @override
  State<SpecializationWidget> createState() => _SpecializationWidgetState();
}

class _SpecializationWidgetState extends State<SpecializationWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.H * 0.14,
      child: ListView.separated(
        itemCount: widget.specializationsList.length,
        padding: context.padding(horizontal: 10),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => 16.wSpace,
        itemBuilder: (context, index) {
          return DoctorSpecialityItemWidget(
            isLoading: widget.isLoading ?? false,
            title: specializationName(
              widget.specializationsList[index].name,
              isArabic: context.isStateArabic,
            ),
            image: widget.specializationsList[index].image,
            specialityName: widget.specializationsList[index].name,
          );
        },
      ),
    );
  }
}

String specializationName(String? name, {required bool isArabic}) {
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
    'Neurologist': 'طبيب اعصاب',
  };

  // لو الاسم null أو فاضي
  if (name == null || name.trim().isEmpty) {
    return isArabic ? 'غير محدد' : 'Unknown';
  }

  // ننضف الاسم ونتأكد أول حرف كابيتال عشان يتطابق مع الماب
  final cleanName = name.trim();
  final formattedName = cleanName[0].toUpperCase() + cleanName.substring(1);

  // لو عربي وفي ترجمة
  if (isArabic && specializationsMap.containsKey(formattedName)) {
    return specializationsMap[formattedName]!;
  }

  // لو مش عربي أو مفيش ترجمة، يرجع الاسم الإنجليزي متظبط
  return formattedName;
}
