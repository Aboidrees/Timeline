import 'package:flutter/material.dart';
import 'package:timeline/helpers/const.dart';
import 'package:timeline/helpers/size_config.dart';
import 'package:timelines/timelines.dart';

class DayTimeline extends StatelessWidget {
  DayTimeline({this.periods});

  final List<dynamic> periods;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return periods == null
        ? Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.yellowAccent,
            child: Text('No Data'),
          )
        : SingleChildScrollView(
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(color: primaryColor, nodePosition: 0.2, indicatorPosition: 0.0),
              builder: TimelineTileBuilder.connectedFromStyle(
                oppositeContentsBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${DateTime.parse(periods[index]['start']).hour.toString().padLeft(2, '0')}:${DateTime.parse(periods[index]['start']).minute.toString().padLeft(2, '0')}",
                        style: TextStyle(fontFamily: 'FiraCode', fontWeight: FontWeight.bold, fontSize: defaultSize * 1.6),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded),
                      Text(
                        "${DateTime.parse(periods[index]['end']).hour.toString().padLeft(2, '0')}:${DateTime.parse(periods[index]['end']).minute.toString().padLeft(2, '0')}",
                        style: TextStyle(fontFamily: 'FiraCode', fontWeight: FontWeight.bold, fontSize: defaultSize * 1.6),
                      ),
                    ],
                  ),
                ),
                contentsBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          periods[index]['periodTitle'],
                          style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor, fontSize: defaultSize * 2, letterSpacing: 0.5),
                        ),
                        SizedBox(height: defaultSize),
                        Text(periods[index]['desc']),
                      ],
                    ),
                  ),
                ),
                connectorStyleBuilder: (context, index) => (index % 2 == 1) ? ConnectorStyle.dashedLine : ConnectorStyle.solidLine,
                indicatorStyleBuilder: (context, index) => IndicatorStyle.outlined,
                itemCount: periods.length,
              ),
            ),
          );
  }
}
