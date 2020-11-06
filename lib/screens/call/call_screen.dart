import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:url_launcher/url_launcher.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) =>
      new AlertDialog(
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
      body: WillPopScope(
        onWillPop: () {
          _onBackPressed();
        },
        child: Center(
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
        ),
      ),
    );
  }
}
