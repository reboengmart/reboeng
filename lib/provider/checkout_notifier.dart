import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/Cart.dart';

class CheckoutNotifier extends ChangeNotifier{
  Cart _currentInvoiceDetail;
  List<Cart> _invoiceDetail;
  String totalTransaction;
  DateTime dateTime;
  int delivery;
  int invoiceTotal;
  int paymentTotal;

  UnmodifiableListView<Cart> get invoiceDetail=>UnmodifiableListView(_invoiceDetail);
  Cart get currentInvoiceDetail=>_currentInvoiceDetail;
  set addressList(List<Cart> invoiceDetail){
    _invoiceDetail=invoiceDetail;
    notifyListeners();
  }



}