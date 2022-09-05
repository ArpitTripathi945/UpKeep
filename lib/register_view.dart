import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upkeep/expense_view.dart';
import 'package:upkeep/main.dart';
import 'package:upkeep/model/profile_model.dart';
import 'package:upkeep/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:upkeep/service_locator.dart';
import 'package:upkeep/services/auth_service.dart';
import 'package:upkeep/verify.dart';
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
  late TextEditingController firstnameController;
  late TextEditingController ageController;
  late TextEditingController currController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    firstnameController = TextEditingController();
    ageController = TextEditingController();
    currController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color.fromARGB(255, 15, 17, 32),
        child: SingleChildScrollView(
            child: Form(
                key: formKey,
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
                      child: SizedBox(
                        height: 85,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
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
                        ),
                      )),
                  const SizedBox(height: 2),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        height: 85,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          validator: (value) =>
                              value != null && value.length < 6
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
                        ),
                      )),
                  const SizedBox(height: 2),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        height: 85,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fields cannot be empty';
                            }
                            return null;
                          },
                          maxLength: 10,
                          textCapitalization: TextCapitalization.words,
                          controller: firstnameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black45,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: "FirstName",
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      )),
                  const SizedBox(height: 2),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        height: 85,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fields cannot be empty';
                            }
                            return null;
                          },
                          maxLength: 2,
                          keyboardType: TextInputType.number,
                          controller: ageController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black45,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: "Age",
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      )),
                  const SizedBox(height: 2),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: SizedBox(
                        height: 85,
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Fields cannot be empty';
                            }
                            return null;
                          },
                          maxLength: 3,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          controller: currController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.black45,
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              labelText: "Currency",
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300),
                              hintText: "INR, EUR, etc",
                              hintStyle: const TextStyle(
                                color: Colors.white38,
                                fontSize: 12,
                              )),
                        ),
                      )),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      signUp(emailController.text, passwordController.text);
                    },
                    child: Text("Let's go!"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 60),
                      primary: Color.fromARGB(255, 75, 71, 232),
                    ),
                  ),
                ]))));
  }

  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      await locator<AuthService>()
          .createUser(
              email: emailController.text, password: passwordController.text)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //callling our firestore
    //calling our usermodel
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    ProfileModel profileModel =
        ProfileModel(age: '', email: '', firstname: '', currency: '', uid: '');

    //writing all the values
    profileModel.uid = user!.uid;
    profileModel.email = emailController.text;
    profileModel.firstname = firstnameController.text;
    profileModel.age = ageController.text;
    profileModel.currency = currController.text;

    await firebaseFirestore
        .collection("profile")
        .doc(user.uid)
        .set(profileModel.toMap());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => VerifyEmailView()),
        (route) => false);
  }
}
