class TransactionModel{
  final String id_transaction;
  final String total_transaction;
  final DateTime date_transaction;
  final DateTime date_invoice;
  final String address;
  final String price;
  final String delivery;
  final String id_invoice;
  final String total_invoice;
  final String total_payment;
  final String user_ref;
  final int qty;
  final String name;
  final String assets;
  final String status;
  final String unit;
  final String total_price;

  TransactionModel({this.id_transaction,this.total_transaction,this.date_transaction,this.date_invoice,this.address,this.price,this.delivery,this.id_invoice,this.total_invoice
    ,this.total_payment,this.user_ref,this.qty,this.name,this.assets,this.status,this.unit,this.total_price});

  TransactionModel.fromFirestore(Map<String,dynamic> firestore)
      : id_transaction=firestore['id_transaction'],
        total_transaction=firestore['total_transaction'],
        date_transaction=firestore['date_transaction'],
        date_invoice=firestore['date_invoice'],
        address=firestore['address'],
        price=firestore['price'],
        delivery=firestore['delivery'],
        id_invoice=firestore['id_invoice'],
        total_invoice=firestore['total_invoice'],
        total_payment=firestore['total_payment'],
        user_ref=firestore['user_ref'],
        qty=firestore['qty'],
        name=firestore['name'],
        assets=firestore['assets'],
        status=firestore['status'],
        unit=firestore['unit'],
        total_price=firestore['total_price'];
  Map<String,dynamic> toMap(){
    return{
      'id_transaction':id_transaction,
      'total_transaction':total_transaction,
      'date_transaction':date_transaction,
      'date_invoice':date_invoice,
      'address':address,
      'price':price,
      'delivery':delivery,
      'id_invoice':id_invoice,
      'total_invoice':total_invoice,
      'total_payment':total_payment,
      'user_ref':user_ref,
      'qty':qty,
      'name':name,
      'assets':assets,
      'status':status,
      'unit':unit,
      'total_price':total_price
    };
  }
}