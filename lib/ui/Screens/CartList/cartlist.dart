import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/CartNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/api/cart_api.dart';
import 'package:reboeng/services/model/SubProduct.dart';
import 'package:reboeng/ui/Screens/checkout/checkout.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

final cartRefernece = Firestore.instance.collection('cart');

class _CartListState extends State<CartList> {
  List<SubProduct> itemlist = new List();
  List<SubProduct> itemlist2 = new List();

  String uid;
  int subtotalproduct;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseUid();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    return true;
  }

  void getSubProduct(SubProductNotifier subProductNotifier,
      String subProductRef, int cartItemLength) async {
    await CartApi.subproductReference(
        subProductNotifier, subProductRef, cartItemLength);
  }

  void subProductGet(String subProductRef, int cartItemLength) async {
    SubProductNotifier subProductNotifier =
        Provider.of<SubProductNotifier>(context, listen: false);
    getSubProduct(subProductNotifier, subProductRef, cartItemLength);
  }

  void firebaseUid() async {
    await new Future.delayed(const Duration(seconds: 2));
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  int subTotal = 0;
  int deliveryTotal = 0;
  int cartTotal = 0;

//  bool bayar = false;
//
//  void updateBayarStatus(bool status){
//    if(!status){
//      setState(() {
//        bayar = false;
//      });
//    }else{
//      setState(() {
//        bayar = true;
//      });
//    }
//  }

//  void subTotalFormulas(String operator, int price, int totalBuy){
//    int formulasTotal;
//    switch(operator){
//      case 'tambah':
//        formulasTotal =  price * totalBuy;
//        setState(() {
//          subTotal += formulasTotal;
//          cartTotal += formulasTotal;
//        });
//        break;
//      case 'kurang':
//        formulasTotal =  price * totalBuy;
//        setState(() {
//          subTotal -= formulasTotal;
//          cartTotal -= formulasTotal;
//        });
//        break;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    int cartTotal;
    firebaseUid();
    return new Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection('user')
                        .document('$uid')
                        .collection('cart')
                        .snapshots(),
                    // ignore: missing_return
                    builder: (context, cartSnapshot) {
                      if (cartSnapshot.hasError) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            "${cartSnapshot.error}",
                            style: TextStyle(color: Colors.black54),
                          ),
                          backgroundColor: Colors.white,
                        ));
                        return Center(
                            child:
                                Text('Terjadi Kesalahan Saat mengambil data'));
                      }
                      if (cartSnapshot.hasData) {
                        return ListView.builder(
                            padding: EdgeInsets.all(16.0),
                            itemCount: cartSnapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              int qty = cartSnapshot
                                  .data.documents[index].data['qty'];
                              String cartId =
                                  cartSnapshot.data.documents[index].documentID;
                              String subProductId =
                                  cartSnapshot.data.documents[index].data['id'];
                              String productAssets = cartSnapshot
                                  .data.documents[index].data['assets'];
                              String productName = cartSnapshot
                                  .data.documents[index].data['name'];
                              String productPrice = cartSnapshot
                                  .data.documents[index].data['price'];
                              String productUnit = cartSnapshot
                                  .data.documents[index].data['unit'];
                              return Stack(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                        right: 30.0, bottom: 5.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(5.0),
                                      elevation: 3.0,
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              height: 80,
                                              child: Row(
                                                children: <Widget>[
                                                  Image.asset(productAssets),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    productName,
                                                    style: TextStyle(
                                                        fontSize: 2 *
                                                            SizeConfig
                                                                .textMultiplier,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Harga: Rp. $productPrice per $productUnit",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 1.4 *
                                                            SizeConfig
                                                                .textMultiplier),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05),
                                              child: Row(
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      if (qty != 1) {
                                                        qty -= 1;
                                                        CartNotifier.kurangqty(
                                                            cartId,
                                                            qty,
                                                            int.parse(
                                                                productPrice),
                                                            cartTotal);
//                                                            _subproduct(_totalproduct);
//                                                            cartss.kurangiqty(_totalproduct);
//                                                            subTotalFormulas('kurang', int.parse(productPrice), qty);
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 25.0,
                                                      width: 25.0,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.0),
                                                          color: Color(
                                                              0xFF7A9BEE)),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    child: Text(
                                                      "$qty $productUnit",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      qty += 1;
//                                                          _subproduct(_totalproduct);
                                                      CartNotifier().tambahqty(
                                                          subProductId,
                                                          cartId,
                                                          qty,
                                                          int.parse(
                                                              productPrice),
                                                          cartTotal);
//                                                          subTotalFormulas('tambah', int.parse(productPrice), qty);
                                                    },
                                                    child: Container(
                                                      height: 25.0,
                                                      width: 25.0,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.0),
                                                          color: Colors.white),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xFF7A9BEE),
                                                          size: 20.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
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
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        padding: EdgeInsets.all(0.0),
                                        color: kPrimaryColor,
                                        child: Icon(
                                          Icons.clear,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          CartNotifier.deleteCart(
                                              cartId,
                                              int.parse(productPrice),
                                              cartTotal,
                                              qty);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                      if (cartSnapshot.connectionState !=
                          ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!cartSnapshot.hasData &&
                          cartSnapshot.connectionState ==
                              ConnectionState.done) {
                        return Text('Tidak Ada Product Di Keranjang');
                      }
//                      if(cartSnapshot.data.documents.length == 0){
//                        return Center(
//                          child: Text('Silakan Berbelanja'),
//                        );
//                      }
                    })),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection('user')
                          .where('uid', isEqualTo: '$uid')
                          .snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        List _cartTotal;
                        if (snapshot.hasData &&
                            snapshot.data.documents.isNotEmpty) {
                          _cartTotal = List.generate(
                              snapshot.data.documents.length,
                              (index) => snapshot
                                  .data.documents[index].data['cartTotal']);
                          cartTotal = int.parse(_cartTotal[0].toString());
                        }
                        if (_cartTotal == null) {
                          return Center(child: Text(''));
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        if (_cartTotal != null) {
                          return Container(
                            margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 20),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  (_cartTotal[0] < 1)
                                      ? "Keranjang anda masih kosong, silahkan buka menu produk dan tambahkan produk\nke dalam keranjang"
                                      : "Total Keranjang    Rp. ${_cartTotal[0].toString()}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 2.6 * SizeConfig.textMultiplier,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: SizeConfig.widthMultiplier * 1.5),
                                  alignment: Alignment.bottomRight,
                                  child: (_cartTotal[0] < 1)
                                      ? Icon(FontAwesomeIcons.cartPlus,
                                          color: kPrimaryColor)
                                      : Text(''),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.widthMultiplier * 40),
                                  child: Container(
                                    child: (_cartTotal[0] == 0)
                                        ? RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            color: kTextColor,
                                            child: Text(
                                              "bayar".toUpperCase(),
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () {},
                                          )
                                        : RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            color: kPrimaryColor,
                                            child: Text(
                                              "bayar".toUpperCase(),
                                              style:
                                                  TextStyle(color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CheckOutScreen()));
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(
                            child: Text(''),
                          );
                        }
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
