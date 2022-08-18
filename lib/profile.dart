import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upkeep/home_view.dart';
import 'package:upkeep/routes.dart';
import 'package:upkeep/verify.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nickController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController profController = TextEditingController();
    final TextEditingController currController = TextEditingController();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },

      // final value = await showDialog<bool>(
      //     context: context,
      //     builder: (context) {
      //       return AlertDialog(
      //         title: const Text('Alert'),
      //         content: const Text('Do you want to exit'),
      //         actions: [
      //           ElevatedButton(
      //             onPressed: () => Navigator.of(context).pop(false),
      //             child: const Text('No'),
      //           ),
      //           ElevatedButton(
      //             onPressed: () => Navigator.of(context).pop(true),
      //             child: const Text('Exit'),
      //           ),
      //         ],
      //       );
      //     });
      // if (value != null) {
      //   return Future.value(value);
      // } else {
      //   return Future.value(false);
      // }

      child: Material(
          color: Color.fromARGB(255, 15, 17, 32),
          child: Column(children: [
            const SizedBox(height: 90),
            const Text(
              "Setup your profile",
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fields cannot be empty';
                    }
                    return null;
                  },
                  maxLength: 10,
                  textCapitalization: TextCapitalization.words,
                  controller: nickController,
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
                )),
            //const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
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
                )),
            //const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fields cannot be empty';
                    }
                    return null;
                  },
                  maxLength: 10,
                  textCapitalization: TextCapitalization.words,
                  controller: profController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black45,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: "Profession",
                      labelStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w300),
                      hintText: "Student, employee etc.",
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(97, 20, 20, 20),
                        fontSize: 12,
                      )),
                )),
            const SizedBox(height: 12),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: TextFormField(
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
                        borderSide: const BorderSide(color: Colors.white),
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
                )),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerifyEmailView()));
              },
              child: Text("Let's verify you!"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(360, 60),
                primary: Color.fromARGB(255, 75, 71, 232),
              ),
            ),
          ])),
    );
  }
}
