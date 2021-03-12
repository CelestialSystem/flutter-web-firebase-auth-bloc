import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_firebase/features/authentication/widgets/animated_background.dart';
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
      child: Card(
        elevation: 32,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Container(
          color: Colors.white,
          height: 600,
          width: 1200,
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBackground(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        Image.asset('lib/resources/images/img-teksna-logo.png'),
                  ),
                ],
              )),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.isSuccess) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Logged In Successfully.")));
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: _emailController,
                            autocorrect: false,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) =>
                                state.isEmailValid ? null : 'Invalid Username',
                            decoration: InputDecoration(labelText: "Username"),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            autocorrect: false,
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => state.isPasswordValid
                                ? null
                                : 'Invalid Password',
                            decoration: InputDecoration(labelText: "Password"),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          TextButton(
                              onPressed:
                                  state.isFormValid ? _onLoginPressed : null,
                              child: Text("LOGIN")),
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
        ),
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
    return TextButton.icon(
      icon: Icon(FontAwesomeIcons.google),
      onPressed: () {
        BlocProvider.of<LoginBloc>(context).add(GoogleLoginClicked());
      },
      label: Text('Sign in with Google'),
    );
  }
}
