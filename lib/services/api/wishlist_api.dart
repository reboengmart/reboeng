import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/model/SubProduct.dart';
import 'package:reboeng/services/model/WishList.dart';

class WishListApi{
  Firestore _db = Firestore.instance;

  String uid;
  void getauth() async{
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
  }
  //show wishlist
  Stream<List<WishListModel>> getWishList() {
    getauth();
    return  _db.collection('user').document("3X5i43n1RzSiCk2mOrGqziiOjNJ3").collection('wishlist').snapshots().map((snapshot) => snapshot.documents.map((document)=> WishListModel.fromFirestore(document.data)).toList());
  }
  //delete data
  static Future<void> removeWishlist(String id) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    return Firestore.instance.collection('user').document(uid).collection('wishlist').document(id).delete();
  }
  //Create Data
  Future<void> saveWishlist(WishListModel wishList){
    getauth();
    return Firestore.instance.collection('user').document(uid).collection('wishlist').document(wishList.id).setData(wishList.toMap());
  }
  static Future<void> subproductReference(SubProductNotifier subProductNotifier, String sub_product_reference, int cartItemLength) async {
    Firestore _db = Firestore.instance;
    List<SubProduct> _subProduct = [];
//    _subProduct.isEmpty;
    QuerySnapshot snapshot=await _db.collection('sub_product').where('id', isEqualTo: sub_product_reference).getDocuments();
    snapshot.documents.forEach((element) {
      SubProduct productCategory=SubProduct.formMap(element.data);
//      subProductNotifier.subproductList.add(productCategory);
      if(_subProduct.length < cartItemLength){
        _subProduct.add(productCategory);
      }else if(_subProduct.length > cartItemLength){
        _subProduct.clear();
      }
    });
    return subProductNotifier.subproductList=_subProduct;
  }
}