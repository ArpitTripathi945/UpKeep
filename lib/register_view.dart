import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upkeep/home_view.dart';
import 'package:upkeep/main.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upkeep/widgets/spinner.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 15, 17, 32),
        child: SingleChildScrollView(
            child: Form(
          // key: formKey,
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
              "Register a new account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
                  controller: emailController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'Enter min. 6 characters'
                      : null,
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
            SizedBox(height: 35),
            ElevatedButton(
              onPressed: () async {
                // final isValid = formKey.currentState!.validate();
                // if (!isValid) return;
                // showDialog(
                //     context: context,
                //     barrierDismissible: false,
                //     builder: (context) => Center(child: Spinner()));
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  if (newUser != null) {
                    Navigator.pushNamed(context, MyRoutes.profileviewRoute);
                  }
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: "User already exists", fontSize: 18);
                  // navigatorKey.currentState!.popUntil((route) => route.isFirst);
                }
              },
              child: Text("Register"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(360, 60),
                primary: Color.fromARGB(255, 75, 71, 232),
              ),
            ),
          ]),
        )));
  }
}
