import 'package:flutter/material.dart';
import 'package:upkeep/routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 0, 5, 46),
      child: Column(children: [
        const SizedBox(
          height: 100.0,
        ),
        Image.asset(
          "assets/UpKeepi.png",
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 35.0,
        ),
        const Text(
          "Welcome to UpKeep",
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Inter',
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        const Text(
          "A penny saved is a penny earned",
          style: TextStyle(
            color: Color.fromARGB(255, 194, 197, 219),
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: 85.0,
        ),
        Container(
          height: 65,
          width: 370,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Material(
              color: const Color.fromARGB(255, 75, 71, 232),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(7.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.registerviewRoute);
                },
                child: const Center(
                  child: Text("Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        Container(
          height: 65,
          width: 370,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: Material(
              color: const Color.fromARGB(255, 115, 118, 137),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              borderRadius: BorderRadius.circular(7.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MyRoutes.registerviewRoute);
                },
                child: const Center(
                  child: Text("Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
