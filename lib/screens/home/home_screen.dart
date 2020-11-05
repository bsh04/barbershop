import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebaseauthproject/screens/home/service_card.dart';
import 'package:firebaseauthproject/widgets/bottom_items.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:firebaseauthproject/widgets/map_view.dart';
import 'package:flutter/cupertino.dart';
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
  new ServiceModel('Оформление бороды', '499'),
  new ServiceModel('Плетение кос', '499'),
  new ServiceModel('И другое', ''),
];

class MasterModel {
  MasterModel(this.title, this.image);

  String title;
  String image;
}

List<MasterModel> masters = [
  new MasterModel('Иван Иванов', '1'),
  new MasterModel('Дмитрий Петров', '2'),
  new MasterModel('Сергей Николаев', '3'),
  new MasterModel('Евгений Миронов', '4'),
  new MasterModel('Николай Сидоров', '5'),
];

class _HomeState extends State<HomeScreen> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: ListView.builder(
                        physics: ScrollPhysics(),
                        controller: _controller,
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
                      Text('Наши лучшие мастера',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                      SizedBox(
                        height: 20,
                      ),
                      CarouselSlider(
                        options: CarouselOptions(height: 400.0),
                        items: masters.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                      image: new AssetImage(
                                          'assets/master/master_${i.image}.png'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Container(
                                    child: Text(
                                      '${i.title}',
                                      style: TextStyle(
                                          backgroundColor: Colors.black,
                                          fontSize: 30.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          'Наша парикмахерская расположена по адресу ул. Ленина 133',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontStyle: FontStyle.italic,
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
