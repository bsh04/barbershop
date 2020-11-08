import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_state.dart';
import 'package:firebaseauthproject/blocs/simple_bloc_observer.dart';
import 'package:firebaseauthproject/login_main.dart';
import 'package:firebaseauthproject/repositories/user_repository.dart';
import 'package:firebaseauthproject/screens/call/call_screen.dart';
import 'package:firebaseauthproject/screens/galery/gallery_screen.dart';
import 'package:firebaseauthproject/screens/home/home_screen.dart';
import 'package:firebaseauthproject/screens/login/login_screen.dart';
import 'package:firebaseauthproject/screens/register/register_screen.dart';
import 'package:firebaseauthproject/screens/shop/shop_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/news/news_screen.dart';
import 'screens/stocks/stocks_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue,
    statusBarColor: Colors.indigo,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  String token;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString('login');

  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository, token: token));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
  final String token;

  MyApp({UserRepository userRepository, this.token})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
      ),
      initialRoute: token != '' && token != null ? '/home' : '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) =>
            RegisterScreen(userRepository: _userRepository),
        '/home': (BuildContext context) => LoginMain(),
        '/gallery': (BuildContext context) => GalleryScreen(),
        '/shop': (BuildContext context) => ShopScreen(),
        '/call': (BuildContext context) => CallScreen(),
        '/news': (BuildContext context) => NewsScreen(token: token),
        '/stocks': (BuildContext context) => StocksScreen(token: token)
      },
    );
  }
}
