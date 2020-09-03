import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reboeng/provider/AddressNotifier.dart';
import 'package:reboeng/services/model/address.dart';

class AddressApi{
  Firestore _db = Firestore.instance;

  String uid,id;

//  void getauth() async {
//    final FirebaseAuth _auth = FirebaseAuth.instance;
//    final FirebaseUser user = await _auth.currentUser();
//    uid = user.uid;
//  }

  Future<void> getUserAddress(AddressNotifier addressNotifier) async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    List<Address> _ListAddress=[];
    List<Address> _ListAddress2=[];
    QuerySnapshot snapshot = await _db.collection('user').document('$uid').collection('address').getDocuments();
    QuerySnapshot snapshot2 = await _db.collection('user').document('$uid').collection('address').where('notSelected',isEqualTo: false).getDocuments();
    snapshot.documents.forEach((element) {
      Address address=Address.formMap(element.data);
      _ListAddress.add(address);
    });
    snapshot2.documents.forEach((element) {
      Address address=Address.formMap(element.data);
      _ListAddress2.add(address);
    });

     addressNotifier.addressList2=_ListAddress2;
    return addressNotifier.addressList=_ListAddress;
  }

  Future<void> getLatlng(AddressNotifier addressNotifier, String id) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    List<Address> _ListAddress=[];
    QuerySnapshot snapshot = await _db.collection('user').document('${uid}').collection('address').where('id', isEqualTo: '$id').getDocuments();
    snapshot.documents.forEach((element) {
      Address address=Address.formMap(element.data);
      _ListAddress.add(address);
    });
    return addressNotifier.addressList=_ListAddress;
  }
  Future<void> saveAddress(Address address) async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    return Firestore.instance.collection('user').document('${uid}').collection('address').document(address.id).setData(address.toMap());
  }

}