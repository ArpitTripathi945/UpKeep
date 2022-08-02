import 'package:flutter/material.dart';
import 'package:upkeep/home_page.dart';
import 'package:upkeep/login_page.dart';
import 'package:upkeep/login_view.dart';
import 'package:upkeep/register_view.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.loginviewRoute: (context) => LoginView(),
        MyRoutes.registerviewRoute: (context) => RegisterView(),
      },
    );
  }
}
