import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_firebase/features/authentication/widgets/animated_background.dart';
import 'package:flutter_web_firebase/features/home/cubit/home_cubit.dart';
import 'package:flutter_web_firebase/router/app_router.dart';
import 'package:flutter_web_firebase/utils/glass_container.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({
    Key key,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  HomeCubit _homeCubit;

  @override
  void initState() {
    _homeCubit = BlocProvider.of<HomeCubit>(context);
    _homeCubit.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBackground(),
          BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is UserSignedOutFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
              if (state is UserSignedOut) {
                Navigator.of(context)
                    .pushReplacementNamed(Screens.LOGIN.toString());
              }
            },
            builder: (context, state) {
              if (state is UserCredentailsLoaded) {
                return Container(
                  height: 500,
                  width: 600,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                          bottom: 20,
                          child: GlassContainer(
                            padding: EdgeInsets.all(40),
                            boderRadius: BorderRadius.all(Radius.circular(24)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UserTile(
                                    title: "Name",
                                    data: "${state.user.displayName}"),
                                UserTile(
                                    title: "Email",
                                    data: "${state.user.email}"),
                                UserTile(
                                    title: "Phone Number",
                                    data: "${state.user.phoneNumber}"),
                                UserTile(
                                    title: "UID", data: "${state.user.uid}"),
                                SizedBox(height: 32),
                                Container(
                                  width: 500,
                                  child: TextButton(
                                      onPressed: _logoutPressed,
                                      child: Text('LOGOUT')),
                                )
                              ],
                            ),
                          )),
                      CircleAvatar(
                        maxRadius: 60,
                        backgroundImage: NetworkImage(state.user.photoURL),
                      ),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  void _logoutPressed() {
    _homeCubit.userLogout();
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    Key key,
    @required this.title,
    @required this.data,
  }) : super(key: key);

  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$title', style: Theme.of(context).textTheme.caption),
        Text('${data ?? 'NA'}', style: Theme.of(context).textTheme.headline6),
        SizedBox(height: 24),
      ],
    );
  }
}
