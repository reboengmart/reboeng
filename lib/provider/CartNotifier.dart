import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/cart_api.dart';


class CartNotifier with ChangeNotifier{
  final firestoreService=CartApi();
  String _id;
  int _qty;
  String _sub_product_ref;
  String _user_ref;

  String get id =>_id;
  int get qty => _qty;
  String get sub_product_ref=> _sub_product_ref;
  String get user_ref=> _user_ref;

  static void deleteCart(String id) {
    CartApi.removeCart(id);
  }


}