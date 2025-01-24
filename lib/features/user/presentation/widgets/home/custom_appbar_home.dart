import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/context_navigation_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_sizer_extansions.dart';
import 'package:curai_app_mobile/core/extensions/context_system_extansions.dart';
import 'package:curai_app_mobile/core/extensions/styletext_context_extansions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarHome extends StatefulWidget {
  const CustomAppBarHome({
    super.key,
  });

  @override
  State<CustomAppBarHome> createState() => _CustomAppBarHomeState();
}

class _CustomAppBarHomeState extends State<CustomAppBarHome> {
  int count = 5;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      // floating: true,
      // snap: true,
      automaticallyImplyLeading: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: Container(color: context.color.surface),
      toolbarHeight: 70.h,
      title: ListTile(
        title: AutoSizeText(
          context.translate(LangKeys.hiMohamed),
          style: context.styleExtraBold20,
          maxLines: 1,
        ),
        subtitle: AutoSizeText(
          context.translate(LangKeys.howAreYouToday),
          style: context.styleBold14.copyWith(
            color: context.color.onSecondary.withAlpha(130),
          ),
          maxLines: 1,
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              count = 0;
              context.pushNamed(Routes.notificationScreen);
            });
          },
          iconSize: iconSize(context),
          icon: Badge.count(
            count: count,
            isLabelVisible: count != 0,
            child: Icon(
              CupertinoIcons.bell,
              color: context.color.primary,
            ),
          ),
        ),
      ),
    );
  }

  double iconSize(BuildContext context) {
    return context.width < 500
        ? 28.sp
        : context.width < 700
            ? 22.sp
            : context.width < 900
                ? 17.sp
                : 12.sp;
  }
}
