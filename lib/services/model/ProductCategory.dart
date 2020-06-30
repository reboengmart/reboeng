//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';

class ProductCategory{
  String id;
  String nama;
  String status;
  String assets;

//  ProductCategory();

  ProductCategory.fromMap(Map<String, dynamic> data){
    id = data['id'];
    nama = data['nama'];
    status = data['status'];
    assets = data['assets'];
  }

//  Map<String, dynamic> toMap() {
//    return {
//      'category' : category,
//      'assets' : assets
//    };
//  }
}