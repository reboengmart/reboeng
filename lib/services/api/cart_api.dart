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
  static Future<void> removeCart(String id,int price,int total,int qty) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    int hasil = total-price*qty;
    Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':hasil});
    return Firestore.instance.collection('user').document(uid).collection('cart').document(id).delete();
  }
  //Create Data
  Future<void> saveCart(Cart cart,String id,String stock_awal)async{
    getauth();
    QuerySnapshot snapshot=await Firestore.instance.collection('user').where('uid', isEqualTo: '$uid').getDocuments();
    QuerySnapshot snapshotnama=await Firestore.instance.collection('user').document('$uid').collection('cart').where('id',isEqualTo: id).getDocuments();
    final _cartTotal = List.generate(snapshot.documents.length, (index) => snapshot.documents[index].data['cartTotal']);
    int cartTotal=int.parse(_cartTotal[0].toString());
//    final _namabarang = List.generate(snapshotnama.documents.length, (index) => snapshotnama.documents[index].data['name']);
//    String namebarang=_namabarang[0].toString();
//    final _namabarang = List.generate(snapshot.documents.length, (index) => snapshot.documents[index].data['name']);
//    String namabarang=_namabarang[0].toString();
    int hasil=int.parse(stock_awal)-cart.qty;
    int hasil1 = cartTotal+int.parse(cart.price);
    // ignore: missing_return
//    validateEnvironment(cart.name,id,cart.id).then((value) {
//      if (!value) {
//        //file not found do dome stuff
//        Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':cartTotal + int.parse(cart.price)*cart.qty});
//        return Firestore.instance.collection('user').document(uid).collection('cart').document(cart.id).setData(cart.toMap());
//      } else {
//      //document exists do some stuff
////        Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':hasil1});
//        return Firestore.instance.collection('user').document(uid).collection('cart').document(id).updateData({'qty':cart.qty});
////        addqty(id, cart.qty, int.parse(cart.price), cartTotal+int.parse(cart.price));
//      }
//    });
//    if(namabarang != null){
//      addqty(id, cart.qty, int.parse(cart.price), cartTotal+int.parse(cart.price));
//    }else{
//      Firestore.instance.collection('sub_product').document(id).updateData({'stock':hasil});

//    }
    validateEnvironment(cart.id).then((value){
      if(!value){
        Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':cartTotal + int.parse(cart.price)*cart.qty});
        return Firestore.instance.collection('user').document(uid).collection('cart').document(cart.id).setData(cart.toMap());
      }else{
        Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':hasil1});
        return Firestore.instance.collection('user').document(uid).collection('cart').document(id).updateData({'qty':cart.qty});
      }
    });

  }
  static Future<bool> validateEnvironment(String idcart) async {
    bool exists = false;
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    final uidd=user.uid;
//    QuerySnapshot snapshotnama=await Firestore.instance.collection('user').document('$uid').collection('cart').where('id',isEqualTo: idcart).getDocuments();
//    final _namabarang = List.generate(snapshotnama.documents.length, (index) => snapshotnama.documents[index].data['name']);
//    String namebarang=_namabarang[0].toString();
    try {
      await Firestore.instance.collection("user").document(uidd).collection("cart").document(idcart).get().then((doc) {
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
  static Future<void> removeqty(String id,int qty, int price, int total) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    int hasil = total-price;
    int pricee=price-price;
    Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':hasil});
    return Firestore.instance.collection('user').document(uid).collection('cart').document(id).updateData({'qty':qty});
  }
  static Future<void> addqty(String id,int qty, int price, int total) async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    String uid=user.uid;
    int hasil = total+price;
    int pricee=price+price;
    Firestore.instance.collection('user').document('$uid').updateData({'cartTotal':hasil});
    return Firestore.instance.collection('user').document(uid).collection('cart').document(id).updateData({'qty':qty});
  }
  }



//static Future<void> deleteCart(Cart cart,Function cartDeleted)async{
//    await Firestore.instance.collection('cart').document(cart.id).delete();
//  cartDeleted(cart);
//}
//}