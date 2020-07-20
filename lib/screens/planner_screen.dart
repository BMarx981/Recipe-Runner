import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:recipe_writer/utils/colors.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  DateTime _currentDate = DateTime.now();
  // Map<DateTime, List<String>> _itemsMap = Map<DateTime, List<String>>();
  EventList<Event> _eventList = EventList(events: {
    DateTime(2020, 7, 21): [
      Event(
        date: DateTime(2020, 7, 21),
        title: 'Tilapia',
        icon: _eventIcon,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
      Event(
        date: DateTime(2020, 7, 21),
        title: 'Pancakes',
        icon: _eventIcon,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
    ],
  });
  List items = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.amberAccent,
          ),
          child: CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() {
                _currentDate = date;
              });
              events.forEach((event) => items.add(event.title));
            },
            weekendTextStyle: null,
            thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
            headerText: 'Weekly Planner',
            weekFormat: true,
            markedDatesMap: _eventList,
            height: 200.0,
            // selectedDateTime: _currentDate2,
            showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
            customGridViewPhysics: NeverScrollableScrollPhysics(),
            markedDateShowIcon: true,
            markedDateIconMaxShown: 2,
            selectedDayTextStyle: TextStyle(
              color: Colors.black,
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
        SizedBox(height: 8),
        Container(
          child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                    color: white,
                  ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Text(
                      items[index] ?? ' ',
                      style: TextStyle(
                        color: white,
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
