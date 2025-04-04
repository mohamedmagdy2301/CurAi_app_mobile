import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/helper/regex.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/features/user/data/doctor_speciality_list.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor_speciality_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/doctor_speciality/doctor_specialities_gridlist_widget.dart';
import 'package:flutter/material.dart';

class FilterDoctorSpeciality extends StatefulWidget {
  const FilterDoctorSpeciality({super.key});

  @override
  _FilterDoctorSpecialityState createState() => _FilterDoctorSpecialityState();
}

class _FilterDoctorSpecialityState extends State<FilterDoctorSpeciality> {
  List<DoctorSpecialityModel> filteredDoctorSpecialityList =
      doctorSpecialityList;

  @override
  void initState() {
    super.initState();
    filteredDoctorSpecialityList = doctorSpecialityList;
  }

  void filterList(String query) {
    setState(() {
      filteredDoctorSpecialityList = doctorSpecialityList.where((item) {
        final localizedName = context.translate(item.name);
        if (isArabicFormat(query)) {
          return localizedName.contains(query);
        } else {
          return localizedName.toLowerCase().contains(query.toLowerCase());
        }
      }).toList();
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
          ),
        ),
        30.hSpace,
        Expanded(
          child: DoctorSpecialitiesGridList(
            filteredItems: filteredDoctorSpecialityList,
          ),
        ),
      ],
    );
  }
}
