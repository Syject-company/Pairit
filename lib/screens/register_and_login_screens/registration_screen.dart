
import 'package:flutter/material.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/services/api_service.dart';
import 'package:provider/provider.dart';

import '../../states.dart';
import '../../widgets.dart';
import '../loading_screen.dart';
import '../main_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final VoidCallback onPressedBack;

  RegistrationScreen({this.onPressedBack});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  ApiService _service = ApiService();

  String errorMessage;

  AppStates _states;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkingPasswordController = TextEditingController();

  bool obscurePassword1 = true;

  bool obscurePassword2 = true;

  @override
  Widget build(BuildContext context) {
    final userState = Provider.of<UserProvider>(context);
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
            "Sing Up",
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
          height: _states.height * 0.001,
        ),
        PairItTextField(
          title: 'Password',
          controller: passwordController,
          obscureText: obscurePassword1,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              size: 20,
              color: obscurePassword1 ? Colors.black54 : accentColor,
            ),
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onPressed: () {
              setState(() {
                obscurePassword1 = !obscurePassword1;
              });
            },
          ),
        ),
        SizedBox(
          height: _states.height * 0.001,
        ),
        PairItTextField(
          title: 'Password Again',
          controller: checkingPasswordController,
          obscureText: obscurePassword2,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              size: 20,
              color: obscurePassword2 ? Colors.black54 : accentColor,
            ),
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onPressed: () {
              setState(() {
                obscurePassword2 = !obscurePassword2;
              });
            },
          ),
        ),
        SizedBox(
          height: _states.height * 0.04,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _states.width * 0.45 - 75),
          child: AccentButton(
            label: 'Register',
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _service
                  .registerUser(
                emailController.text,
                passwordController.text,
                checkingPasswordController.text,
              )
                  .then((result) {
                if (result == null) {
                  setState(() {
                    errorMessage = null;
                  });
                  _service.getAllUserInfo().then((userData) {
                    userState.user = userData.user;
                    userState.personalCard = userData.personalCard;
                    userState.addedCards = [];

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainActivityScreen(),
                      ),
                          (Route<dynamic> route) => false,
                    );
                  });
                } else {
                  setState(() {
                    isLoading = false;
                    errorMessage = result;
                  });
                }
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
