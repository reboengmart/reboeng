import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
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

  static Future<void> removeWishListIndetail(String id) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    QuerySnapshot snapshot = await Firestore.instance.collection('user').document('$uid').collection('wishlist').where('sub_product_ref', isEqualTo: id).getDocuments();
    return Firestore.instance.collection('user').document(uid).collection('wishlist').document(snapshot.documents.first.documentID).delete();
  }
  //Create Data
  Future<void> saveWishlist(WishListModel wishList) async{
    getauth();

    QuerySnapshot snapshot = await Firestore.instance.collection('user').document('$uid').collection('wishlist').where('sub_product_ref', isEqualTo: wishList.subProductRef).getDocuments();
    if(snapshot.documents != null) {
      return validateCartCollection().then((exist) {
        if(exist){
          return validateEnvironment(wishList.id).then((value) {
            if (!value) {
              return Firestore.instance
                  .collection('user')
                  .document(uid).collection('wishlist')
                  .document(wishList.id).setData(wishList.toMap());
            } else{
              return 0;
            }
          });
        }else{
          String randomUid = randomAlpha(20);
          Firestore.instance.collection('user').document('$uid').collection('wishlist').document(randomUid).setData({});
          Firestore.instance
              .collection('user')
              .document(uid)
              .collection('wishlist')
              .document(wishList.id)
              .setData(wishList.toMap());
          return deleteUndefiniedCartItem(randomUid, uid);
        }
      });
    }else{
      return 0;
    }
  }
  Future<void> deleteUndefiniedCartItem(String id, String uid){
    print(id);
    return Future.delayed(Duration(seconds: 1)).then((value) => Firestore.instance
        .collection('user')
        .document(uid)
        .collection('wishlist')
        .document('$id')
        .delete());
  }
  static Future<bool> validateCartCollection() async{
    bool exists = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uidd = user.uid;
    try {
      await Firestore.instance
          .collection("user")
          .document(uidd)
          .collection("wishlist")
          .document()
          .get()
          .then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> validateEnvironment(String idwishlist) async {
    bool exists = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uidd = user.uid;
    try {
      await Firestore.instance
          .collection("user")
          .document(uidd)
          .collection("wishlist")
          .document(idwishlist)
          .get()
          .then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
  static Future<void> subproductReference(SubProductNotifier subProductNotifier, String subProductReference, int cartItemLength) async {
    Firestore _db = Firestore.instance;
    List<SubProduct> _subProduct = [];
//    _subProduct.isEmpty;
    QuerySnapshot snapshot=await _db.collection('sub_product').where('id', isEqualTo: subProductReference).getDocuments();
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