import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upkeep/model/profile_model.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/screens/service_locator.dart';
import 'package:upkeep/services/auth_service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  User? user = FirebaseAuth.instance.currentUser;
  ProfileModel loggedInUser = ProfileModel();
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('userdata');

  @override
  void initState() {
    super.initState();
    ref.doc(user!.uid).get().then((value) {
      this.loggedInUser = ProfileModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 15, 17, 32),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
        child: Container(
            child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
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
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: GoogleFonts.lobster().fontFamily,
              fontSize: 50.0,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 30),
          const CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 59.0,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              maxRadius: 55.0,
              child: CircleAvatar(
                maxRadius: 50.0,
                backgroundColor: Colors.blueAccent,
                child: Icon(
                  Icons.person,
                  size: 70.0,
                  color: Color.fromARGB(255, 15, 17, 32),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Text('Firstname',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 10, color: Colors.white)),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
          SizedBox(height: 10),
          Text('Email',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 10, color: Colors.white)),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
          SizedBox(height: 10),
          Text('Age',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 10, color: Colors.white)),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
          SizedBox(height: 10),
          Text('Currency',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 10, color: Colors.white)),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
    );
  }
}
