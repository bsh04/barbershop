import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  const CustomInput({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.security),
        labelText: 'label',
      ),
    );
  }

}