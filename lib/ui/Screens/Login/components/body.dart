import 'package:flutter/material.dart';
import 'package:reboeng/ui/Screens/Login/components/background.dart';
import 'package:reboeng/ui/Screens/Signup/signup_screen.dart';
import 'package:reboeng/ui/components/already_have_an_account_acheck.dart';
import 'package:reboeng/ui/components/rounded_button.dart';
import 'package:reboeng/ui/components/rounded_input_field.dart';
import 'package:reboeng/ui/components/rounded_password_field.dart';
import 'package:reboeng/services/auth.dart';


// ignore: must_be_immutable
class Body extends StatelessWidget {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(75),
              child: RoundedButton(
                text: "Explore Now!",
                press: () async {
                  await AuthServices.signInAnonymous();
                },
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              children: <Widget>[
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
                  text: "LOGIN",
                  press: () async {
                    await AuthServices.signIn(emailController.text, passwordController.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
