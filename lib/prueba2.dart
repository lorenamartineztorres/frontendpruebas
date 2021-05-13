/*import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'package:flutter_application_1/PublicacionModel.dart';
import 'package:flutter_application_1/requests.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'globals.dart' as globals;

class Prueba extends StatefulWidget {
  Prueba();
  @override
  _PruebaState createState() => _PruebaState();
}

class _PruebaState extends State<Prueba> {

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Welcome to Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Flutter'),
          ),
          body: Container(
            child: _swiper(),

          )
        ),
      );
    }


  Widget _swiper(){
    return Container(
      width: double.infinity,
      height: 250.0,
      child: Swiper(
        scale: 0.8,
        itemBuilder: (BuildContext context,int index){
          return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),

    );

  } 
}*/