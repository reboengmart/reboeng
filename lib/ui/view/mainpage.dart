import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reboeng/provider/DrawerProvider.dart';
import 'package:reboeng/ui/Screens/CartList/cartlist.dart';
import 'package:reboeng/ui/Screens/Home/home.dart';
import 'package:reboeng/ui/Screens/Profile/myprofile.dart';
import 'package:reboeng/ui/Screens/WishList/wishlist.dart';
import 'package:reboeng/ui/components/app_bar.dart';
import 'package:reboeng/ui/components/bottom_bar_navigation_pattern/animated_bottom_bar.dart';
import 'package:reboeng/ui/components/sizeconfig.dart';
import 'package:reboeng/ui/constants.dart';


class MainPage extends StatefulWidget {
  final FirebaseUser firebaseUser;
  final int indexScreen;
  MainPage(this.firebaseUser, this.indexScreen);
  @override
  _MainPageState createState() => _MainPageState(indexScreen);
}

class _MainPageState extends State<MainPage> {

  final firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {

//    firebaseMessaging.configure(
//      onLaunch:  (Map<String, dynamic> message) async {
//        debugPrint('onLaunch: $message');
//      },
//      onBackgroundMessage: (Map<String, dynamic> message) async {
//      debugPrint('onBackground: $message');
//    }
//    );

    firebaseMessaging.requestNotificationPermissions(
    const IosNotificationSettings(sound: true, badge: true, alert: true, provisional: true)
    );

    firebaseMessaging.onIosSettingsRegistered.listen((event) {
      debugPrint('settings registered: $event');
    });

    firebaseMessaging.subscribeToTopic(widget.firebaseUser.uid);

    // TODO: implement initState
    super.initState();
  }

  final int indexScreen;
  _MainPageState(this.indexScreen);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageScreen(indexScreen, widget.firebaseUser),
    );
  }
}

class MainPageScreen extends StatefulWidget {
  final int indexScreen;
  final FirebaseUser userFirebase;
  MainPageScreen(this.indexScreen, this.userFirebase);
  @override
  _MainPageScreenState createState() => _MainPageScreenState(indexScreen);
}

class _MainPageScreenState extends State<MainPageScreen> {
  int _currentIndex;
  final int indexScreen;
  _MainPageScreenState(this.indexScreen);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = indexScreen;
  }


  final List<Widget> _children = [
    HomeScreen(),
    WishList(),
    CartList(),
    MyProfile(),
  ];

  final List<BarItem> barItems = [
    BarItem(
        iconData: Icons.home, text: 'Home', color: kPrimaryColor
    ),
    BarItem(
        iconData: Icons.favorite, text: 'Harapan', color: kPrimaryColor
    ),
    BarItem(
        iconData: Icons.shopping_cart, text: 'Keranjang', color: kPrimaryColor
    ),
    BarItem(
        iconData: Icons.person, text: 'Profil', color: kPrimaryColor
    ),
  ];

  void onTappedBar(int value){
    setState(() {
      _currentIndex = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (context, constraints){
          return OrientationBuilder(
            builder: (context, Orientation orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: MultiProvider(
                  providers: [
                    ChangeNotifierProvider<DrawerProvider>(create: (context) { return DrawerProvider(); },)
                  ],
                  child: Scaffold(
                    // ignore: unrelated_type_equality_checks
                    appBar: (_currentIndex == 3 ) ? null : homeAppBar(context, search[_currentIndex].searchString, widget.userFirebase.uid),
                    body: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      child: _children[_currentIndex],
                    ),
                    bottomNavigationBar: AnimatedBottomBar(
                        barIndex: _currentIndex,
                        barItems: barItems,
                        animationDuration: const Duration(milliseconds: 150),
                        barStyle: BarStyle(
                            fontSize: 15.0,
                            iconSize: 25.0
                        ),
                        onBarTap: (index) {
                          onTappedBar(index);
                        }),
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
class SearchList{
  const SearchList({this.searchString});
  final String searchString;
}

const List<SearchList> search = const <SearchList>[
  const SearchList(searchString: 'home'),
  const SearchList(searchString: 'wishlist'),
  const SearchList(searchString: 'cart'),
  const SearchList(searchString: 'profile'),
];


//class Choice {
//  const Choice({this.homeColor, this.wishColor, this.cartColor, this.profileColor});
//  final Color homeColor, wishColor, cartColor, profileColor;
//}
//
//const List<Choice> choices = const <Choice>[
//  const Choice(homeColor: kPrimaryColor, wishColor: Color.fromRGBO(250, 250, 250, 1), cartColor: Color.fromRGBO(250, 250, 250, 1), profileColor: Color.fromRGBO(250, 250, 250, 1)),
//  const Choice(homeColor: Color.fromRGBO(250, 250, 250, 1), wishColor: kPrimaryColor, cartColor: Color.fromRGBO(250, 250, 250, 1), profileColor: Color.fromRGBO(250, 250, 250, 1)),
//  const Choice(homeColor: Color.fromRGBO(250, 250, 250, 1), wishColor: Color.fromRGBO(250, 250, 250, 1), cartColor: kPrimaryColor, profileColor: Color.fromRGBO(250, 250, 250, 1)),
//  const Choice(homeColor: Color.fromRGBO(250, 250, 250, 1), wishColor: Color.fromRGBO(250, 250, 250, 1), cartColor: Color.fromRGBO(250, 250, 250, 1), profileColor: kPrimaryColor),
//];
