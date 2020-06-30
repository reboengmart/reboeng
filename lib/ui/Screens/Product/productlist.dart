import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reboeng/ui/Screens/Product/Detail/detail_screen.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

class ProductList extends StatefulWidget {
  final String title;
  ProductList(this.title);
  @override
  _ProductListState createState() => _ProductListState(title);
}

class _ProductListState extends State<ProductList> {
  final String title;
  _ProductListState(this.title);
//  ScrollController _scrollController = new ScrollController();

//  int _ProductListItem = 4;
  // ignore: non_constant_identifier_names
  final _ProductList = [
    {
      'name': 'Sawi Putih',
      'price': 12500,
      'unit': 'kg',
      'assets': 'assets/sayur/sawi.png'
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
      'assets': 'assets/sayur/kubis.png'
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
    final String _title = title;
    var colors =[
      Color.fromRGBO(247, 220, 111, 1),
      Color.fromRGBO(171, 235, 198, 1),
      Color.fromRGBO(169, 223, 191, 1),
      Color.fromRGBO(162, 217, 206, 1),
      Color.fromRGBO(236, 240, 241, 1),
      Color.fromRGBO(232, 218, 239, 1),
      Color.fromRGBO(253, 222, 215, 1),
      Color.fromRGBO(224, 255, 255, 1),
      Color.fromRGBO(152, 251, 152, 1),
      Color.fromRGBO(152, 251, 152, 1),
      Color.fromRGBO(34, 139, 34, 10),
      Color.fromRGBO(60, 179, 113, 5),
      Color.fromRGBO(172, 238, 238, 10),
      Color.fromRGBO(144, 238, 114, 10),

      ];
    Random random = new Random();
//    int indexColor = 0;
    return LayoutBuilder(
        builder: (context, constraints){
          return OrientationBuilder(
              builder: (context, orientation){
                SizeConfig().init(constraints, orientation);
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: new Scaffold(
                      appBar: AppBar(
                        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                        elevation: 0,
                        leading:
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Color.fromRGBO(185, 194, 210, 1)),
                          onPressed: () {Navigator.pop(context);},
                        ),

                        title: RichText(
                          text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                            // ignore: deprecated_member_use
                                .title
                                .copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: _title,
                                style: TextStyle(color: kPrimaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body: Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: GestureDetector(
                          onTap: () {

                          },
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
                                        Text("Cari Produk $_title", style: TextStyle(
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
                                child: new StaggeredGridView.countBuilder(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    itemCount: _ProductList.length,
                                    itemBuilder: (context, index){
                                      var c = random.nextInt(colors.length);
                                      final item = _ProductList[index];
                                      return _buildProductListCard(item['name'], item['assets'], item['price'].toString(), item['unit'], colors[c]);
                                    },
                                    staggeredTileBuilder: (index){
                                      return new StaggeredTile.count(1, index.isEven ? 1.6 : 1.9);
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                );
              }
          );
        }
    );
  }

  _buildProductListCard(String name, String asset, String price, String unit, Color color) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen()));},
      child: Container (
        width: 42.5 * SizeConfig.widthMultiplier,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.2),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.add, color: Colors.grey,),
                  )
                ),
              ),
            Center(
              child: Image.asset(
                asset,
                fit: BoxFit.contain,
                height: 35 * SizeConfig.imageSizeMultiplier,
                width: 35 * SizeConfig.imageSizeMultiplier,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text(name, style: TextStyle(
                  fontFamily: 'OpenSans-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 2.5 * SizeConfig.textMultiplier
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: Text("Gurugram Mandi Haryana", style: TextStyle(
                  fontFamily: 'OpenSans-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 1.5 * SizeConfig.textMultiplier
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(price, style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.5 * SizeConfig.textMultiplier
                      ),),
                      Text("Per $unit", style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.3 * SizeConfig.textMultiplier
                      ),),
                    ],
                  ),
                  Spacer(),
                  Text("View Prices", style: TextStyle(
                      fontFamily: 'OpenSans',
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 1.3 * SizeConfig.textMultiplier
                  ),),
                ],
              ),
            ),
            SizedBox(height: 2 * SizeConfig.heightMultiplier,)
          ],
        ),
      ),
    );
  }
}

