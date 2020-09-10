import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/History.dart';
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
          .document(transactionModel.id_transaction)
          .setData(transactionModel.toMap());
      Firestore.instance
          .collection('transaction')
          .document(transactionModel.id_transaction)
          .setData(transactionModel.toMap());
      Firestore.instance
          .collection('transaction')
          .document(transactionModel.id_transaction)
          .collection('invoice')
          .document(invoiceModel.id_invoice)
          .setData(invoiceModel.toMap());
      deletecart();
      createHistory(transactionModel.id_transaction, invoiceModel);
      return Firestore.instance
          .collection('transaction')
          .document(transactionModel.id_transaction)
          .collection('invoice')
          .document(invoiceModel.id_invoice)
          .setData({
        'address': invoiceModel.address,
        'date_invoice': invoiceModel.date_invoice,
        'delivery': invoiceModel.delivery,
        'id_invoice': invoiceModel.id_invoice,
        'total_invoice': invoiceModel.total_invoice,
        'total_payment': invoiceModel.total_payment,
        'user_ref': invoiceModel.user_ref,
        'detail_invoice': FieldValue.arrayUnion(
            invoiceModel.DetailInvoice.map((e) => e.toMap()).toList())
      });
    } else {
      snapshot.documents.forEach((element) {
        TransactionModel transactionModel =
            TransactionModel.formMap(element.data);
        _listTransaction.add(transactionModel);
      });
      Firestore.instance
          .collection('transaction')
          .document(_listTransaction.first.id_transaction)
          .updateData({
        'total_transaction': _listTransaction.first.total_transaction +
            invoiceModel.total_payment
      });
      print(invoiceModel.DetailInvoice.map((e) => e.toMap()).toString());
      deletecart();
      createHistory(_listTransaction.first.id_transaction, invoiceModel);
      return Firestore.instance
          .collection('transaction')
          .document(_listTransaction.first.id_transaction)
          .collection('invoice')
          .document(invoiceModel.id_invoice)
          .setData({
        'address': invoiceModel.address,
        'date_invoice': invoiceModel.date_invoice,
        'delivery': invoiceModel.delivery,
        'id_invoice': invoiceModel.id_invoice,
        'total_invoice': invoiceModel.total_invoice,
        'total_payment': invoiceModel.total_payment,
        'user_ref': invoiceModel.user_ref,
        'detail_invoice': FieldValue.arrayUnion(
            invoiceModel.DetailInvoice.map((e) => e.toMap()).toList())
      });
    }
  }

  Future<void> deletecart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    QuerySnapshot snapshot2 = await Firestore.instance
        .collection('user')
        .document('${uid}')
        .collection('cart')
        .getDocuments();
    Firestore.instance
        .collection('user')
        .document('$uid')
        .updateData({'cartTotal': 0});
    return snapshot2.documents.forEach((element) {
      Firestore.instance
          .collection('user')
          .document('${uid}')
          .collection('cart')
          .document(element.documentID)
          .delete();
    });
  }

  Future<void> createHistory(String id_transaksi,InvoiceModel invoiceModel) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;
    String id=randomAlpha(20);
    Firestore.instance
        .collection('user')
        .document('${uid}')
        .collection('history')
        .document(id)
        .setData({"id":id,"status":"sedang dikemas","transaction_ref":id_transaksi,"invoice_ref":invoiceModel.id_invoice});
  }
//  Future<void> saveCart(TransactionModel transactionModel,InvoiceModel invoiceModel,List liscart) async{
//    DocumentReference docRef=Firestore.instance.collection('transaction').document(transactionModel.id_transaction).collection('invoice').document(invoiceModel.id_invoice);
//    DocumentSnapshot doc=await docRef.get();
////    List cart=doc.data['detail_invoice'];
//    Firestore.instance.collection('transaction')
//        .document(transactionModel.id_transaction)
//        .collection('cart')
//        .document(invoiceModel.id_invoice)
//        .updateData({"detail_invoice":FieldValue.arrayUnion(liscart)});
//    return Firestore.instance.collection('transaction')
//        .document(transactionModel.id_transaction)
//        .collection('cart')
//        .document(invoiceModel.id_invoice).setData(invoiceModel.toMap());
//  }
//  Future<void> saveTransaction(TransactionModel transactionModel) async{
//    return Firestore.instance.collection('transaction').document(transactionModel.id_transaction).setData(transactionModel.toMap());
//  }
}
