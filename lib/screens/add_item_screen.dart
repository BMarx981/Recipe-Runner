import 'package:flutter/material.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/utils/colors.dart';

class AddItemScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 12),
          RecipeTextField(
            text: 'Recipe title',
            controller: titleController,
          ),
          SizedBox(height: 12),
          RecipeTextField(
            text: 'Add a description',
            controller: descController,
          ),
          SizedBox(height: 12),
          RecipeTextField(
            text: 'URL',
            controller: urlController,
          ),
          SizedBox(height: 22),
          Container(
            height: 60,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              onPressed: () {
                model.title = titleController.text;
                model.description = descController.text;
                model.url = urlController.text;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const RecipeTextField({
    Key key,
    this.text = '',
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            spreadRadius: 1.0,
            color: Colors.grey,
            offset: Offset(2.0, 5.0),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: text,
          fillColor: white,
          focusColor: white,
          filled: true,
        ),
      ),
    );
  }
}
