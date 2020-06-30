import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/services/model/ProductCategory.dart';

getProductCategory(ProductCategoryNotifier productCategoryNotifier)async{
  QuerySnapshot snapshot = await Firestore.instance
      .collection('category')
      .getDocuments();

  List<ProductCategory> _productCategoryList= [];

  snapshot.documents.forEach((document) {
    ProductCategory productCategory = ProductCategory.fromMap(document.data);
    _productCategoryList.add(productCategory);
  });

  productCategoryNotifier.productCategoryList = _productCategoryList;
}