import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/ajustes.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/loginRegister.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'globals.dart' as globals;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var obtainedToken = sharedPreferences.getString('tok');
  print(obtainedToken);
  if (obtainedToken == null){
     runApp(MyApp());     
  }else{
    globals.token = obtainedToken;
    runApp(MyApp2());    
  }
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

class MyApp2 extends StatelessWidget {
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
        nextScreen: PagePrincipal(),
        backgroundColor: Colors.white,        
        splashIconSize: 300,        
      ),
    );
  }
}
