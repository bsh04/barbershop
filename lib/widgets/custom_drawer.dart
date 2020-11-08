import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class UserModel {
  String name;
  String login;

  UserModel(this.name, this.login);
}

class CustomDrawer extends StatefulWidget {
  final String token;
  final UserModel userData;

  const CustomDrawer({Key key, this.token, this.userData}) : super(key: key);

  @override
  _CustomDrawerState createState() => new _CustomDrawerState(token, userData);
}

class _CustomDrawerState extends State<CustomDrawer> {
  String token;
  UserModel userData;

  _CustomDrawerState(this.token, this.userData);

  _logOut() async {
    _showDialog();
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Внимание'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Вы действительно хотите выйти из аккаунта?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
                child: Text('Да'),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('login');
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                }),
            TextButton(
              child: Text('Нет'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(userData);
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
                            '${userData.name}',
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
                              '${userData.login}',
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
                          onTap: () {
                            _logOut();
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
