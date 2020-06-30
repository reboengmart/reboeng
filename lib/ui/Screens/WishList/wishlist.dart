import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  int wishlistItem = 5;
  final wishlistItemList = [
    {
      'name': 'Sawi Putih',
      'price': 12500,
      'unit': 'kg',
      'assets': 'assets/sayur/sayur.png'
    },
    {
      'name': 'Paprika',
      'price': 12500,
      'unit': 'kg',
      'assets': 'assets/sayur/paprika.png'
    },
    {
      'name': 'Mentimun',
      'price': 12500,
      'unit': 'kg',
      'assets': 'assets/sayur/mentimun.png'
    },
    {
      'name': 'Kubis',
      'price': 12500,
      'unit': 'kg',
      'assets': 'assets/sayur/sayur.png'
    },
    {
      'name': 'Bawang Prei',
      'price': 12500,
      'unit': 'kg',
      'assets': 'assets/sayur/bawangprei.png'
    }
  ];

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
          builder: (context, constraints){
            return OrientationBuilder(
                builder: (context, orientation){
                  SizeConfig().init(constraints, orientation);
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: new Scaffold(
                      body: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10, bottom: 10),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(color: Colors.grey, width: 0.5),
                                ),
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(14)
                                  ),
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text((wishlistItem == 0) ? "Tidak Produk Harapan Untuk DiCari :(" : "Cari Produk Harapan Anda", style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 2.4 * SizeConfig.textMultiplier,
                                          fontFamily: 'OpenSans'
                                      ),),
                                      Spacer(),
                                      Icon(Icons.search, color: Colors.black, size: 6 * SizeConfig.imageSizeMultiplier,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: (wishlistItem == 0)
                                  ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.heartBroken,
                                      color: Colors.grey,
                                      size: 60.0,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      'Tidak Ada Produk Harapan Di sini :(',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    )
                                  ],
                                ),
                              )
                                  : ListView.builder(
                                itemCount: wishlistItemList.length,
                                itemBuilder: (context, index) {
                                  final item = wishlistItemList[index];
                                  return Container(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 2, right: 5, left: 5),
                                      height: height * 0.23,
                                      child: Card(
                                          elevation: 1.0,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Column(
//                                              crossAxisAlignment: CrossAxisAlignment.center,
//                                              mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    width: width * 0.35,
                                                    height: height * 0.15,
                                                    child: Image(
                                                      image: AssetImage(item['assets']),
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(10.0),
                                                width: (width * 0.40),
                                                height: height * 0.35,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      '${item['name']}',
                                                      style: TextStyle(
                                                        fontSize: 2.9 * SizeConfig.textMultiplier,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 7.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Text(
                                                          'Price:',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 2.3 * SizeConfig.textMultiplier,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        Text(
                                                          'Rp. ${item['price']}',
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 2.3 * SizeConfig.textMultiplier,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 7.0,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        RichText(
                                                          text: TextSpan(
                                                            text: 'Unit:  ',
                                                            style: TextStyle(
                                                                fontSize: 2.4 * SizeConfig.textMultiplier,
                                                                color: Colors.grey),
                                                            children: <TextSpan>[
                                                              TextSpan(
                                                                  text: '  ${item['unit']}',
                                                                  style: TextStyle(
                                                                      fontSize: 2.4 * SizeConfig.textMultiplier,
                                                                      color: Colors.blue)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      child: Container(
                                                        margin: EdgeInsets.only(top: 10),
                                                        padding: EdgeInsets.all(3.0),
                                                        child: Container(
                                                          decoration: new BoxDecoration(
                                                            borderRadius: BorderRadius.circular(7),
                                                            color: Colors.redAccent,
                                                          ),
                                                          padding: EdgeInsets.all(4),
                                                          child: Text('Hapus',
                                                            style: TextStyle(
                                                              fontSize: 2.4 * SizeConfig.textMultiplier,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          wishlistItemList.removeAt(index);
                                                          wishlistItem--;
                                                        });

                                                        // Then show a snackbar.
                                                        Scaffold.of(context).showSnackBar(
                                                            SnackBar(
                                                                content:
                                                                Text("Produk Harapan Telah Dihapus", style: TextStyle(color: Colors.black54),),
                                                              backgroundColor: Colors.white,
                                                            ));
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                child: Container(
                                                  margin: EdgeInsets.only(left: 15),
                                                  padding: EdgeInsets.all(3.0),
                                                  child: Icon(Icons.add_shopping_cart,color: Colors.teal),
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    wishlistItemList.removeAt(index);
                                                    wishlistItem--;
                                                  });

                                                  // Then show a snackbar.
                                                  Scaffold.of(context).showSnackBar(
                                                      SnackBar(
                                                          content:
                                                          Text("Produk Harapan Telah Dipindahkan", style: TextStyle(color: Colors.black54),),
                                                      backgroundColor: Colors.white,
                                                      ));
                                                },
                                              ),
                                            ],
                                          )),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  );
                }
            );
          }
      );
  }


  
}