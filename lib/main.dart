import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upkeep/home_view.dart';
import 'package:upkeep/login_page.dart';
import 'package:upkeep/login_view.dart';
import 'package:upkeep/register_view.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:upkeep/verify.dart';
import 'firebase_options.dart';
import 'package:upkeep/widgets/spinner.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            }

            //display application
            if (snapshot.connectionState == ConnectionState.done) {
              final User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const HomeView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginPage();
              }
            }
            return SplashScreen();
          },
        ),
      ),
      routes: {
        MyRoutes.homeRoute: (context) => HomeView(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.loginviewRoute: (context) => LoginView(),
        MyRoutes.registerviewRoute: (context) => RegisterView(),
        MyRoutes.verifyRoute: (context) => VerifyEmailView(),
      },
    );
  }
}
