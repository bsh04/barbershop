import 'package:firebaseauthproject/screens/shop/product_card.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class DataModel {
  DataModel(this.title, this.desc, this.cost, this.image);

  String title;
  String desc;
  String cost;
  String image;
}

List<DataModel> products = [
  new DataModel(
      'Матовая мастика Ruck Matte Putty',
      'Матовая мастика Lock Stock & Barrel Ruck Matte Putty рекомендуется для волос любого типа, дает волосам хорошую пластичность и контроль.\n\nПозволяет визуально увеличить массу волос. Подходит для укладок с матовой поверхностью и для создания ирокеза. Матовая мастика Ruck Matte Putty придает волосам небольшой объем. ',
      '2 050',
      '1'),
  new DataModel(
      'Dream Catcher Nourishing',
      'Шампунь Dream Catcher Nourishing Shampoo питательный разработан для ежедневного ухода за нормальными и жирными волосами. Провитамин B5 стимулирует глубокое увлажнение и обеспечивает питание кожи головы. Водорастворимый инулин из корня цикория - природный кондиционер, дарит приятные ощущения и усиливает действие активных компонентов.',
      '950',
      '2'),
  new DataModel(
      'Lock Stock & Barrel 85 KARATS',
      'Add here some interesting details about the product. Help people realized that this product is exactly what they need. It could be practical and useful information as well: size of the product, material that it is made of or care instructions.',
      '2 050',
      '3'),
  new DataModel(
      'Lock Stock & Barrel Pucka',
      'Подходит для укладки тонких волос, кудрявым от природы волосам подчеркивает текстуру, придает волосам небольшой объем, загущает их не перегружая и позволяет укладывать по своему желанию, как гладко, так и небрежно, кудрявые волосы формируются в локон. Волосы, уложенные кремом Pucka Grooming Creme смотрятся естественно.',
      '1 850',
      '4'),
  new DataModel(
      'Volumatte Lock Stock & Barrel',
      'Пудра для объема Volumatte подходит мужчинам с короткими стрижками и для рок-н-рольщиков с длинными волосами, для придания волосам небрежного объема у корней, поэтому можно рекомендовать и девушкам, также можно использовать как подготовочный стайлинг для дальнейшей укладки.',
      '1 500',
      '5'),
  new DataModel(
      'Reconstruct Protein Shampoo',
      'Для мужчин с тонкими и редеющими волосами, входящие в состав шампуня протеины и кератин увеличивают волосы в диаметре и укрепляют стержень волоса изнутри. шампунь для тонких волос Reconstruct быстро удаляет любой въедливый стайлинг.',
      '1 650',
      '6'),
  new DataModel(
      'Lock Stock & Barrel Freestyle',
      'Рекомендуется для всех типов волос, для творческого беспорядка на коротких волосах, для создания идеальной укладки по форме головы, для "зализанных" укладок, для стрижки "андеркат". Для идеального создания прически узел или хвост, идеально зализанные и зафиксированные волосы. Единственный в мире гель без эффекта мокрых волос, не блестит, дает эффект матовости.',
      '1 650',
      '7'),
];

class ShopScreen extends StatefulWidget {
  ShopScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ShopScreenState();
  }
}

class _ShopScreenState extends State<ShopScreen> {
  ScrollController _controller = new ScrollController();

  List<Widget> _products = products.map<Widget>((item) {
    return new ProductCard(
        image: item.image, title: item.title, desc: item.desc, cost: item.cost);
  }).toList();

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
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
          onWillPop: () { _onBackPressed(); },
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
}
