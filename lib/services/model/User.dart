class User {
  String email;
  String first_name;
  String last_name;
  String password;
  String phone;
  String uid;
  int cartTotal;
  String create_at;

  User(
      {this.uid,
      this.phone,
      this.last_name,
      this.first_name,
      this.email,
      this.password,
      this.cartTotal,
      this.create_at});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'last_name': last_name,
      'first_name': first_name,
      'email': email,
      'password': password,
      'cartTotal': cartTotal,
      'create_at': create_at,
    };
  }

  User.fromFirestore(Map<String, dynamic> firestore)
      : uid = firestore['uid'],
        phone = firestore['phone'],
        last_name = firestore['last_name'],
        first_name = firestore['first_name'],
        email = firestore['email'],
        cartTotal = firestore['cartTotal'],
        password = firestore['password'],
        create_at = firestore['create_at'];
}
