import 'package:flutter/material.dart';

class PictureScreen extends StatelessWidget {
  final String image;
  PictureScreen({this.image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        child: Center(
          child: Image(
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
