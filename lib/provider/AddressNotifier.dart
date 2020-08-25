import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/address.dart';

class AddressNotifier with ChangeNotifier{
  List<Address> _addressList=[];
  List<Address> _addressList2=[];
  Address _currentAddress;

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
}