import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_firebase/services/services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Services _services = ServicesImpl.getInstance();

  void getUser() {
    emit(UserCredentailsLoaded(_services.firebaseAuthService.getUser()));
  }

  void userLogout() async {
    _services.firebaseAuthService.signOut().then((value) {
      emit(UserSignedOut());
    }).catchError((e) {
      emit(UserSignedOutFailure(e.toString()));
    });
  }
}
