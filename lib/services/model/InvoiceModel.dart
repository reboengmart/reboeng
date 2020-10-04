import 'package:reboeng/services/model/DetaiInvoiceModel.dart';
class InvoiceModel{
  final DateTime dateInvoice;
  final String address;
  final int delivery;
  final String idInvoice;
  final int totalInvoice;
  final int totalPayment;
  final String userRef;
  final List<DetaiInvoiceModel> detailInvoice;
  InvoiceModel({this.dateInvoice,this.address,this.delivery,this.idInvoice,this.totalInvoice
  ,this.totalPayment,this.userRef,this.detailInvoice});

InvoiceModel.fromFirestore(Map<String,dynamic> firestore)
:dateInvoice=firestore['date_invoice'],
address=firestore['address'],
detailInvoice=firestore['detail_invoice'],
delivery=firestore['delivery'],
idInvoice=firestore['id_invoice'],
totalInvoice=firestore['total_invoice'],
totalPayment=firestore['total_payment'],
userRef=firestore['user_ref'];
Map<String,dynamic> toMap(){
  return{
    'date_invoice':dateInvoice,
    'address':address,
    'delivery':delivery,
    'id_invoice':idInvoice,
    'total_invoice':totalInvoice,
    'total_payment':totalPayment,
    'user_ref':userRef
  };
}


}