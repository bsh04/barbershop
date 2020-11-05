import 'package:flutter/material.dart';

class ServicesCard extends StatelessWidget {
  final String title;
  final String cost;

  const ServicesCard({Key key, this.title, this.cost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.black26, width: 1),
      )),
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('$title', style: TextStyle(fontStyle: FontStyle.italic),),
          Text(
            cost != '' ? '$cost Р' : '—    ',
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
