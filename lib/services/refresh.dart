import 'package:reboeng/services/api/productCategory_api.dart';

class RefreshService{
  static Future<void> homeRefresh() async{
    await ProductCategoryApi.getProductCategory();
  }
}