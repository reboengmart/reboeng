import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reboeng/provider/historyNotifier.dart';
import 'package:reboeng/services/model/History.dart';

class DispatchingAPI{

  static Future<void> getDispatching(HistoryNotifier historyNotifier)async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    String uid = user.uid;

    List<History> _historyy = [];

    QuerySnapshot snapshot = await Firestore.instance.collection('user').document('${uid}').collection('history').where('status', isEqualTo: "sedang dikemas").getDocuments();
    snapshot.documents.forEach((element) {
       History history=History.formMap(element.data);
      _historyy.add(history);
    });
    return historyNotifier.historyList=_historyy;

  }

}