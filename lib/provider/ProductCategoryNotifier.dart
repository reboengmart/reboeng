import 'package:reboeng/services/api/productCategory_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class ProductCategoryNotifier with ChangeNotifier {
  final firestoreService=GetProductCategory();
  String _id;
  String _nama;
  String _status;
  String _assets;

  String get id => _id;
  String get nama =>_nama;
  String get status => _status;
  String get assets=> _assets;

}



