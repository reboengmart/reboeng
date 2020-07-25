import 'dart:collection';

import 'package:reboeng/services/api/productCategory_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/ProductCategory.dart';


class ProductCategoryNotifier with ChangeNotifier {
//  final firestoreService=GetProductCategory();
  String _id;
  String _nama;
  String _status;
  String _assets;

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



