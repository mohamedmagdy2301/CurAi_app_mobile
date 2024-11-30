import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare_app_mobile/core/app/cubit/app_cubit.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/helper/snackbar_helper.dart';
import 'package:smartcare_app_mobile/core/language/app_localizations.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';

class TestOne extends StatelessWidget {
  const TestOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate(LangKeys.appName),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder(
          bloc: context.read<AppCubit>(),
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (AppLocalizations.of(context)!.isEnglishLocale) {
                      context.read<AppCubit>().toArabic();
                    } else {
                      context.read<AppCubit>().toEngilsh();
                    }
                  },
                  child: context.read<AppCubit>().currentLocale == 'en'
                      ? const Text('العربيه')
                      : const Text('Engilsh'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: context.read<AppCubit>().changeTheme,
                  child: context.read<AppCubit>().isDark
                      ? const Text('Light Theme')
                      : const Text('Dark Theme'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.pushNamed(Routes.testtwo);
                    showMessage(
                      context,
                      type: SnackBarType.error,
                      message: 'Operation was successful!',
                      isIconVisible: true,
                      labelAction: 'OK',
                      onPressedAction: () {
                        hideMessage(context);
                      },
                    );
                  },
                  child: const Text('Go to Test Two'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
