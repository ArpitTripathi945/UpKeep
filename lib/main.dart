import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upkeep/home_view.dart';
import 'package:upkeep/login_page.dart';
import 'package:upkeep/login_view.dart';
import 'package:upkeep/profile.dart';
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
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        MyRoutes.homeRoute: (context) => HomeView(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.loginviewRoute: (context) => LoginView(),
        MyRoutes.registerviewRoute: (context) => RegisterView(),
        MyRoutes.profileviewRoute: (context) => ProfileView(),
        MyRoutes.verifyRoute: (context) => VerifyEmailView(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Spinner();
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong!'));
            } else if (snapshot.connectionState == ConnectionState.done) {
              final User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return HomeView();
                } else if (snapshot.hasData) {
                  return ProfileView();
                }
              }
            }
            return LoginPage();
          })));
}
