import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeline/helpers/funcs.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timeline/screens/widgets/add_study_period.dart';
import 'package:timeline/screens/widgets/calendar_box.dart';
import 'package:timeline/screens/widgets/timeline.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _periods;
  List<dynamic> _selectedDayPeriods;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _selectedDayPeriods = [];
    _periods = {};
    _initPrefs();
  }

  void _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _periods = Map<DateTime, List<dynamic>>.from(decodePeriods(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  void _updateSelectedDayPeriod(List<dynamic> selectedDayPeriods) {
    setState(() {
      _selectedDayPeriods = selectedDayPeriods;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    _selectedDayPeriods.sort((a, b) => DateTime.parse(a['start']).compareTo(DateTime.parse(b['start'])));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: Icon(Icons.menu),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            CalendarBoxWidget(
              calendarController: _calendarController,
              periods: _periods,
              updateSelectedDayPeriod: _updateSelectedDayPeriod,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultSize * 2), topRight: Radius.circular(defaultSize * 2)),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.black54)],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DayTimeline(periods: _selectedDayPeriods),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final data = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 0),
                child: AddPeriod(
                  selectedPeriods: _selectedDayPeriods,
                  selectedDay: _calendarController.selectedDay,
                ),
              ),
            ),
          );

          setState(() {
            if (data != null) {
              (_periods.containsKey(_calendarController.selectedDay)) ? _periods[_calendarController.selectedDay].add(data) : _periods[_calendarController.selectedDay] = [data];
              prefs.setString('events', jsonEncode(encodePeriods(_periods)));
              _selectedDayPeriods = _periods[_calendarController.selectedDay];
              // rebuildAllChildren(context);
            }
          });
        },
        tooltip: 'Add a New Studding Period',
        child: Icon(Icons.add),
      ),
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
