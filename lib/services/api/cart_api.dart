import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/auth.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/SubProduct.dart';

class CartApi {
  //List Data
  Firestore _db = Firestore.instance;
//  Stream<FirebaseUser> firebaseUserStream = AuthServices.firebaseUserStream;
//  FirebaseUser firebaseUser;
//


  String uid;
  void getauth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
  }

  Stream<List<Cart>> getCart() {
    return _db
        .collection('user')
        .document('${AuthServices().reloadCurrentUser().then((value) {return value.uid;})}')
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Cart.fromFirestore(document.data))
            .toList());
  }

  static Future<void> subproductReference(SubProductNotifier subProductNotifier,
      String subProductReference, int cartItemLength) async {
    Firestore _db = Firestore.instance;
    List<SubProduct> _subProduct = [];
//    _subProduct.isEmpty;
    QuerySnapshot snapshot = await _db
        .collection('sub_product')
        .where('id', isEqualTo: subProductReference)
        .getDocuments();
    snapshot.documents.forEach((element) {
      SubProduct productCategory = SubProduct.formMap(element.data);
//      subProductNotifier.subproductList.add(productCategory);
      if (_subProduct.length < cartItemLength) {
        _subProduct.add(productCategory);
      } else if (_subProduct.length > cartItemLength) {
        _subProduct.clear();
      }
    });
    return subProductNotifier.subproductList = _subProduct;
  }

  //delete data
  static Future<void> removeCart(
      String id, int price, int total, int qty) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    int hasil = total - price * qty;
    Firestore.instance
        .collection('user')
        .document('$uid')
        .updateData({'cartTotal': hasil});
    return Firestore.instance
        .collection('user')
        .document(uid)
        .collection('cart')
        .document(id)
        .delete();
  }

  //Create Data
  Future<void> saveCart(Cart cart, String id, String stockAwal) async {
    getauth();
    QuerySnapshot snapshotvalidate = await Firestore.instance.collection('user')
        .document('$uid')
        .collection('cart')
        .where('name', isEqualTo: cart.name).getDocuments();
    if(snapshotvalidate.documents != null){
      QuerySnapshot snapshot = await Firestore.instance
          .collection('user')
          .where('uid', isEqualTo: '$uid')
          .getDocuments();
      final _cartTotal = List.generate(snapshot.documents.length,
              (index) => snapshot.documents[index].data['cartTotal']);
      int cartTotal = _cartTotal.first;
//      int hasil = int.parse(stockAwal) - cart.qty;
      int hasil1 = cartTotal + int.parse(cart.price);
      return validateCartCollection().then((exist) {
        if(exist){
          return validateEnvironment(cart.id).then((value) {
            if (!value) {
              Firestore.instance.collection('user').document('$uid').updateData(
                  {'cartTotal': cartTotal + int.parse(cart.price) * cart.qty});
              return Firestore.instance
                  .collection('user')
                  .document(uid)
                  .collection('cart')
                  .document(cart.id)
                  .setData(cart.toMap());
            } else {
              Firestore.instance
                  .collection('user')
                  .document('$uid')
                  .updateData({'cartTotal': hasil1});
              return Firestore.instance
                  .collection('user')
                  .document(uid)
                  .collection('cart')
                  .document(id)
                  .updateData({'qty': cart.qty});
            }
          });
        }else{
          String randomUid = randomAlpha(20);
          Firestore.instance.collection('user').document('$uid').collection('cart').document(randomUid).setData({});
          Firestore.instance.collection('user').document('$uid').updateData(
              {'cartTotal': cartTotal + int.parse(cart.price) * cart.qty});
          Firestore.instance
              .collection('user')
              .document(uid)
              .collection('cart')
              .document(cart.id)
              .setData(cart.toMap());
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
        .collection('cart')
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
          .collection("cart")
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

  static Future<bool> validateEnvironment(String idcart) async {
    bool exists = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uidd = user.uid;
    try {
      await Firestore.instance
          .collection("user")
          .document(uidd)
          .collection("cart")
          .document(idcart)
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

  static Future<void> removeqty(
      String id, int qty, int price, int total) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    int hasil = total - price;
//    int pricee = price - price;
    Firestore.instance
        .collection('user')
        .document('$uid')
        .updateData({'cartTotal': hasil});
    return Firestore.instance
        .collection('user')
        .document(uid)
        .collection('cart')
        .document(id)
        .updateData({'qty': qty});
  }

  static Future<void> addqty(String id, int qty, int price, int total) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    int hasil = total + price;
//    int pricee = price + price;
    Firestore.instance
        .collection('user')
        .document('$uid')
        .updateData({'cartTotal': hasil});
    return Firestore.instance
        .collection('user')
        .document(uid)
        .collection('cart')
        .document(id)
        .updateData({'qty': qty});
  }
}

