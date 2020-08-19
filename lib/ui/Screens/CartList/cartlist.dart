import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/CartNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/provider/UserNotifier.dart';
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

final cartRefernece = Firestore.instance.collection('cart');

class _CartListState extends State<CartList> {
  List<SubProduct> itemlist = new List();
  List<SubProduct> itemlist2 = new List();

//  List<Cart> listCart= new List<Cart>();
  String uid;
  int _totalproduct;
  int subtotalproduct;

  void _subproduct(int product) {
//    setState(() {
//      subtotalproduct= int.parse(productPrice) * product;
//    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseUid();
  }

  void getSubProduct(SubProductNotifier subProductNotifier,
      String subProductRef, int cartItemLength) async {
    await CartApi.subproductReference(
        subProductNotifier, subProductRef, cartItemLength);
  }

  void subProductGet(String subProductRef, int cartItemLength) async {
    SubProductNotifier subProductNotifier =
        Provider.of<SubProductNotifier>(context, listen: false);
    await getSubProduct(subProductNotifier, subProductRef, cartItemLength);
  }

  void itemGenerated(List<SubProduct> itemListUngenerated) {
    setState(() {
//     itemlist = List<SubProduct>.generate(itemListUngenerated.length, (index) => itemListUngenerated[index]);
    });
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
    String cartHasDataa;
    int cartTotal;
//    final cartNotifierList = Provider.of<List<Cart>>(context);
//    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context);
    final carts = Provider.of<List<Cart>>(context);
    CartNotifier cartss = Provider.of<CartNotifier>(context);
//    print('test  '+ carts.length.toString());
//    userList = List<User>.generate(users.length, (index) => users[index]);
//    cartList =carts;
//    print("tes "+userList[0].cart.length.toString());
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
//                    DocumentSnapshot subSnapshot = cartSnapshot.data.documents[index];
                              return FutureBuilder(
                                builder:
                                    (BuildContext context, AsyncSnapshot snap) {
                                      cartHasDataa = 'oke';
                                  int qty = carts[index].qty;
                                  String cartId = carts[index].id;
                                  String productAssets = carts[index].assets;
                                  String productName = carts[index].name;
                                  String productPrice = carts[index].price;
                                  String productUnit = carts[index].unit;
//                                  subTotalFormulas('tambah', int.parse(productPrice), qty);
                                  return Stack(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        margin: EdgeInsets.only(
                                            right: 30.0, bottom: 5.0),
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          elevation: 3.0,
                                          child: Container(
                                            padding: EdgeInsets.all(16.0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 80,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Image.asset(
                                                          productAssets),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        productName,
                                                        style: TextStyle(
                                                            fontSize: 2 *
                                                                SizeConfig
                                                                    .textMultiplier,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "Harga: Rp. ${productPrice} per $productUnit",
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
                                                      right:
                                                          MediaQuery.of(context)
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
                                                              color:
                                                                  Colors.white,
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
                                                          "${qty} $productUnit",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 18.0),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          qty += 1;
//                                                          _subproduct(_totalproduct);
                                                          CartNotifier.tambahqty(
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
                                                              color:
                                                                  Colors.white),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.add,
                                                              color: Color(
                                                                  0xFF7A9BEE),
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
                                },
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
                        if (snapshot.data.documents.length != null){
                          _cartTotal = List.generate(
                              snapshot.data.documents.length,
                                  (index) => snapshot
                                  .data.documents[index].data['cartTotal']);
                          cartTotal = int.parse(_cartTotal[0].toString());
                        }
                        if (_cartTotal.length == 0){
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text(snapshot.error);
                        }
                        if (_cartTotal.length != 0) {
                          return Text(
                            "Total Keranjang     Rp. ${_cartTotal[0].toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 2.6 * SizeConfig.textMultiplier,
                            ),
                          );
                        }
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    color: kPrimaryColor,
                    child: Text(
                      "checkout".toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutScreen()));
                    },
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
