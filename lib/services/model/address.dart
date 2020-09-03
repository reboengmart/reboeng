import 'package:cloud_firestore/cloud_firestore.dart';

class Address{
  String id;
  String nama;
  bool notSelected;
  GeoPoint geo;
  String detail;
  String icon;
  String status;
  Address({this.id, this.nama,this.notSelected,this.geo,this.detail,this.icon,this.status});
  Address.formMap(Map<String,dynamic> data){
    id=data['id'];
    nama=data['nama'];
    notSelected=data['notSelected'];
    geo=data['geo'];
    detail=data['detail'];
    icon=data['icon'];
    status=data['status'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'notSelected': notSelected,
      'geo': geo,
      'detail': detail,
      'icon': icon,
      'status': status
    };
  }
}