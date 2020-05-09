class Recipe {
  String name = '';
  String description = '';
  String imageURL = '';
  String url = '';
  List<String> directions = [];
  List<String> ingredients = [];
  Recipe({
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
}
