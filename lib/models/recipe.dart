class Recipe {
  String name;
  String description;
  String symbol;
  String url;
  List<String> directions = [];
  List<String> ingredients = [];
  Recipe({this.name, this.description, this.symbol = '🍔', this.url});
}
