import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterNameChanged extends RegisterEvent {
  final String name;

  RegisterNameChanged({this.name});

  @override
  List<Object> get props => [name];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({this.password});

  @override
  List<Object> get props => [password];
}

class RegisterPasswordConfirmChanged extends RegisterEvent {
  final String passwordConfirm;

  RegisterPasswordConfirmChanged({this.passwordConfirm});

  @override
  List<Object> get props => [passwordConfirm];
}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  RegisterSubmitted({this.name, this.email, this.password});

  @override
  List<Object> get props => [name, email, password];
}
