import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/user_api.dart';
import 'package:reboeng/services/model/User.dart';
import 'package:uuid/uuid.dart';

class UserNotifier with ChangeNotifier{
  final firestoreService=UserApi();
//  final cartApi=CartApi();
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

  List<User> _userList=[];
  User _currentUser;

  UnmodifiableListView<User> get userListt=>UnmodifiableListView(_userList);
  User get currentUser=>_currentUser;
  set userListt(List<User> userListt){
    _currentUser=userListt as User;
    notifyListeners();
  }
  set currentUser(User userList){
    _currentUser=userList;
    notifyListeners();
  }
//  static void deleteCart(String id) {
//    CartApi.removeCart(id);
//  }
//  void saveCart(String subProduct) async {
//    final FirebaseAuth _auth=FirebaseAuth.instance;
//    final FirebaseUser user=await  _auth.currentUser();
//    uid=user.uid;
//    var newCart=Cart(id:uuid.v1(),qty:1,sub_product_ref:subProduct,user_ref:uid);
//    cartApi.saveCart(newCart);
//
//  }
//  void saveCartPage(int qty,String subProduct) async {
//    final FirebaseAuth _auth=FirebaseAuth.instance;
//    final FirebaseUser user=await  _auth.currentUser();
//    uid=user.uid;
//    var newCart=Cart(id:uuid.v1(),qty:qty,sub_product_ref:subProduct,user_ref:uid);
//    cartApi.saveCart(newCart);
//
//  }

}