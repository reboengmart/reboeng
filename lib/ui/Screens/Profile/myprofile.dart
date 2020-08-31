import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:reboeng/services/auth.dart';
import 'package:reboeng/ui/Screens/Profile/address/addressmainscreen.dart';
import 'package:reboeng/ui/Screens/Profile/components/constants.dart';
import 'package:reboeng/ui/Screens/Profile/payment_history/main_payment.dart';
import 'package:reboeng/ui/Screens/Profile/settings/ProfileSettings.dart';

import 'components/profile_list_item.dart';

class MyProfile extends StatelessWidget {
  // This widget is the root of your a pplication.
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseUser userFirebase;

  void firebaseUserAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    setState(() {
      userFirebase = user;
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

    firebaseUserAuth();

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: AssetImage('assets/buah/lemon.png'),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          (userFirebase != null) ? Column(
            children: <Widget>[
              Text(
                '${userFirebase.uid}',
                style: kTitleTextStyle,
              ),
              SizedBox(height: kSpacingUnit.w * 0.5),
              Text(
                '${userFirebase.email}',
                style: kCaptionTextStyle,
              ),
            ],
          ) :Center(child: CircularProgressIndicator(),),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 4,
            width: kSpacingUnit.w * 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'Member',
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );

//    var themeSwitcher = ThemeSwitcher(
//      builder: (context) {
//        return AnimatedCrossFade(
//          duration: Duration(milliseconds: 200),
//          crossFadeState:
//          ThemeProvider.of(context).brightness == Brightness.dark
//              ? CrossFadeState.showFirst
//              : CrossFadeState.showSecond,
//          firstChild: GestureDetector(
//            onTap: () =>
//                ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
//            child: Icon(
//              LineAwesomeIcons.sun,
//              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//            ),
//          ),
//          secondChild: GestureDetector(
//            onTap: () =>
//                ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
//            child: Icon(
//              LineAwesomeIcons.moon,
//              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//            ),
//          ),
//        );
//      },
//    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
//        Icon(
//          LineAwesomeIcons.arrow_left,
//          size: ScreenUtil().setSp(kSpacingUnit.w * 3),
//        ),
        profileInfo,
//        themeSwitcher,
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 4),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddressScreen()));
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.user_shield,
                          text: 'Alamat',
                          hasNavigation: 'true',
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MainPaymentHistory(0))
                          );
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.history,
                          text: 'Purchase History',
                          hasNavigation: 'true',
                        ),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Chat With Costumer Service',
                        hasNavigation: 'true',
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileSettings()));
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.cog,
                          text: 'Settings',
                          hasNavigation: 'true',
                        ),
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Rating',
                        hasNavigation: 'true',
                      ),
                      InkWell(
                        onTap: () async {
                          await AuthServices.signOut();
                        },
                        child: ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          hasNavigation: 'GoTo',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

//class MyProfile extends StatefulWidget {
//  @override
//  _MyProfileState createState() => _MyProfileState();
//}
//
//class _MyProfileState extends State<MyProfile> {
//  @override
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        backgroundColor: Colors.grey.shade100,
//        extendBodyBehindAppBar: true,
//        extendBody: true,
//        appBar: AppBar(
//          backgroundColor: Colors.transparent,
//          elevation: 0,
//        ),
//        body: SingleChildScrollView(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              ProfileHeader(
//                avatar: AssetImage('assets/buah/strawberry.png'),
//                coverImage: AssetImage('assets/buah/buah.png'),
//                title: "Adam Husein",
//                subtitle: "Member",
//                actions: <Widget>[
//
//                ],
//              ),
//              const SizedBox(height: 10.0),
//              UserInfo(),
//              UserMenu(),
//            ],
//          ),
//        ));
//  }
//}
//
//class UserMenu extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(10),
//      child: Column(
//        children: <Widget>[
////          Container(
////            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
////            alignment: Alignment.topLeft,
////            child: Text(
////              "User Menu",
////              style: TextStyle(
////                color: Colors.black87,
////                fontWeight: FontWeight.w500,
////                fontSize: 16,
////              ),
////              textAlign: TextAlign.left,
////            ),
////          ),
//          Card(
//            child: Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.all(15),
//              child: Column(children: <Widget>[
//                InkWell(
//                  onTap: (){
//                    Navigator.push(context, MaterialPageRoute(
//                        builder: (context) => AddressScreen()
//                    ));
//                  },
//                  child: RoundedContainer(
//                    margin: const EdgeInsets.all(8.0),
//                    padding: const EdgeInsets.all(8.0),
//                    borderColor: Colors.grey,
//                    child: ListTile(
//                      leading: Icon(
//                        FontAwesomeIcons.addressBook,
//                        color: kPrimaryColor,
//                      ),
//                      title: Text("Alamat Pengiriman", style: TextStyle(color: Colors.grey),),
//                      trailing: Icon(Icons.arrow_forward_ios),
//                    ),
//                  ),
//                ),
//                InkWell(
//                  onTap: (){
//                    Navigator.push(context, MaterialPageRoute(
//                        builder: (context) => ProfileSettings()
//                    ));
//                  },
//                  child: RoundedContainer(
//                    margin: const EdgeInsets.all(8.0),
//                    padding: const EdgeInsets.all(8.0),
//                    borderColor: Colors.grey,
//                    child: ListTile(
//                      leading: Icon(
//                        Icons.settings,
//                        color: kPrimaryColor,
//                      ),
//                      title: Text("Pengaturan Akun", style: TextStyle(color: Colors.grey),),
//                      trailing: Icon(Icons.arrow_forward_ios),
//                    ),
//                  ),
//                ),
//                RoundedContainer(
//                  margin: const EdgeInsets.all(8.0),
//                  padding: const EdgeInsets.all(8.0),
//                  borderColor: Colors.grey,
//                  child: ListTile(
//                    leading: Icon(
//                      FontAwesomeIcons.googlePlay,
//                      color: kPrimaryColor,
//                    ),
//                    title: Text("Rating Kami di Playstore", style: TextStyle(color: Colors.grey),),
//                    trailing: Icon(Icons.arrow_forward_ios),
//                  ),
//                ),
//                InkWell(
//                  onTap: () async {
//                    await AuthServices.signOut();
//                  },
//                  child: RoundedContainer(
//                    margin: const EdgeInsets.all(8.0),
//                    padding: const EdgeInsets.all(8.0),
//                    borderColor: Colors.grey,
//                    child: ListTile(
//                      leading: Icon(
//                        Icons.phonelink_erase,
//                        color: kPrimaryColor,
//                      ),
//                      title: Text("Log Out", style: TextStyle(color: Colors.grey),),
//                      trailing: Icon(Icons.call_made),
//                    ),
//                  ),
//                ),
//              ],
//              )
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//
//class UserInfo extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      alignment: Alignment.center,
//      child: Row(
//        children: <Widget>[
////          Container(
////            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
////            alignment: Alignment.topLeft,
////            child: Text(
////              "Informasi User",
////              style: TextStyle(
////                color: Colors.black87,
////                fontWeight: FontWeight.w500,
////                fontSize: 16,
////              ),
////              textAlign: TextAlign.left,
////            ),
////          ),
//          Card(
//            child: Container(
//              width: MediaQuery.of(context).size.width * 0.95,
//              alignment: Alignment.center,
//              padding: EdgeInsets.all(15),
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceAround,
//                    children: <Widget>[
//                      Column(
//                        children: <Widget>[
//                          Icon(Icons.my_location),
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Icon(Icons.email),
//                        ],
//                      ),
//                      Column(
//                        children: <Widget>[
//                          Icon(Icons.phone),
//                        ],
//                      ),
//                    ],
//                  )
////                  Column(
////                    children: <Widget>[
////                      ...ListTile.divideTiles(
////                        color: Colors.grey,
////                        tiles: [
////                          ListTile(
////                            contentPadding: EdgeInsets.symmetric(
////                                horizontal: 12, vertical: 4),
////                            leading: Icon(Icons.my_location),
////                            title: Text("Location"),
////                            subtitle: Text("Kathmandu"),
////                          ),
////                          ListTile(
////                            leading: Icon(Icons.email),
////                            title: Text("Email"),
////                            subtitle: Text("sudeptech@gmail.com"),
////                          ),
////                          ListTile(
////                            leading: Icon(Icons.phone),
////                            title: Text("Phone"),
////                            subtitle: Text("99--99876-56"),
////                          ),
////                          ListTile(
////                            leading: Icon(Icons.person),
////                            title: Text("About Me"),
////                            subtitle: Text(
////                                "This is a about me link and you can khow about me in this section."),
////                          ),
////                        ],
////                      ),
////                    ],
////                  )
//                ],
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}
//
//class ProfileHeader extends StatelessWidget {
//  final ImageProvider<dynamic> coverImage;
//  final ImageProvider<dynamic> avatar;
//  final String title;
//  final String subtitle;
//  final List<Widget> actions;
//
//  const ProfileHeader(
//      {Key key,
//        @required this.coverImage,
//        @required this.avatar,
//        @required this.title,
//        this.subtitle,
//        this.actions})
//      : super(key: key);
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[
//        Ink(
//          height: 200,
//          decoration: BoxDecoration(
//            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
//          ),
//        ),
//        Ink(
//          height: 200,
//          decoration: BoxDecoration(
//            color: Colors.black38,
//          ),
//        ),
//        if (actions != null)
//          Container(
//            width: double.infinity,
//            height: 200,
//            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
//            alignment: Alignment.bottomRight,
//            child: Row(
//              mainAxisSize: MainAxisSize.min,
//              children: actions,
//            ),
//          ),
//        Container(
//          width: double.infinity,
//          margin: const EdgeInsets.only(top: 160),
//          child: Column(
//            children: <Widget>[
//              Avatar(
//                image: avatar,
//                radius: 40,
//                backgroundColor: Colors.white,
//                borderColor: Colors.grey.shade300,
//                borderWidth: 4.0,
//              ),
//              Text(
//                title,
//                // ignore: deprecated_member_use
//                style: Theme.of(context).textTheme.title,
//              ),
//              if (subtitle != null) ...[
//                const SizedBox(height: 5.0),
//                Text(
//                  subtitle,
//                  // ignore: deprecated_member_use
//                  style: Theme.of(context).textTheme.subtitle,
//                ),
//              ]
//            ],
//          ),
//        )
//      ],
//    );
//  }
//}
//
//class Avatar extends StatelessWidget {
//  final ImageProvider<dynamic> image;
//  final Color borderColor;
//  final Color backgroundColor;
//  final double radius;
//  final double borderWidth;
//
//  const Avatar(
//      {Key key,
//        @required this.image,
//        this.borderColor = Colors.grey,
//        this.backgroundColor,
//        this.radius = 30,
//        this.borderWidth = 5})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return CircleAvatar(
//      radius: radius + borderWidth,
//      backgroundColor: borderColor,
//      child: CircleAvatar(
//        radius: radius,
//        backgroundColor: backgroundColor != null
//            ? backgroundColor
//            : Theme.of(context).primaryColor,
//        child: CircleAvatar(
//          radius: radius - borderWidth,
//          backgroundImage: image,
//        ),
//      ),
//    );
//  }
//}
