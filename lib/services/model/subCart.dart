class SubCart{
  String id;
  String name;
  String assets;
  int price;
  String productRef;
  int stock;
  String unit;
  String status;
  int qty;

  SubCart.formMap(Map<String,dynamic> data){
    id=data['id'];
    name=data['name'];
    assets=data['assets'];
    price=data['price'];
    productRef=data['product_ref'];
    stock=data['stock'];
    unit=data['unit'];
    status=data['status'];
    qty=data['qty'];
  }
}