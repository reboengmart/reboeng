
class ProductCategory{
  final String id;
  final String nama;
  final String status;
  final String assets;

//  ProductCategory();
ProductCategory({this.id,this.nama,this.status,this.assets});
  Map<String,dynamic> toMap(){
    return{
      'nama' :nama,
      'assets':assets,
      'status':status,
    };
  }
  ProductCategory.fromFirestore(Map<String,dynamic> firestore)
  : id=firestore['id'],
        nama=firestore['nama'],
  assets=firestore['assets'],
  status=firestore['status'];
}