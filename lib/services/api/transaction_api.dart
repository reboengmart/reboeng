import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/InvoiceModel.dart';
import 'package:reboeng/services/model/TransactionModel.dart';

class TransactionApi{
  Firestore _db = Firestore.instance;
  Future<void> saveCart(TransactionModel transactionModel,InvoiceModel invoiceModel,List liscart) async{
    DocumentReference docRef=Firestore.instance.collection('transaction').document(transactionModel.id_transaction).collection('invoice').document(invoiceModel.id_invoice);
    DocumentSnapshot doc=await docRef.get();
//    List cart=doc.data['detail_invoice'];
    Firestore.instance.collection('transaction')
        .document(transactionModel.id_transaction)
        .collection('cart')
        .document(invoiceModel.id_invoice)
        .updateData({"detail_invoice":FieldValue.arrayUnion(liscart)});
    return Firestore.instance.collection('transaction')
        .document(transactionModel.id_transaction)
        .collection('cart')
        .document(invoiceModel.id_invoice).setData(invoiceModel.toMap());
  }
  Future<void> saveTransaction(TransactionModel transactionModel) async{
    return Firestore.instance.collection('transaction').document(transactionModel.id_transaction).setData(transactionModel.toMap());
  }
}