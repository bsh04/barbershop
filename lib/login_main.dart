import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_state.dart';
import 'package:firebaseauthproject/blocs/simple_bloc_observer.dart';
import 'package:firebaseauthproject/repositories/user_repository.dart';
import 'package:firebaseauthproject/screens/call/call_screen.dart';
import 'package:firebaseauthproject/screens/galery/gallery_screen.dart';
import 'package:firebaseauthproject/screens/home/home_screen.dart';
import 'package:firebaseauthproject/screens/login/login_screen.dart';
import 'package:firebaseauthproject/screens/register/register_screen.dart';
import 'package:firebaseauthproject/screens/shop/shop_screen.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/bottom_tab_navigator.dart';
import 'package:firebaseauthproject/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication_bloc/authentication_bloc.dart';
import 'blocs/authentication_bloc/authentication_event.dart';

class LoginMain extends StatelessWidget {
  final UserRepository _userRepository;

  LoginMain({UserRepository userRepository}) : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomTabNavigator(),
    );
  }
}
