import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/TransactionModel.dart';

class TransactionApi{
  Firestore _db = Firestore.instance;
  Future<void> saveCart(TransactionModel transactionModel,Cart cartt) async{
    DocumentReference docRef=Firestore.instance.collection('transaction').document(transactionModel.id_transaction).collection('invoice').document(transactionModel.id_invoice);
    DocumentSnapshot doc=await docRef.get();
    List cart=doc.data['detail_invoice'];
//    return Firestore.instance.collection('transaction').document(transactionModel.id_transaction).collection('cart').document(cartt.id).setData(cartt.toMap());
  }
}