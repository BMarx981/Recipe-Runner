import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:recipe_writer/utils/colors.dart';
// ignore: unused_import
import 'package:recipe_writer/models/event.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  addEvent(DateTime date, String title) {}

  List _selectedEvents = [];

  Map<DateTime, List<dynamic>> _events = {
    DateTime(2020, 8, 5): [
      {'name': 'Apples', 'isDone': true},
    ],
    DateTime(2020, 8, 6): [
      {'name': 'Broccoli', 'isDone': true},
      {'name': 'Shrimp', 'isDone': true},
    ]
  };
  DateTime _selectedDay;

  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.amberAccent,
          ),
          child: Calendar(
            initialDate: DateTime.now(),
            startOnMonday: true,
            weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            events: _events,
            onRangeSelected: (range) =>
                print("Range is ${range.from}, ${range.to}"),
            onDateSelected: (date) => _handleNewDate(date),
            isExpandable: true,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            todayColor: Colors.blue,
            eventColor: Colors.grey,
            dayOfWeekStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: white),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Container(
                        child: Text(
                          _selectedEvents[index]['name'].toString(),
                          style: TextStyle(
                            fontSize: 20,
                            color: white,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.amberAccent,
                      ),
                  itemCount: _selectedEvents.length),
            ),
          ),
        )
      ],
    );
  }
}
