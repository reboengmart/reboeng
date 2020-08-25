import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/AddressNotifier.dart';
import 'package:reboeng/services/api/address_api.dart';
import 'package:reboeng/services/model/address.dart';
import 'package:reboeng/ui/Screens/checkout/components/rounded_container.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

//class AddressScreen extends StatelessWidget {
//
////  final ListAlamat = [
////    {
////      'nama' : 'Rumah',
////      'icon' : 'rumah',
////      'notSelected' : false
////    },
////    {
////      'nama' : 'Kantor',
////      'icon' : 'kantor',
////      'notSelected' : true
////    },
////    {
////      'nama' : 'Tetangga',
////      'icon' : 'lain',
////      'notSelected' : true
////    },
////    {
////      'nama' : 'Gudang',
////      'icon' : 'lain',
////      'notSelected' : true
////    },
////    {
////      'nama' : 'Gudang',
////      'icon' : 'lain',
////      'notSelected' : true
////    }
////  ];
//
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: AddressScreen(),
//      theme: ThemeData.light(),
//    );
//  }
//}


class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {


  @override
  void initState() {
    AddressNotifier addressNotifier = Provider.of<AddressNotifier>(context, listen: false);
    AddressApi().getUserAddress(addressNotifier);
    super.initState();
  }

  Future<void> _refreshNow() async {
    AddressNotifier addressNotifier =
    Provider.of<AddressNotifier>(context, listen: false);
    await setState(() {
      AddressApi().getUserAddress(addressNotifier);
    });
    await Future.delayed(Duration(milliseconds: 1500));
  }
  String uid;
  void firebaseUid() async {
    await new Future.delayed(const Duration(seconds: 2));
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      uid = user.uid;
    });
  }
  @override
  Widget build(BuildContext context) {
    firebaseUid();
    AddressNotifier addressNotifier=Provider.of<AddressNotifier>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
//    List<Address> listdetail=addressNotifier.addressList.where((element) => element.notSelected=false).toList();
//
////    var selectedAddress = List<Address>.generate(listdetail.length, (index) => listdetail[index]);
////    final detailll = selectedAddress[0];
//    List<Address> item2 = List<Address>.generate(addressNotifier.addressList2.length, (index) => addressNotifier.addressList2[index]);
//
////    List<Address> selectedAddress = addressNotifier.addressList2.firstWhere((element) => element.notSelected=false);
//    List<Address> selectedAddress=item2.where((i) => i.notSelected).toList();
//
//    print("Tes MUncul  ${selectedAddress[0].detail}");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop(),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text('Alamat Anda', style: TextStyle(color: kTextColor),),
        actions: <Widget>[
          Center(
            child: InkWell(
              onTap: (){},
              child: Container(
                padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 4),
                child: Text(
                  "Tambah Alamat",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 2.6 * SizeConfig.textMultiplier,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('user')
                      .document("$uid")
                      .collection('address')
                      .where('status',isEqualTo: 'primary')
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    List _cartTotal;
                    if (snapshot.data.documents.length != null) {
                      _cartTotal = List.generate(
                          snapshot.data.documents.length,
                              (index) => snapshot
                              .data.documents[index].data['detail']);
//                      cartTotal = int.parse(_cartTotal[0].toString());
                    }
                    if (_cartTotal.length == 0) {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.red,
                      );
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }
                    if (_cartTotal.length != 0) {
                      return Container(
                        width: width * 0.9,
                        height: height * 0.25,
                        margin: EdgeInsets.only(top: height * 0.02),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromRGBO(22,160,133, 0.08)
                        ),
                        child: Center(
                          child: Text(_cartTotal[0].toString()),
                        ),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }),
              Expanded(
                child: Container(
                  height: height * 0.45,
                  margin: EdgeInsets.only(top: height * 0.02),
                  alignment: Alignment.center,
                  child: RefreshIndicator(
                    onRefresh: _refreshNow,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: addressNotifier.addressList.length,
                      itemBuilder: (context, position) {
                        IconData iconn;
                        final item = addressNotifier.addressList[position];
                        switch(item.icon){
                          case 'rumah':
                            iconn = LineAwesomeIcons.home;
                            break;
                          case 'kantor':
                            iconn = Icons.location_city;
                            break;
                          case 'lain':
                            iconn = LineAwesomeIcons.building;
                            break;
                        }
                        return Container(
                          margin: EdgeInsets.only(top: height * 0.01),
                          padding: EdgeInsets.only(left: width * 0.07, right: width * 0.07),
                          child: RoundedContainer(
                            padding: const EdgeInsets.all(3.0),
                            borderColor: (item.notSelected == true) ? kTextColor : kPrimaryColor,
                            child: ListTile(
                              leading: Icon(
                                iconn,
                                color: kPrimaryColor,
                              ),
                              title: Text(item.nama, style: TextStyle(color: kTextColor),),
                              trailing: (item.notSelected==true) ? Icon(Icons.arrow_forward_ios) : Icon(Icons.check, color: kPrimaryColor,),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


