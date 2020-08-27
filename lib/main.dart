import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/AddressNotifier.dart';
import 'package:reboeng/provider/CartNotifier.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/provider/ProductListNotifier.dart';
import 'package:reboeng/provider/SubProductNotifier.dart';
import 'package:reboeng/provider/TransactionNotifier.dart';
import 'package:reboeng/provider/UserNotifier.dart';
import 'package:reboeng/provider/WishListNotifier.dart';
import 'package:reboeng/services/api/cart_api.dart';
import 'package:reboeng/services/api/cart_total.dart';
import 'package:reboeng/services/api/user_api.dart';
import 'package:reboeng/services/api/wishlist_api.dart';
import 'package:reboeng/services/auth.dart';
import 'package:reboeng/services/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService=UserApi();
    final cartApi=CartApi();
    final cartwishList=WishListApi();
    final cartTotal=CartTotalApi();
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child:  MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AddressNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductCategoryNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => TransactionNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductListNotifier(),
          ), ChangeNotifierProvider(
            create: (context) => SubProductNotifier(),
          ),ChangeNotifierProvider(
            create: (context) => CartNotifier(),
          ), ChangeNotifierProvider(
            create: (context) => UserNotifier(),
          ),ChangeNotifierProvider(
            create: (context) => WishListNotifier(),
          ),
          StreamProvider(create: (context)=>firestoreService.getUser()),
          StreamProvider(create: (context)=>cartApi.getCart()),
          StreamProvider(create: (context)=>cartwishList.getWishList()),
          StreamProvider(create: (context)=>cartTotal.getUser()),
        ],
        child: MaterialApp(
          title: 'Reboeng',
          theme: ThemeData(
              primarySwatch: Colors.teal,
              primaryColor: Color.fromRGBO(22,160,133 ,1),
              accentColor: Color.fromRGBO(22,160,133 ,1),
              primaryColorLight: Color.fromRGBO(241,196,15 ,1)
          ),
          home: Wrapper(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}

//Halloosssssssss
//iyess git repone keneng