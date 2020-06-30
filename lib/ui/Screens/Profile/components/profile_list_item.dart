import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:reboeng/ui/Screens/Profile/components/constants.dart';
import 'package:reboeng/ui/constants.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Widget icon;
    switch(hasNavigation) {
      case 'true':
        icon = Icon(
          LineAwesomeIcons.angle_right,
          size: kSpacingUnit.w * 2.5,
        );
        break;
      case 'false':
        icon = Icon(
          LineAwesomeIcons.check,
          size: kSpacingUnit.w * 2.5,
        );
        break;
      case 'GoTo': icon = Icon(
        Icons.call_made,
        size: kSpacingUnit.w * 2.5,
      );
      break;
    }
    return Container(
      height: kSpacingUnit.w * 5.5,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 4,
      ).copyWith(
        bottom: kSpacingUnit.w * 2,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingUnit.w * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
        color: kPrimaryLightColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: kSpacingUnit.w * 2.5,
          ),
          SizedBox(width: kSpacingUnit.w * 1.5),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          icon,
        ],
      ),
    );
  }
}
