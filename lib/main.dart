import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/loginRegister.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:flutter_application_1/registerForm.dart';
import 'package:flutter_application_1/prueba.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          'images/circulo.gif',
        ),
        nextScreen: globals.logOut == false? Home() : LoginRegister() ,
        backgroundColor: Colors.white,        
        splashIconSize: 300,        
      ),
    );
  }
}
