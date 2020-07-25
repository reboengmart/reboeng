
class ProductCategory{
   String id;
   String nama;
   String status;
   String assets;
   ProductCategory.formMap(Map<String,dynamic> data){
     id=data['id'];
     nama=data['nama'];
     status=data['status'];
     assets=data['assets'];
   }

////  ProductCategory();
//ProductCategory({this.id,this.nama,this.status,this.assets});
//  Map<String,dynamic> toMap(){
//    return{
//      'id' :id,
//      'nama' :nama,
//      'assets':assets,
//      'status':status,
//    };
//  }
//  ProductCategory.fromFirestore(Map<String,dynamic> firestore)
//  :     id=firestore['id'],
//        nama=firestore['nama'],
//        assets=firestore['assets'],
//        status=firestore['status'];
}