import 'package:curai_app_mobile/features/appointment/presentation/widgets/my_appointment/paided_card_item_widget.dart';
import 'package:flutter/material.dart';

class PaidedBodyWidget extends StatelessWidget {
  const PaidedBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const PaidedCardItemWidget();
      },
    );
  }
}
