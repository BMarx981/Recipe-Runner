class Event {
  final int id;
  final DateTime date;
  final Map<String, List<String>> recipesOnDate;

  Event({this.id, this.date, this.recipesOnDate});

  // Map<String, dynamic> toMap() {
  //   String listString = '';
  //   return {
  //     'name':

  //   };
  // }
}
