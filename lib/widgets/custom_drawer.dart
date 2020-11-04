import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: FractionalOffset.topCenter,
                colors: [Colors.lightBlueAccent, Colors.blueAccent],
                stops: [0, 1],
              ),
            ),
            child: Center(
                heightFactor: 100,
                child: SafeArea(
                  child: Stack(
                    children: [
                      Column(children: [
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: Text(
                              'Данные о пользователе',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ))
                      ]),
                      Column(
                          verticalDirection: VerticalDirection.up, children: [
                        Align(
                            child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Text(
                                    'Не просто парикмахерская\nГ. Кемерово, ул. Ленина 133',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 20,
                                        color: Colors.white)),
                            )
                        ),
                      ]),
                    ],
                  ),
                )),
          )),
    );
  }
}
