import 'dart:developer';

import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as ext;
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AddAvailabilityScreen extends StatefulWidget {
  const AddAvailabilityScreen({super.key});

  @override
  State<AddAvailabilityScreen> createState() => _AddAvailabilityScreenState();
}

class _AddAvailabilityScreenState extends State<AddAvailabilityScreen> {
  List<Map<String, dynamic>> scheduleData = [
    {
      'id': 8,
      'doctor': 'Mohamed123',
      'available_from': '10:30:00',
      'available_to': '16:30:00',
      'days_of_week': [
        'Saturday',
      ],
    },
    {
      'id': 9,
      'doctor': 'Mohamed123',
      'available_from': '10:30:00',
      'available_to': '16:30:00',
      'days_of_week': [
        'Saturday',
      ],
    },
  ];

  Future<void> showAvailabilityBottomSheet(
    BuildContext context, {
    int? editIndex,
    Map<String, dynamic>? existingData,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AvailabilityBottomSheet(existingData: existingData),
    );

    if (result != null) {
      setState(() {
        if (editIndex != null) {
          scheduleData[editIndex] = result;
        } else {
          scheduleData.add(result);
        }
      });
    }
  }

  Future<void> confirmDelete(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content:
            const Text('Are you sure you want to delete this availability?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        scheduleData.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Availability')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            if (scheduleData.isEmpty)
              const Text('No availabilities added yet.').expand(),
            if (scheduleData.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemCount: scheduleData.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final item = scheduleData[index];
                    var day = item['days_of_week'];
                    if (day is List<String>) {
                      day = day[0];
                    }
                    return ListTile(
                      leading: const Icon(Icons.calendar_today),
                      title: Text(day as String),
                      subtitle: Text(
                        "From ${item["available_from"]} to ${item["available_to"]}",
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => showAvailabilityBottomSheet(
                              context,
                              editIndex: index,
                              existingData: item,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => confirmDelete(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ElevatedButton(
              onPressed: () => showAvailabilityBottomSheet(context),
              child: const Text('Add Availability'),
            ),
          ],
        ),
      ),
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
