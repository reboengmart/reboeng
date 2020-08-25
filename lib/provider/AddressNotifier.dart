import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:reboeng/services/model/address.dart';

class AddressNotifier with ChangeNotifier{
  List<Address> _addressList=[];
  Address _currentAddress;

  UnmodifiableListView<Address> get addressList=>UnmodifiableListView(_addressList);
  Address get currentAddress=>_currentAddress;
  set addressList(List<Address> addresList){
    _addressList=addresList;
    notifyListeners();
  }
  set currentAddress(Address address){
    _currentAddress=address;
    notifyListeners();
  }
}