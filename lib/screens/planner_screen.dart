import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:intl/intl.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  addEvent(DateTime date, String title) {
    _eventList.add(
      date,
      Event(
        date: date,
        title: title,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
    );
  }

  DateTime _currentDate = DateTime.now();
  EventList<Event> _eventList = EventList(events: {
    DateTime(2020, 7, 21): [
      Event(
        date: DateTime(2020, 7, 21),
        title: 'Tilapia',
        // icon: _eventIcon,
        dot: Container(
          margin: EdgeInsets.symmetric(horizontal: 1.0),
          color: Colors.red,
          height: 5.0,
          width: 5.0,
        ),
      ),
      Event(
        date: DateTime(2020, 7, 21),
        title: 'Tilapia',
        // icon: _eventIcon,
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
        // icon: _eventIcon,
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
  TextEditingController _editingController = TextEditingController();

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
              items.clear();
              this.setState(() {
                _currentDate = date;
                events.forEach((event) => items.add(event.title));
              });
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
            markedDateIconMaxShown: 1,
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
            markedDateIconMargin: 9,
            markedDateIconOffset: 3,
            onDayLongPressed: (DateTime date) {
              showModalBottomSheet(
                elevation: 5.0,
                context: context,
                builder: (context) {
                  String dateString = DateFormat('MM/dd/yyyy').format(date);
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Text('Enter a recipe for $dateString'),
                        TextField(
                          controller: _editingController,
                        ),
                        RaisedButton(
                          child: Text('Add'),
                          onPressed: () {
                            this.setState(() {
                              addEvent(date, _editingController.text);
                              items.add(_editingController.text);
                            });
                            _editingController.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                }, //builder
              ); // end showBottomSheet
            },
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
