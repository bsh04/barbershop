import 'package:firebaseauthproject/api/posts_service.dart';
import 'package:firebaseauthproject/api/userInfo_service.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:firebaseauthproject/widgets/news-stocks-item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StocksScreen extends StatefulWidget {
  final String token;

  const StocksScreen({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StocksState(token);
  }
}

class _StocksState extends State<StocksScreen> {
  ScrollController _controller = new ScrollController();
  String token;
  var responseDataUser;
  var responseDataStocks;
  List<Widget> _stocksList;

  _StocksState(this.token);

  _getData() async {
    responseDataStocks = await PostsService.getPromotionsList();
    responseDataUser = await UserInfoService.getUserInfo(token);

    return _stocksList = responseDataStocks.data.map<Widget>((item) {
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
                    userData: UserModel(responseDataUser.data.name,
                        responseDataUser.data.login)),
                appBar: CustomAppBar('Акции', true),
                body: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text('СПИСОК АКЦИЙ',
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
                        children: _stocksList,
                      )),
                    ])));
          }
          if (snapshot.hasError) {}
          return new Center(child: new CircularProgressIndicator());
        });
  }
}
