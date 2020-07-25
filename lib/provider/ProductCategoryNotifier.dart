import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/ProductCategory.dart';


class ProductCategoryNotifier with ChangeNotifier {
  List<ProductCategory> _categoryList=[];
  ProductCategory _currentCategory;

  UnmodifiableListView<ProductCategory> get categoryList=>UnmodifiableListView(_categoryList);
  ProductCategory get currentCategory=>_currentCategory;
  set categoryList(List<ProductCategory> categoryList){
    _categoryList=categoryList;
    notifyListeners();
  }
  set currentCategory(ProductCategory productCategory){
    _currentCategory=productCategory;
    notifyListeners();
  }
}



