import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/PublicacionModel.dart';
import 'package:flutter_application_1/detailedCommentPage.dart';
import 'package:flutter_application_1/requests.dart';
import 'dart:io';
import 'globals.dart' as globals;

class Home extends StatefulWidget {
  //stateful ja que cambiara depende un parametro de entrada, la ubicación
  /* var token;
  Home(@required this.token);*/
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double num_gradiente = 0; //poner el que ha introducido el usuario
  int num_mg = 0;
  List<String> _comments;
  List<dynamic> _publications;
  var _rPublications;
  //final newcomment = TextEditingController();
  List<TextEditingController> newcomment;
  var grads = []; //lista parche de gradientes
  List<dynamic> gradList; //lista buena de gradientes, que se modifican bien
  String commentText;
  final _commentKey = GlobalKey<FormState>();
  Future<double> newaverage;

  @override
  void initState() {
    //globals.token = widget.token;
    publication();

    //num_gradiente = _publicacion['gradient'][0];
  }

  void publication() async {
    //await Future.delayed(Duration(seconds: 1));
    Text("Welcome");
    getPublicaciones().then((result) {
      setState(() => _publications = result);
      _rPublications = new List.from(_publications.reversed);
      newcomment = List.generate(
          _publications.length.toInt(), (index) => TextEditingController());
      constGrads(_rPublications); //CREAR UNA LIST<INT> CON LOS GRADIENTAVERAGES
    });
  }

  @override
  void dispose() {
    newcomment.forEach((element) => element.dispose());
    super.dispose();
  }

  void reload() async {
    await Future.delayed(Duration(seconds: 1));
    getPublicaciones().then((result) {
      setState(() => _publications = result);
      _rPublications = new List.from(_publications.reversed);
      constGrads(_rPublications);
    });
  }

  bool likedComment(String comment, int pos) {
    bool liked = false;
    if (globals.likedComments[pos] == comment) {
      liked = true;
    }
    return liked;
  }

  String validateComment(String value) {
    if (value.isEmpty) {
      return "Escribe algo";
    } else if (value.length > 300) {
      return "Max 300 caracteres";
    } else if (value == " ") {
      return null;
    } else
      return "true";
  }

  String validate(String value) {
    if (value.isEmpty) {
      return '* Campo Requerido';
    } else {
      return null;
    }
  }

