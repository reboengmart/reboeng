import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/ProductCategoryNotifier.dart';
import 'package:reboeng/provider/ProductListNotifier.dart';
import 'package:reboeng/services/auth.dart';
import 'package:reboeng/services/wrapper.dart';
import 'package:reboeng/services/api/productCategory_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService=GetProductCategory();
    return StreamProvider.value(
      value: AuthServices.firebaseUserStream,
      child:  MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductCategoryNotifier(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductListNotifier(),
          ),
          StreamProvider(create: (context)=>firestoreService.getCategory()),
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