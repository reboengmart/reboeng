import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:reboeng/provider/CartNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/services/api/subproduct.dart';
import 'package:reboeng/ui/Screens/Product/detail_promo/detailsPage.dart';

class PromoDetailScreen extends StatefulWidget {
  final String title,status;
  PromoDetailScreen(this.title,this.status);
  @override
  _PromoDetailScreenState createState() => _PromoDetailScreenState(title,status);
}

class _PromoDetailScreenState extends State<PromoDetailScreen> {
  final String title,status;
  _PromoDetailScreenState(this.title,this.status);
  @override
  void initState() {
    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context,listen: false);
    SubProductApi.getPromoProducts(subProductNotifier, status);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SubProductNotifier subProductNotifier=Provider.of<SubProductNotifier>(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 196, 15, 1),
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
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.filter_list),
                          color: Colors.white,
                          onPressed: () {},
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
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PromoDetailsPage(heroTag: imgPath, foodName: foodName, foodPrice: price, foodStock : stock,foodId: id,status:status,unit:unit)
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
//                IconButton(
//                    icon: Icon(Icons.add_shopping_cart),
//                    color: Colors.black,
//                    onPressed: () {
//                      subCartNotifier.saveCart(foodName,price,imgPath,status,unit);
//                    }
//                )
              ],
            )
        ));
  }
}