  Widget _buildRow(Map<String, dynamic> publication, int index) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      // nombre de usuario
      Row(children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(publication['userName'],
                style: TextStyle(
                    color: Color.fromRGBO(71, 82, 94,
                        0.58))), //cambiar por descripción del usuario
          ),
        )
      ]),
      // ubicación
      Row(children: [
        Flexible(
          child: Container(
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
                Flexible(
                  child: Text(publication['ubication'],
                      style: TextStyle(color: Colors.black.withOpacity(0.5))),
                ),
              ])),
        )
      ]),
      // imagen
      Image.network("http://158.109.74.52:55002/" + publication['imagePath'],
          width: 500, scale: 0.8, fit: BoxFit.fitWidth),
      // Gradiente
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                gradiente(index),
                IconButton(
                  onPressed: () => {
                    setState(() {
                      newaverage = putGradient(
                          gradList[index].toInt(), publication['_id']);
                      gradList[index] = newaverage;
                    }),
                    gradList.clear(),
                    reload(),
                  },
                  icon: Icon(Icons.check_outlined),
                ),
                Image.asset(
                  //'images/furor.png',
                  emojiGradiente(gradList[index].toInt()),
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
      Row(children: [
        Flexible(
          child: Container(
            //DESCRIPCIÓN
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(publication['description'],
                style: TextStyle(
                    color: Color.fromRGBO(71, 82, 94,
                        0.58))), //cambiar por descripción del usuario
          ),
        )
      ]),

      // Comentarios
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(children: <Widget>[
            Text("Comentarios",
                style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
          ])),
      if (publication['comments'].length > 0)
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(publication['comments'][0],
                        style: TextStyle(
                            color: Color.fromRGBO(71, 82, 94,
                                0.58))), //cambiar por comentario del usuario
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: likedComment(publication['comments'][0], 0)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            String comment1 = publication['comments'][0];
                            if (likedComment(comment1, 0)) {
                              num_mg = publication['mgCount'][0];
                              num_mg--;
                              publication['mgCount'][0] = num_mg;
                              globals.likedComments.remove(0);
                              removeLike(publication['_id'], 0);
                            } else {
                              num_mg = publication['mgCount'][0];
                              num_mg++;
                              publication['mgCount'][0] = num_mg;
                              globals.likedComments[0] = comment1;
                              doLike(publication['_id'], 0);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(publication['mgCount'][0].toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(71, 82, 94,
                                  0.58))), //cambiar numeros de mg reales del comentario
                    ],
                  ),
                ])),
      if (publication['comments'].length > 1)
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(publication['comments'][1],
                        style: TextStyle(
                            color: Color.fromRGBO(71, 82, 94,
                                0.58))), //cambiar por comentario del usuario
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: likedComment(publication['comments'][1], 1)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            String comment2 = publication['comments'][1];
                            if (likedComment(comment2, 1)) {
                              num_mg = publication['mgCount'][1];
                              num_mg--;
                              publication['mgCount'][1] = num_mg;
                              globals.likedComments.remove(1);
                              removeLike(publication['_id'], 1);
                            } else {
                              num_mg = publication['mgCount'][1];
                              num_mg++;
                              publication['mgCount'][1] = num_mg;
                              globals.likedComments[1] = comment2;
                              doLike(publication['_id'], 1);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(publication['mgCount'][1].toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(71, 82, 94,
                                  0.58))), //cambiar numeros de mg reales del comentario
                    ],
                  ),
                ])),
      if (publication['comments'].length > 2)
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CommentsPage(_rPublications[index]),
              ),
            );
          },
          child: Text(
            'Ver todos los comentarios',
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
        ),
      comentarios(index, publication),
    ]));
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
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget gradiente(int index) {
    if (gradList[index].runtimeType == int)
      return new Expanded(
        child: Slider(
          value: gradList[index].toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          label: gradList[index].round().toString(),
          activeColor: Color.fromRGBO(71, 82, 94, 1),
          inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
          onChanged: (double value) {
            setState(() {
              gradList[index] = value.toInt();
            });
          },
        ),
      );
    if (gradList[index].runtimeType == double)
      return new Expanded(
        child: Slider(
          value: gradList[index],
          min: 0,
          max: 100,
          divisions: 100,
          label: gradList[index].round().toString(),
          activeColor: Color.fromRGBO(71, 82, 94, 1),
          inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
          onChanged: (double value) {
            setState(() {
              gradList[index] = value;
            });
          },
        ),
      );
  }

  void constGrads(List<dynamic> _rPublications) {
    if (grads != null && gradList != null) {
      grads.clear();
      gradList.clear();
    }

    for (int i = 0; i < _rPublications.length; i++) {
      grads.add(_rPublications[i]['gradientAverage']);
    }
    gradList = new List.from(grads);
    print(gradList);
  }

  String emojiGradiente(int gradientAverage) {
    String emoji = 'images/cara1.png';
    if (gradientAverage < 25) {
      emoji = 'images/cara1.png';
    }
    if ((gradientAverage >= 25) && (gradientAverage < 50)) {
      emoji = 'images/cara2.png';
    }
    if ((gradientAverage >= 50) && (gradientAverage < 75)) {
      emoji = 'images/cara3.png';
    }
    if (gradientAverage >= 75) {
      emoji = 'images/cara4.png';
    }
    print(emoji);
    return emoji;
  }

  Widget comentarios(int index, dynamic publication) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: newcomment[index],
        onChanged: (text) {
          final controller = newcomment[index];
          //this.commentText = text;
          //text = null;
          // print(commentText);
        },
        decoration: InputDecoration(
          hintText: 'Añade un nuevo comentario',
          suffixIcon: IconButton(
            onPressed: () => {
              if (validateComment(newcomment[index].text) == "true")
                {
                  addComment(newcomment[index].text, publication['_id']),
                  newcomment[index].clear(),
                  reload(),
                }
              else
                {print("NO")},
              reload(),
            },
            icon: Icon(Icons.check_outlined),
          ),
        ),
      ),
    );
  }
}
