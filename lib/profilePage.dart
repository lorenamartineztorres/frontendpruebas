import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var user;
/*
   @override
  void initState() {
    getUsr();
  }

  void getUsr() async {
    getUser().then((result) {
      setState(() => _publications = result);
      _rPublications = new List.from(_publications.reversed);
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
              child: Row(children: <Widget>[
                Text("NombreUsuario",
                style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1), fontSize: 18, fontWeight:FontWeight.w700)),
                
          ])),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                Text("Logros",
                style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),

          ])),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                children: <Widget>[
                 Image.asset(
                  'images/logro1.png',
                  width: 30.0,
                  height: 30.0,
                ),

                SizedBox(width: 10),

                 Image.asset(
                  'images/logro2.png',
                  width: 30.0,
                  height: 30.0,
                ),

                SizedBox(width: 10),

                 Image.asset(
                  'images/logro3.png',
                  width: 30.0,
                  height: 30.0,
                ),
              ])),

          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                Text("Publicaciones",
                style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
                
          ])),

           Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                 Image.asset(
                  'images/vp_basura.jpeg',
                  width: 170.0,
                  height: 120.0,
                  fit: BoxFit.fill 
                ),

                 Image.asset(
                  'images/basura_playa.jpg',
                  width: 170.0,
                  height: 120.0,
                  fit: BoxFit.fill 
                )])),
          ],
        ),
      ),
    );
  }
}