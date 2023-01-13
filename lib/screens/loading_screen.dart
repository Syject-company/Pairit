import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:pairit/provider/element_provider.dart';
import 'package:pairit/services/api_service.dart';
import 'package:provider/provider.dart';

import '../states.dart';
import 'register_and_login_screens/first_screen.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          SvgPicture.asset('assets/images/Logo.svg'),
          Spacer(),
          LoadingFlipping.square(
            borderColor: Colors.white,
            size: 60.0,
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  ApiService _service = ApiService();

  @override
  Widget build(BuildContext context) {
    final elementState = Provider.of<ElementProvider>(context);

    Timer(Duration(seconds: 3), () {
      // Get all card templates
      _service.getTemplates().then((templates) {
        // Save all templates in local
        elementState.setTemplates(templates);
        Navigator.push(context, MaterialPageRoute(builder: (_) => SecurityScreen()));
      });
    });
    return Loading();
  }
}
