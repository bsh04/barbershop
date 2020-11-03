import 'package:firebaseauthproject/blocs/login_bloc/login_bloc.dart';
import 'package:firebaseauthproject/repositories/user_repository.dart';
import 'package:firebaseauthproject/screens/login/login_form.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:firebaseauthproject/widgets/curved_widget.dart';
import 'package:firebaseauthproject/widgets/custom_button.dart';
import 'package:firebaseauthproject/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Вход в аккаунт', true),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: Container(
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Text('Войдите в свой аккаунт'),
              CustomInput(),
              CustomInput(),
              CustomButton(0xff01579b),
              CustomButton(0xff014211)
            ],
          ) 
        ),
      ),
    );
  }
}
