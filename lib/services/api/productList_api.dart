import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/ProductListNotifier.dart';

class ProductListApi{
  Firestore _db = Firestore.instance;
  productList(String id) {
    ProductListNotifier().listOfProduct.clear();
    return _db.collection("product")
        .where('category_ref', isEqualTo: id)
        .getDocuments()
        .then((QuerySnapshot snapshot) {snapshot.documents.forEach((element)
    => ProductListNotifier().listOfProduct.add(element.data));});
  }
}