import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/auth/presentation/screens/your_profile_screen.dart';
import 'package:curai_app_mobile/features/auth/presentation/widgets/your_profile/custom_appbar_your_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildYourProfileScreen extends StatefulWidget {
  const BuildYourProfileScreen({super.key});

  @override
  State<BuildYourProfileScreen> createState() => _BuildYourProfileScreenState();
}

class _BuildYourProfileScreenState extends State<BuildYourProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().getProfile(context);
  }

  int? selectedGender;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: const CustomAppBarYourProfile(),
      body: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) =>
            current is GetProfileLoading ||
            current is GetProfileError ||
            current is GetProfileSuccess,
        builder: (context, state) {
          if (state is GetProfileSuccess) {
            return YourProfileScreen(profileModel: state.profileModel);
          } else if (state is GetProfileError) {
            return Text(state.message).center();
          }
          return const Center(child: CustomLoadingWidget());
        },
      ),
    );
  }
}
