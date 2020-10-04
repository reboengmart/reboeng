class History{
  String id;
  String status;
  String transactionRef;
  String invoiceRef;

  History({this.id,this.status,this.transactionRef,this.invoiceRef});

  History.fromFirestore(Map<String,dynamic> firestore)
      : id=firestore['id'],
        status=firestore['status'],
        transactionRef=firestore['transaction_ref'],
        invoiceRef=firestore['invoice_ref'];
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'status':status,
      'transaction_ref':transactionRef,
      'invoice_ref':invoiceRef
    };
  }

  History.formMap(Map<String,dynamic> firestore){
    id=firestore['id'];
    status=firestore['status'];
    transactionRef=firestore['transaction_ref'];
    invoiceRef=firestore['invoice_ref'];
  }
}