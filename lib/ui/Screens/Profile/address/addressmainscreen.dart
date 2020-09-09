import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/AddressNotifier.dart';
import 'package:reboeng/services/api/address_api.dart';
import 'package:reboeng/ui/Screens/Profile/address/addaddressmainscreen.dart';
import 'package:reboeng/ui/Screens/Profile/address/show_geo_location.dart';
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
    AddressNotifier addressNotifier =
        Provider.of<AddressNotifier>(context, listen: false);
    AddressApi().getUserAddress(addressNotifier);
    super.initState();
  }

  bool isLoading = true;

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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    firebaseUid();
    AddressNotifier addressNotifier = Provider.of<AddressNotifier>(context);
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Alamat Anda',
          style: TextStyle(color: kTextColor),
        ),
        actions: <Widget>[
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddAddressScreen()));
              },
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
                      .where('status', isEqualTo: 'primary')
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    String _detail;
                    if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }
                    if (snapshot.hasData &&
                        snapshot.data.documents.isNotEmpty) {
                      _detail = snapshot.data.documents[0].data['detail'];
                    }
                    if (_detail == null) {
                      isLoading = true;
                    }
                    if (_detail != null) {
                      isLoading = false;
                      return Container(
                        width: width * 0.9,
                        height: height * 0.25,
                        margin: EdgeInsets.only(top: height * 0.02),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromRGBO(22, 160, 133, 0.08)),
                        child: Center(
                          child: Text(_detail),
                        ),
                      );
                    }
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: Text(''),
                      );
                    }
                    if (snapshot.data.documents.isEmpty) {
                      return Center(
                        child: Text(''),
                      );
                    }
                  }),
              Container(
                child: isLoading
                    ? Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: SizeConfig.heightMultiplier * 35),
                            CircularProgressIndicator(),
                          ],
                        ),
                      )
                    : Expanded(
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
                                final item =
                                    addressNotifier.addressList[position];
                                switch (item.icon) {
                                  case 'rumah':
                                    iconn = LineAwesomeIcons.home;
                                    break;
                                  case 'kantor':
                                    iconn = Icons.location_city;
                                    break;
                                  default:
                                    iconn = LineAwesomeIcons.building;
                                }
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowGeoLocation(item.id)));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: height * 0.01),
                                    padding: EdgeInsets.only(
                                        left: width * 0.07,
                                        right: width * 0.07),
                                    child: RoundedContainer(
                                      padding: const EdgeInsets.all(3.0),
                                      borderColor: (item.notSelected == true)
                                          ? kTextColor
                                          : kPrimaryColor,
                                      child: ListTile(
                                        leading: Icon(
                                          iconn,
                                          color: kPrimaryColor,
                                        ),
                                        title: Text(
                                          item.nama,
                                          style: TextStyle(color: kTextColor),
                                        ),
                                        trailing: (item.notSelected == true)
                                            ? InkWell(
                                                onTap: () {},
                                                child: Text(
                                                  'ganti ini',
                                                  style: TextStyle(
                                                      color: kPrimaryColor),
                                                ))
                                            : Icon(
                                                Icons.check,
                                                color: kPrimaryColor,
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
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
