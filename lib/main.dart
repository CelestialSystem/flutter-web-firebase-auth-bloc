import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_firebase/core/app_text_style.dart';
import 'package:flutter_web_firebase/router/app_router.dart';
import 'package:flutter_web_firebase/services/auth/cubit/auth_cubit.dart';
import 'package:flutter_web_firebase/services/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Services _services = ServicesImpl.getInstance();
  AuthCubit _authCubit;

  @override
  void initState() {
    _authCubit = AuthCubit(services: _services);
    _authCubit.appStarted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authCubit,
      child: MaterialApp(
        title: 'Flutter Web Firebase Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: appTextTheme,
            brightness: Brightness.dark,
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    shadowColor: MaterialStateProperty.all(Color(0xffa81d55)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 32, vertical: 24)),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xffa81d55)),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(decorationColor: Colors.white)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))))))),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: Screens.LOGIN.toString(),
      ),
    );
  }
}
