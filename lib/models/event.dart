class Event {
  final String delimiter = '||?';

  DateTime date;
  int id;
  List<String> names = [];
  int isDoneDB = 0;
  bool isDone = false;
  Event({this.id, this.date, this.names, this.isDone});

  Event.fromDB(Map<String, dynamic> map) {
    date = getDateTimeFromDB(map['date']);
    names = getNamesFromDB(map['names']);
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

  List<String> getNamesFromDB(String input) {
    return input?.split(delimiter) ?? [];
  }

  Map<String, dynamic> toMapForDB() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['date'] = '${date.year}$delimiter${date.month}$delimiter${date.day}';
    map['names'] = processNamesArray(names);
    map['isDone'] = 0;
    return map;
  }

  String processNamesArray(List<String> list) {
    if (list.length == 0) return ' ';
    return list.join(delimiter);
  }
}
