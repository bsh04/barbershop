import 'dart:collection';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebaseauthproject/api/masters_service.dart';
import 'package:firebaseauthproject/screens/home/service_card.dart';
import 'package:firebaseauthproject/widgets/bottom_items.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:firebaseauthproject/widgets/map_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeScreen extends StatefulWidget {
  final String products;

  const HomeScreen({Key key, this.products}) : super(key: key);

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
  MasterModel(this.name, this.rating, this.url);

  String name;
  double rating;
  String url;
}

class _HomeState extends State<HomeScreen> {
  ScrollController _controller = new ScrollController();

  List<MasterModel> _masters;

  getData() async {
    var response = await MastersService.getMastersList();

    return _masters = response.data.map((item) {
      return new MasterModel(item.name, item.rating, item.url);
    }).toList();
  }

  _ratingCalc(double rating) {
    if (rating == 5) {
      return 15 + (17 * rating) + (16 * rating.round().ceil()) - 10;
    } else {
      return 15 + (17 * rating) + (16 * rating.round().ceil());
    }
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Внимание'),
            content: new Text('Вы действительно хотите выйти из приложения?'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("Нет"),
              ),
              SizedBox(height: 16),
              new TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Да"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
            _onBackPressed();
          },
          child: SingleChildScrollView(
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
                          FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CarouselSlider(
                                  options: CarouselOptions(height: 480.0),
                                  items: _masters.map((i) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: Column(children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                color: Colors.blue,
                                                child: Text(
                                                  '${i.name}',
                                                  style: TextStyle(
                                                      fontSize: 30.0,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                height: 390,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child:
                                                    FadeInImage.memoryNetwork(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  fit: BoxFit.fill,
                                                  placeholder:
                                                      kTransparentImage,
                                                  image: '${i.url}',
                                                ),
                                              ),
                                              Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 50,
                                                  color: Colors.blue,
                                                  child: Center(
                                                    child: Container(
                                                        child: Stack(
                                                      children: [
                                                        Positioned(
                                                          child: Container(
                                                            height: 35,
                                                            width: _ratingCalc(
                                                                i.rating),
                                                            color: Colors
                                                                .amberAccent,
                                                          ),
                                                          top: 5,
                                                        ),
                                                        Container(
                                                          width: 180,
                                                          height: 40,
                                                          decoration:
                                                              new BoxDecoration(
                                                            image: new DecorationImage(
                                                                image: new AssetImage(
                                                                    'assets/master/rating.png'),
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                                  )),
                                            ]));
                                      },
                                    );
                                  }).toList(),
                                );
                              }
                              if (snapshot.hasError) {}
                              return new Center(
                                  child: new CircularProgressIndicator());
                            },
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
        ));
  }
}
