import 'package:cloud_firestore/cloud_firestore.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getSubProduct(SubProductNotifier subProductNotifier, String subProductRef)async{
    await CartApi.subproductReference(subProductNotifier,subProductRef);
  }

  void subProductGet(String subProductRef)async{
      SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context,listen: false);
      await getSubProduct(subProductNotifier, subProductRef);
  }

  void itemGenerated(List<SubProduct> itemListUngenerated){
   setState(() {
//     itemlist = List<SubProduct>.generate(itemListUngenerated.length, (index) => itemListUngenerated[index]);
   });
  }


  @override
  Widget build(BuildContext context) {
    final cartNotifierList = Provider.of<List<Cart>>(context);
    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context);
    return new Scaffold(
//      appBar: homeAppBar(context, 'cartlist'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: cartNotifierList.length,
              itemBuilder: (BuildContext context, int index){
                final cartData = cartNotifierList[index];
                subProductGet(cartData.sub_product_ref);
                itemlist = List.generate(subProductNotifier.subproductList.length, (index)
                => subProductNotifier.subproductList[index]);
                itemlist2.add(itemlist[0]);
                final item=itemlist2[index];
//                itemGenerated(subProductNotifier.subproductList);
//                itemlist=List<SubProduct>.generate(listItem.length, (index) => listItem[index]);
//                final cartNameData = cartNotifier.subproductList[index];
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
                                  Image.asset(item.assets),
                                ],
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(item.name, style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(height: 20.0,),
                                    Text("${item.price}", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    ),),
                                    Text("${cartData.qty}", style: TextStyle(
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
                            CartNotifier.deleteCart(cartData.id);
                          },
                        ),
                      ),
                    )
                  ],
                );
              },

            ),),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
//                  Text("Subtotal      \$50", style: TextStyle(
//                      color: Colors.grey.shade700,
//                    fontSize: 2.6 * SizeConfig.textMultiplier,
//                  ),),
//                  SizedBox(height: 5.0,),
//                  Text("Delivery       \$05", style: TextStyle(
//                      color: Colors.grey.shade700,
//                    fontSize: 2.6 * SizeConfig.textMultiplier,
//                  ),),
//                  SizedBox(height: 10.0,),
//                  Text("Total Keranjang     \$55", style: TextStyle(
//                      fontWeight: FontWeight.bold,
//                    fontSize: 2.9 * SizeConfig.textMultiplier,
//                  ),),
//                  SizedBox(height: 20.0,),
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