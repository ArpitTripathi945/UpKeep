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

  late TextEditingController amountController;

  late TextEditingController noteController;
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('userdata');
  String dateTime =
      DateFormat(' KK:mm a\n dd/MM/yyyy').format(DateTime.now()).toString();
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
    amountController = TextEditingController();

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
              DropdownButton<String>(
                  hint: Align(
                    child: Text(
                      "Select Tag type",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                  isExpanded: true,
                  alignment: AlignmentDirectional.center,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  value: tag,
                  items: tags.map(buildMenuItem).toList(),
                  onChanged: (value) => setState(() => this.tag = value)),
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
                maxLength: 30,
                autofocus: true,
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
                onPressed: () async {
                  User? user = auth.currentUser;
                  if (formKey.currentState!.validate()) {
                    ExpenseModel expenseModel = ExpenseModel();

                    //writing all the values

                    expenseModel.amount = amountController.text;
                    expenseModel.tag = tag;
                    expenseModel.note = noteController.text;
                    expenseModel.dateTime = dateTime;

                    await ref.doc(user!.uid).collection('userexpenses').add({
                      "amount": amountController.text,
                      "tag": tag,
                      "note": noteController.text,
                      "dateTime": dateTime,
                    }).then((value) {
                      Navigator.pop(context);
                    }).catchError((error) =>
                        print("Failed to add new Expense due to $error"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
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

  // Future<void> sendingExpenses(int index, String amount, String tag,
  //     String note, String dateTime) async {
  //   if (formKey.currentState!.validate()) {
  //     await postExpenseToFirestore();
  //   }
  // }

  // postExpenseToFirestore() async {
  //   //callling our firestore
  //   //calling our expensemodel
  //   //sending these values

  //   // FirebaseFirestore expensefirebaseFirestore = FirebaseFirestore.instance;
  //   User? user = auth.currentUser;

  //   ExpenseModel expenseModel = ExpenseModel();

  //   //writing all the values

  //   expenseModel.index = index;
  //   expenseModel.amount = amountController.text;
  //   expenseModel.tag = tagController.text;
  //   expenseModel.note = noteController.text;
  //   expenseModel.dateTime = dateTime;

  //   await ref.doc(user!.uid).collection('userexpenses').add({
  //     "index": index,
  //     "amount": amountController.text,
  //     "tag": tagController.text,
  //     "note": noteController.text,
  //     "dateTime": dateTime,
  //   }).then((value) {
  //     Navigator.pop(context);
  //   }).catchError((error) => print("Failed to add new Expense due to $error"));
  // }
}
