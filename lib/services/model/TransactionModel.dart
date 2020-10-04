class TransactionModel{
  String idTransaction;
  int totalTransaction;
  String dateTransaction;


  TransactionModel({this.idTransaction,this.totalTransaction,this.dateTransaction});

  TransactionModel.fromFirestore(Map<String,dynamic> firestore)
      : idTransaction=firestore['id_transaction'],
        totalTransaction=firestore['total_transaction'],
        dateTransaction=firestore['date_transaction'];
  Map<String,dynamic> toMap(){
    return{
      'id_transaction':idTransaction,
      'total_transaction':totalTransaction,
      'date_transaction':dateTransaction
    };
  }

  TransactionModel.formMap(Map<String,dynamic> firestore){
    idTransaction=firestore['id_transaction'];
    totalTransaction=firestore['total_transaction'];
    dateTransaction=firestore['date_transaction'];
  }
}