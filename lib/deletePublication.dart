import 'package:flutter/material.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:flutter_application_1/requests.dart';
import 'package:flutter_application_1/detailedCommentPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_application_1/profilePage.dart';
import 'dart:async';
import 'globals.dart' as globals;

class OnePublication extends StatefulWidget {
  String _publicationid;
  OnePublication(this._publicationid);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<OnePublication> {
  String _publicationid;
  dynamic _publication;
  dynamic gradient;
  StreamController _postsController;

  @override
  void initState() {
    _postsController = new StreamController();
    _publicationid = widget._publicationid;
    getUser();
    super.initState();
  }

  void getUser() async {
    await getOnePublication(this._publicationid).then((result) {
      setState(() {
        print(result);
        _publication = result;
        gradient = result['gradientAverage'];
        _postsController.add(result);
      });
    });
  }

  bool likedComment(String comment, int pos) {
    bool liked = false;
    if (globals.likedComments[pos] == comment) {
      liked = true;
    }
    return liked;
  }

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
      body: StreamBuilder(
          stream: _postsController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print('Has error: ${snapshot.hasError}');
            print('Has data: ${snapshot.hasData}');
            print('Snapshot Data ${snapshot.data}');

            if (snapshot.hasError) {
              return Text(snapshot.error);
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

            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              child: Text(_publication['userName'],
                                  style: TextStyle(
                                      color: Color.fromRGBO(71, 82, 94,
                                          0.58))), //cambiar por descripción del usuario
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                deletePublication(_publicationid);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PagePrincipal(),
                                  ),
                                );
                              });
                            },
                          ),
                        ]),
                  ),
                  // ubicación
                  Row(children: [
                    Flexible(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
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
                              child: Text(_publication['ubication'],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5))),
                            ),
                          ])),
                    )
                  ]),
                  // imagen
                  if (_publication['solutionPath'] != ' ')
                    _swiper(_publication['imagePath'],
                        _publication['solutionPath']),
                  if (_publication['solutionPath'] == ' ')
                    Image.network(
                        "http://158.109.74.52:55002/" +
                            _publication['imagePath'],
                        width: 400,
                        height: 250,
                        scale: 0.8,
                        fit: BoxFit.fill),
                  // Gradiente
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            gradiente(),
                            Image.asset(
                              //'images/furor.png',
                              emojiGradiente(gradient.toInt()),
                              width: 30.0,
                              height: 30.0,
                            ),
                          ])),

                  // Descripción
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Row(children: <Widget>[
                        Text("Descripción",
                            style: TextStyle(
                                color: Color.fromRGBO(71, 82, 94, 1))),
                      ])),
                  Row(children: [
                    Flexible(
                      child: Container(
                        //DESCRIPCIÓN
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Text(_publication['description'],
                            style: TextStyle(
                                color: Color.fromRGBO(71, 82, 94,
                                    0.58))), //cambiar por descripción del usuario
                      ),
                    )
                  ]),

                  // Comentarios
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      child: Row(children: <Widget>[
                        Text("Comentarios",
                            style: TextStyle(
                                color: Color.fromRGBO(71, 82, 94, 1))),
                      ])),
                  if (_publication['comments'].length > 0)
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(_publication['comments'][0],
                                    style: TextStyle(
                                        color: Color.fromRGBO(71, 82, 94,
                                            0.58))), //cambiar por comentario del usuario
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: likedComment(
                                              _publication['comments'][0], 0)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        /*
                                            String comment1 = _publication['comments'][0];
                                            if (likedComment(comment1, 0)) {
                                              num_mg = _publication['mgCount'][0];
                                              num_mg--;
                                              _publication['mgCount'][0] = num_mg;
                                              globals.likedComments.remove(0);
                                              removeLike(_publication['_id'], 0);
                                            } else {
                                              num_mg = _publication['mgCount'][0];
                                              num_mg++;
                                              _publication['mgCount'][0] = num_mg;
                                              globals.likedComments[0] = comment1;
                                              doLike(_publication['_id'], 0);
                                            }
                                            */
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(_publication['mgCount'][0].toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(71, 82, 94,
                                              0.58))), //cambiar numeros de mg reales del comentario
                                ],
                              ),
                            ])),
                  if (_publication['comments'].length > 1)
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(_publication['comments'][1],
                                    style: TextStyle(
                                        color: Color.fromRGBO(71, 82, 94,
                                            0.58))), //cambiar por comentario del usuario
                              ),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.favorite,
                                      color: likedComment(
                                              _publication['comments'][1], 1)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        /*
                                            String comment2 = _publication['comments'][1];
                                            if (likedComment(comment2, 1)) {
                                              num_mg = _publication['mgCount'][1];
                                              num_mg--;
                                              _publication['mgCount'][1] = num_mg;
                                              globals.likedComments.remove(1);
                                              removeLike(_publication['_id'], 1);
                                            } else {
                                              num_mg = _publication['mgCount'][1];
                                              num_mg++;
                                              _publication['mgCount'][1] = num_mg;
                                              globals.likedComments[1] = comment2;
                                              doLike(_publication['_id'], 1);
                                            }
                                            */
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(_publication['mgCount'][1].toString(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(71, 82, 94,
                                              0.58))), //cambiar numeros de mg reales del comentario
                                ],
                              ),
                            ])),
                  if (_publication['comments'].length > 2)
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CommentsPage(_publication),
                          ),
                        );
                      },
                      child: Text(
                        'Ver todos los comentarios',
                        style: TextStyle(color: Colors.green, fontSize: 15),
                      ),
                    ),
                ]),
              );
            }
          }),
    );
  }

  Widget gradiente() {
    if (gradient.runtimeType == int)
      return new Expanded(
        child: Slider(
          value: gradient.toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          label: gradient.round().toString(),
          activeColor: Color.fromRGBO(71, 82, 94, 1),
          inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
          onChanged: (double value) {
            setState(() {
              //gradient = value.toInt();
            });
          },
        ),
      );
    if (gradient.runtimeType == double)
      return new Expanded(
        child: Slider(
          value: gradient,
          min: 0,
          max: 100,
          divisions: 100,
          label: gradient.round().toString(),
          activeColor: Color.fromRGBO(71, 82, 94, 1),
          inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
          onChanged: (double value) {
            setState(() {
              //gradient = value;
            });
          },
        ),
      );
  }

  String emojiGradiente(int gradientAverage) {
    String emoji = 'images/cara1.png';
    if (gradientAverage < 10) {
      emoji = 'images/cara11.png';
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

  Widget _swiper(String imagePath, String solutionPath) {
    return Container(
      width: double.infinity,
      height: 250.0,
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
}
