import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:recipe_writer/models/event.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/utils/db_helper.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  final _dbHelper = DatabaseHelper.instance;

  List _selectedEvents = [];

  Map<DateTime, List<dynamic>> _events = {};
  DateTime _selectedDay;

  addEvent(DateTime date, String title) {
    DateTime formattedDate = getFormattedDate(date);
    List list = _events[formattedDate];
    if (list == null) {
      list = [
        {'name': title, 'isDone': false}
      ];
      _events[formattedDate] = list;
    } else {
      _events[formattedDate].add({'name': title, 'isDone': false});
    }
    _addEventToDB(date, title);
    _handleNewDate(date);
  }

  _addEventToDB(DateTime date, String title) async {
    DateTime formattedDate = getFormattedDate(date);
    Event event = Event(date: formattedDate, isDone: false);
    event.name = title;
    event.isDoneDB = event.isDone ? 1 : 0;
    event.id = await _dbHelper.insertPlannerRow(event);
  }

  DateTime getFormattedDate(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  Future populateEvents() async {
    var table = await _dbHelper.getPlannerTable();
    table.forEach((row) {
      var eve = Event.fromDB(row);
      Map<String, dynamic> inputMap = {'name': eve.name, 'isDone': false};
      if (_events[eve.date] == null) {
        _events[eve.date] = [];
        _events[eve.date].add(inputMap);
      } else {
        _events[eve.date].add(inputMap);
      }
    });
    _handleNewDate(DateTime.now());
  }

  void _handleNewDate(DateTime date) {
    setState(() {
      _selectedDay = DateTime(date.year, date.month, date.day);
      _selectedEvents = _events[_selectedDay] ?? [];
    });
  }

  @override
  void initState() {
    super.initState();
    populateEvents();
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
            var element = _selectedEvents[index];
            return (_selectedEvents.length == 0)
                ? SizedBox(height: 1)
                : Dismissible(
                    key: Key(
                        DateTime.now().toString() + element['name'].toString()),
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      setState(() {
                        _dbHelper.deletePlannerRow(element['id']);
                        _selectedEvents.removeAt(index);
                      });
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text("${element['name'].toString()} dismissed"),
                        ),
                      );
                    },
                    child: Center(
                      child: Container(
                        child: Text(
                          element['name'].toString(),
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
      isScrollControlled: true,
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 400),
          curve: Curves.decelerate,
          child: Container(
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: red,
            ),
            child: Wrap(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
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
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Icon(
                            Icons.close,
                            color: white,
                          ),
                        ),
                      ],
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
              ],
            ),
          ),
        );
      },
    );
  }
}
