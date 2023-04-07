import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:upkeep/screens/about_view.dart';

import 'package:upkeep/screens/search_view.dart';
import 'package:upkeep/screens/service_locator.dart';
import 'package:upkeep/screens/user_analytics.dart';
import 'package:upkeep/screens/add_expense_screen.dart';

import 'package:upkeep/model/profile_model.dart';
import 'package:upkeep/routes.dart';
import 'package:intl/intl.dart';
import 'package:upkeep/screens/user_profile.dart';
import 'package:upkeep/widgets/spinner.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  User? user = FirebaseAuth.instance.currentUser;
  ProfileModel loggedInUser = ProfileModel();
  late TextEditingController updateamountController;
  late TextEditingController updatetagController;
  late TextEditingController updatenoteController;
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('userdata');

  bool shouldPop = false;
  String? tag;
  final tags = [
    'Food',
    'Travel',
    'Bills',
    'Service',
    'Shopping',
    'Entertainment',
    'Others'
  ];

  @override
  void initState() {
    super.initState();
    updateamountController = TextEditingController();
    updatetagController = TextEditingController();
    updatenoteController = TextEditingController();
    ref.doc(user!.uid).get().then((value) {
      this.loggedInUser = ProfileModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Material(
        color: Color.fromARGB(255, 15, 17, 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 50.0, left: 15.0, bottom: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      child: Icon(
                        Icons.wallet_rounded,
                        size: 28.0,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AboutView()));
                      },
                    ),
                    Text(
                      ' Welcome, ${loggedInUser.firstname}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your expenses',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM').format(DateTime.now()),
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: ref
                      .doc(user!.uid)
                      .collection('userexpenses')
                      .orderBy("dateTime", descending: true)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //checking the connection state, if we still load the data we display a spinner
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Spinner();
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Container(
                              height: 80,
                              width: 100,
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 10.0,
                                  shadowColor: Colors.blueAccent,
                                  clipBehavior: Clip.antiAlias,

                                  // child: Row(children: [
                                  //   IconButton(
                                  //       icon: Icon(Icons.edit),
                                  //       onPressed: () {
                                  //         _update(documentSnapshot);
                                  //       }),
                                  //   IconButton(
                                  //     icon: Icon(Icons.delete),
                                  //     onPressed: () {
                                  //       _delete(documentSnapshot.id);
                                  //     },
                                  //   ),
                                  //])
                                  child: ListTile(
                                    onTap: () {
                                      update(documentSnapshot);
                                    },
                                    onLongPress: () {
                                      delete(documentSnapshot.id);
                                      Fluttertoast.showToast(
                                          msg:
                                              "You have successfully deleted an expense");
                                    },
                                    tileColor:
                                        Color.fromARGB(255, 173, 176, 201),
                                    leading: Text(
                                      '\u{20B9}' + documentSnapshot["amount"],
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily),
                                    ),
                                    title: Text(
                                      documentSnapshot["tag"],
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily),
                                    ),
                                    subtitle: Text(
                                      documentSnapshot["note"],
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          fontFamily:
                                              GoogleFonts.inter().fontFamily),
                                    ),
                                    trailing: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 30, 0, 0),
                                      child: Text(
                                        documentSnapshot["dateTime"],
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize: 7,
                                            fontWeight: FontWeight.bold,
                                            fontFamily:
                                                GoogleFonts.inter().fontFamily),
                                      ),
                                    ),
                                  )));
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
                    }
                    return Text("Start by adding your first expense",
                        style: GoogleFonts.inter(
                            color: Colors.white, fontWeight: FontWeight.bold));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      updateamountController.text = documentSnapshot['amount'];
      updatetagController.text = documentSnapshot['tag'];
      updatenoteController.text = documentSnapshot['note'];
    }

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                    color: Color(0xff757575),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Update Expense',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: GoogleFonts.lobster().fontFamily,
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 15, 17, 32),
                            ),
                          ),
                          DropdownButton<String>(
                          hint: Align(
                    child: Text(
                      "Update Tag",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  value: tag,
                  items: tags.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.tag = value)),
                          
                          // TextFormField(
                          //   textInputAction: TextInputAction.done,
                          //   textCapitalization: TextCapitalization.sentences,
                          //   maxLength: 15,
                          //   autofocus: true,
                          //   textAlign: TextAlign.center,
                          //   controller: updatetagController,
                          //   decoration: InputDecoration(
                          //       hintText: 'Update tag',
                          //       hintStyle: const TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: 14,
                          //       )),
                          // ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone,
                            maxLength: 4,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            controller: updateamountController,
                            decoration: InputDecoration(
                                hintText: 'Update amount',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                )),
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 30,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            controller: updatenoteController,
                            decoration: InputDecoration(
                                hintText: 'Update note...',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                )),
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 15, 17, 32)),
                            onPressed: () async {
                              final String tag = tag;
                              final String amount = updateamountController.text;
                              final String note = updatenoteController.text;
                              if (amount != null) {
                                await ref
                                    .doc(user!.uid)
                                    .collection('userexpenses')
                                    .doc(documentSnapshot!.id)
                                    .update({
                                  "amount": amount,
                                  "tag": tag,
                                  "note": note
                                });

                                updateamountController.text = '';
                                updatetagController.text = '';
                                updatenoteController.text = '';
                                Navigator.of(context).pop();
                              }
                            },
                          )
                        ],
                      ),
                    )))));
  }

  @override
  Future<void> delete(String productId) async {
    await ref.doc(user!.uid).collection('userexpenses').doc(productId).delete();
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
}
