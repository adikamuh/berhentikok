import 'dart:collection';

import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/model/smoking_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTableWidget extends StatefulWidget {
  const CalendarTableWidget({Key? key}) : super(key: key);

  @override
  State<CalendarTableWidget> createState() => _CalendarTableWidgetState();
}

class _CalendarTableWidgetState extends State<CalendarTableWidget> {
  final DateFormat _format = DateFormat('d-MMMM');
  late final ValueNotifier<List<SmokingDetails>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final kSmokingDetails = LinkedHashMap<DateTime, List<SmokingDetails>>(
    equals: isSameDay,
    hashCode: SmokingDetails.getHashCode,
  )..addAll(
      {
        DateTime.now(): [
          SmokingDetails(date: DateTime.now(), excuse: 'excuse-1', total: 1),
          SmokingDetails(date: DateTime.now(), excuse: 'excuse-2', total: 2),
          SmokingDetails(date: DateTime.now(), excuse: 'excuse-3', total: 20),
        ],
      },
    );

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getSmokingDetailsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar<SmokingDetails>(
          locale: "id_ID",
          firstDay: DateTime.now().subtract(const Duration(days: 7)),
          lastDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          focusedDay: _focusedDay,
          onFormatChanged: _onFormatChanged,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          eventLoader: _getSmokingDetailsForDay,
          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.secondaryColor1,
            ),
            todayTextStyle: TextStyle(color: Colors.black),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.secondaryColor2,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: ((context, day, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  right: 0,
                  bottom: -5,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade700,
                    ),
                    child: Text(
                      events.first.sumTotal(events),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return null;
            }),
          ),
        ),
        SizedBox(height: 10.h),
        ValueListenableBuilder<List<SmokingDetails>>(
          valueListenable: _selectedEvents,
          builder: (context, values, _) {
            return Column(
              children: _buildSmokingDetails(values),
            );
          },
        ),
      ],
    );
  }

  List<SmokingDetails> _getSmokingDetailsForDay(DateTime day) {
    return kSmokingDetails[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getSmokingDetailsForDay(selectedDay);
    }
  }

  void _onFormatChanged(CalendarFormat format) {
    if (_calendarFormat != format) {
      setState(() {
        _calendarFormat = format;
      });
    }
  }

  List<Widget> _buildSmokingDetails(List<SmokingDetails> smokingDetails) {
    return smokingDetails.map((smokingDetail) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.0.h,
        ),
        decoration: BoxDecoration(
          color: ColorConst.primaryColor1,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          onTap: () => print(smokingDetail.excuse),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          tileColor: ColorConst.primaryColor1,
          title: Text(
            smokingDetail.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }).toList();
  }
}
