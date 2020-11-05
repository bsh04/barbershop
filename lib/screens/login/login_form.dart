import 'dart:ui';

import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_event.dart';
import 'package:firebaseauthproject/blocs/login_bloc/login_bloc.dart';
import 'package:firebaseauthproject/blocs/login_bloc/login_event.dart';
import 'package:firebaseauthproject/blocs/login_bloc/login_state.dart';
import 'package:firebaseauthproject/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginForm({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

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

  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _loginController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
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
                          Navigator.of(context).pushNamed('/home');
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

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: _loginController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _loginController.text, password: _passwordController.text));
  }
}
