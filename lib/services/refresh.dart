import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/provider/ProductListNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/api/productCategory_api.dart';
import 'package:reboeng/services/api/productList_api.dart';
import 'package:reboeng/services/api/subproduct.dart';

class RefreshServices{
  static Future<void> homeRefresh(ProductCategoryNotifier categoryNotifier) async{
    return await ProductCategoryApi.getProductCategory(categoryNotifier);
  }

  static Future<void> productListRefresh(ProductListNotifier productListNotifier, String idcategory) async{
   return await ProductListApi.getProducts(productListNotifier, idcategory);
  }

  static Future<void> subProductRefresh(SubProductNotifier subProductNotifier, String id) async {
    return await SubProductApi.getsubProducts(subProductNotifier, id);
  }
}