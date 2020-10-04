import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/provider/WishListNotifier.dart';
import 'package:reboeng/services/refresh.dart';
import 'package:reboeng/ui/view/mainpage.dart';

import 'detailsPage.dart';

class DetailScreen extends StatefulWidget {
  final String title,id;
  DetailScreen(this.title,this.id);
  @override
  _DetailScreenState createState() => _DetailScreenState(title,id);
}

class _DetailScreenState extends State<DetailScreen> {
  final String title,id;
  _DetailScreenState(this.title,this.id);
  @override
  void initState() {
    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context,listen: false);
    RefreshServices.subProductRefresh(subProductNotifier, id);
    initUid();
    super.initState();
  }

  String uid;
  FirebaseUser userFirebase;

  void initUid()async{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    setState(() {
      uid = user.uid;
      userFirebase = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context);
    return Scaffold(
      backgroundColor: Color(0xFF21BFBD),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.shopping_cart),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MainPageScreen(2, userFirebase)
                              )
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ))
              ],
            ),
          ),
          SizedBox(height: 25.0),
          Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Row(
              children: <Widget>[
                Text(title,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0)),
                SizedBox(width: 10.0),
              ],
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.only(left: 25.0, right: 20.0),
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 45.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 300.0,
                            child: ListView.builder(
                            itemCount: subProductNotifier.subproductList.length,
                            itemBuilder: (context, index) {
                            final item = subProductNotifier.subproductList[index];
                            return _buildFoodItem(item.assets,item.name,item.price.toString(),item.stock.toString(),item.id,item.status,item.unit);
                            },
                            ),
                          )
                    )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFoodItem(String imgPath, String foodName, String price,String stock,String id,String status,String unit) {
//    CartNotifier subCartNotifier=Provider.of<CartNotifier>(context);
    WishListNotifier wishListNotifier=Provider.of<WishListNotifier>(context);
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price, foodStock : stock,foodId: id,status:status,unit:unit)
              ));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    child: Row(
                        children: [
                          Hero(
                              tag: imgPath,
                              child: Image(
                                  image: AssetImage(imgPath),
                                  fit: BoxFit.cover,
                                  height: 75.0,
                                  width: 75.0
                              )
                          ),
                          SizedBox(width: 10.0),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                Text(
                                    foodName,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                Text(
                                    price.toString(),
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                ),
                                Text(
                                    "Stok Tersisa "+stock,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15.0,
                                        color: Colors.grey
                                    )
                                )
                              ]
                          )
                        ]
                    )
                ),
                Container(
                  child: StreamBuilder(
                    stream: Firestore.instance.collection('user').document('$uid').collection('wishlist').where('sub_product_ref', isEqualTo: id).snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return Container(
                          child: (snapshot.data.documents.length == 0) ? IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.black26,
                              onPressed: () {
                                setState(() {
                                  wishListNotifier.saveWishList(id);
                                });
                              }
                          ) : IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.redAccent,
                              onPressed: () {
                                wishListNotifier.deleteWishListIndetail(id);
                              }
                          ),
                        );
                      }
                      if(!snapshot.hasData){
                        return Text('');
                      }
                    },

                  ),
                ),
//                IconButton(
//                    icon: Icon(Icons.add_shopping_cart),
//                    color: Colors.black,
//                    onPressed: () {
//                     setState(() {
//                      subCartNotifier.saveCart(foodName,price,imgPath,status,unit);
//                     });
//                    }
//                )
              ],
            )
        ));
  }
}
