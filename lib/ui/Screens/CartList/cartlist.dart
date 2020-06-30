import 'package:flutter/material.dart';
import 'package:reboeng/ui/Screens/checkout/checkout.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final List<Map> items = [
      {
        "image": AssetImage('assets/buah/lemon'),
        "title":"Lemon",
        "price": 20,
      },
      {
        "image":AssetImage('assets/sayur/sawi'),
        "title":"Sawi Segar",
        "price": 30
      },
    ];
    return new Scaffold(
//      appBar: homeAppBar(context, 'cartlist'),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index){
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
                                  Image.asset('assets/buah'),
                                ],
                                ),
                              ),
                              SizedBox(width: 10.0,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(items[index]["title"], style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(height: 20.0,),
                                    Text("\$${items[index]['price']}", style: TextStyle(
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
                          onPressed: () {},
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