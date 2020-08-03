class WishList {
  final String id;
  final String sub_product_ref;

  WishList({this.id, this.sub_product_ref});

  WishList.fromFirestore(Map<String, dynamic> firestore)
      : id=firestore['id'],
        sub_product_ref=firestore['sub_product_ref'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sub_product_ref': sub_product_ref
    };
  }
}