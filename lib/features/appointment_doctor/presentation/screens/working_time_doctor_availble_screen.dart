// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/widgets/build_working_time_doctor_listview.dart';
import 'package:flutter/material.dart';

class WorkingTimeDoctorAvailableScreen extends StatefulWidget {
  const WorkingTimeDoctorAvailableScreen({super.key});

  @override
  State<WorkingTimeDoctorAvailableScreen> createState() =>
      _WorkingTimeDoctorAvailableScreenState();
}

class _WorkingTimeDoctorAvailableScreenState
    extends State<WorkingTimeDoctorAvailableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate(LangKeys.workingTime),
        ),
      ),
      body: const BuildWorkingTimeDoctorListview(),
    );
  }
}

class AvailabilityBottomSheet extends StatefulWidget {
  const AvailabilityBottomSheet({super.key, this.existingData});
  final Map<String, dynamic>? existingData;
  @override
  State<AvailabilityBottomSheet> createState() =>
      _AvailabilityBottomSheetState();
}

class _AvailabilityBottomSheetState extends State<AvailabilityBottomSheet> {
  int step = 0;
  String? selectedDay;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  @override
  void initState() {
    super.initState();
    final data = widget.existingData;
    if (data != null) {
      selectedDay = (data['days_of_week'] as List).first as String;
      fromTime = _parseTimeOfDay(data['available_from'] as String);
      toTime = _parseTimeOfDay(data['available_to'] as String);
      step = 1;
    }
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  final days = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  Future<void> _pickTime(bool isFrom) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromTime = picked;
        } else {
          toTime = picked;
        }
      });
    }
  }

  void _submit() {
    if (selectedDay != null && fromTime != null && toTime != null) {
      final fromMinutes = fromTime!.hour * 60 + fromTime!.minute;
      final toMinutes = toTime!.hour * 60 + toTime!.minute;

      if (fromMinutes >= toMinutes) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Start time must be before end time'),
          ),
        );
        return;
      }

      final data = {
        'available_from': fromTime!.format(context).to24HourTimeFormat(),
        'available_to': toTime!.format(context).to24HourTimeFormat(),
        'days_of_week': [selectedDay!],
      };
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context, data);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
    }
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: days.map((day) {
                final isSelected = selectedDay == day;
                return ChoiceChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (_) {
                    setState(() {
                      selectedDay = day;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        );

      case 1:
        return Row(
          children: [
            CustomButton(
              isHalf: true,
              isNoLang: fromTime != null,
              title: fromTime == null
                  ? LangKeys.selectTime
                  : fromTime!.format(context),
              onPressed: () {
                _pickTime(true);
              },
            ).expand(),
            10.wSpace,
            CustomButton(
              isHalf: true,
              isNoLang: toTime != null,
              title: toTime == null
                  ? LangKeys.selectTime
                  : toTime!.format(context),
              onPressed: () {
                _pickTime(false);
              },
            ).expand(),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          Center(
            child: Container(
              height: 4,
              width: 40,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Text(
            'Add Working Hours',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildStep(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (step > 0)
                TextButton(
                  onPressed: () => setState(() => step--),
                  child: const Text('Back'),
                ),
              ElevatedButton(
                onPressed: () {
                  if (step < 1) {
                    if (selectedDay != null) {
                      setState(() => step++);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please select a day')),
                      );
                    }
                  } else {
                    if (fromTime != null && toTime != null) {
                      _submit();
                      log('-----------------');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please select both times'),
                        ),
                      );
                    }
                  }
                },
                child: Text(step == 1 ? 'Save' : 'Next'),
              ).expand(),
            ],
          ),
        ],
      ),
    );
  }
}
