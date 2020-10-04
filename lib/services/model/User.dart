import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String firstName;
  String lastName;
  String password;
  String phone;
  String uid;
  int cartTotal;
  Timestamp registeredAt;
  String profilePhoto;
  String status;

  User(
      {this.uid,
      this.phone,
      this.lastName,
      this.firstName,
      this.email,
      this.password,
      this.cartTotal,
      this.registeredAt,
      this.profilePhoto,
        this.status
      });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'last_name': lastName,
      'first_name': firstName,
      'email': email,
      'password': password,
      'cartTotal': cartTotal,
      'registered_at': registeredAt,
      'profile_photo' : profilePhoto,
      'status' : status
    };
  }

  User.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        phone = firestore['phone'],
        lastName = firestore['last_name'],
        firstName = firestore['first_name'],
        email = firestore['email'],
        cartTotal = firestore['cartTotal'],
        password = firestore['password'],
        registeredAt = firestore['registered_at'],
        profilePhoto = firestore['profile_photo'],
        status = firestore['status'];

  User.formMap(Map<String,dynamic> firestore){
    uid = firestore['uid'];
    phone = firestore['phone'];
    lastName = firestore['last_name'];
    firstName = firestore['first_name'];
    email = firestore['email'];
    cartTotal = firestore['cartTotal'];
    password = firestore['password'];
    registeredAt = firestore['registered_at'];
    profilePhoto = firestore['profile_photo'];
    status = firestore['status'];
  }
}
