import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/services/model/ProductCategory.dart';
import 'package:reboeng/services/refresh.dart';
import 'package:reboeng/ui/Screens/Product/productlist.dart';

class CategoryGrid extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<CategoryGrid>{

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  ProductCategoryNotifier categoryNotifier=Provider.of<ProductCategoryNotifier>(context);

      return Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        alignment: Alignment.center,
        child: (categoryNotifier.categoryList !=null) ? GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            primary: false,
            padding:  const EdgeInsets.all(0),
            crossAxisSpacing: 0,
            mainAxisSpacing: 15,
            crossAxisCount: 4,
          children: List.generate(categoryNotifier.categoryList.length, (index) {
            final categoryData = categoryNotifier.categoryList[index];
            return InkWell(
                child: Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage(categoryNotifier.categoryList[index].assets),
                      fit: BoxFit.fitHeight,
                    ),
                  ],
                ),
                onTap: () async{
//                  await ProductServices.listProduct(categoryData.id);
                  (categoryData.status == 'available') ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductListItem(categoryData.nama,categoryData.id ),
                      )
                  // ignore: unnecessary_statements
                  ) : 0;
                }
            );
          }),
        ):Center(child: CircularProgressIndicator())
      );
    }
  }