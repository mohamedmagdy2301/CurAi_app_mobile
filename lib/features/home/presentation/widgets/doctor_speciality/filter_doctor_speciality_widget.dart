import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/features/home/data/models/specializations_model/specializations_model.dart';
import 'package:curai_app_mobile/features/home/presentation/widgets/doctor_speciality/doctor_specialities_gridlist_widget.dart';
import 'package:flutter/material.dart';

class FilterDoctorSpeciality extends StatefulWidget {
  const FilterDoctorSpeciality({
    required this.specializationsList,
    this.isLoading,
    super.key,
  });
  final List<SpecializationsModel> specializationsList;
  final bool? isLoading;
  @override
  State<FilterDoctorSpeciality> createState() => _FilterDoctorSpecialityState();
}

class _FilterDoctorSpecialityState extends State<FilterDoctorSpeciality> {
  late List<SpecializationsModel> filteredDoctorSpecialityList;

  @override
  void initState() {
    super.initState();
    filteredDoctorSpecialityList = widget.specializationsList;
  }

  void filterList(String query) {
    setState(() {
      filteredDoctorSpecialityList = widget.specializationsList
          .where(
            (element) =>
                element.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        30.hSpace,
        Padding(
          padding: context.padding(horizontal: 20),
          child: CustomTextFeild(
            labelText: context.translate(LangKeys.doctorSpeciality),
            onChanged: filterList,
            isValidator: false,
          ),
        ),
        30.hSpace,
        Expanded(
          child: DoctorSpecialitiesGridList(
            isLoading: widget.isLoading ?? false,
            filteredItems: filteredDoctorSpecialityList,
          ),
        ),
      ],
    );
  }
}
