import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reboeng/provider/CartNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/SubProduct.dart';

class CartApi{
  //List Data
  Firestore _db = Firestore.instance;

  String uid;
  void getauth() async{
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
  }
  Stream<List<Cart>> getCart() {
   getauth();
    return  _db.collection('cart').where('uid',isEqualTo:uid).snapshots().map((snapshot) => snapshot.documents.map((document)=> Cart.fromFirestore(document.data)).toList());
  }
  static Future<void> subproductReference(SubProductNotifier subProductNotifier, String sub_product_reference) async {
    Firestore _db = Firestore.instance;
    List<SubProduct> _subProduct = [];
    QuerySnapshot snapshot=await _db.collection('sub_product').where('id', isEqualTo: sub_product_reference).getDocuments();
    snapshot.documents.forEach((element) {
      SubProduct productCategory=SubProduct.formMap(element.data);
      _subProduct.add(productCategory);
    });
    return subProductNotifier.subproductList=_subProduct;
  }
  //delete data
  static Future<void> removeCart(String id) {
    return Firestore.instance.collection('cart').document(id).delete();
  }
  //Create Data
  Future<void> saveCart(Cart cart){
    return Firestore.instance.collection('cart').document(cart.id).setData(cart.toMap());
  }
  }



//static Future<void> deleteCart(Cart cart,Function cartDeleted)async{
//    await Firestore.instance.collection('cart').document(cart.id).delete();
//  cartDeleted(cart);
//}
//}