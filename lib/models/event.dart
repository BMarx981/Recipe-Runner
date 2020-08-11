class Event {
  final int id;
  final DateTime date;
  final List<String> names;
  final String delimiter = '||?';

  Event({this.id, this.date, this.names});

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
