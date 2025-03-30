import 'dart:async';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/features/user/data/doctors_list.dart';
import 'package:curai_app_mobile/features/user/models/doctor_model/popular_doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/all_doctor/custom_appbar_all_doctor.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/all_doctor/custom_search_bar.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({super.key});

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
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
    return CustomScrollView(
      slivers: [
        const CustomAppBarAllDoctor(),
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchBarDelegate(onChanged: filterList),
        ),
        SliverList.separated(
          itemCount: filteredAllDoctorList.length,
          separatorBuilder: (context, index) => 10.hSpace,
          itemBuilder: (context, index) {
            return PopularDoctorItemWidget(
              doctorModel: filteredAllDoctorList[index],
            );
          },
        ),
      ],
    );
  }
}
