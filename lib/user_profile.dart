import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upkeep/model/profile_model.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/service_locator.dart';
import 'package:upkeep/services/auth_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  ProfileModel loggedInUser = ProfileModel();
  final CollectionReference profile =
      FirebaseFirestore.instance.collection('profile');

  @override
  void initState() {
    super.initState();
    profile.doc(user!.uid).get().then((value) {
      this.loggedInUser = ProfileModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 15, 17, 32),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.logout_outlined),
                          color: Colors.white,
                          onPressed: () {
                            locator<AuthService>().signOut();
                            Navigator.pushNamed(context, MyRoutes.loginRoute);
                          }),
                    ]),
                Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.lobster().fontFamily,
                    fontSize: 50.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 59.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    maxRadius: 55.0,
                    child: CircleAvatar(
                      maxRadius: 50.0,
                      backgroundColor: Colors.blueAccent,
                      child: Image.asset('assets/Wallet_icon.png',
                          alignment: Alignment.topCenter),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Text('Firstname',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 10, color: Colors.white)),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 10.0,
                  shadowColor: Colors.blueAccent,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                      tileColor: Color.fromARGB(255, 173, 176, 201),
                      title: Text(
                        '${loggedInUser.firstname}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(height: 15),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 10.0,
                  shadowColor: Colors.blueAccent,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                      tileColor: Color.fromARGB(255, 173, 176, 201),
                      title: Text(
                        '${loggedInUser.email}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(height: 15),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 10.0,
                  shadowColor: Colors.blueAccent,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                      tileColor: Color.fromARGB(255, 173, 176, 201),
                      title: Text(
                        '${loggedInUser.age}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(height: 15),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 10.0,
                  shadowColor: Colors.blueAccent,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                      tileColor: Color.fromARGB(255, 173, 176, 201),
                      title: Text(
                        '${loggedInUser.currency}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ])),
        ),
      ),
    );
  }
}
