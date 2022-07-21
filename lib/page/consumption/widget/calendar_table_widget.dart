import 'dart:collection';

import 'package:berhentikok/base/color_const.dart';
import 'package:berhentikok/base/font_const.dart';
import 'package:berhentikok/model/smoking_detail.dart';
import 'package:berhentikok/page/consumption/widget/smoking_detail_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTableWidget extends StatefulWidget {
  const CalendarTableWidget({Key? key}) : super(key: key);

  @override
  State<CalendarTableWidget> createState() => _CalendarTableWidgetState();
}

class _CalendarTableWidgetState extends State<CalendarTableWidget> {
  late final ValueNotifier<List<SmokingDetail>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final kSmokingDetails = LinkedHashMap<DateTime, List<SmokingDetail>>(
    equals: isSameDay,
    hashCode: SmokingDetail.getHashCode,
  )..addAll(
      {
        DateTime.now(): [
          SmokingDetail(date: DateTime.now(), excuse: 'excuse-1', total: 1),
          SmokingDetail(date: DateTime.now(), excuse: 'excuse-2', total: 2),
          SmokingDetail(date: DateTime.now(), excuse: 'excuse-3', total: 20),
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
        TableCalendar<SmokingDetail>(
          locale: "id_ID",
          firstDay: DateTime.now().subtract(const Duration(days: 7)),
          lastDay: DateTime.now(),
          calendarFormat: _calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.monday,
          focusedDay: _focusedDay,
          onFormatChanged: _onFormatChanged,
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: _onDaySelected,
          eventLoader: _getSmokingDetailsForDay,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Seminggu',
            CalendarFormat.twoWeeks: 'Bulan',
            CalendarFormat.week: '2 Minggu',
          },
          calendarStyle: const CalendarStyle(
            selectedDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.darkGreen,
            ),
            todayTextStyle: TextStyle(color: Colors.black),
            todayDecoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConst.lightGreen,
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
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConst.lightRed,
                    ),
                    child: Text(
                      events.first.sumTotal(events),
                      style: FontConst.small(
                        color: ColorConst.darkRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }
              return null;
            }),
          ),
        ),
        SizedBox(height: 10.h),
        ValueListenableBuilder<List<SmokingDetail>>(
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

  List<SmokingDetail> _getSmokingDetailsForDay(DateTime day) {
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

  List<Widget> _buildSmokingDetails(List<SmokingDetail> smokingDetails) {
    return smokingDetails.map((smokingDetail) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.0.h,
        ),
        decoration: BoxDecoration(
          color: ColorConst.lightGreen,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 30.w,
                    vertical: 25.h,
                  ),
                  children: [SmokingDetailDialog(smokingDetail: smokingDetail)],
                );
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: Text(
            smokingDetail.toString(),
            style: FontConst.subtitle(color: ColorConst.darkGreen),
          ),
        ),
      );
    }).toList();
  }
}