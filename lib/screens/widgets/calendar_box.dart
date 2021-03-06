import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/day_builder.dart';

class CalendarBoxWidget extends StatefulWidget {
  const CalendarBoxWidget({
    Key key,
    @required this.calendarController,
    @required this.periods,
    @required this.updateSelectedDayPeriod,
  }) : super(key: key);

  final CalendarController calendarController;
  final Map<DateTime, List<dynamic>> periods;
  final Function updateSelectedDayPeriod;

  @override
  _CalendarBoxWidgetState createState() => _CalendarBoxWidgetState();
}

class _CalendarBoxWidgetState extends State<CalendarBoxWidget> {
  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDay = widget.calendarController.selectedDay ?? DateTime.now();

    double defaultSize = SizeConfig.defaultSize;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  '${weekDays[1][today.weekday - 1]}DAY',
                  style: TextStyle(fontFamily: 'FiraCode', fontSize: defaultSize * 1.8, color: primaryColor),
                ),
                Text(
                  today.day.toString().padLeft(2, '0'),
                  style: TextStyle(fontFamily: 'FiraCode', fontSize: defaultSize * 7.5, color: primaryColor),
                ),
                Text(
                  '${months[0][today.month - 1]}, ${today.year}',
                  style: TextStyle(fontFamily: 'FiraCode', fontSize: defaultSize * 1.8, color: primaryColor),
                )
              ],
            ),
            Container(
              width: defaultSize * 28,
              height: defaultSize * 34,
              alignment: Alignment.center,
              child: TableCalendar(
                events: widget.periods,
                calendarController: widget.calendarController,
                initialCalendarFormat: CalendarFormat.month,
                formatAnimation: FormatAnimation.scale,
                availableCalendarFormats: {CalendarFormat.month: "Month"},
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(color: primaryColor, fontSize: defaultSize * 2.6),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(dowTextBuilder: (weekDay, locale) => weekDays[0][weekDay.weekday - 1]),
                startingDayOfWeek: StartingDayOfWeek.friday,
                weekendDays: const [DateTime.friday, DateTime.saturday],
                onDaySelected: (DateTime date, List periods, List holidays) {
                  setState(() {
                    widget.updateSelectedDayPeriod(periods);
                    widget.calendarController.setSelectedDay(date);
                  });
                },
                builders: CalendarBuilders(
                  dayBuilder: (context, date, events) => DayBuilderWidget(date: date),
                  todayDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'today'),
                  selectedDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'selected'),
                  weekendDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'weekend'),
                  holidayDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'holiday'),
                  outsideDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'outside'),
                  outsideWeekendDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'weekend'),
                  outsideHolidayDayBuilder: (context, date, events) => DayBuilderWidget(date: date, dayType: 'outside'),
                  markersBuilder: (context, date, events, selectedEvents) {
                    return [
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Container(
                          width: defaultSize * 1.8,
                          height: defaultSize * 1.8,
                          child: Center(child: Text(events.length.toString(), style: TextStyle(color: Colors.white))),
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(defaultSize)),
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "TODAY: ${weekDays[1][selectedDay.weekday - 1]}DAY - ${months[1][selectedDay.weekday - 1]} ${selectedDay.day.toString().padLeft(2, '0')}, ${selectedDay.year}",
            style: TextStyle(fontSize: 18.0, color: Colors.black54),
          ),
        )
      ],
    );
  }
}
