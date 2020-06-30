import 'package:flutter/material.dart';
import 'package:reboeng/ui/Screens/Login/login_screen.dart';
import 'package:reboeng/ui/Screens/Signup/components/background.dart';
import 'package:reboeng/ui/Screens/Signup/components/or_divider.dart';
import 'package:reboeng/ui/Screens/Signup/components/social_icon.dart';
import 'package:reboeng/ui/components/already_have_an_account_acheck.dart';
import 'package:reboeng/ui/components/rounded_button.dart';
import 'package:reboeng/ui/components/rounded_input_field.dart';
import 'package:reboeng/ui/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reboeng/services/auth.dart';

// ignore: must_be_immutable
class Body extends StatelessWidget {

  TextEditingController emailController =  TextEditingController(text: "");
  TextEditingController passwordController =  TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              controller: emailController,
              hintText: "Your Email",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                await AuthServices.signUp(emailController.text, passwordController.text);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
