import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'camera_screen.dart';
import 'recipe_textfield.dart';
import 'package:recipe_writer/utils/db_helper.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final dbHelper = DatabaseHelper.instance;

  final titleController = TextEditingController();

  final descController = TextEditingController();

  final urlController = TextEditingController();

  final ingredientsController = TextEditingController();

  final directionsController = TextEditingController();

  RecipeTextField titleField;

  RecipeTextField descField;

  RecipeTextField urlField;

  RecipeTextField ingredientsField;

  RecipeTextField directionsField;

  List<String> ingredients = [];

  List<String> directions = [];

  bool colorChange = false;

  String localImageUrl;

  //The new Recipe to be added
  Recipe recipe = Recipe();

  @override
  Widget build(BuildContext context) {
    titleField = RecipeTextField(
      text: 'Recipe title',
      controller: titleController,
    );
    descField = RecipeTextField(
      text: 'Add a description',
      controller: descController,
    );
    ingredientsField = RecipeTextField(
      text: 'Add Ingredients',
      controller: ingredientsController,
    );
    directionsField = RecipeTextField(
      text: 'Add Directions',
      controller: directionsController,
    );
    urlField = RecipeTextField(
      text: 'URL',
      controller: urlController,
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
          // saveChanges(recipe, context);
        }
      },
      child: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 12),
            titleField,
            SizedBox(height: 12),
            descField,
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(child: ingredientsField),
                SizedBox(width: 12),
                Container(
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                      color: Colors.grey[400],
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        ingredients.add(ingredientsController.text);
                        ingredientsController.clear();
                        setState(() {
                          colorChange = false;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(child: directionsField),
                SizedBox(width: 12),
                Container(
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(35),
                        ),
                      ),
                      color: Colors.grey[400],
                      child: Icon(
                        Icons.add,
                      ),
                      onPressed: () {
                        directions.add(directionsController.text);
                        directionsController.clear();
                        setState(() {
                          colorChange = false;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(height: 12),
            buildRaisedButton(context, recipe),
            SizedBox(height: 12),
            urlField,
            SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                right: 18,
              ),
              child: Container(
                height: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                  color: Colors.grey[400],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Add',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: white),
                      ),
                    ],
                  ),
                  onPressed: () {
                    saveChanges(recipe, context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveChanges(Recipe recipe, BuildContext context) {
    recipe = Recipe(
        name: titleController.text,
        description: descController.text,
        ingredients: ingredients,
        directions: directions,
        url: urlController.text,
        imageURL: '');
    recipe.imageURL = localImageUrl;
    Provider.of<MainModel>(context, listen: false).addRecipe(recipe);
    dbHelper.insertRow(recipe);
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('${titleController.text} recipe added'),
      ),
    );
    _clear();
    setState(() {});
  }

  void _clear() {
    titleField = titleField;
    descField = descField;
    urlField = urlField;
    directionsField = directionsField;
    ingredientsField = ingredientsField;
    titleController.clear();
    descController.clear();
    ingredientsController.clear();
    directionsController.clear();
    urlController.clear();
    recipe = Recipe();
  }

  RaisedButton buildRaisedButton(BuildContext context, Recipe recipe) {
    return RaisedButton(
      elevation: 7.5,
      color: Colors.limeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      child: Icon(
        Icons.photo_camera,
        color: red,
        size: 28,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraScreen(recipe: recipe),
          ),
        ).then((v) => setState(() => localImageUrl = recipe.imageURL));
      },
    );
  }
}
