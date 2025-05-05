import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/get_location/get_location_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/complete_profile/form_add_address_clinic_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/header_auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAddressClinicScreen extends StatefulWidget {
  const AddAddressClinicScreen({super.key, this.isEdit});
  final bool? isEdit;
  @override
  State<AddAddressClinicScreen> createState() => _AddAddressClinicScreenState();
}

class _AddAddressClinicScreenState extends State<AddAddressClinicScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetLocationCubit()..getCurrentLocation(context),
      child: BlocProvider<AuthCubit>(
        create: (context) => sl<AuthCubit>(),
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: context.isLandscape
                  ? context.padding(horizontal: 100, vertical: 35)
                  : context.padding(horizontal: 20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderAuthWidget(
                      title: LangKeys.clinicAddress,
                      descraption: LangKeys.clinicAddressDescription,
                      isBack: widget.isEdit ?? false,
                    ),
                    10.hSpace,
                    AddAddressClinicFormWidget(isEdit: widget.isEdit),
                    35.hSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
