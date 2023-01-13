
import 'package:flutter/material.dart';
import 'package:pairit/provider/user_provider.dart';
import 'package:pairit/services/api_service.dart';
import 'package:provider/provider.dart';

import '../../states.dart';
import '../../widgets.dart';
import '../loading_screen.dart';
import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onPressedRegister;
  final VoidCallback onPressedForgotPassword;

  LoginScreen({this.onPressedRegister, this.onPressedForgotPassword});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiService _service = ApiService();
  String errorMessage;
  AppStates _states;
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

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
            "Sing In",
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
          height: _states.height * 0.005,
        ),
        PairItTextField(
          title: 'Password',
          controller: passwordController,
          obscureText: obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              Icons.remove_red_eye,
              size: 20,
              color: obscurePassword ? Colors.black54 : accentColor,
            ),
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                widget.onPressedForgotPassword();
              },
              child: Container(
                color: Colors.white,
                child: Text(
                  'Forgot password',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: _states.height * 0.08,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _states.width * 0.45 - 75),
          child: AccentButton(
            label: 'Sing in',
            onPressed: () {
             setState(() {
               isLoading = true;
             });
              _service
                  .loginUser(
                emailController.text,
                passwordController.text,
              )
                  .then((result) {
                if (result) {
                  _service.getAllUserInfo().then((userData) {
                    userState.user = userData.user;
                    userState.personalCard = userData.personalCard;
                    userState.addedCards = userData.addedCards;

                    _service.getChatRooms().then((chatRooms) {
                      userState.chatRooms = chatRooms;
                    });

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
                    errorMessage = 'Incorrect email or password';
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
            label: 'Register',
            onPressed: widget.onPressedRegister,
          ),
        ),
      ],
    );
  }
}
