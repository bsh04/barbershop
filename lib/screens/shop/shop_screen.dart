import 'package:firebaseauthproject/api/products_service.dart';
import 'package:firebaseauthproject/models/product_model.dart';
import 'package:firebaseauthproject/models/response_model.dart';
import 'package:firebaseauthproject/screens/shop/product_card.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductModel {
  String name;
  String description;
  double price;
  String url;

  ProductModel(this.name, this.description, this.price, this.url);
}

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShopScreenState();
  }
}

class _ShopScreenState extends State<ShopScreen> {
  ScrollController _controller = new ScrollController();

  List<Widget> _products;

  String token;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('login');

    var response = await ProductsService.getProductsList();

    return _products = response.data.map<Widget>((item) {
      return new ProductCard(
        title: item.name,
        desc: item.description,
        cost: item.price,
        image: item.url,
        token: token,
        id: item.id,
      );
    }).toList();
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
    return FutureBuilder(
      future: _getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            body: WillPopScope(
                onWillPop: () {
                  return _onBackPressed();
                },
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: Text(
                                  'ВЫ МОЖЕТЕ ВЫБРАТЬ И ПРИОБРЕСТИ ТОВАРЫ ОНЛАЙН',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              child: ListView(
                                physics: ScrollPhysics(),
                                controller: _controller,
                                shrinkWrap: true,
                                children: _products,
                              ))
                        ],
                      ),
                    ))),
          );
        }
        if (snapshot.hasError) {}
        return new Center(child: new CircularProgressIndicator());
      },
    );
  }
}
