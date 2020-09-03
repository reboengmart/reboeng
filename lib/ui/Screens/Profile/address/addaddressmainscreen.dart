import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/AddressNotifier.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressNotifier>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add Address')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(decoration: InputDecoration(hintText: 'Nama'),
            onChanged: (value){
            addressProvider.changeNama(value);
            },
            ),
            TextField(decoration: InputDecoration(hintText: 'Geo'),),
            TextField(decoration: InputDecoration(hintText: 'icon'),
              onChanged: (value){
                addressProvider.changeIcon(value);
              },),
            TextField(decoration: InputDecoration(hintText: 'detail'),
              onChanged: (value){
                addressProvider.changeDetail(value);
              },),
          SizedBox(height: 20.0),
            RaisedButton(
              child: Text("Save"),
              onPressed: (){
                addressProvider.saveAddress();
              }
              ),
          ],
        ),
      ),

    );
  }
}
