
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pairit/screens/register_and_login_screens/forgot_password_screen.dart';

import '../../states.dart';
import '../../ui_elements.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class SecurityScreen extends StatefulWidget {
  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {

  List<Widget> body = [];
  int _currentPage = 0;

  @override
  void initState() {
    body = [
      LoginScreen(
        onPressedRegister: () {
          setState(() {
            _currentPage = 1;
          });
        },
        onPressedForgotPassword: () {
          setState(() {
            _currentPage = 2;
          });
        },
      ),
      RegistrationScreen(
        onPressedBack: () {
          setState(() {
            _currentPage = 0;
          });
        },
      ),
      ForgotPasswordScreen(
        onPressedBack: () {
          setState(() {
            _currentPage = 0;
          });
        },
      )
    ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var states = AppStates(context);

    return Scaffold(
      body: Stack(
        children: [
          body[_currentPage],
          TopMainShape(
            height: states.height*0.42,
            body: Container(
              margin: EdgeInsets.only(top: 50),
              child: SvgPicture.asset('assets/images/Logo.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
