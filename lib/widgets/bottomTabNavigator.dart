import 'package:flutter/material.dart';

import 'BottomItems.dart';

class CustomBottomTabNavigator extends StatefulWidget {
  const CustomBottomTabNavigator({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<CustomBottomTabNavigator> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              backgroundColor: destination.color,
              title: Text(destination.title));
        }).toList(),
      ),
    );
  }
}
