import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reboeng/services/model/User.dart';

class UserApi {
  //List Data
  Firestore _db = Firestore.instance;

  String uid,id;

  void getauth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
  }

  Stream<List<User>> getUser() {
    getauth();
    return _db.collection('user').document(uid).collection('cart').snapshots().map((
        snapshot) =>
        snapshot.documents.map((document)=> User.fromFirestore(document.data)).toList());
  }

}