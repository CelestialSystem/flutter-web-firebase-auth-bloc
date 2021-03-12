import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_firebase/features/authentication/widgets/animated_background.dart';
import 'package:flutter_web_firebase/router/app_router.dart';
import 'package:flutter_web_firebase/utils/glass_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBackground(),
          GlassContainer(
            boxBorder: Border.all(color: Colors.white.withOpacity(.3)),
            child: Container(
              padding: EdgeInsets.all(40),
              child: BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state.isSuccess) {
                    Navigator.of(context)
                        .pushReplacementNamed(Screens.HOME.toString());
                  }
                  if (state.isFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${state.errorMessage}')));
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Welcome back please login to your account.",
                          style: Theme.of(context).textTheme.caption),
                      SizedBox(
                        height: 56,
                      ),
                      Container(
                        width: 450,
                        child: TextFormField(
                          controller: _emailController,
                          autocorrect: false,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              state.isEmailValid ? null : 'Invalid Username',
                          decoration: InputDecoration(
                              labelText: "Username",
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white))),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        width: 450,
                        child: TextFormField(
                          controller: _passwordController,
                          autocorrect: false,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) =>
                              state.isPasswordValid ? null : 'Invalid Password',
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: Theme.of(context).textTheme.bodyText1,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      width: 2, color: Colors.white))),
                        ),
                      ),
                      SizedBox(
                        height: 56,
                      ),
                      Container(
                        width: 450,
                        child: TextButton(
                            onPressed:
                                state.isFormValid ? _onLoginPressed : null,
                            child: Text("LOGIN",
                                style: Theme.of(context).textTheme.button)),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      GoogleLoginButton(),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLoginPressed() {
    _loginBloc.add(LoginWithCredentialsClicked(
        _emailController.text, _passwordController.text));
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(_emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(_passwordController.text));
  }
}

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      child: TextButton.icon(
        icon: Icon(FontAwesomeIcons.google),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(GoogleLoginClicked());
        },
        label: Text('Sign in with Google',
            style: Theme.of(context).textTheme.button),
      ),
    );
  }
}
