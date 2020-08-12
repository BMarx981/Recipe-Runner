class Event {
  final DateTime date;
  final String delimiter = '||?';

  int id;
  List<String> names;
  bool isDone;
  Event({this.id, this.date, this.names, this.isDone});

  Map<String, dynamic> toMapForDB() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['date'] = '${date.year}$delimiter${date.month}$delimiter${date.day}';
    map['names'] = processNamesArray(names);
    return map;
  }

  String processNamesArray(List<String> list) {
    if (list.length == 0) return ' ';
    return list.join(delimiter);
  }
}
