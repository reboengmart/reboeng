class SubProduct{
  String id;
  String name;
  String status;
  String assets;
  int price;
  String product_ref;
  int stock;
  String unit;

  SubProduct.formMap(Map<String,dynamic> data){
    id=data['id'];
    name=data['name'];
    status=data['status'];
    assets=data['assets'];
    price=data['price'];
    product_ref=data['product_ref'];
    stock=data['stock'];
    unit=data['unit'];
  }
}