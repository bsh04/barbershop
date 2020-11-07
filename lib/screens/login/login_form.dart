import 'dart:ui';

import 'package:firebaseauthproject/api/auth_service.dart';
import 'package:firebaseauthproject/api/masters_service.dart';
import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_event.dart';
import 'package:firebaseauthproject/blocs/login_bloc/login_bloc.dart';
import 'package:firebaseauthproject/blocs/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _loginController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  String loginType = 'email';

  AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = new AuthService();
  }

  Future<void> _showDialog(message, isLog) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Внимание'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ОК'),
              onPressed: () {
                if (isLog) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSubmitting) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging In...'),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  ],
                ),
                backgroundColor: Color(0xffffae88),
              ),
            );
        }

        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        icon: loginType == 'email'
                            ? Icon(Icons.email)
                            : Icon(Icons.phone),
                        labelText: loginType == 'email'
                            ? "Введите свой E-mail"
                            : "Введите свой номер телефона",
                      ),
                      keyboardType: loginType == 'email'
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      //autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: "Введите свой пароль",
                      ),
                      obscureText: true,
                      // autovalidateMode: Type,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? 'Invalid Password'
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 250,
                      child: FloatingActionButton.extended(
                        heroTag: 'logIn',
                        backgroundColor: const Color(0xff00c853),
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _onFormSubmitted();
                        },
                        label: Text('Войти в аккаунт'),
                        icon: Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 250,
                      child: FloatingActionButton.extended(
                        heroTag: 'phone',
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          setState(() {
                            loginType == 'phone'
                                ? loginType = 'email'
                                : loginType = 'phone';
                          });
                        },
                        label: loginType == 'phone'
                            ? Text('Войти по почте')
                            : Text('Войти по номеру телефона'),
                        icon: Icon(
                          loginType == 'phone' ? Icons.mail : Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        'Нет аккаунта ?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 250,
                      child: FloatingActionButton.extended(
                        heroTag: 'register',
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                        label: Text('Зарегистрироваться'),
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        FlatButton(
                          onPressed: () {
                            //logIn VK
                          },
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image: new AssetImage('assets/icons/vk.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        FlatButton(
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          onPressed: () {
                            // logIn google
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: new BoxDecoration(
                              image: new DecorationImage(
                                image:
                                    new AssetImage('assets/icons/google.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() async {
    if (_loginController.text != '' && _passwordController.text != '') {
      var signInResponse =
          await _authService.signIn(_loginController.text, _passwordController.text);
      if (signInResponse.code == 201) {
        Navigator.of(context).pushNamed('/home');
      } else {
        _showDialog(
            'Неверный ${loginType == 'phone' ? 'телефон' : 'e-mail'} или пароль',
            false);
      }
    } else {
      _showDialog('Необходимо заполнить все поля', false);
    }
  }
}
