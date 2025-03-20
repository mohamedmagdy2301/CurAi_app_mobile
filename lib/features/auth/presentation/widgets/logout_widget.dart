// ignore_for_file: inference_failure_on_function_invocation

import 'package:curai_app_mobile/core/di/dependency_injection.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/helper/snackbar_helper.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_loading_widget.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
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
        listener: (context, state) {
          if (state is LogoutSuccess) {
            showMessage(
              context,
              type: SnackBarType.success,
              message: state.message,
            );
            SharedPrefManager.removeData(key: SharedPrefKey.keyAccessToken);
            SharedPrefManager.removeData(key: SharedPrefKey.keyRefreshToken);
            SharedPrefManager.removeData(key: SharedPrefKey.keyUserName);
            SharedPrefManager.removeData(key: SharedPrefKey.keyRole);
            SharedPrefManager.removeData(key: SharedPrefKey.keyUserId);
            context.pushNamedAndRemoveUntil(Routes.loginScreen);
          } else if (state is LogoutError) {
            showMessage(
              context,
              type: SnackBarType.error,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          return ListTile(
            leading: state is LogoutLoading
                ? const CustomLoadingWidget()
                : Icon(Icons.logout, color: context.color.primary),
            title: Text(
              context.translate(LangKeys.logout),
              style: context.styleRegular14,
            ),
            onTap: () {
              context.read<AuthCubit>().logout();
            },
          );
        },
      ),
    );
  }
}
