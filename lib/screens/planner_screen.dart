import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.amberAccent,
              ),
              child: CalendarCarousel<Event>(
                onDayPressed: (DateTime date, List<Event> events) {
                  this.setState(() => _currentDate = date);
                  events.forEach((event) => print(event.title));
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
                headerText: 'Weekly Planner',
                weekFormat: true,
                // markedDatesMap: _markedDateMap,
                height: 200.0,
                // selectedDateTime: _currentDate2,
                showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
                customGridViewPhysics: NeverScrollableScrollPhysics(),
                markedDateShowIcon: true,
                markedDateIconMaxShown: 2,
                selectedDayTextStyle: TextStyle(
                  color: Colors.yellow,
                ),
                todayTextStyle: TextStyle(
                  color: Colors.blue,
                ),
                markedDateIconBuilder: (event) {
                  return event.icon;
                },
                minSelectedDate: _currentDate.subtract(Duration(days: 360)),
                maxSelectedDate: _currentDate.add(Duration(days: 360)),
                todayButtonColor: Colors.transparent,
                todayBorderColor: Colors.red,
                markedDateMoreShowTotal:
                    true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
