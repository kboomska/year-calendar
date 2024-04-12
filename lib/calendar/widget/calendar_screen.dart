import 'package:flutter/material.dart';

import 'package:calendar/calendar/widget/month_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

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
              return MonthCalendar(index: index);
            },
          );
        }),
      ),
    );
  }
}
