import 'package:firebaseauthproject/blocs/register_bloc/register_bloc.dart';
import 'package:firebaseauthproject/repositories/user_repository.dart';
import 'package:firebaseauthproject/screens/register/register_form.dart';
import 'package:firebaseauthproject/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar('Вход в аккаунт', false),
        body: BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(userRepository: _userRepository),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(child: RegisterForm()),
              ],
            )));
  }
}
