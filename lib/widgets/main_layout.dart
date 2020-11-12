import 'package:firebaseauthproject/api/products_service.dart';
import 'package:firebaseauthproject/api/userInfo_service.dart';
import 'package:firebaseauthproject/screens/call/call_screen.dart';
import 'package:firebaseauthproject/screens/galery/gallery_screen.dart';
import 'package:firebaseauthproject/screens/home/home_screen.dart';
import 'package:firebaseauthproject/screens/shop/shop_screen.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/users_model.dart';
import 'bottom_items.dart';

class CustomBottomTabNavigator extends StatefulWidget {
  const CustomBottomTabNavigator({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<CustomBottomTabNavigator> {
  int _pageIndex = 0;
  String token;
  var responseData;

  PageController _pageController;

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('login');
    return responseData = await UserInfoService.getUserInfo(token);
  }

  List<Widget> tabPages = [
    HomeScreen(),
    GalleryScreen(),
    ShopScreen(),
    CallScreen()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    this._pageController.jumpToPage(index);
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
                userData:
                    UserModel(responseData.data.name, responseData.data.login, responseData.data.balance)),
            appBar: CustomAppBar(allDestinations[_pageIndex].title, true),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _pageIndex,
              onTap: onTabTapped,
              items: allDestinations.map((Destination destination) {
                return BottomNavigationBarItem(
                    icon: Icon(destination.icon),
                    backgroundColor: destination.color,
                    title: Text(destination.title));
              }).toList(),
            ),
            body: SafeArea(
              child: PageView(
                children: tabPages,
                onPageChanged: onPageChanged,
                controller: _pageController,
              ),
            ),
          );
        }
        if (snapshot.hasError) {}
        return new Center(child: new CircularProgressIndicator());
      },
    );
  }
}
