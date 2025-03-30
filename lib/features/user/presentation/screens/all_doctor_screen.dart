import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_cubit.dart';
import 'package:curai_app_mobile/features/user/presentation/cubit/home_state.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/all_doctor/custom_appbar_all_doctor.dart';
import 'package:curai_app_mobile/features/user/presentation/widgets/home/popular_doctor/popular_doctor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllDoctorScreen extends StatefulWidget {
  const AllDoctorScreen({super.key});

  @override
  State<AllDoctorScreen> createState() => _AllDoctorScreenState();
}

class _AllDoctorScreenState extends State<AllDoctorScreen> {
  // List<DoctorModel> filteredAllDoctorList = doctorsList;
  // Timer? _debounce;

  // @override
  // void initState() {
  //   super.initState();
  //   filteredAllDoctorList = doctorsList;
  // }

  // void filterList(String query) {
  //   if (_debounce?.isActive ?? false) _debounce?.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 200), () {
  //     setState(() {
  //       filteredAllDoctorList = doctorsList.where((item) {
  //         final localizedNameAr = item.nameAr.toLowerCase();
  //         final localizedNameEn = item.nameEn.toLowerCase();
  //         final searchQuery = query.toLowerCase();
  //         return localizedNameAr.contains(searchQuery) ||
  //             localizedNameEn.contains(searchQuery);
  //       }).toList();
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeCubit>()..getAllDoctor(),
      child: CustomScrollView(
        slivers: [
          const CustomAppBarAllDoctor(),
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: SearchBarDelegate( ),
          // ),
          BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) =>
                current is GetAllDoctorSuccess ||
                current is GetAllDoctorFailure ||
                current is GetAllDoctorLoading,
            builder: (context, state) {
              if (state is GetAllDoctorSuccess) {
                final doctorsList = state.doctorModel;
                return SliverList.separated(
                  itemCount: doctorsList.length,
                  separatorBuilder: (context, index) => 10.hSpace,
                  itemBuilder: (context, index) {
                    return PopularDoctorItemWidget(
                      doctorModel: doctorsList[index],
                    );
                  },
                );
              } else if (state is GetAllDoctorFailure) {
                return SliverToBoxAdapter(
                  child: Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyleApp.regular26().copyWith(
                      color: context.onSecondaryColor,
                    ),
                  ).center().paddingSymmetric(vertical: 45),
                );
              }
              return SliverList.separated(
                itemCount: doctorsListDome.length,
                separatorBuilder: (context, index) => 10.hSpace,
                itemBuilder: (context, index) {
                  return Skeletonizer(
                    child: PopularDoctorItemWidget(
                      doctorModel: doctorsListDome[index],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

List<DoctorModel> doctorsListDome = List.generate(
  7,
  (index) => DoctorModel(
    id: index,
    username: 'محمد',
    profilePicture:
        'https://images.unsplash.com/photo-1499714608240-22fc6ad53fb2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    consultationPrice: index.toString(),
    email: 'nsjka bjba',
    location: 'msabnj hjdgav hdgah',
    specialization: 'sdnaj sadkldbn ',
    reviews: List.generate(
      2,
      (index) => Reviews(
        id: index,
        rating: index,
      ),
    ),
  ),
);
