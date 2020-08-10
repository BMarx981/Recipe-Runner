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
  addEvent(DateTime date, String title) {
    List list = _events[DateTime(date.year, date.month, date.day)];
    if (list == null) {
      _events[DateTime(date.year, date.month, date.day)] = [
        {'name': title, 'isDone': false}
      ];
    } else {
      list.add({'name': title, 'isDone': false});
    }
    _handleNewDate(date);
  }

  List _selectedEvents = [];

  Map<DateTime, List<dynamic>> _events = {
    DateTime(2020, 8, 5): [
      {'name': 'Apples', 'isDone': true},
    ],
    DateTime(2020, 8, 6): [
      {'name': 'Broccoli', 'isDone': false},
      {'name': 'Shrimp', 'isDone': true},
    ]
  };
  DateTime _selectedDay;

  void _handleNewDate(DateTime date) {
    setState(() {
      _selectedDay = DateTime(date.year, date.month, date.day);
      _selectedEvents = _events[_selectedDay] ?? [];
    });
  }

  @override
  void initState() {
    _handleNewDate(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            onDateSelected: (date) => _handleNewDate(date),
            isExpandable: true,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            todayColor: Colors.blue,
            eventColor: Colors.grey,
            dayOfWeekStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Center(
          child: FlatButton(
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: red,
              ),
              child: Center(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            onPressed: () {
              modalSheet(context);
            },
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: (_selectedEvents.length == 0)
              ? SizedBox(height: 1)
              : buildListContainer(),
        )
      ],
    );
  }

  Container buildListContainer() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(
                  index.toString() + _selectedEvents[index]['name'].toString()),
              onDismissed: (direction) {
                // Remove the item from the data source.
                setState(() {
                  _selectedEvents.removeAt(index);
                });
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "${_selectedEvents[index]['name'].toString()} dismissed"),
                  ),
                );
              },
              child: Center(
                child: Container(
                  child: Text(
                    _selectedEvents[index]['name'].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: white,
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
            color: Colors.amberAccent,
          ),
          itemCount: _selectedEvents.length,
        ),
      ),
    );
  }

  void modalSheet(BuildContext context) {
    TextEditingController controller = TextEditingController();
    showModalBottomSheet(
        backgroundColor: Color(0x00FFFF54),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: red,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: white,
                      ),
                    )
                  ],
                ),
                TextField(
                  autofocus: true,
                  style: TextStyle(
                    color: white,
                  ),
                  cursorColor: white,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      color: white,
                    ),
                    fillColor: white,
                    focusColor: white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: white,
                      ),
                    ),
                    hintText: 'Enter a recipe',
                  ),
                  controller: controller,
                ),
                SizedBox(height: 20),
                FlatButton(
                  onPressed: () {
                    addEvent(_selectedDay, controller.text);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(
                        Radius.circular(35),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Submit',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
