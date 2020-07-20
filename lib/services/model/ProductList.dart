class ProductList{
  final String id;
  final String assets;
  final String nama;

  ProductList({this.id,this.assets,this.nama});
  Map<String,dynamic> toMap(){
    return{
      'nama' :nama,
      'assets':assets,
      'id':id,
    };
  }

  ProductList.fromFirestore(Map<String, dynamic> firestore)
  : id=firestore['id'],
    nama=firestore['nama'],
    assets=firestore['assets'];
}