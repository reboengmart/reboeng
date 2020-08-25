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

    QuerySnapshot snapshot = await _db.collection('user').document('$uid').collection('address').getDocuments();

    snapshot.documents.forEach((element) {
      Address address=Address.formMap(element.data);
      _ListAddress.add(address);
    });

    return addressNotifier.addressList=_ListAddress;
  }


}