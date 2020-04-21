import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0.0, backgroundColor: Colors.transparent),
      body: Container(
        decoration: BoxDecoration(gradient: colorGrad),
        child: Text('Search screen'),
      ),
    );
  }
}
