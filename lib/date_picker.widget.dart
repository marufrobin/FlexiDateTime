import 'dart:developer';

import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Date Picker Widget'),
        CalendarDatePicker(
          initialCalendarMode: DatePickerMode.day,
          currentDate: DateTime.now(),
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
          onDateChanged: (date) {
            log(name: 'onDateChanged:', "$date");
          },
          onDisplayedMonthChanged: (value) {
            log(name: 'onDisplayedMonthChanged:', "$value");
          },
          selectableDayPredicate: (day) {
            log(name: 'selectableDayPredicate:', "$day");
            return true;
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
