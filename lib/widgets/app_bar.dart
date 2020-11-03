import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {

  final String title;

  const AppBarWidget(
    this.title, {
    Key key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.menu),
      title: Text('Page title'),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.search),
        ),
        Icon(Icons.more_vert),
      ],
      backgroundColor: Colors.purple,
      automaticallyImplyLeading: true,
    );
  }
}
