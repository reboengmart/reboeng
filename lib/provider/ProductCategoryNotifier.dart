import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/ProductCategory.dart';

class ProductCategoryNotifier with ChangeNotifier{
  List<ProductCategory> _productCategoryList = [];

  ProductCategory _currentProductCategory;

  UnmodifiableListView<ProductCategory> get productCategoryList => UnmodifiableListView(_productCategoryList);

  ProductCategory get currentProductCategory => _currentProductCategory;

  set productCategoryList(List<ProductCategory> productCategoryList){
    _productCategoryList = productCategoryList;
    notifyListeners();
  }

  set currentProductCategory(ProductCategory productCategory){
    _currentProductCategory = productCategory;
    notifyListeners();
  }


}
