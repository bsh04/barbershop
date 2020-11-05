import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.access_time,
            size: 30,
            color: Colors.blue,
          ),
          SizedBox(
            height: 20,
          ),
          Column(children: [
            Text('ВРЕМЯ РАБОТЫ',
                style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            Text('Ежедневно с 10:00 до 20:00',
                style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 22))
          ]),
          SizedBox(
            height: 50,
          ),
          Icon(
            Icons.phone,
            size: 30,
            color: Colors.blue,
          ),
          SizedBox(
            height: 20,
          ),
          Column(children: [
            Text('ПОЗВОНИТЬ',
                style: TextStyle(
                    color: Colors.blue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
                backgroundColor: const Color(0xff00c853),
                onPressed: () {
                  launch("tel://+7‒913‒139‒72‒53");
                },
                label: Column(
                  children: [
                    Text('+7‒913‒139‒72‒53',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    Text('парикмахерский зал',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            FloatingActionButton.extended(
                onPressed: () {
                  launch("tel://+7‒904‒994‒19‒16");
                },
                backgroundColor: const Color(0xff00c853),
                label: Column(
                  children: [
                    Text('+7‒904‒994‒19‒16',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    Text('администрация',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 14))
                  ],
                ))
          ]),
        ],
      ),
    ));
  }
}
