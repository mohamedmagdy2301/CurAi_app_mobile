import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:curai_app_mobile/core/extensions/int_extensions.dart' as ext;
import 'package:curai_app_mobile/core/extensions/localization_context_extansions.dart';
import 'package:curai_app_mobile/core/extensions/string_extensions.dart';
import 'package:curai_app_mobile/core/extensions/widget_extensions.dart';
import 'package:curai_app_mobile/core/language/lang_keys.dart';
import 'package:curai_app_mobile/core/utils/widgets/custom_button.dart';
import 'package:curai_app_mobile/features/appointment_doctor/presentation/cubit/appointment_doctor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAvailabilityScreen extends StatefulWidget {
  const AddAvailabilityScreen({super.key});

  @override
  State<AddAvailabilityScreen> createState() => _AddAvailabilityScreenState();
}

class _AddAvailabilityScreenState extends State<AddAvailabilityScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AppointmentDoctorCubit>().getWorkingTimeAvailableDoctor();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppointmentDoctorCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Availability')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            if (cubit.state is GetWorkingTimeDoctorAvailableLoading)
              const CircularProgressIndicator().center().expand()
            else if (cubit.state is GetWorkingTimeDoctorAvailableFailure)
              Text(
                (cubit.state as GetWorkingTimeDoctorAvailableFailure).message,
              ).center()
            else if (cubit.workingTimeList.isEmpty)
              const Text('No availabilities added yet.').expand()
            else
              Expanded(
                child: ListView.builder(
                  itemCount: cubit.workingTimeList.length,
                  itemBuilder: (context, index) {
                    final groupedData = groupBy(
                      cubit.workingTimeList,
                      (item) => item.id,
                    );

                    final groupedItemsList = groupedData.entries.toList();

                    if (index < groupedItemsList.length) {
                      final groupedItem = groupedItemsList[index];
                      final id = groupedItem.key;
                      final items = groupedItem.value;

                      return ExpansionTile(
                        title: Text('Availability ID: $id'),
                        children: [
                          for (final item in items)
                            ListTile(
                              title: Text(
                                '${item.getLocalizedDays(isArabic: context.isStateArabic).join(', ')} - ${item.availableFrom} to ${item.availableTo}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () {
                                    // TODO: Edit via API
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    // TODO: Delete via API
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
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
