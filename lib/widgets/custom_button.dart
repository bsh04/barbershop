import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final int bgColor;

  const CustomButton(this.bgColor, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color(bgColor),
        onPressed: () => {}
        );
  }

}