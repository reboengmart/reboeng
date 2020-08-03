import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/model/SubProduct.dart';

class SubProductApi{
  static Future<void> getsubProducts(SubProductNotifier subProductNotifier, String id) async{
    QuerySnapshot snapshot=await Firestore.instance.collection('sub_product').where('product_ref', isEqualTo: id).getDocuments();

    List<SubProduct> _subListProduct=[];
    snapshot.documents.forEach((element) {
      SubProduct subproductList=SubProduct.formMap(element.data);
      _subListProduct.add(subproductList);
    });

    return subProductNotifier.subproductList=_subListProduct;
  }

  static Future<void> getPromoProducts(SubProductNotifier subProductNotifier, String status) async{
    QuerySnapshot snapshot=await Firestore.instance.collection('sub_product').where('status', isEqualTo: status).getDocuments();

    List<SubProduct> _subListProduct=[];
    snapshot.documents.forEach((element) {
      SubProduct subproductList=SubProduct.formMap(element.data);
      _subListProduct.add(subproductList);
    });

    return subProductNotifier.subproductList=_subListProduct;
  }
}