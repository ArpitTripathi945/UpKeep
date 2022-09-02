import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upkeep/expense_view.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  final TextEditingController nickController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController profController = TextEditingController();
  final TextEditingController currController = TextEditingController();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? ExpenseView()
      : WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Material(
            color: Color.fromARGB(255, 15, 17, 32),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A verification email has been sent to your provided email. Check your spam folder if you are not able to find the email',
                      style: TextStyle(fontSize: 24, color: Colors.white60),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      icon: Icon(Icons.email, size: 32),
                      label: Text(
                        'Resent Email',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                    ),
                    TextButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () => FirebaseAuth.instance.signOut(),
                    )
                  ]),
            ),
          ));

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Fluttertoast.showToast(msg: "Oops! Something went wrong.", fontSize: 18);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      timer?.cancel();
      Fluttertoast.showToast(msg: "Account created successfully :) ");
    }
  }
}
