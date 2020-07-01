import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/services/model/ProductCategory.dart';
class GetProductCategory {
  Firestore _db = Firestore.instance;
   Stream<List<ProductCategory>> getCategory(){
    return  _db.collection('category').snapshots().map((snapshot) => snapshot.documents.map((document)=> ProductCategory.fromFirestore(document.data)).toList());
   }
}
