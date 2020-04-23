class SearchModel {
  String label;
  String image;
  String sourceID;
  String sourceURL;
  List<String> ingredients;

  SearchModel({
    this.label,
    this.image,
    this.sourceID,
    this.sourceURL,
    this.ingredients,
  });

  @override
  String toString() {
    return 'Label: $label, Image: $image, SourceID: $sourceID, SourceURL: $sourceURL, Ingredients: $ingredients';
  }
}
