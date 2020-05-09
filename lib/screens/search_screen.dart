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

  List<String> extractDirections(List list) {
    List<String> steps = [];
    list.forEach((obj) {
      List<dynamic> stepsData = obj['steps'];
      stepsData.forEach((step) {
        steps.add(step['step']);
      });
    });
    debugPrint('getNetworkData ${steps.toString()}', wrapWidth: 1000);
    return steps;
  }

  getNetworkData(String query) async {
    Networking n = Networking();
    respMap = await n.getRequest(query);
    List<dynamic> results = respMap['results'];
    results.forEach((result) async {
      dynamic id = result['id'];
//      debugPrint('getNetworkData ${result.toString()}', wrapWidth: 1000);
      List<dynamic> instructionsData = await n.getInstructions(id.toString());
      List<String> directions = extractDirections(instructionsData);
      Recipe recipe = Recipe(
          name: result['title'],
          imageURL: 'https://spoonacular.com/recipeImages/${result['image']}',
          instructions: ,
          directions: directions);
      _searchedRecipes.add(recipe);
      setState(() => _searchedList.insert(0, SearchResultTile(rec: recipe)));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
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
                        'Clear',
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
                    setState(() {
                      _searchedList.clear();
                    });
                  },
                ),
              ),
            ],
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
