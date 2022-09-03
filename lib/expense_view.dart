import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:upkeep/search_view.dart';
import 'package:upkeep/service_locator.dart';
import 'package:upkeep/user_analytics.dart';
import 'package:upkeep/add_expense_screen.dart';

import 'package:upkeep/model/expense_model.dart';
import 'package:upkeep/model/profile_model.dart';
import 'package:upkeep/routes.dart';
import 'package:intl/intl.dart';
import 'package:upkeep/user_profile.dart';
import 'package:upkeep/widgets/spinner.dart';

class ExpenseView extends StatefulWidget {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  State<ExpenseView> createState() => _ExpenseViewState();
}

class _ExpenseViewState extends State<ExpenseView> {
  int currentIndex = 0;
  User? user = FirebaseAuth.instance.currentUser;
  ProfileModel loggedInUser = ProfileModel();
  late TextEditingController updateamountController;
  late TextEditingController updatetagController;
  late TextEditingController updatenoteController;
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('expenses');
  final List<Widget> screens = [
    ExpenseView(),
    UserProfile(),
    SearchView(),
    UserAnalytics()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = ExpenseView();
  bool shouldPop = false;

  @override
  void initState() {
    super.initState();
    updateamountController = TextEditingController();
    updatetagController = TextEditingController();
    updatenoteController = TextEditingController();
    FirebaseFirestore.instance
        .collection("profile")
        .doc(user!.uid)
        .get()
        .then((value) {
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
      child: Scaffold(
        body: Padding(
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
                    Icon(
                      Icons.wallet_rounded,
                      size: 28.0,
                      color: Colors.white,
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
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
                    //   child: IconButton(
                    //       icon: Icon(Icons.logout_outlined),
                    //       color: Colors.white,
                    //       onPressed: () {
                    //         FirebaseAuth.instance.signOut();
                    //         Navigator.pushNamed(context, MyRoutes.loginRoute);
                    //       }),
                    // ),
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
                  stream: expenses
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
        backgroundColor: Color.fromARGB(255, 15, 17, 32),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 75, 71, 232),
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                          child: Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddExpenseScreen(),
                      )));
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Color.fromARGB(255, 2, 4, 18),
          notchMargin: 10,
          child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 90,
                        onPressed: () {
                          setState(() {
                            currentScreen = ExpenseView();
                            currentIndex = 0;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.home,
                                color: currentIndex == 0
                                    ? Colors.blueAccent
                                    : Colors.white,
                              ),
                            ]),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = UserProfile();
                            currentIndex = 1;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: currentIndex == 1
                                    ? Colors.blueAccent
                                    : Colors.white,
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          setState(() {
                            currentScreen = SearchView();
                            currentIndex = 2;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: currentIndex == 2
                                    ? Colors.blueAccent
                                    : Colors.white,
                              ),
                            ]),
                      ),
                      MaterialButton(
                        minWidth: 90,
                        onPressed: () {
                          setState(() {
                            currentScreen = UserAnalytics();
                            currentIndex = 3;
                          });
                        },
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bar_chart_rounded,
                                color: currentIndex == 3
                                    ? Colors.blueAccent
                                    : Colors.white,
                              ),
                            ]),
                      ),
                    ],
                  ),
                ],
              )),
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
                            maxLength: 15,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            controller: updatetagController,
                            decoration: InputDecoration(
                                hintText: 'Update tag',
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
                              final String amount = updateamountController.text;
                              final String tag = updatetagController.text;
                              final String note = updatenoteController.text;
                              if (amount != null) {
                                await expenses
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
    final CollectionReference expenses =
        FirebaseFirestore.instance.collection('expenses');
    await expenses.doc(productId).delete();
  }
}
