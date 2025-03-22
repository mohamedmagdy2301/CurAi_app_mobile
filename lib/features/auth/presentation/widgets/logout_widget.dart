// ignore_for_file: inference_failure_on_function_invocation, inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => sl<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listenWhen: (previous, current) =>
            current is LogoutSuccess ||
            current is LogoutError ||
            current is LogoutLoading,
        listener: (context, state) async {
          if (state is LogoutSuccess) {
            context.pop();

            showMessage(
              context,
              type: SnackBarType.success,
              message: state.message,
            );

            await SharedPrefManager.removeData(
              key: SharedPrefKey.keyAccessToken,
            );
            await SharedPrefManager.removeData(
              key: SharedPrefKey.keyRefreshToken,
            );
            await SharedPrefManager.removeData(key: SharedPrefKey.keyUserName);
            await SharedPrefManager.removeData(key: SharedPrefKey.keyRole);
            await SharedPrefManager.removeData(key: SharedPrefKey.keyUserId);
            await SharedPrefManager.removeData(
              key: SharedPrefKey.keyIsLoggedIn,
            );

            await context.pushNamedAndRemoveUntil(Routes.loginScreen);
          } else if (state is LogoutError) {
            context.pop();
            showMessage(
              context,
              type: SnackBarType.error,
              message: state.message,
            );
          } else if (state is LogoutLoading) {
            await AdaptiveDialogs.shoLoadingAlertDialog(
              context: context,
              title: context.translate(LangKeys.logout),
            );
          }
        },
        builder: (context, state) {
          return RowNavigateProfileWidget(
            icon: Icons.logout_rounded,
            title: LangKeys.logout,
            onTap: () {
              AdaptiveDialogs.showOkCancelAlertDialog(
                context: context,
                title: context.translate(LangKeys.logout),
                message: Text(context.translate(LangKeys.logoutMessage)),
                onPressedOk: () {
                  context.pop();
                  context.read<AuthCubit>().logout();
                },
                onPressedCancel: () => context.pop(),
              );
            },
          );
        },
      ),
    );
  }
}
