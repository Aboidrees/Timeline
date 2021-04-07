import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:timeline/screens/Home/widgets/add_study_period.dart';
import 'package:timeline/screens/Home/widgets/calendar_box.dart';
import 'package:timeline/size_config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {};
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), leading: Icon(Icons.menu)),
      body: SafeArea(
        child: Column(
          children: [
            CalendarBoxWidget(calendarController: _calendarController, events: _events, selectedEvents: _selectedEvents),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(defaultSize * 2),
                    topRight: Radius.circular(defaultSize * 2),
                  ),
                  boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.black54)],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _showAddDialog(context);
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 0),
                child: AddPeriod(
                  selectedDay: _calendarController.selectedDay,
                ),
              ),
            ),
          );
        },
        tooltip: 'Add a New Studing Period',
        child: Icon(Icons.add),
      ),
    );
  }
}
  // _showAddDialog(context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       content: TextField(controller: _eventController),
  //       actions: [
  //         // ignore: deprecated_member_use
  //         FlatButton(
  //           onPressed: () {
  //             setState(() {
  //               if (_eventController.text.isEmpty) return;
  //               if (_events[_calendarController.selectedDay] != null) {
  //                 _events[_calendarController.selectedDay].add(_eventController.text);
  //               } else {
  //                 _events[_calendarController.selectedDay] = [_eventController.text];
  //               }
  //               _eventController.clear();
  //               Navigator.pop(context);
  //             });
  //           },
  //           color: primaryColor,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SizeConfig.defaultSize / 2)),
  //           child: Text('save'),
  //         ),
  //       ],
  //     ),
  //   );
  // }