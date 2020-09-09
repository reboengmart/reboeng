import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:reboeng/services/model/InvoiceModel.dart';
import 'package:reboeng/services/model/TransactionModel.dart';

class TransactionApi{
  Firestore _db = Firestore.instance;

  Future<void> saveTransaction(TransactionModel transactionModel,InvoiceModel invoiceModel) async {
    QuerySnapshot snapshot = await Firestore.instance.collection('transaction').where('date_transaction', isEqualTo: DateFormat('d MMMM y').format(DateTime.now())).getDocuments();
    List<TransactionModel> _listTransaction = [];
    if(snapshot.documents.isEmpty) {
       Firestore.instance.collection('transaction').document(
          transactionModel.id_transaction).setData(transactionModel.toMap());
      return Firestore.instance.collection('transaction').document(
          transactionModel.id_transaction).collection('invoice').document(
          invoiceModel.id_invoice).setData(invoiceModel.toMap());
    }else{
      snapshot.documents.forEach((element) {
        TransactionModel transactionModel=TransactionModel.formMap(element.data);
        _listTransaction.add(transactionModel);
      });
      QuerySnapshot _myDoc = await Firestore.instance.collection('transaction').document(_listTransaction.first.id_transaction).collection('invoice').getDocuments();
      List<DocumentSnapshot> _myDocCount = _myDoc.documents;
      Firestore.instance
          .collection('transaction')
          .document(_listTransaction.first.id_transaction)
          .updateData({'total_transaction': int.parse(_myDocCount.length.toString())+1});
      return Firestore.instance.collection('transaction').document(_listTransaction.first.id_transaction).collection('invoice').document(invoiceModel.id_invoice).setData(invoiceModel.toMap());
    }

  }
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
//  Future<void> saveTransaction(TransactionModel transactionModel) async{
//    return Firestore.instance.collection('transaction').document(transactionModel.id_transaction).setData(transactionModel.toMap());
//  }
}