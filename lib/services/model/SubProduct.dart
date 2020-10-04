class SubProduct{
  String id;
  String name;
  String assets;
  int price;
  String productRef;
  int stock;
  String unit;
  String status;

  SubProduct.formMap(Map<String,dynamic> data){
    id=data['id'];
    name=data['name'];
    assets=data['assets'];
    price=data['price'];
    productRef=data['product_ref'];
    stock=data['stock'];
    unit=data['unit'];
    status=data['status'];
  }
}