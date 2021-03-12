part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';
}

class Authenticated extends AuthState {
  final User _userCredential;

  Authenticated(this._userCredential);

  @override
  List<Object> get props => [_userCredential];
}
