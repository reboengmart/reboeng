import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reboeng/services/wrapper.dart';
import 'package:reboeng/ui/Screens/Profile/address/addressmainscreen.dart';
import 'package:reboeng/ui/Screens/checkout/components/rounded_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';
import 'package:intl/intl.dart';
class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
  static const TextStyle boldText = TextStyle(
    fontWeight: FontWeight.bold,
  );
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String uid;
  bool isLoading = true;

  void firebaseUid() async {
    await new Future.delayed(const Duration(seconds: 2));
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();
    new Future.delayed(new Duration(seconds: 4), () {
      setState(() {
        uid = user.uid;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool loading = true;
    firebaseUid();
    final image = 'assets/img/3.jpg';
    final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
    final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);
    int totalCart=0;
    int kirimongkos=3000;
    DateTime now = DateTime.now();
    String formattanggal = DateFormat('d MMMM y').format(now);
    String formattime = DateFormat('kk:mm:ss').format(now);
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: <Widget>[
                    StreamBuilder<QuerySnapshot>(
                        stream: Firestore.instance
                            .collection('user')
                            .where('uid',
                            isEqualTo:
                            "$uid")
                            .snapshots(),
                        // ignore: missing_return
                        builder: (context, snapshot) {
                          List _cartTotal;
                          if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
                            _cartTotal = List.generate(
                                snapshot.data.documents.length,
                                    (index) => snapshot
                                    .data
                                    .documents[index]
                                    .data['cartTotal']);
                            totalCart =
                                int.parse(_cartTotal[0].toString()) +
                                    kirimongkos;
                          }
                          if (_cartTotal == null) {
                            return CircularProgressIndicator();
                          }
                          if (snapshot.hasError) {
                            return Text(snapshot.error);
                          }
                          if (_cartTotal != null) {
                            return Column(
                              children: <Widget>[
                                Text(
                                  "Thank You!",
                                  style: TextStyle(color: Colors.green),
                                ),
                                Text(
                                  "Your transaction was successful",
                                  style: label,
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "DATE",
                                      style: label,
                                    ),
                                    Text("TIME", style: label)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("$formattanggal"),
                                    Text("$formattime")
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "TO",
                                          style: label,
                                        ),
                                        Text("Manny Moto"),
                                        Text(
                                          "manny.moto@gmail.com",
                                          style: subtitle,
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      backgroundImage: AssetImage(image),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "AMOUNT",
                                          style: label,
                                        ),
                                        Text("Rp .${totalCart.toString()}"),
                                      ],
                                    ),
                                    Text(
                                      "COMPLETED",
                                      style: label,
                                    )
                                  ],
                                ),
                              ],
                            );
                          }
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        }),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Icon(Icons.account_balance_wallet),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Credit/Debit Card"),
                              Text(
                                "Master Card ending ***5",
                                style: subtitle,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Simpan'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Wrapper(),
                      )
                      // ignore: unnecessary_statements
                      );
                },
              ),
            ],
          );
        },
      );
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int cartTotal = 0;
    int ongkos_kirim = 3000;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
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
                  List _cartTotal;
                  if (snapshot.hasData) {
                    _cartTotal = List.generate(
                        snapshot.data.documents.length,
                        (index) =>
                            snapshot.data.documents[index].data['detail']);
//                      cartTotal = int.parse(_cartTotal[0].toString());
                  }
                  if (_cartTotal == null) {
                    return Padding(
                        padding: const EdgeInsets.only(top : 2),
                        child: Center(child: CircularProgressIndicator())
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error);
                  }
                  if (_cartTotal.isNotEmpty) {
                    loading = false;
                    return Column(
                      children: <Widget>[
                        Text(
                          "Pilih Cara Pembayaran",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        RoundedContainer(
                          width: width * 0.95,
                          height: height * 0.15,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          child: Center(
                            child: Text(_cartTotal[0].toString()),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: width * 0.9,
                              alignment: Alignment.bottomRight,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddressScreen()));
                                },
                                child: Text('Ganti Alamat Pengiriman ->',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat')),
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            RoundedContainer(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.paypal,
                                  color: Colors.blueAccent,
                                ),
                                title: Text("Paypal"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                            RoundedContainer(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.googleWallet,
                                  color: Colors.redAccent,
                                ),
                                title: Text("Google Pay"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                            RoundedContainer(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Icon(
                                  FontAwesomeIcons.applePay,
                                  color: kTextColor,
                                ),
                                title: Text("Apple Pay"),
                                trailing: Icon(Icons.arrow_forward_ios),
                              ),
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier * 5),
                            Container(
                              alignment: Alignment.bottomRight,
                              padding: EdgeInsets.only(
                                  right: SizeConfig.widthMultiplier * 5),
                              width: MediaQuery.of(context).size.width * 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  StreamBuilder<QuerySnapshot>(
                                      stream: Firestore.instance
                                          .collection('user')
                                          .where('uid',
                                          isEqualTo:
                                          "$uid")
                                          .snapshots(),
                                      // ignore: missing_return
                                      builder: (context, snapshot) {
                                        List _cartTotal;
                                        if (snapshot.hasData && snapshot.data.documents.isNotEmpty) {
                                          _cartTotal = List.generate(
                                              snapshot.data.documents.length,
                                                  (index) => snapshot
                                                  .data
                                                  .documents[index]
                                                  .data['cartTotal']);
                                          cartTotal =
                                              int.parse(_cartTotal[0].toString()) +
                                                  ongkos_kirim;
                                        }
                                        if (_cartTotal == null) {
                                          return CircularProgressIndicator();
                                        }
                                        if (snapshot.hasError) {
                                          return Text(snapshot.error);
                                        }
                                        if (_cartTotal != null) {
                                          return Column(
                                            children: <Widget>[
                                              Text(
                                                "Total Keranjang     Rp. ${_cartTotal[0].toString()}",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 2.6 *
                                                      SizeConfig.textMultiplier,
                                                ),
                                              ),
                                              Text(
                                                "Total Ongkos Kirim Rp. ${ongkos_kirim.toString()}",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 2.6 *
                                                      SizeConfig.textMultiplier,
                                                ),
                                              ),
                                              Text(
                                                "Total Bayar Rp. ${cartTotal.toString()}",
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 2.6 *
                                                      SizeConfig.textMultiplier,
                                                ),
                                              )
                                            ],
                                          );
                                        }
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.green,
                                            ),
                                          );
                                        }
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 32.0,
                              ),
                              child: RaisedButton(
                                  elevation: 0,
                                  padding: const EdgeInsets.all(24.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  child: Text("Continue"),
                                  color: kPrimaryColor,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _showMyDialog();
                                  }),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.only(top : 2),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class PaymentSuccessDialog extends StatelessWidget {
  final image = 'assets/img/3.jpg';
  final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 370,
        child: Dialog(),
      ),
    );
  }
}
