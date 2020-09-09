class DetaiInvoiceModel {
  final int qty;
  final String name;
  final String assets;
  final String price;
  final String unit;
  final String total_price;
  final String status;

  DetaiInvoiceModel({this.price,this.qty,this.name,this.assets,this.status,this.unit,this.total_price});

  DetaiInvoiceModel.fromFirestore(Map<String,dynamic> firestore)
      :price=firestore['price'],
        qty=firestore['qty'],
        name=firestore['name'],
        assets=firestore['assets'],
        status=firestore['status'],
        unit=firestore['unit'],
        total_price=firestore['total_price'];
  Map<String,dynamic> toMap(){
    return{
      'price':price,
      'qty':qty,
      'name':name,
      'assets':assets,
      'status':status,
      'unit':unit,
      'total_price':total_price
    };
  }
}