import 'package:flutter/material.dart';

import 'bottom_items.dart';

class CustomBottomTabNavigator extends StatefulWidget {
  const CustomBottomTabNavigator({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<CustomBottomTabNavigator> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    return BottomAppBar(
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          print(_currentIndex);
          setState(() {
            _currentIndex = index;
          });
        },
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
