import 'package:flutter/material.dart';
import 'package:reboeng/ui/screens/home/components/item_card.dart';

class PopularFruits extends StatelessWidget {
  const PopularFruits({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ItemCard(
            svgSrc: "assets/buah/avocado.png",
            title: "Alpukat",
            shopName: "Tersisa 8 kg",
            press: () {},
          ),
          ItemCard(
            svgSrc: "assets/buah/kelapa.png",
            title: "Kelapa",
            shopName: "Tersisa 15 kg",
            press: () {},
          ),
          ItemCard(
            svgSrc: "assets/buah/durian.png",
            title: "Durian",
            shopName: "Tersisa 5 kg",
            press: () {},
          )
        ],
      ),
    );
  }
}
