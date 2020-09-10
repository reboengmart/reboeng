class History{
  String id;
  String status;
  String transaction_ref;
  String invoice_ref;

  History({this.id,this.status,this.transaction_ref,this.invoice_ref});

  History.fromFirestore(Map<String,dynamic> firestore)
      : id=firestore['id'],
        status=firestore['status'],
        transaction_ref=firestore['transaction_ref'],
        invoice_ref=firestore['invoice_ref'];
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'status':status,
      'transaction_ref':transaction_ref,
      'invoice_ref':invoice_ref
    };
  }

  History.formMap(Map<String,dynamic> firestore){
    id=firestore['id'];
    status=firestore['status'];
    transaction_ref=firestore['transaction_ref'];
    invoice_ref=firestore['invoice_ref'];
  }
}