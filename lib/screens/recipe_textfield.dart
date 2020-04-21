import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

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
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          hintText: text,
          fillColor: white,
          focusColor: white,
          filled: true,
        ),
      ),
    );
  }
}
