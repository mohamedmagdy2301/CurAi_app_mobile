// ignore_for_file: lines_longer_than_80_chars

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/navigation_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/local_storage/shared_pref_key.dart';
import 'package:curai_app_mobile/core/local_storage/shared_preferences_manager.dart';
import 'package:curai_app_mobile/core/routes/routes.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      flexibleSpace: Container(color: context.backgroundColor),
      toolbarHeight: context.H * 0.1,
      title: ListTile(
        title: AutoSizeText(
          context.isStateArabic
              ? 'مرحبا, ${CacheDataHelper.getData(key: SharedPrefKey.keyUserName)} 👋'
              : 'Hi, ${CacheDataHelper.getData(key: SharedPrefKey.keyUserName)} 👋',
          style: TextStyleApp.extraBold20().copyWith(
            color: context.primaryColor,
          ),
          maxLines: 1,
        ),
        subtitle: AutoSizeText(
          context.translate(LangKeys.howAreYouToday),
          style: TextStyleApp.bold14().copyWith(
            color: context.onSecondaryColor.withAlpha(130),
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
          iconSize: 27.sp,
          icon: Badge.count(
            count: count,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            textStyle: TextStyleApp.medium8().copyWith(
              color: Colors.white,
            ),
            isLabelVisible: count != 0,
            child: Icon(
              CupertinoIcons.bell,
              size: 27.sp,
              color: context.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
