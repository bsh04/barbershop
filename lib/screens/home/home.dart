import 'package:firebaseauthproject/widgets/BottomItems.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/bottomTabNavigator.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  int _currentIndex = 0;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Главная', true),
      body: Center(
        child: Text('Главная'),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
