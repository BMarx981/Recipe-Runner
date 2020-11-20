import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';
import 'package:recipe_writer/utils/networking.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'search_result_tile.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';

import 'dart:math' as math;

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

  String delimiter = "??><??";

  bool isLoading = true;

  @override
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
    List<dynamic> results = respMap['recipes'];
    results.forEach((result) async {
      Recipe recipe = Recipe(
        id: math.Random().nextInt(100000000),
        name: result['name'],
        url: result['url'],
        imageURL: result['imageurl'],
        ingredients: List<String>.from(result['ingredients']),
        directions: List<String>.from(result['directions']),
      );
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
    return GestureDetector(
      onTap: () {
        // This allows you to disiss the keyboard by tapping
        // anywhere thats not the keyboard
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          if (tc.text.isNotEmpty) _executeSubmit();
        }
      },
      child: Container(
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
                        _executeSubmit();
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
            isLoading
                ? Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 2),
                      color: Colors.transparent,
                      child: Scrollbar(
                        child: ListView.builder(
                          itemCount: _searchedList.length,
                          itemBuilder: (context, index) {
                            return _searchedList[index];
                          },
                        ),
                      ),
                    ),
                  )
                : CupertinoActivityIndicator(
                    animating: true,
                  ),
          ],
        ),
      ),
    );
  }

  void _executeSubmit() async {
    setState(() => isLoading = !isLoading);
    await getNetworkData(tc.text);
    tc.clear();
    setState(() => isLoading = !isLoading);
  }
}
