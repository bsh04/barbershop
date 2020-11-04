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

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/authentication_bloc/authentication_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;

  MyApp({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xff6a515e),
        cursorColor: Color(0xff6a515e),
      ),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) => RegisterScreen(userRepository: _userRepository),
        '/home': (BuildContext context) => LoginMain(),
        '/gallery': (BuildContext context) => GalleryScreen(),
        '/shop': (BuildContext context) => ShopScreen(),
        '/call': (BuildContext context) => CallScreen()
      },
    );
  }
}
