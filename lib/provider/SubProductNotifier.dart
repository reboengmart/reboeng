import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/SubProduct.dart';

class SubProductNotifier with ChangeNotifier{

  List<SubProduct> _subproductList=[];
  SubProduct _currentsubProduct;

  UnmodifiableListView<SubProduct> get subproductList=>UnmodifiableListView(_subproductList);
  SubProduct get currentsubProduct=>_currentsubProduct;
  set subproductList(List<SubProduct> subproductList){
    _subproductList=subproductList;
    notifyListeners();
  }
  set subcurrentProduct(SubProduct subproductList){
    _currentsubProduct=subproductList;
    notifyListeners();
  }
}