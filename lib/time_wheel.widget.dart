import 'dart:developer';

import 'package:flutter/material.dart';

class TimeWheelWidget extends StatelessWidget {
  const TimeWheelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Testing Time Wheel Widget'),
        _TimeWheelWidget(),
        const Text('Testing Wheel Widget'),
        const SizedBox(height: 10),
        _ListWheelTestWidget(),
        const SizedBox(height: 10),
        const Text('Test List Wheel Child Builder Delegate Widget'),
        _ListWheelChildBuilderDelegateWidget(),
        const SizedBox(height: 10),
        const Text('Test List Wheel Child Looping List Delegate'),
        const Text('List will show from beginning to end and then will loop'),
        _LoopingWheelWidget(),
        const SizedBox(height: 10),
      ],
    );
  }
}

/// Enum for time format
/// for [HoursFormat24] it will show 24 hours format
/// for [HoursFormat12] it will show 12 hours format
enum TimeHourFormat { HoursFormat24, HoursFormat12 }

class _TimeWheelWidget extends StatelessWidget {
  const _TimeWheelWidget({
    super.key,
    this.timeHourFormat = TimeHourFormat.HoursFormat12,
    this.height,
    this.width,
    this.itemExtent = 30,
  });

  final TimeHourFormat timeHourFormat;
  final double? height;
  final double? width;
  final double itemExtent;

  @override
  Widget build(BuildContext context) {
    final timesList = _generateTimeIntervals(
      timeHourFormat: timeHourFormat,
      intervalMinutes: 10,
      startTime: const TimeOfDay(hour: 8, minute: 0),
      endTime: const TimeOfDay(hour: 14, minute: 00),
    );
    log(name: 'timesList', "$timesList");

    return SizedBox(
      height: height ?? 300,
      width: width ?? 60,
      child: ListWheelScrollView.useDelegate(
        itemExtent: itemExtent,
        // useMagnifier: true,
        onSelectedItemChanged: (value) {
          log('onSelectedItemChanged: ${value + 1}');
        },

        overAndUnderCenterOpacity: 0.6,
        diameterRatio: 1.4,
        useMagnifier: true,
        magnification: 1.4,
        squeeze: 0.9,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildLoopingListDelegate(
          children: timesList
                  ?.map(
                    (time) => Container(
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Center(
                        child: Text(
                          '$time',
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList() ??
              [],
        ),
      ),
    );
  }

  List<String> _generateTimeIntervals({
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required int intervalMinutes,
    required TimeHourFormat timeHourFormat,
  }) {
    // Convert TimeOfDay to DateTime for easier calculations
    final startDateTime = DateTime(0, 1, 1, startTime.hour, startTime.minute);
    final endDateTime = DateTime(0, 1, 1, endTime.hour, endTime.minute);

    final times = <String>[];

    for (var current = startDateTime;
        current.isBefore(endDateTime);
        current = current.add(Duration(minutes: intervalMinutes))) {
      final hour = current.hour;
      final minute = current.minute.toString().padLeft(2, '0');

      if (timeHourFormat == TimeHourFormat.HoursFormat24) {
        // 24-hour format
        times.add('${hour.toString().padLeft(2, '0')}:$minute');
      } else {
        // 12-hour format
        final hour12 = _get12Hours(
            hour); /* hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);*/
        final period = _get12HoursString(hour); /* hour < 12 ? 'AM' : 'PM';*/
        times.add('$hour12:$minute $period');
      }
    }

    return times;
  }

  List<String?>? getTimeList({
    required TimeHourFormat timeHourFormat,
    required int intervalMinutes,
  }) {
    final intervalPerDay = (24 * 60) ~/ intervalMinutes;

    List<String?>? timeList;
    timeList = List.generate(
      intervalPerDay,
      (index) {
        final totalMinutes = index * intervalMinutes;
        final timeHour = totalMinutes ~/ 60;
        final timeMinute = totalMinutes % 60;
        if (timeHourFormat == TimeHourFormat.HoursFormat24) {
          return "${timeHour.toString().padLeft(2, '0')}:${timeMinute.toString().padLeft(2, '0')}";
        } else if (timeHourFormat == TimeHourFormat.HoursFormat12) {
          // Correct 12-hour format
          final hour12 = _get12Hours(timeHour); // Convert hours
          final period = _get12HoursString(timeHour); // Determine AM/PM
          return "${hour12.toString().padLeft(2, '0')}:${timeMinute.toString().padLeft(2, '0')} $period";
        } else {
          return null;
        }
      },
    );
    return timeList;
  }

  int _get12Hours(int hour) => hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
  String _get12HoursString(int hour) => hour < 12 ? 'AM' : 'PM';
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
