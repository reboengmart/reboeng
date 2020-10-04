import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:reboeng/services/model/InvoiceModel.dart';
import 'package:reboeng/services/model/TransactionModel.dart';

class TransactionApi {
//  Firestore _db = Firestore.instance;

  Future<void> saveTransaction(
      TransactionModel transactionModel, InvoiceModel invoiceModel) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection('transaction')
        .where('date_transaction',
            isEqualTo: DateFormat('d MMMM y').format(DateTime.now()))
        .getDocuments();
    List<TransactionModel> _listTransaction = [];
    if (snapshot.documents.isEmpty) {
      Firestore.instance
          .collection('transaction')
          .document(transactionModel.idTransaction)
          .setData(transactionModel.toMap());
      Firestore.instance
          .collection('transaction')
          .document(transactionModel.idTransaction)
          .setData(transactionModel.toMap());
      Firestore.instance
          .collection('transaction')
          .document(transactionModel.idTransaction)
          .collection('invoice')
          .document(invoiceModel.idInvoice)
          .setData(invoiceModel.toMap());
      deletecart();
      createHistory(transactionModel.idTransaction, invoiceModel);
      return Firestore.instance
          .collection('transaction')
          .document(transactionModel.idTransaction)
          .collection('invoice')
          .document(invoiceModel.idInvoice)
          .setData({
        'address': invoiceModel.address,
        'date_invoice': invoiceModel.dateInvoice,
        'delivery': invoiceModel.delivery,
        'id_invoice': invoiceModel.idInvoice,
        'total_invoice': invoiceModel.totalInvoice,
        'total_payment': invoiceModel.totalPayment,
        'user_ref': invoiceModel.userRef,
        'detail_invoice': FieldValue.arrayUnion(
            invoiceModel.detailInvoice.map((e) => e.toMap()).toList())
      });
    } else {
      snapshot.documents.forEach((element) {
        TransactionModel transactionModel =
            TransactionModel.formMap(element.data);
        _listTransaction.add(transactionModel);
      });
      Firestore.instance
          .collection('transaction')
          .document(_listTransaction.first.idTransaction)
          .updateData({
        'total_transaction': _listTransaction.first.totalTransaction +
            invoiceModel.totalPayment
      });
      print(invoiceModel.detailInvoice.map((e) => e.toMap()).toString());
      deletecart();
      createHistory(_listTransaction.first.idTransaction, invoiceModel);
      return Firestore.instance
          .collection('transaction')
          .document(_listTransaction.first.idTransaction)
          .collection('invoice')
          .document(invoiceModel.idInvoice)
          .setData({
        'address': invoiceModel.address,
        'date_invoice': invoiceModel.dateInvoice,
        'delivery': invoiceModel.delivery,
        'id_invoice': invoiceModel.idInvoice,
        'total_invoice': invoiceModel.totalInvoice,
        'total_payment': invoiceModel.totalPayment,
        'user_ref': invoiceModel.userRef,
        'detail_invoice': FieldValue.arrayUnion(
            invoiceModel.detailInvoice.map((e) => e.toMap()).toList())
      });
    }
  }

  Future<void> deletecart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    QuerySnapshot snapshot2 = await Firestore.instance
        .collection('user')
        .document('$uid')
        .collection('cart')
        .getDocuments();
    Firestore.instance
        .collection('user')
        .document('$uid')
        .updateData({'cartTotal': 0});
    return snapshot2.documents.forEach((element) {
      Firestore.instance
          .collection('user')
          .document('$uid')
          .collection('cart')
          .document(element.documentID)
          .delete();
    });
  }

  Future<void> createHistory(
      String idTransaksi, InvoiceModel invoiceModel) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    String id = randomAlpha(20);
    Firestore.instance
        .collection('user')
        .document('$uid')
        .collection('history')
        .document(id)
        .setData({
      "id": id,
      "status": "sedang dikemas",
      "transaction_ref": idTransaksi,
      "invoice_ref": invoiceModel.idInvoice
    });
  }
//  Future<void> saveCart(TransactionModel transactionModel,InvoiceModel invoiceModel,List liscart) async{
//    DocumentReference docRef=Firestore.instance.collection('transaction').document(transactionModel.idTransaction).collection('invoice').document(invoiceModel.idInvoice);
//    DocumentSnapshot doc=await docRef.get();
////    List cart=doc.data['detail_invoice'];
//    Firestore.instance.collection('transaction')
//        .document(transactionModel.idTransaction)
//        .collection('cart')
//        .document(invoiceModel.idInvoice)
//        .updateData({"detail_invoice":FieldValue.arrayUnion(liscart)});
//    return Firestore.instance.collection('transaction')
//        .document(transactionModel.idTransaction)
//        .collection('cart')
//        .document(invoiceModel.idInvoice).setData(invoiceModel.toMap());
//  }
//  Future<void> saveTransaction(TransactionModel transactionModel) async{
//    return Firestore.instance.collection('transaction').document(transactionModel.idTransaction).setData(transactionModel.toMap());
//  }
}
