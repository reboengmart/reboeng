import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reboeng/ui/Screens/notification/notification.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';

AppBar homeAppBar(BuildContext context, String search, String uid) {

  switch (search) {
    case 'home' :
          return AppBar(
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            elevation: 0,
            title: RichText(
              text: TextSpan(
                style: Theme.of(context)
                    .textTheme
                // ignore: deprecated_member_use
                    .title
                    .copyWith(fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: "Re",
                    style: TextStyle(color: ksecondaryColor),
                  ),
                  TextSpan(
                    text: "boeng",
                    style: TextStyle(color: kPrimaryColor),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: new Icon(Icons.search, color: Color.fromRGBO(185, 194, 210, 1),),
                onPressed: () {},
              ),
              Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainNotification()));
                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
                        child: IconButton(
                          icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: FutureBuilder(
                            future: Firestore.instance.collection('user').document(uid).collection('notification').where('readed', isEqualTo: false).getDocuments(),
                            builder: (BuildContext context, AsyncSnapshot snap){
                              int _totalCompleted = 0;
                              if(snap.hasData){
                                _totalCompleted = snap.data.documents.length;
                              }
                              return Container(
                                child: (_totalCompleted != 0) ? Container(
                                  width: (_totalCompleted >= 100) ? SizeConfig.heightMultiplier * 5 : SizeConfig.heightMultiplier * 4,
                                  height: SizeConfig.heightMultiplier * 5,
                                  padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2, left: SizeConfig.widthMultiplier * 2, top: SizeConfig.heightMultiplier * 0.2),
                                  margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
                                  decoration: BoxDecoration(
                                      color: Colors.transparent
                                  ),
                                  child: Container(
                                    width: SizeConfig.heightMultiplier * 1,
                                    height: SizeConfig.heightMultiplier * 1,
                                    padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.3),
                                    decoration: new BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius: BorderRadius.circular(35)
                                    ),
                                    child: Text(
                                      '${_totalCompleted.toString()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.textMultiplier * 2,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ) : Text(''),
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
      break;

    case 'cart' :
      return AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        title: RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
            // ignore: deprecated_member_use
                .title
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Keranjang",
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search, color: Color.fromRGBO(185, 194, 210, 1),),
            onPressed: () {},
          ),
          Container(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainNotification()));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
                    child: IconButton(
                      icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    child: FutureBuilder(
                        future: Firestore.instance.collection('user').document(uid).collection('notification').where('readed', isEqualTo: false).getDocuments(),
                        builder: (BuildContext context, AsyncSnapshot snap){
                          int _totalCompleted = 0;
                          if(snap.hasData){
                            _totalCompleted = snap.data.documents.length;
                          }
                          return Container(
                            child: (_totalCompleted != 0) ? Container(
                              width: (_totalCompleted >= 100) ? SizeConfig.heightMultiplier * 5 : SizeConfig.heightMultiplier * 4,
                              height: SizeConfig.heightMultiplier * 5,
                              padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2, left: SizeConfig.widthMultiplier * 2, top: SizeConfig.heightMultiplier * 0.2),
                              margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
                              decoration: BoxDecoration(
                                  color: Colors.transparent
                              ),
                              child: Container(
                                width: SizeConfig.heightMultiplier * 1,
                                height: SizeConfig.heightMultiplier * 1,
                                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.3),
                                decoration: new BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(35)
                                ),
                                child: Text(
                                  '${_totalCompleted.toString()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.textMultiplier * 2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ) : Text(''),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
      break;

    case 'wishlist':
      return AppBar(
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 0,
        title: RichText(
          text: TextSpan(
            style: Theme.of(context)
                .textTheme
            // ignore: deprecated_member_use
                .title
                .copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Favorit ",
                style: TextStyle(color: ksecondaryColor),
              ),
              TextSpan(
                text: "Anda",
                style: TextStyle(color: kPrimaryColor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainNotification()));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
                    child: IconButton(
                      icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    child: FutureBuilder(
                        future: Firestore.instance.collection('user').document(uid).collection('notification').where('readed', isEqualTo: false).getDocuments(),
                        builder: (BuildContext context, AsyncSnapshot snap){
                          int _totalCompleted = 0;
                          if(snap.hasData){
                            _totalCompleted = snap.data.documents.length;
                          }
                          return Container(
                            child: (_totalCompleted != 0) ? Container(
                              width: (_totalCompleted >= 100) ? SizeConfig.heightMultiplier * 5 : SizeConfig.heightMultiplier * 4,
                              height: SizeConfig.heightMultiplier * 5,
                              padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2, left: SizeConfig.widthMultiplier * 2, top: SizeConfig.heightMultiplier * 0.2),
                              margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
                              decoration: BoxDecoration(
                                  color: Colors.transparent
                              ),
                              child: Container(
                                width: SizeConfig.heightMultiplier * 1,
                                height: SizeConfig.heightMultiplier * 1,
                                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.3),
                                decoration: new BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(35)
                                ),
                                child: Text(
                                  '${_totalCompleted.toString()}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeConfig.textMultiplier * 2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ) : Text(''),
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
      break;

//    case 'profile':
//      return AppBar(
//        toolbarOpacity: 0,
//        brightness: Brightness.dark,
//        backgroundColor: Colors.transparent,
//        elevation: 0,
//        actions: <Widget>[
//          IconButton(
//            icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
//            onPressed: () {},
//          ),
//        ],
//      );
//      break;

    default: return AppBar(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      elevation: 0,
      title: RichText(
        text: TextSpan(
          style: Theme.of(context)
              .textTheme
          // ignore: deprecated_member_use
              .title
              .copyWith(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: "Re",
              style: TextStyle(color: ksecondaryColor),
            ),
            TextSpan(
              text: "boeng",
              style: TextStyle(color: kPrimaryColor),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: new Icon(Icons.search, color: Color.fromRGBO(185, 194, 210, 1),),
          onPressed: () {},
        ),
        Container(
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainNotification()));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: SizeConfig.widthMultiplier * 2),
                  child: IconButton(
                    icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
                    onPressed: () {},
                  ),
                ),
                Container(
                  child: FutureBuilder(
                      future: Firestore.instance.collection('user').document(uid).collection('notification').where('readed', isEqualTo: false).getDocuments(),
                      builder: (BuildContext context, AsyncSnapshot snap){
                        int _totalCompleted = 0;
                        if(snap.hasData){
                          _totalCompleted = snap.data.documents.length;
                        }
                        return Container(
                          child: (_totalCompleted != 0) ? Container(
                            width: (_totalCompleted >= 100) ? SizeConfig.heightMultiplier * 5 : SizeConfig.heightMultiplier * 4,
                            height: SizeConfig.heightMultiplier * 5,
                            padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2, left: SizeConfig.widthMultiplier * 2, top: SizeConfig.heightMultiplier * 0.2),
                            margin: EdgeInsets.only(left: SizeConfig.widthMultiplier * 4),
                            decoration: BoxDecoration(
                                color: Colors.transparent
                            ),
                            child: Container(
                              width: SizeConfig.heightMultiplier * 1,
                              height: SizeConfig.heightMultiplier * 1,
                              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 0.3),
                              decoration: new BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(35)
                              ),
                              child: Text(
                                '${_totalCompleted.toString()}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.textMultiplier * 2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ) : Text(''),
                        );
                      }
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Logout', icon: Icons.open_in_new),
  const Choice(title: 'total', icon: Icons.web),
  const Choice(title: 'total', icon: Icons.search),
];
