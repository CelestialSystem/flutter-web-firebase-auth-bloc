import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_firebase/features/authentication/login_view.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(16),
                    shadowColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(decorationColor: Colors.white)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(24))))))),
        home: LoginView(),
      ),
    );
  }
}
