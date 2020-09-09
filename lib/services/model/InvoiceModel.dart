class InvoiceModel{
  final DateTime date_invoice;
  final String address;
  final String delivery;
  final String id_invoice;
  final String total_invoice;
  final String total_payment;
  final String user_ref;
  final List DetailInvoice;
  InvoiceModel({this.date_invoice,this.address,this.delivery,this.id_invoice,this.total_invoice
  ,this.total_payment,this.user_ref,this.DetailInvoice});

InvoiceModel.fromFirestore(Map<String,dynamic> firestore)
:date_invoice=firestore['date_invoice'],
address=firestore['address'],
DetailInvoice=firestore['DetailInvoice'],
delivery=firestore['delivery'],
id_invoice=firestore['id_invoice'],
total_invoice=firestore['total_invoice'],
total_payment=firestore['total_payment'],
user_ref=firestore['user_ref'];
Map<String,dynamic> toMap(){
  return{
    'date_invoice':date_invoice,
    'address':address,
    'delivery':delivery,
    'id_invoice':id_invoice,
    'total_invoice':total_invoice,
    'total_payment':total_payment,
    'user_ref':user_ref
  };
}
}