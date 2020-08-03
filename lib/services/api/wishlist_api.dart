import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Stream<List<WishList>> getWishList() {
    getauth();
    return  _db.collection('user').document(uid).collection('wishlist').snapshots().map((snapshot) => snapshot.documents.map((document)=> WishList.fromFirestore(document.data)).toList());
  }
  //delete data
  static Future<void> removeWishlist(String id) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    return Firestore.instance.collection('user').document(uid).collection('wishlist').document(id).delete();
  }
  //Create Data
  Future<void> saveWishlist(WishList wishList){
    getauth();
    return Firestore.instance.collection('user').document(uid).collection('wishlist').document(wishList.id).setData(wishList.toMap());
  }
}