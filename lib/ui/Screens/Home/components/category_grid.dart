import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
//import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/services/model/ProductCategory.dart';
import 'package:reboeng/services/product.dart';
import 'package:reboeng/ui/Screens/Product/productlist.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

//    final categoryList = [
//      {
//        'nama': 'Sayur',
//        'assets': 'assets/sayur/sayur.png',
//        'status': 'available'
//      },
//      {
//        'nama': 'Buah',
//        'assets': 'assets/buah/buah.png',
//        'status': 'available'
//      },
//      {
//        'nama': 'Rempah-Rempah',
//        'assets': 'assets/rempahrempah/rempahrempah.png',
//        'status': 'available'
//      },
//      {
//        'nama': 'Sembako',
//        'assets': 'assets/sembako/sembako.png',
//        'status': 'available'
//      },
//      {
//        'nama': 'Kebutuhan Rumah Tangga',
//        'assets': 'assets/kebutuhanrumahtangga/KebutuhanRumahTanggaComingSoon.png',
//        'status': 'comingsoon'
//      },
//      {
//        'nama': 'Elektronik',
//        'assets': 'assets/elektronik/ElektronikComingSoon.png',
//        'status': 'comingsoon'
//      },
//      {
//        'nama': 'Fashion',
//        'assets': 'assets/fashion/FashionComingSoon.png',
//        'status': 'comingsoon'
//      },
//      {
//        'nama': 'Lain-Lain',
//        'assets': 'assets/lainlain/LainLainComingSoon.png',
//        'status': 'comingsoon'
//      },
//    ];
    final categorys = Provider.of<List<ProductCategory>>(context);
      return Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        alignment: Alignment.center,
        child: (categorys !=null) ? GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            primary: false,
            padding:  const EdgeInsets.all(0),
            crossAxisSpacing: 0,
            mainAxisSpacing: 15,
            crossAxisCount: 4,
          children: List.generate(categorys.length, (index) {
            final categoryData = categorys[index];
            return InkWell(
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage(categoryData.assets),
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
                onTap: () async{
                  await ProductServices.listProduct(categoryData.id);
                  (categoryData.status == 'available') ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListItem(categoryData.nama),
                      )
                  ) : 0;
                }
            );
          }),
        ):Center(child: CircularProgressIndicator())
      );
    }
  }