class DetaiInvoiceModel {
  int qty;
  String name;
  String assets;
  String price;
  String unit;
  String total_price;
  String status;

  DetaiInvoiceModel({this.price,this.qty,this.name,this.assets,this.status,this.unit,this.total_price});

  DetaiInvoiceModel.fromFirestore(Map<String,dynamic> firestore)
      :price=firestore['price'],
        qty=firestore['qty'],
        name=firestore['name'],
        assets=firestore['assets'],
        status=firestore['status'],
        unit=firestore['unit'],
        total_price=firestore['price'];
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

  DetaiInvoiceModel.formMap(Map<String,dynamic> firestore){
    price=firestore['price'];
    qty=firestore['qty'];
    name=firestore['name'];
    assets=firestore['assets'];
    status=firestore['status'];
    unit=firestore['unit'];
    total_price=firestore['price'];
  }

}