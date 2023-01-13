import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/element_provider.dart';
import 'provider/user_provider.dart';
import 'screens/loading_screen.dart';
import 'screens/onboarding_screens/onboarding_screen.dart';
import 'states.dart';
import 'test.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: ElementProvider()),
      ChangeNotifierProvider.value(value: UserProvider())
    ],
    child: BusinessCardsApp(),
  ));
}

class BusinessCardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Business Cards',
      theme: ThemeData(
        cursorColor: accentColor,
        textSelectionColor: accentColor,
        toggleableActiveColor: accentColor,
        textSelectionHandleColor: accentColor,
        splashColor: accentColor.withOpacity(0.5),
        highlightColor: accentColor.withOpacity(0.5),
        accentColor: accentColor,
        primaryColor: accentColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(), // SplashScreen() TestPage() OnboardingScreen()
    );
  }
}