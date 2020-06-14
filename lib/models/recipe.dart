class Recipe {
  String name = '';
  String description = '';
  String imageURL = '';
  String url = '';
  int id = 0;
  List<String> directions = [];
  List<String> ingredients = [];
  Recipe({
    this.id,
    this.name,
    this.description,
    this.imageURL = '🍔',
    this.url,
    this.ingredients,
    this.directions,
  });

  factory Recipe.fromJson(Map<String, dynamic> parsedJson) {
    return Recipe(name: parsedJson['title'], imageURL: parsedJson['image']);
  }

  Recipe.fromDB(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    description = map['description'];
    url = map['url'];
    imageURL = map['image'];
    ingredients = splitMap(map['ingredients']);
    directions = splitMap(map['directions']);
  }

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name ?? ' ';
    map['description'] = description ?? ' ';
    map['url'] = url ?? ' ';
    map['image'] = imageURL ?? ' ';
    map['ingredients'] = processArrayRow(ingredients);
    map['directions'] = processArrayRow(directions);
    return map;
  }

  String processArrayRow(List<String> list) {
    if (list.length == 0) return ' ';
    // String str = '';
    // list.forEach((input) => str += input + '||?');
    return list.join('||?');
  }

  List<String> splitMap(String input) {
    List<String> list = input.split('||?');
    list.removeLast();
    return list;
  }
}
