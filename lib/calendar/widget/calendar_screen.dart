import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:calendar/calendar/widget/month_calendar.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({super.key});

  /// Текущая дата.
  final DateTime today = DateTime.now();

  /// Список месячных контроллеров для управления выделением дат.
  final List<CalendarController> yearController =
      List.generate(12, (index) => CalendarController());

  /// Названия месяцев должны храниться в файлах локализации.
  /// А еще лучше использовать DateFormat из пакета intl.
  static const monthList = [
    'Январь',
    'Февраль',
    'Март',
    'Апрель',
    'Май',
    'Июнь',
    'Июль',
    'Август',
    'Сентябрь',
    'Октябрь',
    'Ноябрь',
    'Декабрь',
  ];

  /// Следует использовать DateFormat('EEEE').format(date); из пакета intl.
  static const weekDays = [
    'Пн',
    'Вт',
    'Ср',
    'Чт',
    'Пт',
    'Сб',
    'Вс',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfCalendarTheme(
          // Цвет рамки при наведении не меняется даже при кастомном цвете
          // выделения ячейки даты. Решается через тему или SfCalendarTheme.
          data: SfCalendarThemeData(
            selectionBorderColor: Colors.lightBlueAccent,
            todayHighlightColor: Colors.blueAccent,
          ),
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
                return Column(
                  children: [
                    // Кастомный заголовок для месяца взамен стандартного для
                    // SfCalendar, в котором нельзя сделать заголовок с большой
                    // буквы для русского языка. Также в SfCalendar название
                    // месяца и дней недели остаются кликабельными, даже если
                    // ничего не назначено.
                    MonthHeader(month: monthList[index], weekDays: weekDays),
                    // Для сохранения соотношения сторон элемента в GridView
                    // используем [Flexible], чтобы виджет Месяца не уползал
                    // за границы, выталкиваемый заголовком.
                    Flexible(
                      child: MonthCalendar(
                        month: index + 1,
                        currentDate: today,
                        controller: yearController[index],
                        onTap: (calendarTapDetails) {
                          // При выборе даты сбрасываем выбор для других месяцев.
                          for (CalendarController monthController
                              in yearController) {
                            if (monthController != yearController[index]) {
                              monthController.selectedDate = null;
                            }
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ),
    );
  }
}

/// Виджет заголовка и дней недели для месячного представления календаря.
class MonthHeader extends StatelessWidget {
  /// Виджет заголовка и дней недели для месячного представления календаря.
  const MonthHeader({
    super.key,
    required this.month,
    required this.weekDays,
  });

  final String month;
  final List<String> weekDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          month,
          style: const TextStyle(fontSize: 24),
        ),
        Flex(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          direction: Axis.horizontal,
          children: weekDays
              .map((day) => Text(day, style: const TextStyle(fontSize: 14)))
              .toList(),
        ),
      ],
    );
  }
}
