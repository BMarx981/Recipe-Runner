class Event {
  final String delimiter = '||?';

  DateTime date;
  int id;
  String name = '';
  int isDoneDB = 0;
  bool isDone = false;
  Event({this.id, this.date, this.name, this.isDone});

  Event.fromDB(Map<String, dynamic> map) {
    date = getDateTimeFromDB(map['date']);
    name = map['name'] ?? '';
    id = map['id'] ?? 0;
    isDone = isDoneDB == 0;
  }

  DateTime getDateTimeFromDB(String input) {
    List<String> list = input?.split(delimiter) ?? [];
    var d = DateTime.now();
    if (list.isNotEmpty) {
      return DateTime(
        int.parse(list[0]),
        int.parse(list[1]),
        int.parse(list[2]),
      );
    } else {
      return d;
    }
  }

  Map<String, dynamic> toMapForDB() {
    print('toMapforDb Name: $name');
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['date'] = '${date.year}$delimiter${date.month}$delimiter${date.day}';
    map['name'] = name;
    map['isDone'] = 0;
    return map;
  }
}
