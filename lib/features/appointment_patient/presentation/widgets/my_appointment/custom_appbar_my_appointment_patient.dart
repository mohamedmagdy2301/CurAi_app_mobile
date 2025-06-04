import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbarMyAppointmentPatient extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbarMyAppointmentPatient({
    required this.tabController,
    super.key,
  });

  final TabController tabController;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 60.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(color: context.backgroundColor),
      title: AutoSizeText(
        context.translate(LangKeys.myAppointments),
        maxLines: 1,
      ),
      centerTitle: true,
      bottom: TabBar(
        labelColor: context.primaryColor,
        unselectedLabelColor: context.onPrimaryColor,
        indicatorColor: context.primaryColor,
        indicatorWeight: 3.w,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyleApp.bold16().copyWith(
          color: context.primaryColor,
        ),
        unselectedLabelStyle: TextStyleApp.regular16().copyWith(
          color: context.onPrimaryColor,
        ),
        dividerColor: context.onSecondaryColor.withAlpha(120),
        overlayColor: WidgetStateProperty.all(
          context.primaryColor.withAlpha(25),
        ),
        controller: tabController,
        tabs: [
          Tab(text: context.translate(LangKeys.unpaid)),
          Tab(text: context.translate(LangKeys.paided)),
        ],
      ),
    );
  }
}
