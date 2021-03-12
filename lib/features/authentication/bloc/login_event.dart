part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GoogleLoginClicked extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);
  @override
  List<Object> get props => [password];
}

class LoginWithCredentialsClicked extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsClicked(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}

class RegisterWithCredentialsClicked extends LoginEvent {
  final String email;
  final String password;

  RegisterWithCredentialsClicked(this.email, this.password);
  @override
  List<Object> get props => [email, password];
}
