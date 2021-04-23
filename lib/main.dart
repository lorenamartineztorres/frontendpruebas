import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginRegister.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECOPROTECT',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(100, 211, 83, 1),
        fontFamily: GoogleFonts.lato(
          fontWeight: FontWeight.w700,
        ).fontFamily,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset(
          'images/eco_logo.jpg',
        ),
        nextScreen: PagePrincipal(),
        backgroundColor: Colors.white,
        duration: 2500,
        splashIconSize: 300,
        splashTransition: SplashTransition.rotationTransition,
      ),
    );
  }
}
