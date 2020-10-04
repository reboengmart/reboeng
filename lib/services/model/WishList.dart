class WishListModel{
  final String id;
  final String subProductRef;

  WishListModel({this.id, this.subProductRef});

  WishListModel.fromFirestore(Map<String, dynamic> firestore)
      : id=firestore['id'],
        subProductRef=firestore['sub_product_ref'];


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sub_product_ref': subProductRef
    };
  }
}