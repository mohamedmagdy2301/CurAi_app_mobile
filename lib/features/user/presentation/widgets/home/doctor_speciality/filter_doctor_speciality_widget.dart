import 'package:curai_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/helper/regex.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/user/data/doctor_speciality_list.dart';
import 'package:curai_app_mobile/features/user/models/doctor_speciality_model/doctor_speciality_model.dart';
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
        context.spaceHeight(30),
        Padding(
          padding: context.padding(horizontal: 20),
          child: CustomTextFeild(
            labelText: context.translate(LangKeys.doctorSpeciality),
            onChanged: filterList,
          ),
        ),
        context.spaceHeight(30),
        Expanded(
          child: DoctorSpecialitiesGridList(
            filteredItems: filteredDoctorSpecialityList,
          ),
        ),
      ],
    );
  }
}
