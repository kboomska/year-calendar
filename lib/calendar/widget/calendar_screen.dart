import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:calendar/calendar/widget/month_calendar.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  /// Текущая дата.
  final DateTime today = DateTime.now();

  /// Список месячных контроллеров для управления выделением дат.
  final List<CalendarController> yearController =
      List.generate(12, (index) => CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemBuilder: (context, index) {
              return MonthCalendar(
                month: index + 1,
                currentDate: today,
                controller: yearController[index],
                onTap: (calendarTapDetails) {
                  // При выборе даты сбрасываем выбор для других месяцев.
                  for (CalendarController monthController in yearController) {
                    if (monthController != yearController[index]) {
                      monthController.selectedDate = null;
                    }
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}
