// ignore_for_file: flutter_style_todos

import 'package:curai_app_mobile/core/extensions/theme_context_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageProfileWidget extends StatelessWidget {
  const ImageProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          ),
        ),
        Positioned(
          bottom: 5,
          right: 0,
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 16,
              backgroundColor: context.backgroundColor,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: context.primaryColor,
                child: const Icon(
                  CupertinoIcons.pencil,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
