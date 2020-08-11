class SubCart{
  String id;
  String name;
  String assets;
  int price;
  String product_ref;
  int stock;
  String unit;
  String status;
  int qty;

  SubCart.formMap(Map<String,dynamic> data){
    id=data['id'];
    name=data['name'];
    assets=data['assets'];
    price=data['price'];
    product_ref=data['product_ref'];
    stock=data['stock'];
    unit=data['unit'];
    status=data['status'];
    qty=data['qty'];
  }
}