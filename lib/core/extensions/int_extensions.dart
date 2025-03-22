import 'package:flutter/material.dart';

extension Spacer on num {
  Widget get hSpace => SizedBox(height: toDouble());
  Widget get wSpace => SizedBox(width: toDouble());
}
