import 'package:flutter/material.dart';
import 'package:reboeng/ui/constants.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class MainNotification extends StatefulWidget {
  @override
  _MainNotificationState createState() => _MainNotificationState();
}

class _MainNotificationState extends State<MainNotification> {

//  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {

//    firebaseMessaging.getToken().then((value) {print('ini tokennya   $value');});

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'Notifikasi Saya',
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('ini adalah halaman notifikasi'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.check, color: kPrimaryColor,), backgroundColor: Colors.white,),
    );
  }
}
