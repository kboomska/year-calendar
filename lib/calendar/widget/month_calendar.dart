import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final DateTime today = DateTime.now();

    /// Количество дней в месяце.
    ///
    /// Требутеся для установления параметра [maxDate], чтобы исключить
    /// возможность переключения месяца внутри одного виджета при
    /// выборе даты стрелками на клавиатуре.
    final int dayInMonth = DateTime(today.year, index + 2, 0).day;

    return SfCalendar(
      view: CalendarView.month,
      allowViewNavigation: false,
      firstDayOfWeek: 1,
      initialDisplayDate: DateTime(today.year, index + 1, today.day),
      // initialSelectedDate: ,
      showNavigationArrow: false,
      showDatePickerButton: false,
      viewNavigationMode: ViewNavigationMode.none,
      minDate: DateTime(today.year, index + 1, 1),
      maxDate: DateTime(today.year, index + 1, dayInMonth),
      // onSelectionChanged: ,
      dataSource: MeetingDataSource(_getDataSource()),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        // navigationDirection:
        showTrailingAndLeadingDates: false,
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(
    Meeting(
      'Conference',
      startTime,
      endTime,
      const Color(0xFF0F8644),
      false,
    ),
  );

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
