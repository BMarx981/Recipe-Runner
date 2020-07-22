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
  List items = [];
  DateTime _currentDate = DateTime.now();
  TextEditingController _editingController = TextEditingController();
  CalendarCarousel calendarCarousel;

  addEvent(DateTime date, String title) {
    Event ev = Event(
      date: date,
      title: title,
      dot: Container(
        margin: EdgeInsets.symmetric(horizontal: 1.0),
        color: Colors.red,
        height: 5.0,
        width: 5.0,
      ),
    );
    _eventList.add(
      date,
      ev,
    );
    items.add(ev.title);
  }

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
        title: 'Chicken',
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.amberAccent,
          ),
          child: calendarCarousel = CalendarCarousel<Event>(
            onDayPressed: (DateTime date, List<Event> events) {
              items.clear();
              setState(() {
                _currentDate = date;
                events.forEach((event) => items.add(event.title));
              });
            },
            prevDaysTextStyle: TextStyle(
              fontSize: 16,
              color: Colors.pinkAccent,
            ),
            inactiveDaysTextStyle: TextStyle(
              color: Colors.tealAccent,
              fontSize: 16,
            ),
            showOnlyCurrentMonthDate: true,
            weekendTextStyle: null,
            thisMonthDayBorderColor: Colors.grey,
            headerText:
                '${DateFormat.LLLL().format(_currentDate)} Weekly Planner',
            weekFormat: true,
            markedDatesMap: _eventList,
            height: 200.0,
            showIconBehindDayText: true,
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
            markedDateMoreShowTotal: true,
            markedDateIconMargin: 9,
            markedDateIconOffset: 3,
            onDayLongPressed: (DateTime date) {
              setState(() {
                _currentDate = date;
                buildShowModalBottomSheet(context, _currentDate);
              });
            },
          ),
        ),
        SizedBox(height: 18),
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
            },
          ),
        ),
      ],
    );
  }

  Future buildShowModalBottomSheet(BuildContext context, DateTime date) {
    return showModalBottomSheet(
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
                  setState(() {
                    addEvent(date, _editingController.text);
                    // items.add(_editingController.text);
                  });
                  _editingController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      }, //builder
    );
  }
}
