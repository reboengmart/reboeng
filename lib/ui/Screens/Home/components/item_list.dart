import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:reboeng/ui/constants.dart';
//import 'package:reboeng/ui/screens/home/components/item_card.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductList = [
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

    return Container(
        height: 250,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          itemCount: ProductList.length,
          itemBuilder: (context, index) {
            final item = ProductList[index];
                  return Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: kPrimaryLightColor,
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(item['assets']),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromRGBO(22, 160, 133, 0.3)),
                      child: Text(
                        item['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    )
                  ],
            );
          }
      )
    );
  }
}
