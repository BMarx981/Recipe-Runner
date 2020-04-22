import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';
import 'package:recipe_writer/utils/networking.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController tc = TextEditingController();

  final List<Widget> list = [
    Text(
      'Something',
      style: TextStyle(color: white),
    ),
  ];

  getNetworkData(String query) async {
    Networking n = Networking();
    Map<String, dynamic> respMap = await n.getRequest(query);
    print(respMap);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: colorGrad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RecipeTextField(text: 'Search', controller: tc),
          SizedBox(
            height: 22,
          ),
          Container(
            height: 60,
            child: RaisedButton(
              elevation: 5.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Done',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: textGrey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              color: white,
              onPressed: () {
                getNetworkData(tc.text);
                tc.clear();
              },
            ),
          ),
          SizedBox(
            height: 22,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 2),
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return list[index];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
