import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';
import 'package:recipe_writer/utils/networking.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'search_result_tile.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController tc = TextEditingController();

  RecipeTextField searchfield;

  Map<String, dynamic> respMap = {};

  List<Widget> _searchedList = [];
  List<Recipe> _searchedRecipes = [];

  initState() {
    super.initState();
    Provider.of<MainModel>(context, listen: false).searchResults.forEach(
          (recipe) => _searchedList.add(
            SearchResultTile(rec: recipe),
          ),
        );
  }

  getNetworkData(String query) async {
    Networking n = Networking();
    respMap = await n.getRequest(query);
    List<dynamic> hits = respMap['hits'];
    hits.forEach((hit) {
      Map<String, dynamic> recipe = hit['recipe'];
      List<String> ingredients = List<String>.from(recipe['ingredientLines']);
      Recipe rec = Recipe(
        name: recipe['label'],
        imageURL: recipe['image'],
        url: recipe['url'],
      );
      rec.ingredients = ingredients;
      rec.description = '';
      setState(() => _searchedList.insert(0, SearchResultTile(rec: rec)));
      _searchedRecipes.add(rec);
    });
    Provider.of<MainModel>(context, listen: false)
        .searchResults
        .addAll(_searchedRecipes);
  }

  @override
  Widget build(BuildContext context) {
    searchfield = RecipeTextField(
      text: 'Find the recipe you are looking for here.',
      controller: tc,
    );
    return Container(
      decoration: BoxDecoration(gradient: colorGrad),
      child: Column(
        children: <Widget>[
          searchfield,
          SizedBox(
            height: 22,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: 60,
            child: RaisedButton(
              //Done button
              elevation: 5.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Submit',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              color: Colors.grey[400],
              onPressed: () {
                searchfield.toggleIconColor();
                getNetworkData(tc.text);
                tc.clear();
              },
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 2),
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: _searchedList.length,
                itemBuilder: (context, index) {
                  return _searchedList[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
