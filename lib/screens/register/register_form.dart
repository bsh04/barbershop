import 'package:firebaseauthproject/api/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  bool get isPopulated =>
      _loginController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  AuthService _auth;

  @override
  void initState() {
    super.initState();
    _auth = new AuthService();
  }

  Future<void> _showDialog(message, isReg) async {
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
                if (isReg) {
                  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            children: <Widget>[
              // Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "ФИО",
                ),
                keyboardType: TextInputType.text,
                //autovalidate: true,
                autocorrect: false,
              ),
              // Email
              TextFormField(
                controller: _loginController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "E-mail или телефон",
                ),
                keyboardType: TextInputType.emailAddress,
                // autovalidate: true,
                autocorrect: false,
//                             validator: (_) {
//                                return !state.isEmailValid ? 'Invalid Password' : null;
//                             },
              ),
              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Пароль",
                ),
                obscureText: true,
                // autovalidate: true,
                autocorrect: false,
//                             validator: (_) {
//                                return !state.isPasswordValid ? 'Invalid Password' : null;
//                             },
              ),
              // Confirm password
              TextFormField(
                controller: _passwordConfirmController,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: "Повторите пароль",
                ),
                obscureText: true,
                // autovalidate: true,
                autocorrect: false,
//                             validator: (_) {
//                                return !state.isPasswordValid ? 'Invalid Password' : null;
//                             },
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 250,
                child: FloatingActionButton.extended(
                  heroTag: 'register',
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: () {
                    if (true) {
                      // isButtonEnabled
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
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() async {
    if (_loginController.text != '' &&
        _passwordController.text != '' &&
        _nameController.text != '' &&
        _passwordConfirmController.text != '') {
      if (_passwordConfirmController.text != _passwordController.text) {
        _showDialog('Пароли не одинаковы', false);
      } else {
        var registerResponse = await _auth.signUp(_nameController.text,
            _loginController.text, _passwordController.text);
        if (registerResponse.code == 201) {
          _showDialog(registerResponse.message, true);
        } else {
          _showDialog(registerResponse.message, false);
        }
      }
    } else {
      _showDialog('Все поля должны быть заполнены!', false);
    }
  }
}
