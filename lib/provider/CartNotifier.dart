import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/cart_api.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/SubProduct.dart';
import 'package:reboeng/ui/Screens/CartList/cartlist.dart';
import 'package:uuid/uuid.dart';


class CartNotifier with ChangeNotifier{
  final cartApi=CartApi();
  String _id;
  int _qty;
  String _sub_product_ref;
  String _user_ref;
  String uid;
  var uuid=Uuid();
  String get id =>_id;
  int get qty => _qty;
  String get sub_product_ref=> _sub_product_ref;
  String get user_ref=> _user_ref;

  static void deleteCart(String id) {
    CartApi.removeCart(id);
  }
  void saveCart(String subProduct) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newCart=Cart(id:uuid.v1(),qty:1,sub_product_ref:subProduct,user_ref:uid);
    cartApi.saveCart(newCart);

  }
  void saveCartPage(int qty,String subProduct) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newCart=Cart(id:uuid.v1(),qty:qty,sub_product_ref:subProduct,user_ref:uid);
    cartApi.saveCart(newCart);

  }

}