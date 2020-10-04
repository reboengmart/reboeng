import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/ProductListNotifier.dart';
import 'package:reboeng/services/model/ProductList.dart';

class ProductListApi{
  static Future<void> getProducts(ProductListNotifier productListNotifier, String id) async{
    QuerySnapshot snapshot = await Firestore.instance.collection('product').where('category_ref', isEqualTo: id).getDocuments();

    List<ProductList> _listProduct=[];
    snapshot.documents.forEach((element) {
      ProductList productList=ProductList.formMap(element.data);
      _listProduct.add(productList);
    });

    return productListNotifier.productList=_listProduct;
  }
}