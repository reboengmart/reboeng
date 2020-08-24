import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/services/refresh.dart';
import 'package:reboeng/ui/Screens/Product/detail_promo/detail_screen.dart';
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
      return (categoryNotifier ==null)?Container(child: CircularProgressIndicator()):Container(
        padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 1.5, right: SizeConfig.widthMultiplier * 1.5),
        alignment: Alignment.center,
        child: (categoryNotifier.categoryList.length !=null) ? GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            primary: false,
            padding:  const EdgeInsets.all(0),
            crossAxisSpacing: 0,
            mainAxisSpacing: 15,
            crossAxisCount: 4,
          children: List.generate(8, (index) {
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
                  switch(categoryData.status){
                    case "available" :
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductListItem(categoryData.nama,categoryData.id ),
                          )
                        // ignore: unnecessary_statements
                      );
                      break;
                    case "comingsoon":
                      0;
                      break;
                    default:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PromoDetailScreen(categoryData.nama,categoryData.status ),
                          )
                        // ignore: unnecessary_statements
                      );
                  }
                }
            );
          }),
        ):Center(child: CircularProgressIndicator())
      );
    }
  }