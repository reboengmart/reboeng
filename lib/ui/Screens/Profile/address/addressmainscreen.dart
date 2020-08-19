import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:reboeng/ui/Screens/checkout/components/rounded_container.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

class AddressScreen extends StatelessWidget {
  final ListAlamat = [
    {
      'nama' : 'Rumah',
      'icon' : LineAwesomeIcons.home,
      'notSelected' : false
    },
    {
      'nama' : 'Kantor',
      'icon' : LineAwesomeIcons.building,
      'notSelected' : true
    },
    {
      'nama' : 'Tetangga',
      'icon' : LineAwesomeIcons.building,
      'notSelected' : true
    },
    {
      'nama' : 'Gudang',
      'icon' : LineAwesomeIcons.building,
      'notSelected' : true
    },
    {
      'nama' : 'Gudang',
      'icon' : LineAwesomeIcons.building,
      'notSelected' : true
    }
  ];


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
              Container(
                width: width * 0.9,
                height: height * 0.25,
                margin: EdgeInsets.only(top: height * 0.02),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Color.fromRGBO(22,160,133, 0.08)
                ),
                child: Center(
                  child: Text('Ini adalah Alamat Utama .... '),
                ),
              ),
              Expanded(
                child: Container(
                  height: height * 0.45,
                  margin: EdgeInsets.only(top: height * 0.02),
                  alignment: Alignment.center,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: ListAlamat.length,
                    itemBuilder: (context, position) {
                      final item = ListAlamat[position];
                      return Container(
                        margin: EdgeInsets.only(top: height * 0.01),
                        padding: EdgeInsets.only(left: width * 0.07, right: width * 0.07),
                        child: RoundedContainer(
                          padding: const EdgeInsets.all(3.0),
                          borderColor: (item['notSelected']) ? kTextColor : kPrimaryColor,
                          child: ListTile(
                            leading: Icon(
                              item['icon'],
                              color: kPrimaryColor,
                            ),
                            title: Text(item['nama'], style: TextStyle(color: kTextColor),),
                            trailing: (item['notSelected']) ? Icon(Icons.arrow_forward_ios) : Icon(Icons.check, color: kPrimaryColor,),
                          ),
                        ),
                      );
                    },
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

