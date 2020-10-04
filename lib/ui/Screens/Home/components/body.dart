import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/services/refresh.dart';
import 'package:reboeng/ui/Screens/Home/components/category_item.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/screens/home/components/category_grid.dart';
import 'package:reboeng/ui/screens/home/components/discount_card.dart';
import 'package:reboeng/ui/screens/home/components/item_list.dart';

import 'most_item.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    ProductCategoryNotifier productCategoryNotifier =
        Provider.of<ProductCategoryNotifier>(context, listen: false);
    RefreshServices.homeRefresh(productCategoryNotifier);
    super.initState();
  }

  Future<void> _refreshNow() async {
    ProductCategoryNotifier productCategoryNotifier =
        Provider.of<ProductCategoryNotifier>(context, listen: false);
    setState(() {
      RefreshServices.homeRefresh(productCategoryNotifier);
    });
    await Future.delayed(Duration(milliseconds: 1500));
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      onRefresh: _refreshNow,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: SizeConfig.heightMultiplier * 135,
          child: Column(
            children: <Widget>[
              Expanded(flex: 15, child: DiscountCard()),
              Expanded(
                  flex: 17,
                  child: Container(
                    padding: EdgeInsets.only(left: SizeConfig.widthMultiplier * 2, right: SizeConfig.widthMultiplier * 2),
                    color: Color.fromRGBO(189, 195, 199, 0.2),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 6,
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              child: CategoryItem()),
                        ),
                        Expanded(flex: 16, child: CategoryGrid()),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 19,
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.heightMultiplier * 3),
                    color: Color.fromRGBO(236, 240, 241, 0.5),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              child: MostItem()),
                        ),
                        Expanded(flex: 4, child: ItemList()),
                      ],
                    ),
                  )),
//              Expanded(
//                flex: 21,
//                child: Container(
//                  child: Column(
//                    children: <Widget>[
//                      Expanded(
//                        flex: 7,
//                        child: Container(
//                            alignment: Alignment.bottomLeft, child: FruitsHeader()),
//                      ),
//                      Expanded(flex: 27, child: PopularFruits()),
//                    ],
//                  ),
//                ),
//              )
            ],
          ),
        ),
      ),
    );
  }
}
