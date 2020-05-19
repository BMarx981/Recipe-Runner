import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/screens/recipe_textfield.dart';
import 'package:recipe_writer/utils/colors.dart';

class EditRecipeScreen extends StatefulWidget {
  final Recipe recipe;
  EditRecipeScreen({this.recipe});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController ingredientsController = TextEditingController();

  final TextEditingController directionsController = TextEditingController();

  final TextEditingController urlController = TextEditingController();

  final List<String> tempDirections = [];

  final List<String> tempIngredients = [];

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.recipe.name;
    descriptionController.text = widget.recipe.description;
    ingredientsController.text = widget.recipe.ingredients[0];
    directionsController.text = widget.recipe.directions[0];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: red,
          title: Text(
            'Edit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                widget.recipe.name = titleController.text;
                widget.recipe.description = descriptionController.text;
                widget.recipe.directions.addAll(tempDirections);
                widget.recipe.ingredients.addAll(tempIngredients);
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: colorGrad),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _buildFields(
                  'Title',
                  titleController,
                ),
                _buildFields(
                  'Description',
                  descriptionController,
                ),
                _buildEditLists(
                  'Ingredients',
                  ingredientsController,
                  widget.recipe.ingredients,
                ),
                _buildEditLists(
                  'Directions',
                  directionsController,
                  widget.recipe.directions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildEditLists(
      String title, TextEditingController controller, List<String> list) {
    String text = '';
    if (title == 'Ingredients' || widget.recipe.ingredients.isEmpty) {
      text = 'Add Ingredient';
    }
    if (title == 'Directions' || widget.recipe.directions.isEmpty) {
      text = 'Add Direction';
    }
    int index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RecipeTextField(
                  controller: controller,
                  text: text,
                ),
              ),
              SizedBox(width: 6),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: textGrey,
                    child: Icon(
                      Icons.add,
                      color: white,
                    ),
                    onPressed: () {
                      if (index >= list.length - 1) return;
                      index += 1;
                      controller.text = list.elementAt(index);
                      setState(() {});
                    },
                  ), //-21 89 -65 nether position
                  RaisedButton(
                    color: textGrey,
                    child: Icon(
                      Icons.remove,
                      color: white,
                    ),
                    onPressed: () {
                      if (index == 0) return;
                      index -= 1;
                      controller.text = list.elementAt(index);
                      setState(() {});
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Column _buildFields(String name, TextEditingController controller) {
    String text = '';
    if (name == 'Description') text = 'Edit description';
    if (name == 'Title') text = 'Edit title';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: white,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RecipeTextField(
            controller: controller,
            text: text,
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
