import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';
import 'package:recipe_writer/utils/networking.dart';
import 'package:recipe_writer/models/search_model.dart';
import 'package:recipe_writer/models/recipe.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController tc = TextEditingController();
  Map<String, dynamic> respMap = {};

  List<Widget> searchedList = [
    Text(
      'Something',
      style: TextStyle(color: white),
    ),
  ];

  getNetworkData(String query) async {
    Networking n = Networking();
    respMap = await n.getRequest(query);
    List<dynamic> hits = respMap['hits'];
    hits.forEach((hit) {
      Map<String, dynamic> recipe = hit['recipe'];
      List<String> ingredients = List<String>.from(recipe['ingredientLines']);
      Recipe rec = Recipe(
        name: recipe['label'],
        imageURL: recipe[''],
        url: recipe['url'],
      );
      print(rec.imageURL);
      setState(() {
        searchedList.add(
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.all(
                Radius.circular(35.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                (rec.imageURL == null)
                    ? Text('🍔')
                    : Image.network(rec.imageURL),
                Text(rec.name),
              ],
            ),
          ),
        ); //searchList.add
      });

      SearchModel model = SearchModel(
        ingredients: ingredients,
        label: recipe['label'],
        image: recipe['image'],
        sourceURL: recipe['url'],
        sourceID: recipe['source'],
      );
      print(model.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: colorGrad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RecipeTextField(text: 'Search', controller: tc),
          SizedBox(
            height: 22,
          ),
          Container(
            height: 60,
            child: RaisedButton(
              elevation: 5.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Done',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: textGrey,
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
              color: white,
              onPressed: () {
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
                itemCount: searchedList.length,
                itemBuilder: (context, index) {
                  return searchedList[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
