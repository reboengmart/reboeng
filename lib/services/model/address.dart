import 'package:cloud_firestore/cloud_firestore.dart';

class Address{
  String id;
  String nama;
  GeoPoint geo;
  String detail;
  String icon;
  String status;
  Address({this.id, this.nama,this.geo,this.detail,this.icon,this.status});
  Address.formMap(Map<String,dynamic> data){
    id=data['id'];
    nama=data['nama'];
    geo=data['geo'];
    detail=data['detail'];
    icon=data['icon'];
    status=data['status'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'geo': geo,
      'detail': detail,
      'icon': icon,
      'status': status
    };
  }
}