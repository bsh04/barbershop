import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/image_dialog.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<GalleryScreen> {
  bool _isOpen = false;
  int _selectedItem = 1;

  void _openPhoto(int item) {
    _selectedItem = item;
    _isOpen = true;
  }

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
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < 13; i++) {
      list.add(GestureDetector(
        onTap: () async {
          await showDialog(
              context: context,
              builder: (_) => ImageDialog(image: i + 1,)
          );
        },
        child: Container(
          height: 160,
          width: MediaQuery
              .of(context)
              .size
              .width * .3333,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/gallery/${i + 1}.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ));
    }
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: WillPopScope(
            child: SingleChildScrollView(child: Wrap(children: list)),
            onWillPop: () { _onBackPressed(); },
      ),
    ));
  }
}
