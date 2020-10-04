import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/cart_api.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/SubProduct.dart';
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
  void saveCart(String id,String stockAwal,String name,String price,String assets,String status,String unit) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newCart=Cart(id:name,qty:1,name:name,price: price,assets: assets,status: status,unit: unit);
    cartApi.saveCart(newCart,name,stockAwal);


  }
  void saveCartPage(String id,String stockAwal,int qty,String name,String price,String assets,String status,String unit) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newCart=Cart(id:name,qty:qty,name:name,price: price,assets: assets,status: status,unit: unit);
    cartApi.saveCart(newCart,name,stockAwal);

  }
  static void kurangqty(String id,int qty, int price, int total) {
    CartApi.removeqty(id,qty,price,total);
  }
  void tambahqty(String subProductId, String id,int qty, int price, int total)async{
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;

    List<SubProduct> _subprodutList = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('sub_product').where('name', isEqualTo: subProductId).getDocuments();
    snapshot.documents.forEach((element) {
      SubProduct subProduct = SubProduct.formMap(element.data);
      _subprodutList.add(subProduct);
    });

    if(qty <= _subprodutList.first.stock){
      CartApi.addqty(id, qty, price, total);
    }
  }
  
}