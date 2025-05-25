import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/helper/funcations_helper.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_text_feild.dart';
import 'package:curai_app_mobile/core/utils/widgets/sankbar/snackbar_helper.dart';
import 'package:curai_app_mobile/features/auth/data/models/contact_us/contact_us_request.dart';
import 'package:curai_app_mobile/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

class CustomerServiceFormWidget extends StatefulWidget {
  const CustomerServiceFormWidget({
    super.key,
  });

  @override
  State<CustomerServiceFormWidget> createState() =>
      _CustomerServiceFormWidgetState();
}

class _CustomerServiceFormWidgetState extends State<CustomerServiceFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          spacing: 15.h,
          children: [
            0.hSpace,
            CustomTextFeild(
              labelText: context.translate(LangKeys.fullName),
              controller: _fullNameController,
              isLable: false,
            ),
            CustomTextFeild(
              labelText: context.translate(LangKeys.email),
              controller: _emailController,
              isLable: false,
            ),
            CustomTextFeild(
              labelText: context.translate(LangKeys.howDoWeHelpYou),
              controller: _messageController,
              isLable: false,
              maxLines: 5,
            ),
            BlocProvider(
              create: (context) => sl<AuthCubit>(),
              child: BlocConsumer<AuthCubit, AuthState>(
                listenWhen: (previous, current) =>
                    current is ContactUsLoading ||
                    current is ContactUsSuccess ||
                    current is ContactUsError,
                listener: (context, state) {
                  if (state is ContactUsError) {
                    Navigator.pop(context);
                    showMessage(
                      context,
                      message: state.message,
                      type: ToastificationType.error,
                    );
                    context.read<AuthCubit>().clearState();
                  }
                  if (state is ContactUsSuccess) {
                    Navigator.pop(context);
                    showMessage(
                      context,
                      message: state.message,
                      type: ToastificationType.success,
                    );
                    context.read<AuthCubit>().clearState();
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: LangKeys.send,
                    isLoading: state is ContactUsLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(_emailController.text.trim())) {
                          showMessage(
                            context,
                            message: context.isStateArabic
                                ? 'البريد الإلكتروني غير صالح'
                                : 'Email is not valid',
                            type: ToastificationType.error,
                          );
                          return;
                        }
                        context.read<AuthCubit>().contactUs(
                              context,
                              ContactUsRequest(
                                subject: 'Customer Service',
                                name: _fullNameController.text.trim(),
                                email: _emailController.text.trim(),
                                message: _messageController.text.trim(),
                              ),
                            );
                        hideKeyboard();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
