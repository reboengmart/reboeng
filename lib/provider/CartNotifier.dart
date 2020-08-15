import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/cart_api.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:uuid/uuid.dart';


class CartNotifier with ChangeNotifier{
  final cartApi=CartApi();
//  final firestoreService2=CartApi();
  String _id;
  int _qty;
//  String _sub_product_ref;
//  String _user_ref;
  String _name,_price,_assets,_status,_unit;
  String uid;
  var uuid=Uuid();
  String get id =>_id;
  int get qty => _qty;
  String get name =>_name;
  String get price =>_price;
  String get assets => _assets;
  String get status => _status;
  String get unit => _unit;
//  String get sub_product_ref=> _sub_product_ref;
//  String get user_ref=> _user_ref;

  static void deleteCart(String id,int price,int total,int qty) {
    CartApi.removeCart(id,price,total,qty);
  }
  void saveCart(String id,String stock_awal,String name,String price,String assets,String status,String unit) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newCart=Cart(id:uuid.v1(),qty:1,name:name,price: price,assets: assets,status: status,unit: unit);
    cartApi.saveCart(newCart,id,stock_awal);


  }
  void saveCartPage(String id,String stock_awal,int qty,String name,String price,String assets,String status,String unit) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    int total=int.parse(price) * qty;
    var newCart=Cart(id:uuid.v1(),qty:qty,name:name,price: price,assets: assets,status: status,unit: unit);
    cartApi.saveCart(newCart,id,stock_awal);

  }
  static void kurangqty(String id,int qty, int price, int total) {
    CartApi.removeqty(id,qty,price,total);
  }
  static void tambahqty(String id,int qty, int price, int total){
    CartApi.addqty(id, qty, price, total);
  }
  
}