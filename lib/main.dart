import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:google_fonts/google_fonts.dart';


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
          fontFamily: GoogleFonts.lato(fontWeight: FontWeight.w700,).fontFamily,
          textTheme: TextTheme(
              subhead: TextStyle(fontSize:20.0),
              body1:TextStyle(fontSize:17.0)),
        ),
        
        home: LoginForm(), // pasar ubicacion del dispositivo

    );
  }
}
