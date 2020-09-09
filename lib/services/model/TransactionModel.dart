class TransactionModel{
  String id_transaction;
  int total_transaction;
  DateTime date_transaction;


  TransactionModel({this.id_transaction,this.total_transaction,this.date_transaction});

  TransactionModel.fromFirestore(Map<String,dynamic> firestore)
      : id_transaction=firestore['id_transaction'],
        total_transaction=firestore['total_transaction'],
        date_transaction=firestore['date_transaction'];
  Map<String,dynamic> toMap(){
    return{
      'id_transaction':id_transaction,
      'total_transaction':total_transaction,
      'date_transaction':date_transaction
    };
  }

  TransactionModel.formMap(Map<String,dynamic> firestore){
    id_transaction=firestore['id_transaction'];
    total_transaction=firestore['total_transaction'];
    date_transaction=firestore['date_transaction'];
  }
}