import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as a;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/images/app_images.dart';
import 'package:curai_app_mobile/core/utils/helper/url_launcher_helper.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/customer_service_form_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/row_navigate_contact_us_widget.dart';
import 'package:curai_app_mobile/features/profile/presentation/widgets/help_center/whatsapp_content_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactUsBodyListview extends StatelessWidget {
  const ContactUsBodyListview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomNavagationTile(
          title: context.translate(LangKeys.customerService),
          leadingIcon: const Icon(Icons.support_agent_outlined),
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              backgroundColor: context.backgroundColor,
              isScrollControlled: true,
              builder: (context) => const CustomerServiceFormWidget(),
            );
          },
        ),
        10.hSpace,
        CustomExpansionTile(
          leadingIcon: const Icon(CupertinoIcons.phone),
          title: context.translate(LangKeys.phone),
          contentWidget: const NumberPhoneContentWidget(
            number: '01015415210',
            isPhone: true,
          ),
        ),
        10.hSpace,
        CustomNavagationTile(
          leadingIcon: Icon(CupertinoIcons.mail, size: 25.sp),
          title: context.translate(LangKeys.email),
          onTap: () => UrlLauncherHelper.launchEmail(
            context,
            'smartcare112000@gmail.com',
          ),
        ),
        10.hSpace,
        CustomNavagationTile(
          title: context.translate(LangKeys.website),
          leadingIcon: SvgPicture.asset(
            AppImagesSvg.logoWebsite,
            height: 25.h,
            width: 25.h,
            colorFilter:
                ColorFilter.mode(context.onPrimaryColor, BlendMode.srcIn),
          ),
          onTap: () =>
              UrlLauncherHelper.launchWebsite(context, 'https://google.com'),
        ),
        10.hSpace,
        CustomExpansionTile(
          leadingIcon: SvgPicture.asset(
            AppImagesSvg.logoWhatsapp,
            height: 25.h,
            width: 25.h,
          ),
          title: context.translate(LangKeys.whatsApp),
          contentWidget: const NumberPhoneContentWidget(
            number: '01015415210',
          ),
        ),
        10.hSpace,
        CustomNavagationTile(
          title: context.translate(LangKeys.facebook),
          leadingIcon: SvgPicture.asset(
            AppImagesSvg.logoFacebookRect,
            height: 25.h,
            width: 25.h,
          ),
          onTap: () =>
              UrlLauncherHelper.launchWebsite(context, 'https://facebook.com'),
        ),
        10.hSpace,
        CustomNavagationTile(
          title: context.translate(LangKeys.instagram),
          leadingIcon: Image.asset(
            AppImages.logoInstagram,
            height: 25.h,
            width: 25.h,
          ),
          onTap: () =>
              UrlLauncherHelper.launchWebsite(context, 'https://instagram.com'),
        ),
        10.hSpace,
        CustomNavagationTile(
          title: context.translate(LangKeys.x),
          leadingIcon: SvgPicture.asset(
            AppImagesSvg.logoX,
            height: 25.h,
            width: 25.h,
          ),
          onTap: () =>
              UrlLauncherHelper.launchWebsite(context, 'https://x.com'),
        ),
      ],
    ).paddingSymmetric(horizontal: 15, vertical: 10);
  }
}
