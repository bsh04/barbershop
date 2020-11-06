import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String desc;
  final String cost;
  final String image;

  const ProductCard({Key key, this.title, this.cost, this.image, this.desc})
      : super(key: key);

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
                    style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage('assets/product/product_$image.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      desc, textAlign: TextAlign.justify, style: TextStyle(color: Colors.black),
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
                        //
                      },
                      label: Text(cost),
                      icon: Icon(
                        Icons.monetization_on,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}