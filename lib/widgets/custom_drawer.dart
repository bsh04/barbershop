import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

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
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 30.0),
                        child: Row(children: [
                          Icon(Icons.assignment_ind, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'Привет, Иван Иванов',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          )
                        ])),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 30.0, top: 20.0),
                        child: Row(
                          children: [
                            Icon(Icons.person, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Login (email / phone)',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            )
                          ],
                        )),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: 30.0, top: 20.0),
                        child: TouchableOpacity(
                          onTap: (){
                            // REMOVE FUCKING TOKEN!!!
                          },
                         child: Row(
                           children: [
                             Icon(Icons.login, color: Colors.white),
                             SizedBox(width: 10),
                             Text(
                               'Сменить пользователя',
                               style: TextStyle(
                                   fontWeight: FontWeight.bold,
                                   fontSize: 20,
                                   color: Colors.white),
                             ),
                           ],
                         ),
                        ))
                  ]),
                  Column(verticalDirection: VerticalDirection.up, children: [
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
                    )),
                  ]),
                ],
              ),
            )),
      )),
    );
  }
}
