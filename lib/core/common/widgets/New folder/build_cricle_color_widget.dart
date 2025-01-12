import 'package:curai_app_mobile/core/app/cubit/settings_cubit.dart';
import 'package:curai_app_mobile/core/app/cubit/settings_state.dart';
import 'package:curai_app_mobile/core/styles/colors/theme_palette_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildCircleColorWidget extends StatelessWidget {
  const BuildCircleColorWidget({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final state = context.watch<SettingsCubit>().state;
    return GestureDetector(
      onTap: () => cubit.setColors(ColorsPalleteState.values[index]),
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: state.colors == ColorsPalleteState.values[index]
              ? Border.all(color: colorPalette[index], width: 3)
              : null,
        ),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorPalette[index],
          ),
        ),
      ),
    );
  }
}
