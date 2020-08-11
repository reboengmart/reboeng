class Cart{
  final String id;
  final int qty;
  final String name;
  final String price;
  final String assets;
  final String status;
  final String unit;

  Cart({this.id,this.qty,this.name,this.price,this.assets,this.status,this.unit});
  Cart.fromFirestore(Map<String,dynamic> firestore)
      : id=firestore['id'],
        qty=firestore['qty'],
        name=firestore['name'],
        price=firestore['price'],
        assets=firestore['assets'],
        status=firestore['status'],
        unit=firestore['unit'];


  Map<String,dynamic> toMap(){
      return{
        'id':id,
        'qty':qty,
        'name':name,
        'price':price,
        'assets':assets,
        'status':status,
        'unit':unit
      };
  }
}
