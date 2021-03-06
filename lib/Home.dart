import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/PublicacionModel.dart';
import 'package:flutter_application_1/detailedCommentPage.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/profilePage.dart';
import 'package:flutter_application_1/requests.dart';
import 'package:flutter_application_1/prueba2.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_1/showOnePublication.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'dart:io';
import 'globals.dart' as globals;
import 'dart:async';

class Home extends StatefulWidget {
  //stateful ja que cambiara depende un parametro de entrada, la ubicación
  /* var token;
  Home(@required this.token);*/
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BuildContext _myContext;
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
  StreamController _postsController;
  BitmapDescriptor pinLocationIcon;

  @override
  void initState() {
    //globals.token = widget.token;
    _postsController = new StreamController();
    publication();
    super.initState();
    setCustomMapPin();
    //num_gradiente = _publicacion['gradient'][0];
  }

  void setCustomMapPin() async {
      pinLocationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'images/eco.ico');
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
      _postsController.add(result);
      addMarkers();
    });

    getProfile().then((result2) {
      setState(() => 
      globals.username = result2["username"]);
    });
  }

  void addMarkers() {
    for(int i=0; i< _rPublications.length; i++) {
      var pos = LatLng(_rPublications[i]['latitude'], _rPublications[i]['longitude']);
      print('marcador:');
      print(pos);
      setState(() {
        globals.markers.add(Marker(
          markerId:  MarkerId('publication'),
          icon: globals.type == false? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed) : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          draggable: true, 
              
          onTap: () {
            print('Marker Tapped');
          Navigator.push(
        globals.contextGoogle,
        MaterialPageRoute(builder: (context) => showOnePublication(_rPublications[i]['_id'])));
          },
          position: pos,
      ));
      });
      
      print(pos);
    }
    
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
              child: Row(children: <Widget>[
                Flexible(
                  child: Text(publication['userName'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if (publication['solutionPath'] != " ")
                  Image.asset(
                    'images/verificado.png',
                    width: 15.0,
                    height: 15.0,
                  ),
              ])),
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
      if (publication['solutionPath'] != ' ')
        _swiper(publication['imagePath'], publication['solutionPath']),
      if (publication['solutionPath'] == ' ')
        Image.network("http://158.109.74.52:55002/" + publication['imagePath'],
            width: 400, height: 250, scale: 0.8, fit: BoxFit.fill),
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
                    //setState(() {
                    newaverage = putGradient(
                        gradList[index].toInt(), publication['_id']),
                    gradList[index] = newaverage,
                    //}

                    //Future.delayed(const Duration(seconds: 1)),
                    gradList.clear(),
                    reload(),
                    //Future.delayed(const Duration(seconds: 1)),
                  },
                  icon: Icon(Icons.check_outlined),
                ),
                if (publication['solutionPath'] == " ")
                  Image.asset(
                    emojiGradiente(gradList[index].toInt()),
                    width: 30.0,
                    height: 30.0,
                  )
                else
                  Image.asset(
                    emojiGradienteCuentaEspecial(gradList[index].toInt()),
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
                      if(getUsername(publication['comments'][0]) == globals.username)
                      IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                deleteComment(publication['_id'],0);
                                reload();
                              });
                            },
                          ),
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
                      if(getUsername(publication['comments'][1]) == globals.username)
                      IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                deleteComment(publication['_id'],1);
                                reload();
                              });
                            },
                          ),
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
    return new Scaffold(
      body: StreamBuilder(
        stream: _postsController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print('Has error: ${snapshot.hasError}');
          print('Has data: ${snapshot.hasData}');
          print('Snapshot Data ${snapshot.data}');

          if (snapshot.hasError) {
            return Text(snapshot.error);
          }

          if (snapshot.hasData) {
            return ListView.separated(
              // it's like ListView.builder() but better because it includes a separator between items
              padding: const EdgeInsets.all(16.0),
              itemCount: _rPublications.length,
              itemBuilder: (BuildContext context, int index) =>
                  _buildRow(_rPublications[index], index),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            );
          }
          if (!snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }
        },
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
    if (gradientAverage < 10) {
      emoji = 'images/cara1.png';
    }
    if ((gradientAverage >= 10) && (gradientAverage < 20)) {
      emoji = 'images/cara12.png';
    }
    if ((gradientAverage >= 20) && (gradientAverage < 30)) {
      emoji = 'images/cara13.png';
    }
    if ((gradientAverage >= 30) && (gradientAverage < 40)) {
      emoji = 'images/cara14.png';
    }
    if ((gradientAverage >= 40) && (gradientAverage < 50)) {
      emoji = 'images/cara5.png';
    }
    if ((gradientAverage >= 50) && (gradientAverage < 60)) {
      emoji = 'images/cara6.png';
    }
    if ((gradientAverage >= 60) && (gradientAverage < 70)) {
      emoji = 'images/cara7.png';
    }
    if ((gradientAverage >= 70) && (gradientAverage < 80)) {
      emoji = 'images/cara8.png';
    }
    if ((gradientAverage >= 80) && (gradientAverage < 90)) {
      emoji = 'images/cara9.png';
    }
    if ((gradientAverage >= 90) && (gradientAverage <= 100)) {
      emoji = 'images/cara10.png';
    }
    return emoji;
  }

  String emojiGradienteCuentaEspecial(int gradientAverage) {
    String emoji = 'images/cara10.png';
    if (gradientAverage < 10) {
      emoji = 'images/cara10.png';
    }
    if ((gradientAverage >= 10) && (gradientAverage < 20)) {
      emoji = 'images/cara9.png';
    }
    if ((gradientAverage >= 20) && (gradientAverage < 30)) {
      emoji = 'images/cara8.png';
    }
    if ((gradientAverage >= 30) && (gradientAverage < 40)) {
      emoji = 'images/cara7.png';
    }
    if ((gradientAverage >= 40) && (gradientAverage < 50)) {
      emoji = 'images/cara6.png';
    }
    if ((gradientAverage >= 50) && (gradientAverage < 60)) {
      emoji = 'images/cara5.png';
    }
    if ((gradientAverage >= 60) && (gradientAverage < 70)) {
      emoji = 'images/cara14.png';
    }
    if ((gradientAverage >= 70) && (gradientAverage < 80)) {
      emoji = 'images/cara13.png';
    }
    if ((gradientAverage >= 80) && (gradientAverage < 90)) {
      emoji = 'images/cara12.png';
    }
    if ((gradientAverage >= 90) && (gradientAverage <= 100)) {
      emoji = 'images/cara11.png';
    }
    return emoji;
  }

  Widget comentarios(int index, dynamic publication) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        maxLength: 200,
        controller: newcomment[index],
        onChanged: (text) {
          final controller = newcomment[index];
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

  Widget _swiper(String imagePath, String solutionPath) {
    return Container(
      width: 400,
      height: 250,
      child: Swiper(
        scale: 0.8,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return new Image.network("http://158.109.74.52:55002/" + imagePath,
                width: 400, height: 250, scale: 0.8, fit: BoxFit.fill);
          } else {
            return new Image.network(
                "http://158.109.74.52:55002/" + solutionPath,
                width: 400,
                height: 250,
                scale: 0.8,
                fit: BoxFit.fill);
          }
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }

  String getUsername(String comment) {
     
    var arr = comment.split(' '); //divide nombre usuario y comentario
    var username = arr[0].replaceAll(":", ""); 
  
    return username;
  }
}
