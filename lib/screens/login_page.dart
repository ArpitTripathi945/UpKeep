import 'package:flutter/material.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/widgets/spinner.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 0, 5, 46),
      child: SingleChildScrollView(
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
              color: Color.fromARGB(255, 165, 168, 186),
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 85.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.registerviewRoute);
            },
            child: Text("Register"),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(360, 60),
              primary: Color.fromARGB(255, 75, 71, 232),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.loginviewRoute);
            },
            child: Text("Login"),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(360, 60),
                primary: Color.fromARGB(255, 115, 117, 137)),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }
}
