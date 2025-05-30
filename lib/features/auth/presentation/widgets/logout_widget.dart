// ignore_for_file: inference_failure_on_function_invocation,// inference_failure_on_instance_creation, use_build_context_synchronously

import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart'
    as di;
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/services/local_storage/menage_user_data.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/services/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/utils/widgets/adaptive_dialogs/adaptive_dialogs.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/row_navigate_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

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
            await clearUserData();
            await di
                .sl<CacheDataManager>()
                .removeData(key: SharedPrefKey.keyIsLoggedIn);
            if (!context.mounted) return;
            await context.pushNamedAndRemoveUntil(Routes.loginScreen);
            if (!context.mounted) return;
            context.read<AuthCubit>().clearState();
          }
          if (state is LogoutError) {
            showMessage(
              context,
              type: ToastificationType.error,
              message: state.message,
            );
            context.read<AuthCubit>().clearState();
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
                message: context.translate(LangKeys.logoutMessage),
                onPressedOk: () {
                  context.read<AuthCubit>().logout(context);
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
