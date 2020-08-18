import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/transaction_api.dart';
import 'package:reboeng/services/model/TransactionModel.dart';

class TransactionNotifier with ChangeNotifier{
  final transactionApi=TransactionApi();

  void saveCartPage() async {

   var newTransaction=TransactionModel();
   transactionApi.saveCart(newTransaction);
  }
}