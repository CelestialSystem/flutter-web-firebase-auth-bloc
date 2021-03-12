import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_firebase/services/services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Services _services;
  AuthCubit({@required Services services})
      : assert(services != null),
        _services = services,
        super(Uninitialized());

  void appStarted() {
    try {
      final isSignedIn = _services.firebaseAuthService.isSignedIn();
      if (isSignedIn) {
        final user = _services.firebaseAuthService.getUser();
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  void userLoggedIn() {
    emit(Authenticated(_services.firebaseAuthService.getUser()));
  }

  Future<void> userLoggedOut() async {
    await _services.firebaseAuthService.signOut();
    emit(Unauthenticated());
  }
}
