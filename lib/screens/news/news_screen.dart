import 'package:firebaseauthproject/api/userInfo_service.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatefulWidget {
  final String token;

  const NewsScreen({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsState(token);
  }
}

class _NewsState extends State<NewsScreen> {
  String token;
  var responseDataUser;
  var responseDataNews;

  _NewsState(this.token);

  _getData() async {
    return responseDataUser = await UserInfoService.getUserInfo(token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              drawer: CustomDrawer(
                  token: token,
                  userData: UserModel(
                      responseDataUser.data.name, responseDataUser.data.login)),
              appBar: CustomAppBar('Новости', true),
              body: Text('news'),
            );
          }
          if (snapshot.hasError) {}
          return new Center(child: new CircularProgressIndicator());
        });
  }
}
