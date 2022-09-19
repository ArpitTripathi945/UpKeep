import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  String? amount;
  String? tag;
  String? note;
  String? dateTime;

  ExpenseModel({this.amount, this.tag, this.note, this.dateTime});

  //receiving data from server
  factory ExpenseModel.fromMap(map) {
    return ExpenseModel(
      amount: map['amount'],
      tag: map['tag'],
      note: map['note'],
      dateTime: map['dateTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'tag': tag,
      'note': note,
      'dateTime': dateTime,
    };
  }
}
