import 'package:firebaseauthproject/api/posts_service.dart';
import 'package:firebaseauthproject/api/userInfo_service.dart';
import 'package:firebaseauthproject/models/post_model.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:firebaseauthproject/widgets/main_layout.dart';
import 'package:firebaseauthproject/widgets/news-stocks-item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/users_model.dart';

class NewsScreen extends StatefulWidget {
  final String token;

  const NewsScreen({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewsState(token);
  }
}

class _NewsState extends State<NewsScreen> {
  ScrollController _controller = new ScrollController();
  String token;
  var responseDataUser;
  var responseDataNews;
  List<Widget> _newsList;

  _NewsState(this.token);

  _getData() async {
    responseDataNews = await PostsService.getNewsList();
    responseDataUser = await UserInfoService.getUserInfo(token);

    return _newsList = responseDataNews.data.map<Widget>((item) {
      return new NewsAndStocksItem(
          image: item.imageUrl, title: item.title, desc: item.description);
    }).toList();
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
                      responseDataUser.data.name, responseDataUser.data.login, responseDataUser.data.balance)),
              appBar: CustomAppBar('Новости', true),
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text('СПИСОК НОВОСТЕЙ',
                        style: TextStyle(
                            color: Colors.blue,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: ListView(
                      physics: ScrollPhysics(),
                      controller: _controller,
                      shrinkWrap: true,
                      children: _newsList,
                    )),
                  ])),
            );
          }
          if (snapshot.hasError) {}
          return new Center(child: new CircularProgressIndicator());
        });
  }
}
