import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class RecipeTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  const RecipeTextField({
    Key key,
    this.text = '',
    this.controller,
  }) : super(key: key);

  @override
  _RecipeTextFieldState createState() => _RecipeTextFieldState();
}

class _RecipeTextFieldState extends State<RecipeTextField> {
  Color iconColor = white;

  setIconColor() =>
      (iconColor == white) ? iconColor = textGrey : iconColor = white;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (newText) {
          setState(() {
            iconColor = (newText.isEmpty) ? white : textGrey;
          });
        },
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          hintText: widget.text,
          fillColor: white,
          focusColor: white,
          filled: true,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.cancel,
              color: setIconColor(),
            ),
            onPressed: () {
              setState(() {
                widget.controller.clear();
                setIconColor();
              });
            },
          ),
        ),
      ),
    );
  }
}
