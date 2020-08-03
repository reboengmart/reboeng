

class User{
  String email,first_name,last_name,password,phone,uid,id;
  User({this.id, this.uid, this.phone, this.last_name, this.first_name, this.email, this.password});
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'uid':uid,
      'phone':phone,
      'last_name':last_name,
      'first_name':first_name,
      'email':email,
      'password':password,

    };
  }

  User.fromFirestore(Map<String,dynamic> firestore)
       : id=firestore['id'],
         uid=firestore['uid'],
         phone=firestore['phone'],
         last_name=firestore['last_name'],
         first_name=firestore['first_name'],
         email=firestore['email'],
         password=firestore['password'];



//  List<Cart> get cart => null;

//  User.fromMap(Map<String, dynamic> map) {
//    this.id = map['id'];
//    this.uid = map['uid'];
//    this.phone = map['phone'];
//    this.last_name = map['last_name'];
//    this.first_name = map['first_name'];
//    this.email = map['email'];
//    this.password = map['password'];
//    this.cart = map['cart'].map((Map<String, dynamic> restFood) {
//      Map<String, dynamic> food = {
//        'id': restFood['id'],
//        'qty': restFood['qty'],
//        'sub_product_ref': restFood['sub_product_ref'],
//      };
//      return food;
//    }).toList();
//    this.wishlist = map['wishlist'].map((Map<String, dynamic> restFood) {
//      Map<String, dynamic> food = {
//        'sub_product_ref': restFood['sub_product_ref'],
//      };
//      return food;
//    }).toList();
//  }
}
//class Cart{
//  final String id;
//  final int qty;
//  final String sub_product_ref;
//
//  Cart({this.id, this.sub_product_ref, this.qty});
//
//}
