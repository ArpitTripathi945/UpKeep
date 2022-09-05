import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:upkeep/model/expense_model.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  //final user = FirebaseAuth.instance.currentUser;
  late TextEditingController amountController;
  late TextEditingController tagController;
  late TextEditingController noteController;
  final CollectionReference expenses =
      FirebaseFirestore.instance.collection('expenses');
  String dateTime =
      DateFormat(' kk:mm \n dd/MM/yyyy').format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    tagController = TextEditingController();
    noteController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Container(
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
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Expense',
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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Fields cannot be empty';
                  }
                  return null;
                },
                maxLength: 4,
                autofocus: true,
                textAlign: TextAlign.center,
                controller: amountController,
                decoration: InputDecoration(
                    hintText: 'Amount',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Fields cannot be empty';
                  }
                  return null;
                },
                maxLength: 15,
                autofocus: true,
                textAlign: TextAlign.center,
                controller: tagController,
                decoration: InputDecoration(
                    hintText: 'Tag',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
              ),
              TextFormField(
                textInputAction: TextInputAction.done,
                textCapitalization: TextCapitalization.sentences,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Fields cannot be empty';
                  }
                  return null;
                },
                maxLength: 30,
                autofocus: true,
                textAlign: TextAlign.center,
                controller: noteController,
                decoration: InputDecoration(
                    hintText: 'Any note...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
              ),
              ElevatedButton(
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 15, 17, 32)),
                onPressed: () {
                  sendingExpenses(amountController.text, tagController.text,
                      noteController.text, dateTime);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendingExpenses(
      String amount, String tag, String note, String dateTime) async {
    if (formKey.currentState!.validate()) {
      await postExpenseToFirestore();
    }
  }

  postExpenseToFirestore() async {
    //callling our firestore
    //calling our expensemodel
    //sending these values

    // FirebaseFirestore expensefirebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    ExpenseModel expenseModel = ExpenseModel();

    //writing all the values
    expenseModel.amount = amountController.text;
    expenseModel.tag = tagController.text;
    expenseModel.note = noteController.text;
    expenseModel.dateTime = dateTime;

    await expenses.doc(user!.uid).collection('userexpenses').add({
      "amount": amountController.text,
      "tag": tagController.text,
      "note": noteController.text,
      "dateTime": dateTime
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) => print("Failed to add new Expense due to $error"));
  }
}
