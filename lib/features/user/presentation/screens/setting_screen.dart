import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:smartcare_app_mobile/core/common/widgets/custom_button.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/functions_helper.dart';
import 'package:smartcare_app_mobile/core/helper/snackbar_helper.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: padding(horizontal: 50),
          child: BlocBuilder(
            bloc: context.read<AppCubit>(),
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  spaceHeight(20),
                  CustemButton(
                    title: LangKeys.changeLanguage,
                    onPressed: () {
                      if (AppLocalizations.of(context)!.isEnglishLocale) {
                        context.read<AppCubit>().toArabic();
                      } else {
                        context.read<AppCubit>().toEngilsh();
                      }
                    },
                  ),
                  spaceHeight(20),
                  CustemButton(
                    onPressed: context.read<AppCubit>().changeTheme,
                    title: LangKeys.changeTheme,
                  ),
                  spaceHeight(20),
                  CustemButton(
                    onPressed: () {
                      showMessage(
                        context,
                        type: SnackBarType.info,
                        message: isArabic() ? 'التــــألي' : 'Next',
                      );
                    },
                    title: LangKeys.next,
                  ),
                  spaceHeight(20),
                  CustemButton(
                    onPressed: () => context.pushNamed(Routes.registerScreen),
                    title: LangKeys.login,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
