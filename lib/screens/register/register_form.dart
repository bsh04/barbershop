import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:firebaseauthproject/blocs/authentication_bloc/authentication_event.dart';
import 'package:firebaseauthproject/blocs/register_bloc/register_bloc.dart';
import 'package:firebaseauthproject/blocs/register_bloc/register_event.dart';
import 'package:firebaseauthproject/blocs/register_bloc/register_state.dart';
import 'package:firebaseauthproject/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Register Failure'),
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
                    Text('Registering...'),
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
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: "ФИО",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      //autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isEmailValid ? 'Invalid Email' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: "E-mail или телефон",
                      ),
                      obscureText: true,
                      // autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid ? 'Invalid Password' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: "Пароль",
                      ),
                      obscureText: true,
                      // autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid ? 'Invalid Password' : null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: "Повторите пароль",
                      ),
                      obscureText: true,
                      // autovalidate: true,
                      autocorrect: false,
                      validator: (_) {
                        return !state.isPasswordValid ? 'Invalid Password' : null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
                      child: FloatingActionButton.extended(
                        heroTag: 'register',
                        backgroundColor: const Color(0xff64b5f6),
                        foregroundColor: Colors.white,
                        onPressed: () {
                          if (isButtonEnabled(state)) {
                            _onFormSubmitted();
                          }
                        },
                        label: Text('Зарегистрироваться'),
                        icon: Icon(
                          Icons.person_add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
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

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onFormSubmitted() {
    _registerBloc.add(RegisterSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }
}
