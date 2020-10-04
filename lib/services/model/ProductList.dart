class ProductList{
   String id;
   String assets;
   String categoryRef;
   String nama;


   ProductList.formMap(Map<String,dynamic> data){
     id=data['id'];
     nama=data['nama'];
     categoryRef=data['category_ref'];
     assets=data['assets'];
   }
//  ProductList({this.id,this.assets,this.categoryRef,this.nama});
//  Map<String,dynamic> toMap(){
//    return{
//      'nama' :nama,
//      'assets':assets,
//      'category_ref':categoryRef,
//      'id':id,
//    };
//  }
//
//  ProductList.fromFirestore(Map<String, dynamic> firestore)
//  : id=firestore['id'],
//    nama=firestore['nama'],
//    categoryRef=firestore['category_ref'],
//    assets=firestore['assets'];
}