import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return  _db.collection('user').document("3X5i43n1RzSiCk2mOrGqziiOjNJ3").collection('cart').snapshots().map((snapshot) => snapshot.documents.map((document)=> Cart.fromFirestore(document.data)).toList());
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
  //delete data
  static Future<void> removeCart(String id) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    return Firestore.instance.collection('user').document(uid).collection('cart').document(id).delete();
  }
  //Create Data
  Future<void> saveCart(Cart cart)async{
    getauth();
    QuerySnapshot snapshot=await Firestore.instance.collection('user').where('uid', isEqualTo: '$uid').getDocuments();
    final _cartTotal = List.generate(snapshot.documents.length, (index) => snapshot.documents[index].data['cartTotal']);
    int cartTotal=int.parse(_cartTotal[0].toString());
    Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':cartTotal + int.parse(cart.price)});
    return Firestore.instance.collection('user').document(uid).collection('cart').document(cart.id).setData(cart.toMap());
  }
  static Future<void> removeqty(String id,int qty, int price, int total) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    int hasil = total-price*qty;
    Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':hasil});
    return Firestore.instance.collection('user').document(uid).collection('cart').document(id).updateData({'qty':qty,'price':price});
  }
  }



//static Future<void> deleteCart(Cart cart,Function cartDeleted)async{
//    await Firestore.instance.collection('cart').document(cart.id).delete();
//  cartDeleted(cart);
//}
//}