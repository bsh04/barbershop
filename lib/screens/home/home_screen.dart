import 'package:firebaseauthproject/widgets/bottom_items.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/bottom_tab_navigator.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  var title = '123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      body: SafeArea(
          child: Center(
        child: Text('Главная'),
      )),
    );
  }
}
