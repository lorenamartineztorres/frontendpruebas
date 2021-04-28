import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/PublicacionModel.dart';
import 'package:flutter_application_1/requests.dart';
import 'dart:io';

class Home extends StatefulWidget {
  //stateful ja que cambiara depende un parametro de entrada, la ubicación
  Home();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double num_gradiente = 0; //poner el que ha introducido el usuario
  int num_mg = 0;
  List<String> _comments;
  List<dynamic> _publications;
  var _rPublications;

  @override
  void initState() {
    publication();

    //num_gradiente = _publicacion['gradient'][0];
  }

  void publication() async {
    getPublicaciones().then((result) {
      setState(() => _publications = result);
      _rPublications = new List.from(_publications.reversed);
      //avgGradient(_publications['gradient']);
    });
  }

  double avgGradient(List<dynamic> gradients) {
    double avg = 0.0;
    if (gradients.isNotEmpty) {
      double sum = 0.0;

      for (int i = 0; i < gradients.length; i++) {
        sum += gradients[i];
      }
      avg = sum / gradients.length;

      setState(() {
        num_gradiente = avg;
      });
    }
    return avg;
  }


  Widget _buildRow(Map<String, dynamic> publication, int index) {
    return SingleChildScrollView(
            child: Column(
      children: <Widget>[
        // nombre de usuario
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(children: <Widget>[
              Text(publication['userName'],
                  style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
            ])),
        // ubicación
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(children: <Widget>[
              Image.asset(
                'images/location.png',
                width: 15.0,
                height: 15.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(publication['ubication'],
                  style: TextStyle(color: Colors.black.withOpacity(0.5))),
            ])),
        // imagen
        Image.network(
            "http://158.109.74.52:55002/" + publication['imagePath']),
        // Gradiente
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Expanded(
                    child: gradiente(),
                  ),
                  Image.asset(
                    'images/furor.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                ])),
        // Descripción
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(children: <Widget>[
              Text("Descripción",
                  style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
            ])),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(children: <Widget>[
              Text(publication['description'],
                  style: TextStyle(
                      color: Color.fromRGBO(71, 82, 94,
                          0.58))), //cambiar por descripción del usuario
            ])),
        // Comentarios
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(children: <Widget>[
              Text("Comentarios",
                  style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
            ])),
        for (int i = 0; i<publication['comments'].length; i++)
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(publication['comments'][i],
                          style: TextStyle(
                              color: Color.fromRGBO(71, 82, 94,
                                  0.58))), //cambiar por comentario del usuario
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          setState(() {
                            num_mg = publication['mgCount'][i];
                            num_mg++;
                           publication['mgCount'][i] = num_mg;
                          });
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(publication['mgCount'][i],
                          style: TextStyle(
                              color: Color.fromRGBO(71, 82, 94,
                                  0.58))), //cambiar numeros de mg reales del comentario
                    ],
                  ),
                ])),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            onChanged: (text) {
              // this.newcomment = text;
            },
            decoration: InputDecoration(
              hintText: 'Añade un nuevo comentario',
            ),
          ),
        ),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
              // it's like ListView.builder() but better because it includes a separator between items
              padding: const EdgeInsets.all(16.0),
              itemCount: _rPublications.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildRow(_rPublications[index], index),
              separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
            ),
    );
  }

  Widget gradiente() {
    return Slider(
      value: num_gradiente,
      min: 0,
      max: 100,
      divisions: 100,
      label: num_gradiente.round().toString(),
      activeColor: Color.fromRGBO(71, 82, 94, 1),
      inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
      onChanged: (double value) {
        setState(() {
          num_gradiente = value;
        });
      },
    );
  }
}
