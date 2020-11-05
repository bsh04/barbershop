import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/image_dialog.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
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
          width: MediaQuery.of(context).size.width * .3333,
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
      child: SingleChildScrollView(child: Wrap(children: list)),
    ));
  }
}
