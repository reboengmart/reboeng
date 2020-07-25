class ProductList{
   String id;
   String assets;
   String category_ref;
   String nama;


   ProductList.formMap(Map<String,dynamic> data){
     id=data['id'];
     nama=data['nama'];
     category_ref=data['category_ref'];
     assets=data['assets'];
   }
//  ProductList({this.id,this.assets,this.category_ref,this.nama});
//  Map<String,dynamic> toMap(){
//    return{
//      'nama' :nama,
//      'assets':assets,
//      'category_ref':category_ref,
//      'id':id,
//    };
//  }
//
//  ProductList.fromFirestore(Map<String, dynamic> firestore)
//  : id=firestore['id'],
//    nama=firestore['nama'],
//    category_ref=firestore['category_ref'],
//    assets=firestore['assets'];
}