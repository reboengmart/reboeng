import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/api/address_api.dart';
import 'package:reboeng/services/model/address.dart';
import 'package:uuid/uuid.dart';

class AddressNotifier with ChangeNotifier{
  List<Address> _addressList=[];
  List<Address> _addressList2=[];
  Address _currentAddress;
  var uuid=Uuid();
  final addressAPI=AddressApi();
  String uid;
  String _id,_nama,_detail,_icon,_status;
  GeoPoint _geo;
  bool _notSelected;
  //Getter
  String get nama => _nama;
  bool get notSelected => _notSelected;
  GeoPoint get geo => _geo;
  String get detail => _detail;
  String get icon => _icon;
  String get status => _status;

  //Setter
  changeNama(String value){
  _nama =value;
  notifyListeners();
  }

  resetAll(){
    _nama = null;
    _geo = null;
    _detail = null;
    _icon = null;
    notifyListeners();
  }

  changeGeo(GeoPoint point){
    _geo = point;
    notifyListeners();
  }
  changeDetail(String value){
    _detail=value;
    notifyListeners();
  }
  changeIcon(String value){
    _icon=value;
    notifyListeners();
  }
  void getauth() async{
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
  }
  UnmodifiableListView<Address> get addressList=>UnmodifiableListView(_addressList);
  UnmodifiableListView<Address> get addressList2=>UnmodifiableListView(_addressList2);
  Address get currentAddress=>_currentAddress;
  set addressList(List<Address> addresList){
    _addressList=addresList;
    notifyListeners();
  }
  set addressList2(List<Address> addresList){
    _addressList2=addresList;
    notifyListeners();
  }
  set currentAddress(Address address){
    _currentAddress=address;
    notifyListeners();
  }
  void saveAddress() async {
    final FirebaseAuth _auth=FirebaseAuth.instance;
    final FirebaseUser user=await  _auth.currentUser();
    uid=user.uid;
    var newAddress=Address(id:uuid.v1(),nama:nama,geo:geo,detail:detail,icon:icon,status:'not primary');
    addressAPI.saveAddress(newAddress);
  }
}