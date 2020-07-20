import 'package:reboeng/services/api/productList_api.dart';

class ProductServices{
  static Future<void> listProduct(String idReference) async {
    try{
      ProductListApi().productList(idReference);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}