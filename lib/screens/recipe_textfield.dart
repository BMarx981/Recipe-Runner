import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class RecipeTextField extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  RecipeTextField({
    Key key,
    this.text = '',
    this.controller,
  }) : super(key: key);

  @override
  _RecipeTextFieldState createState() => _RecipeTextFieldState();
}

class _RecipeTextFieldState extends State<RecipeTextField> {
  bool toggleColor = false;

  @override
  void didUpdateWidget(RecipeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    toggleColor = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onChanged: (newText) {
          setState(() {
            if (newText.isNotEmpty) toggleColor = true;
            if (newText.isEmpty) toggleColor = false;
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
            icon: Visibility(
              visible: toggleColor,
              replacement: Text(""),
              child: Icon(
                Icons.cancel,
                color: textGrey,
              ),
            ),
            onPressed: () {
              setState(() {
                toggleColor = false;
                widget.controller.clear();
              });
            },
          ),
        ),
      ),
    );
  }
}
