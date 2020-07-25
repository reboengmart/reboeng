import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/services/model/ProductCategory.dart';

class ProductCategoryApi {

 static Future<void> getProductCategory(ProductCategoryNotifier categoryNotifier) async{
  QuerySnapshot snapshot=await Firestore.instance.collection('category').orderBy('status').getDocuments();

  List<ProductCategory> _ListCategory=[];
  snapshot.documents.forEach((element) {
   ProductCategory productCategory=ProductCategory.formMap(element.data);
   _ListCategory.add(productCategory);
  });

  return categoryNotifier.categoryList=_ListCategory;
 }

}
