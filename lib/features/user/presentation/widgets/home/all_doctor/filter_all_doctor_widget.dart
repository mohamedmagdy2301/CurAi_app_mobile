import 'dart:async';

import 'package:curai_app_mobile/core/common/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/extensions/settings_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/functions_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/user/data/doctors_list.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/all_doctor/all_doctor_listview_widget.dart';
import 'package:flutter/material.dart';

class FilterAllDoctorWidget extends StatefulWidget {
  const FilterAllDoctorWidget({super.key});

  @override
  _FilterAllDoctorState createState() => _FilterAllDoctorState();
}

class _FilterAllDoctorState extends State<FilterAllDoctorWidget> {
  List<DoctorModel> filteredAllDoctorList = doctorsList;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    filteredAllDoctorList = doctorsList;
  }

  void filterList(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      setState(() {
        filteredAllDoctorList = doctorsList.where((item) {
          final localizedNameAr = item.nameAr.toLowerCase();
          final localizedNameEn = item.nameEn.toLowerCase();
          final searchQuery = query.toLowerCase();

          return localizedNameAr.contains(searchQuery) ||
              localizedNameEn.contains(searchQuery);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        spaceHeight(30),
        Padding(
          padding: padding(horizontal: 20),
          child: CustomTextFeild(
            labelText: context.translate(LangKeys.doctors),
            onChanged: filterList,
          ),
        ),
        spaceHeight(30),
        Expanded(
          child: AllDoctorListviewWidget(
            filteredItems: filteredAllDoctorList,
          ),
        ),
      ],
    );
  }
}
