import 'package:firebaseauthproject/api/order_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../widgets/custom_drawer.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String desc;
  final double cost;
  final String image;
  final String token;
  final String id;

  const ProductCard(
      {Key key,
      this.title,
      this.desc,
      this.cost,
      this.image,
      this.token,
      this.id})
      : super(key: key);

  @override
  _ProductState createState() =>
      new _ProductState(title, desc, cost, image, token, id);
}

class _ProductState extends State<ProductCard> {
  String title;
  String desc;
  double cost;
  String image;
  String token;
  String id;

  _ProductState(
      this.title, this.desc, this.cost, this.image, this.token, this.id);

  Future<void> _showDialog(cost, title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Внимание'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$title'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text(cost != '' ? 'Да' : 'Ок'),
                onPressed: () async {
                  if (cost != '') {
                    var res = await OrderService.makeOrder(id, token);
                    Navigator.of(context).pop();
                    _showDialog('', res.message);
                  } else {
                    Navigator.of(context).pop();
                  }
                }),
            cost != ''
                ? TextButton(
                    child: Text('Нет'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : null,
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width * .6,
              decoration: new BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black26, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: FractionalOffset.topCenter,
                  colors: [Colors.white, Colors.black26],
                  stops: [0, 1],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$title',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: '$image',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      desc,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      child: FloatingActionButton.extended(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _showDialog(cost,
                              'Вы уверены что хотите приобрести этот товар за $cost рублей?');
                        },
                        label: Text('$cost'),
                        icon: Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
