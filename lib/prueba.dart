import 'package:flutter/material.dart';

import 'package:flutter_application_1/PublicacionModel.dart';
import 'package:flutter_application_1/requests.dart';
import 'dart:convert';
import 'globals.dart' as globals;

class Prueba extends StatefulWidget {
  Prueba();
  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {

  Map<String, dynamic> _publicacion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ECOPROTECT',
          style: TextStyle(fontSize: 16.0, fontFamily: 'Glacial Indifference'),
        ),
      ),
      body: Column(
        children: <Widget>[
          if (globals.token != null) Text("${globals.token}"),
          Text("hola"),

          _publicacion == null ? Container() :
            Text("The publicacion ${_publicacion['ubication']} , ${_publicacion['imagePath']} is created successfully at time ${_publicacion['userName']}"),
          


        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{


          final Map<String, dynamic> resultado = await getPublicaciones();

          

          setState(() {
            _publicacion = resultado;
          });

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
            
    );
  }
}
