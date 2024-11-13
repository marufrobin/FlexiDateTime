import 'dart:developer';

import 'package:flutter/material.dart';

class TimeWheelWidget extends StatelessWidget {
  const TimeWheelWidget({super.key});

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
        const Text('Time Wheel Widget'),
        const SizedBox(height: 10),
        _ListWheelTestWidget(),
        const SizedBox(height: 10),
        const Text(' List Wheel Child Builder Delegate Widget'),
        _ListWheelChildBuilderDelegateWidget(),
        const SizedBox(height: 10),
        const Text('List Wheel Child Looping List Delegate'),
        const Text('List will show from beginning to end and then will loop'),
        _LoopingWheelWidget(),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _LoopingWheelWidget extends StatelessWidget {
  const _LoopingWheelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 30,
        // useMagnifier: true,
        onSelectedItemChanged: (value) {
          log('onSelectedItemChanged: ${value + 1}');
        },
        overAndUnderCenterOpacity: 0.4,
        diameterRatio: 1.0,
        useMagnifier: true,
        magnification: 1.5,
        // squeeze: 1,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: List.generate(
            24,
            (index) => Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListWheelChildBuilderDelegateWidget extends StatelessWidget {
  const _ListWheelChildBuilderDelegateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListWheelScrollView.useDelegate(
        itemExtent: 30,
        // useMagnifier: true,
        onSelectedItemChanged: (value) {
          log('onSelectedItemChanged: ${value + 1}');
        },
        diameterRatio: 1.0,
        useMagnifier: true,
        magnification: 1.5,
        squeeze: 1,
        overAndUnderCenterOpacity: 0.4,

        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 30,
          builder: (context, index) {
            return Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ListWheelTestWidget extends StatelessWidget {
  const _ListWheelTestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListWheelScrollView(
          itemExtent: 30,
          // useMagnifier: true,
          onSelectedItemChanged: (value) {
            log('onSelectedItemChanged: ${value + 1}');
          },
          diameterRatio: 1.0,
          useMagnifier: true,
          magnification: 1.5,
          squeeze: 1,
          physics: const FixedExtentScrollPhysics(),
          // perspective: 0.0004,
          // hitTestBehavior: HitTestBehavior.translucent,
          children: List.generate(
            24,
            (index) => Container(
              color: Colors.grey.shade300,
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          )),
    );
  }
}
