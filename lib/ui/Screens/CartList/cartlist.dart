import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/CartNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/api/cart_api.dart';
import 'package:reboeng/services/model/Cart.dart';
import 'package:reboeng/services/model/SubProduct.dart';
import 'package:reboeng/ui/Screens/checkout/checkout.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}
final cartRefernece=Firestore.instance.collection('cart');
class _CartListState extends State<CartList> {
  List<SubProduct> itemlist= new List();
  List<SubProduct> itemlist2=new List();
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseUid();
  }

  void getSubProduct(SubProductNotifier subProductNotifier, String subProductRef, int cartItemLength)async{
    await CartApi.subproductReference(subProductNotifier,subProductRef, cartItemLength);
  }

  void subProductGet(String subProductRef, int cartItemLength)async{
    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context,listen: false);
    await getSubProduct(subProductNotifier, subProductRef, cartItemLength);
  }

  void itemGenerated(List<SubProduct> itemListUngenerated){
    setState(() {
//     itemlist = List<SubProduct>.generate(itemListUngenerated.length, (index) => itemListUngenerated[index]);
    });
  }

  void firebaseUid()async{
    FirebaseAuth _auth=FirebaseAuth.instance;
    FirebaseUser user=await  _auth.currentUser();
    setState(() {
      uid=user.uid;
    });
  }


  @override
  Widget build(BuildContext context) {
//    final cartNotifierList = Provider.of<List<Cart>>(context);
//    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context);
    firebaseUid();
    return new Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('cart').where('user_ref', isEqualTo: uid).snapshots(),
                  builder: (context, cartSnapshot) {
                    if (!cartSnapshot.hasData) {
                      return Center(
                        child: Text('Data Anda Sedang Kami Ambil!'),
                      );
                    }  else{
                      return ListView.builder(
                          padding: EdgeInsets.all(16.0),
                          itemCount: cartSnapshot.data.documents.length,
                          itemBuilder: (context, index){
                            DocumentSnapshot subSnapshot = cartSnapshot.data.documents[index];
                            return FutureBuilder(
                              future: Firestore.instance.collection('sub_product').where('id', isEqualTo: subSnapshot.data['sub_product_ref']).getDocuments(),
                              builder: (BuildContext context, AsyncSnapshot snap){
                                int qty = cartSnapshot.data.documents[index].data['qty'];
                                String cartId = cartSnapshot.data.documents[index].data['id'];
                                String productAssets = snap.data.documents.toList()[0].data['assets'];
                                String productName = snap.data.documents.toList()[0].data['name'];
                                int productPrice = snap.data.documents.toList()[0].data['price'];
                                String productUnit = snap.data.documents.toList()[0].data['unit'];
                                return Stack(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(right: 30.0, bottom: 5.0),
                                      child: Material(
                                        borderRadius: BorderRadius.circular(5.0),
                                        elevation: 3.0,
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                height: 80,
                                                child: Row(children: <Widget>[
                                                  Image.asset(productAssets),
                                                ],
                                                ),
                                              ),
                                              SizedBox(width: 10.0,),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(productName, style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.bold
                                                    ),),
                                                    SizedBox(height: 20.0,),
                                                    Text("${productPrice}", style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0
                                                    ),),
                                                    Text("${qty} $productUnit", style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0
                                                    ),),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      right: 15,
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        alignment: Alignment.center,
                                        child: MaterialButton(
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                          padding: EdgeInsets.all(0.0),
                                          color: kPrimaryColor,
                                          child: Icon(Icons.clear, color: Colors.white,),
                                          onPressed: () {
                                            CartNotifier.deleteCart(cartId);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                      );
                    }
                  }
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Subtotal      \$50", style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 2.6 * SizeConfig.textMultiplier,
                  ),),
                  SizedBox(height: 5.0,),
                  Text("Delivery       \$05", style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 2.6 * SizeConfig.textMultiplier,
                  ),),
                  SizedBox(height: 10.0,),
                  Text("Total Keranjang     \$55", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 2.9 * SizeConfig.textMultiplier,
                  ),),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    color: kPrimaryColor,
                    child: Text("Bayar".toUpperCase(), style: TextStyle(
                        color: Colors.white
                    ),),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CheckOutScreen()
                      ));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}