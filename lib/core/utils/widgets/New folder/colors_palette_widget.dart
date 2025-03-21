import 'package:curai_app_mobile/core/utils/widgets/New%20folder/build_cricle_color_widget.dart';
import 'package:curai_app_mobile/core/styles/colors/theme_palette_model.dart';
import 'package:flutter/material.dart';

class ColorPaletteWidget extends StatelessWidget {
  const ColorPaletteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        colorPalette.length,
        (index) => BuildCircleColorWidget(index: index),
      ),
    );
  }
}
