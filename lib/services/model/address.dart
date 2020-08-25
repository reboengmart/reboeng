import 'package:cloud_firestore/cloud_firestore.dart';

class Address{
  String id;
  String nama;
  bool notSelected;
  GeoPoint geo;
  String detail;
  String icon;
  String status;
  Address.formMap(Map<String,dynamic> data){
    id=data['id'];
    nama=data['nama'];
    notSelected=data['notSelected'];
    geo=data['geo'];
    detail=data['detail'];
    icon=data['icon'];
    status=data['status'];
  }
}