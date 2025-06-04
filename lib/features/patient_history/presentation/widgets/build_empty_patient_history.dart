import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:flutter/material.dart';

class BuildEmptyPatientHistory extends StatelessWidget {
  const BuildEmptyPatientHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.history,
          size: 80,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 16),
        Text(
          'لا يوجد تاريخ طبي',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'اضغط على زر + لإضافة ملاحظة جديدة',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade500,
          ),
        ),
      ],
    ).center();
  }
}
