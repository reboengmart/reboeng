class Cart{
  final String id;
  final int qty;
  final String sub_product_ref;
  final String user_ref;

Cart({this.id,this.qty,this.sub_product_ref,this.user_ref});
  Cart.fromFirestore(Map<String,dynamic> firestore)
      : id=firestore['id'],
        qty=firestore['qty'],
        sub_product_ref=firestore['sub_product_ref'],
        user_ref=firestore['user_ref'];

  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'qty':qty,
      'sub_product_ref':sub_product_ref,
      'user_ref':user_ref
    };
  }
}