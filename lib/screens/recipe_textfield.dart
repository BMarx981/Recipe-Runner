import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class RecipeTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  Color iconColor = white;

  toggleIconColor() {
    if (iconColor == textGrey) {
      iconColor = white;
      return;
    }
    iconColor = textGrey;
  }

  setIconColorGrey() {
    iconColor = textGrey;
  }

  setIconColorWhite() {
    iconColor = white;
  }

  RecipeTextField({
    Key key,
    this.text = '',
    this.controller,
  }) : super(key: key);

  @override
  _RecipeTextFieldState createState() => _RecipeTextFieldState();
}

class _RecipeTextFieldState extends State<RecipeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (newText) {
          if (newText.isNotEmpty) {
            setState(() => widget.setIconColorGrey());
          }
          if (newText.isEmpty) {
            setState(() => widget.toggleIconColor());
          }
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
              color: widget.iconColor,
            ),
            onPressed: () {
              setState(() {
                widget.toggleIconColor();
                widget.controller.clear();
              });
            },
          ),
        ),
      ),
    );
  }
}
