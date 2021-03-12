import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_firebase/services/services.dart';
import 'package:flutter_web_firebase/utils/validators.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Services _services = ServicesImpl.getInstance();

  LoginBloc() : super(LoginState.empty());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged)
      yield state.update(isEmailValid: Validators.isValidEmail(event.email));

    if (event is PasswordChanged)
      yield state.update(
          isPasswordValid: Validators.isValidPassword(event.password));

    if (event is LoginWithCredentialsClicked)
      yield* _loginWithCredentials(event);

    if (event is GoogleLoginClicked)
      yield* _googleLogin();
    else
      UnimplementedError();
  }

  Stream<LoginState> _loginWithCredentials(
      LoginWithCredentialsClicked event) async* {
    try {
      await _services.firebaseAuthService
          .signInWithEmailPassword(event.email, event.password);
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure('$e');
    }
  }

  Stream<LoginState> _googleLogin() async* {
    try {
      await _services.firebaseAuthService.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure('$e');
    }
  }
}
