import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/productList_api.dart';


class ProductListNotifier with ChangeNotifier {
  List listOfProduct;
  final firestoreService = ProductListApi();
  String _id;
  String _nama;
  String _assets;

  String get id => _id;
  List get listOfProductList => listOfProduct;
  String get nama =>_nama;
  String get assets=> _assets;

}



