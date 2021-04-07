import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeline/const.dart';
import 'package:timeline/models/period.dart';
import 'package:timeline/size_config.dart';

class AddPeriod extends StatefulWidget {
  const AddPeriod({Key key, @required this.selectedDay}) : super(key: key);

  final DateTime selectedDay;
  @override
  _AddPeriodState createState() => _AddPeriodState();
}

class _AddPeriodState extends State<AddPeriod> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    double _timePickerWidth = (SizeConfig.screenWidth / 2) - defaultSize * 5;
    // Title Controller
    TextEditingController _titleController = TextEditingController();

    // Time period Controller
    DateTime _startTime = DateTime.now();
    DateTime _endTime = DateTime.now();

    // Events
    Map<DateTime, List<Period>> _periods;

    // print(widget.selectedDay);
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(defaultSize * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultSize * 4), topRight: Radius.circular(defaultSize * 4)),
          boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.black54)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: defaultSize * 2),
            // Text(
            //   "Add Study Period",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: defaultSize * 2, fontWeight: FontWeight.bold, color: primaryColor),
            // ),
            TextField(controller: _titleController, autofocus: true),
            SizedBox(height: defaultSize * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Start Time',
                  style: TextStyle(fontSize: defaultSize * 2, color: primaryColor),
                ),
                Text(
                  'End Time',
                  style: TextStyle(fontSize: defaultSize * 2, color: primaryColor),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: defaultSize * 10,
                  width: _timePickerWidth,
                  child: CupertinoDatePicker(
                      initialDateTime: _startTime,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (time) {
                        setState(() {
                          _startTime = time;
                        });
                      }),
                ),
                SizedBox(
                  height: defaultSize * 10,
                  width: _timePickerWidth,
                  child: CupertinoDatePicker(
                      initialDateTime: _endTime,
                      mode: CupertinoDatePickerMode.time,
                      onDateTimeChanged: (time) {
                        setState(() {
                          _endTime = time;
                        });
                      }),
                )
              ],
            ),
            SizedBox(height: defaultSize * 2),

            // ignore: deprecated_member_use
            FlatButton(
              color: primaryColor,
              onPressed: () {
                setState(() {
                  if (_titleController.text.isEmpty) return;
                  Period studyPeriod = Period(
                    periodTitle: _titleController.text,
                    start: _startTime,
                    end: _endTime,
                  );

                  if (_periods[widget.selectedDay] != null) {
                    _periods[widget.selectedDay].add(studyPeriod);
                  } else {
                    _periods[widget.selectedDay] = [studyPeriod];
                  }

                  // _titleController.clear();
                  // Navigator.pop(context);
                });
              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: defaultSize * 2),
          ],
        ),
      ),
    );
  }
}

//               if (_eventController.text.isEmpty) return;
//               if (_periods[_calendarController.selectedDay] != null) {
//                 _periods[_calendarController.selectedDay].add(_eventController.text);
//               } else {
//                 _periods[_calendarController.selectedDay] = [_eventController.text];
//               }
//               _eventController.clear();
//               Navigator.pop(context);
