import 'package:flutter/material.dart';
import 'package:timeline/const.dart';
import 'package:timeline/size_config.dart';

class DayBuilderWidget extends StatelessWidget {
  DayBuilderWidget({
    Key key,
    this.date,
    this.dayType,
  }) : super(key: key);

  final DateTime date;
  final String dayType;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return Container(
      alignment: Alignment.center,
      child: Text(
        date.day.toString(),
        style: TextStyle(
          fontSize: defaultSize * 2,
          fontFamily: 'FiraCode',
          color: dayColors[dayType],
          fontWeight: ['selected', 'today'].contains(dayType) ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      decoration: BoxDecoration(
        color: dayType == 'selected' ? primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(defaultSize * 2),
        border: Border.all(
          color: dayType == 'today' ? primaryColor : Colors.white,
          width: dayType == 'today' ? defaultSize / 3 : 0.0,
        ),
      ),
    );
  }
}
