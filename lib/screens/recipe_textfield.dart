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
  Icon cancelIcon = Icon(
    Icons.cancel,
    color: white,
  );

  Icon setIconColor(Color color) {
    return Icon(
      Icons.cancel,
      color: color,
    );
  }

  //TODO: Fix setIconColor to work properly

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (newText) {
          if (newText.isEmpty) {
            setState(() {
              cancelIcon = setIconColor(white);
            });
          } else {
            setState(() {
              cancelIcon = setIconColor(textGrey);
            });
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
            icon: cancelIcon,
            onPressed: () {
              setState(() {
                cancelIcon = setIconColor(white);
                widget.controller.clear();
              });
            },
          ),
        ),
      ),
    );
  }
}
