import 'package:flutter/material.dart';
import 'package:flutter_web_firebase/core/expections/route_exception.dart';
import 'package:flutter_web_firebase/features/authentication/login_view.dart';

enum Screens { LOGIN, HOME }

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings route) {
    var screen = Screens.values.firstWhere((e) => e.toString() == route.name);

    switch (screen) {
      case Screens.LOGIN:
        return MaterialPageRoute(
            builder: (context) => LoginView(), settings: route.arguments);
      case Screens.HOME:
        return MaterialPageRoute(
            builder: (context) => LoginView(), settings: route.arguments);
      default:
        throw RouteException('Route Not Found!');
    }
  }
}
