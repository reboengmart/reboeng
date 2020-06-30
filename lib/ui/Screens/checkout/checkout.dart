import 'package:flutter/material.dart';
import 'package:reboeng/ui/Screens/Profile/address/addressmainscreen.dart';
import 'package:reboeng/ui/Screens/checkout/components/rounded_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reboeng/ui/constants.dart';


class CheckOutScreen extends StatelessWidget {

  static const TextStyle boldText = TextStyle(
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {

    final image = 'assets/img/3.jpg';
    final TextStyle subtitle = TextStyle(fontSize: 12.0, color: Colors.grey);
    final TextStyle label = TextStyle(fontSize: 14.0, color: Colors.grey);

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
                    Text("Thank You!",style: TextStyle(color: Colors.green),),
                    Text("Your transaction was successful",style: label,),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("DATE", style: label,),
                        Text("TIME", style: label)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("2, April 2019"),
                        Text("9:10 AM")
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("TO", style: label,),
                            Text("Manny Moto"),
                            Text("manny.moto@gmail.com", style: subtitle,),
                          ],
                        ),
                        CircleAvatar(backgroundColor: Colors.green, backgroundImage: AssetImage(image),)
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("AMOUNT", style: label,),
                            Text("\$ 15000"),
                          ],
                        ),
                        Text("COMPLETED", style: label,)
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.account_balance_wallet),),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Credit/Debit Card"),
                              Text("Master Card ending ***5", style: subtitle,),
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
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                height: height * 0.25,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 8.0,
                ),
                child: Center(
                  child: Text('alamat ..... '),
                ),
              ),
            Container(
              width: width * 0.9,
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddressScreen()
                  ));
                },
                child: Text('Ganti Alamat Pengiriman ->', style: boldText,),
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
            const SizedBox(height: 20.0),
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
                onPressed: () { _showMyDialog();}
              ),
            )
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
        child: Dialog(

        ),
      ),
    );
  }
}