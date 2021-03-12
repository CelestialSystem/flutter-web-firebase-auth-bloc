import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_firebase/services/services.dart';

@immutable
abstract class AppEvent {}

@immutable
abstract class AppState {}

abstract class AppBloc<B extends Bloc<AppEvent, AppState>> {
  set setServices(Services services);
}
