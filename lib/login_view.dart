import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upkeep/home_view.dart';
import 'package:upkeep/main.dart';
import 'package:upkeep/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upkeep/widgets/spinner.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Material(
          color: Color.fromARGB(255, 15, 17, 32),
          child: SingleChildScrollView(
              child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 325, 20),
              child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  )),
            ),
            const Text(
              "Welcome back!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "We're so excited to see you again",
              style: TextStyle(
                color: Color.fromARGB(255, 165, 168, 186),
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Email");
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black45,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Email",
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                )),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
                  controller: passwordController,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black45,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300),
                  ),
                )),
            const SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = await _auth.signInWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  if (user != null) {
                    Navigator.pushNamed(context, MyRoutes.homeRoute);
                  }
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(
                      msg: "User does not exist",
                      fontSize: 18,
                      toastLength: Toast.LENGTH_LONG);
                }
              },
              child: Text("Login"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(360, 60),
                primary: Color.fromARGB(255, 75, 71, 232),
              ),
            ),
          ]))),
    );
  }
}
