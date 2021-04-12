import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timeline/const.dart';
import 'package:timeline/size_config.dart';

class AddPeriod extends StatefulWidget {
  const AddPeriod({Key key, @required this.selectedDay, @required this.selectedPeriods}) : super(key: key);

  final DateTime selectedDay;
  final List<dynamic> selectedPeriods;

  @override
  _AddPeriodState createState() => _AddPeriodState();
}

class _AddPeriodState extends State<AddPeriod> {
  // Title Controller
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  // Time period Controller
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    double _timePickerWidth = (SizeConfig.screenWidth / 2) - defaultSize * 5;
    return Container(
      color: Color(0xFF757575),
      child: Container(
        padding: EdgeInsets.all(defaultSize * 3),
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade100, Colors.white],
          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Start Time', style: TextStyle(fontSize: defaultSize * 2, color: primaryColor)),
                Text('End Time', style: TextStyle(fontSize: defaultSize * 2, color: primaryColor)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  height: defaultSize * 10,
                  width: _timePickerWidth,
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (time) => setState(() => _startTime = time),
                  ),
                ),
                SizedBox(
                  height: defaultSize * 10,
                  width: _timePickerWidth,
                  child: CupertinoDatePicker(
                    initialDateTime: _endTime,
                    minimumDate: _startTime,
                    mode: CupertinoDatePickerMode.time,
                    onDateTimeChanged: (time) => setState(() => _endTime = time),
                  ),
                ),
              ],
            ),
            SizedBox(height: defaultSize * 2.5),
            TextFormField(
              controller: _titleController,
              validator: (value) => (value.isEmpty) ? "Please Enter title" : null,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: defaultSize * 1.8),
              decoration: InputDecoration(
                labelText: "Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultSize)),
              ),
            ),
            SizedBox(height: defaultSize * 2.5),
            TextFormField(
              controller: _descController,
              minLines: 3,
              maxLines: 5,
              validator: (value) => (value.isEmpty) ? "Please Enter description" : null,
              style: TextStyle(fontFamily: 'Montserrat', fontSize: defaultSize * 1.8),
              decoration:
                  InputDecoration(labelText: "Description", border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultSize))),
            ),
            SizedBox(height: defaultSize * 2),

            // ignore: deprecated_member_use
            FlatButton(
              color: primaryColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultSize)),
              onPressed: () {
                var checkResult = _checkPeriodOverlapping(widget.selectedPeriods, _startTime, _endTime);

                if (checkResult != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                        'The selected period is overlapping with ${checkResult['start'].hour.toString().padLeft(2, '0')}:${checkResult['start'].minute.toString().padLeft(2, '0')}   to   ${checkResult['end'].hour.toString().padLeft(2, '0')}:${checkResult['end'].minute.toString().padLeft(2, '0')}'),
                  );
                  return false;
                }

                if (DateTimeRange(start: _startTime, end: _endTime).duration.inMinutes < 1) {
                  showDialog(context: context, builder: (BuildContext context) => SimpleDialog('Start time is less than End time'));
                  return false;
                }

                if (_titleController.text.isEmpty) {
                  showDialog(context: context, builder: (BuildContext context) => SimpleDialog('period title should not be empty'));
                  return false;
                }

                if (_descController.text.isEmpty) {
                  showDialog(context: context, builder: (BuildContext context) => SimpleDialog('period desc should not be empty'));
                  return false;
                }
                // return false;

                Map<String, dynamic> studyPeriod = {
                  "periodTitle": _titleController.text,
                  "start": _startTime.toIso8601String(),
                  "end": _endTime.toIso8601String(),
                  "desc": _descController.text,
                };

                Navigator.pop(context, studyPeriod);
              },
              child: Text('Add', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _checkPeriodOverlapping(List selectedPeriods, DateTime startTime, DateTime endTime) {
    for (int i = 0; i < selectedPeriods.length; i++) {
      DateTime __startTime = DateTime.parse(selectedPeriods[i]['start']);
      DateTime __endTime = DateTime.parse(selectedPeriods[i]['end']);
      if ((startTime.isAfter(__startTime) && startTime.isBefore(__endTime)) ||
          (endTime.isAfter(__startTime) && endTime.isBefore(__endTime))) {
        return {'start': __startTime, 'end': __endTime};
      }
    }
    return null;
  }
}

class SimpleDialog extends StatelessWidget {
  final message;
  SimpleDialog(this.message);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //title: Text('Alert'),

      content: Container(
        height: SizeConfig.screenHeight / 12,
        child: Center(child: Text(message, textAlign: TextAlign.center)),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        TextButton(child: Icon(Icons.close, color: primaryColor), onPressed: () => Navigator.of(context).pop()),
      ],
    );
  }
}
