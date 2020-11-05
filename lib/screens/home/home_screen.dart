import 'dart:collection';

import 'package:firebaseauthproject/widgets/bottom_items.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:firebaseauthproject/widgets/map_view.dart';
import 'package:firebaseauthproject/widgets/service_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class ServiceModel {
  ServiceModel(this.title, this.cost);

  String title;
  String cost;
}

List<ServiceModel> services = [
  new ServiceModel('Мужская стрижка', '299'),
  new ServiceModel('Женская стрижка', '299'),
  new ServiceModel('Детская стрижка', '299'),
  new ServiceModel('Плетение кос', ''),
  new ServiceModel('И другое', ''),
];

class _HomeState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
              child: Column(
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/icons/logo.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text('НАШИ УСЛУГИ',
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      return ServicesCard(
                          title: services[index].title,
                          cost: services[index].cost);
                    },
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Наша парикмахерская расположена по адресу ул. Ленина 133',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 22)),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: CustomMapView(),
                  ),
                ],
              )
            ],
          )),
        ),
      )),
    );
  }
}
