import 'package:firebase_auth/firebase_auth.dart';
import 'package:upkeep/profile.dart';
import 'package:flutter/material.dart';
import 'package:upkeep/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: Column(children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 23,
                    backgroundImage: AssetImage('assets/UpKeepi.png'),
                  ),
                  IconButton(
                      icon: Icon(Icons.logout_outlined),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, MyRoutes.loginRoute);
                      }),
                ],
              ),
            ),
          ]),
        ));
  }
}
