import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/ProductListNotifier.dart';
import 'package:reboeng/services/model/ProductCategory.dart';
import 'package:reboeng/services/model/ProductList.dart';

class ProductListApi{
//  Firestore _db = Firestore.instance;
//  List<ProductCategory> _items = [];
//  Future<List<DocumentSnapshot>> productList(String id) async {
//    final prodIndex = _items.indexWhere((prod) => prod.id == id);
////  ProductListNotifier().listOfProduct.clear();
//    return _db.collection("product")
//        .where('category_ref', isEqualTo: prodIndex)
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {snapshot.documents.forEach((element)
//    => ProductListNotifier().listOfProduct.add(element.data));});
//  }

}