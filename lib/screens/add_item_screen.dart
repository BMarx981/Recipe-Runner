import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class AddItemScreen extends StatelessWidget {
  void textFieldCallBack(newText) {}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 12),
          RecipeTextField(text: 'Recipe title'),
          SizedBox(height: 12),
          RecipeTextField(text: 'Add a description'),
          SizedBox(height: 12),
          RecipeTextField(text: 'Add a direction'),
          SizedBox(height: 12),
          RecipeTextField(text: 'URL'),
          SizedBox(height: 52),
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
                print('Something Happened to the button');
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
  final Function callBack;
  const RecipeTextField({
    Key key,
    this.text = '',
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newStringValue) {
        print(newStringValue);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        fillColor: white,
        focusColor: white,
        filled: true,
      ),
    );
  }
}
