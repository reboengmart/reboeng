import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:reboeng/services/api/transaction_api.dart';
import 'package:reboeng/services/model/DetaiInvoiceModel.dart';
import 'package:reboeng/services/model/InvoiceModel.dart';
import 'package:reboeng/services/model/TransactionModel.dart';
import 'package:reboeng/services/model/User.dart';
import 'package:reboeng/services/model/address.dart';
import 'package:uuid/uuid.dart';

class CheckoutNotifier extends ChangeNotifier{
  String uid;
//  Cart _currentInvoiceDetail;
//  Map<String, dynamic> _invoiceDetail;
  String totalTransaction;
  DateTime dateTime;
  int delivery;
  int invoiceTotal;
  int paymentTotal;

  var uuid = Uuid();
//  UnmodifiableListView<Cart> get invoiceDetail=>UnmodifiableListView(_invoiceDetail);
//  Cart get currentInvoiceDetail=>_currentInvoiceDetail;
//  set addressList(List<Cart> invoiceDetail){
//    _invoiceDetail=invoiceDetail;
//    notifyListeners();
//  }

  void saveTransaction() async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;

    List<Address> _addressList = [];
    List<User> _userList = [];
    Map<String, dynamic> _cartMap = new Map<String, dynamic>();
    List<DetaiInvoiceModel> _array = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('user').document('${uid}').collection('address').where('status', isEqualTo: 'primary').getDocuments();
    snapshot.documents.forEach((element) {
      Address address=Address.formMap(element.data);
      _addressList.add(address);
    });


    QuerySnapshot snapshot1 = await Firestore.instance.collection('user').where('uid', isEqualTo: '${uid}').getDocuments();
    snapshot1.documents.forEach((element) {
      User user=User.formMap(element.data);
      _userList.add(user);
    });

    QuerySnapshot snapshot2 = await Firestore.instance.collection('user').document('${uid}').collection('cart').getDocuments();
    snapshot2.documents.forEach((element) {
      DetaiInvoiceModel detaiInvoiceModel= DetaiInvoiceModel.formMap(element.data);
//      _cartMap.addAll(detaiInvoiceModel.toMap());
      _array.add(detaiInvoiceModel);
    });
    DateTime now = DateTime.now();
    String formattanggal = DateFormat('d MMMM y').format(now);


    var newCheckout = InvoiceModel(date_invoice: DateTime.now(), address: _addressList.first.id, delivery: 3000, id_invoice: randomAlpha(20), total_invoice: _userList.first.cartTotal, total_payment: _userList.first.cartTotal + 3000, user_ref: uid, DetailInvoice: _array);
    var newTransaction = TransactionModel(id_transaction: randomAlpha(20), total_transaction: _userList.first.cartTotal + 3000, date_transaction: formattanggal);
    TransactionApi().saveTransaction(newTransaction,newCheckout);
//    var newAddress=Address(id:uuid.v1(),nama:nama,geo:geo,detail:detail,icon:icon,status:'not primary');
//    addressAPI.saveAddress(newAddress);
  }

}