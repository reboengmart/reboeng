import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reboeng/ui/Screens/Home/components/category_item.dart';
import 'package:reboeng/ui/Screens/Home/components/fruits_header.dart';
import 'package:reboeng/ui/Screens/Home/components/popular_fruits.dart';
import 'package:reboeng/ui/screens/home/components/category_grid.dart';
import 'package:reboeng/ui/screens/home/components/discount_card.dart';
import 'package:reboeng/ui/screens/home/components/item_list.dart';

import 'most_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height * 1.4,
        child: Column(
              children: <Widget>[
                Expanded(
                  flex: 15,
                    child: DiscountCard()
                ),
                Expanded(
                  flex: 18,
                    child: Container(
                      padding: EdgeInsets.all(2),
                        color: Color.fromRGBO(189, 195, 199, 0.2),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: CategoryItem()
                            ),
                          ),
                          Expanded(
                              flex: 11,
                              child: CategoryGrid()
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                  flex: 21,
                    child: Container(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
                      color: Color.fromRGBO(236, 240, 241, 0.5),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                                alignment: Alignment.bottomLeft,
                                child: MostItem()
                            ),
                          ),
                          Expanded(
                              flex: 16,
                              child: ItemList()
                          ),
                        ],
                      ),
                    )
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                      alignment: Alignment.bottomLeft,
                      child: FruitsHeader()
                  ),
                ),
                Expanded(
                    flex: 18,
                    child: PopularFruits()
                ),
              ],
        ),
      ),
    );
  }
}

