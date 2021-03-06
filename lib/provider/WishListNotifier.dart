import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/wishlist_api.dart';
import 'package:reboeng/services/model/WishList.dart';
import 'package:uuid/uuid.dart';

class WishListNotifier with ChangeNotifier{
  final cartwishList=WishListApi();
//  final firestoreService2=CartApi();
  String _id;
  String _subProductRef;
  String uid;
  var uuid=Uuid();
  String get id =>_id;
  String get subProductRef=> _subProductRef;

   void deleteWishList(String id) {
    WishListApi.removeWishlist(id);
  }

  void deleteWishListIndetail(String id){
     WishListApi.removeWishListIndetail(id);
  }
  void saveWishList(String subProduct) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newCart=WishListModel(id:uuid.v1(),subProductRef:subProduct);
    cartwishList.saveWishlist(newCart);


  }

}