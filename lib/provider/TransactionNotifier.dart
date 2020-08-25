import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/transaction_api.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/InvoiceModel.dart';
import 'package:reboeng/services/model/TransactionModel.dart';

class TransactionNotifier with ChangeNotifier{
  final transactionApi=TransactionApi();

  void saveCartPage(String id_transaction,String total_transaction,DateTime date_transaction,
      DateTime date_invoice,String address,String assets,String name,String price,int qty,String status,String total_price,String unit) async {
   var invoice=InvoiceModel(date_invoice: date_invoice,assets: assets,name: name,
       price: price,qty: qty,status: status,total_price: qty.toString()*int.parse(price),unit: unit);
   var transaction=TransactionModel(id_transaction: id_transaction,total_transaction: total_transaction,date_transaction: date_transaction);
   List<InvoiceModel> list;
   transactionApi.saveTransaction(transaction);
   transactionApi.saveCart(transaction,invoice,list);
  }
}