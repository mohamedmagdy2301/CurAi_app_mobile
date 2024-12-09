import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartcare_app_mobile/core/extensions/context_extansions.dart';
import 'package:smartcare_app_mobile/core/language/lang_keys.dart';
import 'package:smartcare_app_mobile/core/routes/routes.dart';
import 'package:smartcare_app_mobile/core/styles/fonts/font_weight_helper.dart';

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
      backgroundColor: context.colors.appBarHome,
      automaticallyImplyLeading: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: Container(color: context.colors.appBarHome),
      toolbarHeight: 70.h,
      title: ListTile(
        title: Text(
          context.translate(LangKeys.hiMohamed),
          style: context.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeightHelper.bold,
          ),
        ),
        subtitle: Text(
          context.translate(LangKeys.howAreYouToday),
          style: context.textTheme.bodyMedium!.copyWith(
            color: context.colors.textColorLight,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              count = 0;
              context.pushNamed(Routes.notificationScreen);
            });
          },
          iconSize: 28.sp,
          icon: Badge.count(
            count: count,
            isLabelVisible: count != 0,
            child: Icon(
              CupertinoIcons.bell,
              color: context.colors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
