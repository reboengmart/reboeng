import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/services/model/ProductCategory.dart';
class ProductCategoryApi {

 static Future<void> getProductCategory() async{
  ProductCategoryNotifier categoryNotifier;
  QuerySnapshot snapshot=await Firestore.instance.collection('category').orderBy('status').getDocuments();

  List<ProductCategory> _ListCategory=[];
  snapshot.documents.forEach((element) {
   ProductCategory productCategory=ProductCategory.formMap(element.data);
   _ListCategory.add(productCategory);
  });

  categoryNotifier.categoryList=_ListCategory;
 }
//  Firestore _db = Firestore.instance;
//   Stream<List<ProductCategory>> getCategory(){
//    return  _db
//        .collection('category')
//        .orderBy('status')
//        .snapshots()
//        .map((snapshot)
//    => snapshot.documents.map((document)
//    => ProductCategory.fromFirestore(document.data)).toList());
//   }

}
