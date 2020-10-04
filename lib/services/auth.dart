import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reboeng/services/model/User.dart';


class AuthServices{
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<FirebaseUser> signInAnonymous() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = result.user;
      return firebaseUser;
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  static Future<FirebaseUser> signUp(String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      return firebaseUser;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<FirebaseUser> signIn(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      return firebaseUser;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  static Future<void> signOut() async{
    _auth.signOut();
  }

  static Stream<FirebaseUser> get firebaseUserStream => _auth.onAuthStateChanged;

  Future<FirebaseUser> reloadCurrentUser() async {
    FirebaseUser oldUser = await FirebaseAuth.instance.currentUser();
    oldUser.reload();
    FirebaseUser newUser = await FirebaseAuth.instance.currentUser();
    // Add newUser to a Stream, maybe merge this Stream with onAuthStateChanged?
    return newUser;
  }

  void initSignup(FirebaseUser firebaseUser, String phone, String firstName, String lastName, String password, String email) async {
    var createUser = User(uid: firebaseUser.uid, phone: phone, lastName: lastName, firstName: firstName, email: email, password: password, cartTotal: 0, registeredAt: new Timestamp.now(), profilePhoto: "", status: "member");

    Firestore.instance.collection('user').document(createUser.uid).setData(createUser.toMap());
  }
}
//static Future<FirebaseUser> signUp(String email, String password) async{
//  try{
//    AuthResult result = await _auth.createUserWithEmail
//}
//}