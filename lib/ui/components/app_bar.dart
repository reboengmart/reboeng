import 'package:flutter/material.dart';
import 'package:reboeng/ui/constants.dart';

AppBar homeAppBar(BuildContext context, String search) {
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
              IconButton(
                icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
                onPressed: () {},
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
          IconButton(
            icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
            onPressed: () {},
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
          IconButton(
            icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
            onPressed: () {},
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
        IconButton(
          icon: new Icon(Icons.notifications, color: Color.fromRGBO(185, 194, 210, 1),),
          onPressed: () {},
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
