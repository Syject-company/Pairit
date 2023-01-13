import 'package:flutter/material.dart';
import 'package:pairit/services/api_service.dart';

import '../../states.dart';
import '../../widgets.dart';
import '../loading_screen.dart';
import 'first_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final VoidCallback onPressedBack;

  ForgotPasswordScreen({this.onPressedBack});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ApiService _service = ApiService();
  String errorMessage;
  AppStates _states;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    _states = AppStates(context);

    return isLoading ? Loading() : ListView(
      padding: EdgeInsets.symmetric(horizontal: _states.width * 0.05),
      children: [
        SizedBox(
          height: _states.height * 0.48,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            "Forgot Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        SizedBox(
          height: _states.height * 0.01,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            errorMessage ?? " ",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ),
        PairItTextField(
          title: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        
        SizedBox(
          height: _states.height * 0.16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _states.width * 0.45 - 75),
          child: AccentButton(
            label: 'Send password',
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _service
                  .forgotPassword(
                emailController.text
              ).then((success) {

                // todo show thm thing like 'your new password was sand on you email'

                Navigator.push(context, MaterialPageRoute(builder: (_) => SecurityScreen()));

              });
            },
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _states.width * 0.45 - 75),
          child: WhiteButton(
            label: 'Back',
            onPressed: widget.onPressedBack,
          ),
        ),
      ],
    );
  }
}
