// ignore_for_file: library_private_types_in_public_api, document_ignores

import 'package:auto_size_text/auto_size_text.dart';
import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/styles/fonts/app_text_style.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    required this.title,
    this.contentWidget,
    super.key,
    this.leadingIcon,
  });
  final String title;
  final Widget? contentWidget;
  final Widget? leadingIcon;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor.withAlpha(80),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: context.onSecondaryColor.withAlpha(15)),
        boxShadow: [
          BoxShadow(
            color: context.onSecondaryColor.withAlpha(5),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: widget.leadingIcon,
          title: AutoSizeText(
            widget.title,
            style: TextStyleApp.regular18().copyWith(
              color: context.onPrimaryColor,
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: context.primaryColor,
            size: 30.sp,
          ),
          onExpansionChanged: (expanded) {
            setState(() {
              _isExpanded = expanded;
            });
          },
          children: widget.contentWidget == null
              ? []
              : [
                  const CustomDivider(),
                  widget.contentWidget
                      .paddingSymmetric(horizontal: 15, vertical: 10),
                ],
        ),
      ),
    );
  }
}

class CustomNavagationTile extends StatefulWidget {
  const CustomNavagationTile({
    required this.title,
    super.key,
    this.leadingIcon,
    this.onTap,
  });
  final String title;
  final Widget? leadingIcon;
  final void Function()? onTap;

  @override
  _CustomNavagationTileState createState() => _CustomNavagationTileState();
}

class _CustomNavagationTileState extends State<CustomNavagationTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap ?? () {},
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundColor.withAlpha(80),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: context.onSecondaryColor.withAlpha(15)),
          boxShadow: [
            BoxShadow(
              color: context.onSecondaryColor.withAlpha(5),
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListTile(
            leading: widget.leadingIcon,
            title: AutoSizeText(
              widget.title,
              style: TextStyleApp.regular18().copyWith(
                color: context.onPrimaryColor,
              ),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: context.primaryColor,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
