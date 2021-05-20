import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:flutter_application_1/requests.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/addLocation.dart';
import 'globals.dart' as globals;

class Upload extends StatefulWidget {
  //stateful ja que cambiara depende un parametro de entrada, la ubicación
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  double num_gradiente = 50; //poner el que ha introducido el usuario
  int num_mg = 0;
  var imageFile;
  var imageFile1;
  var imageFile2;
  var description = TextEditingController();
  StreamController _postsController;
  var pathimagen;
  var pathimagen1;
  var pathimagen2;
  bool ubi = false;
  bool type;

  @override
  void initState() {
    _postsController = new StreamController();
    getUser();
    globals.ubication = '';
    super.initState();
  }

  void getUser() async {
    await getProfile().then((result) {
      setState(() {
        type = result["type"];
        print(type);
        globals.type = type;
        _postsController.add(result);
        //sleep(Duration(seconds:1));
      });
    });
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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    description.dispose();
    super.dispose();
  }

  bool cantPublicate() {
    if (globals.type == false)
      return (imageFile1 == null) || (ubi == false);
    else
      return (imageFile1 == null) || (imageFile2 == null) || (ubi == false);
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
              if (globals.type == false) {
                //TODO DE CUENTA NORMAL AQUI
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Añadir nueva publicación
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                "Añadir nueva publicación",
                                style: new TextStyle(fontSize: 22),
                              )
                            ],
                          ),
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                //SELECCIONAR IMAGEN
                                alignment: Alignment.centerLeft,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen[300]),
                                child: FlatButton(
                                    onPressed: () {
                                      //TODO SELECCIONAR IMAGEN
                                      _showSelectionDialog(context, 1);
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Seleccionar Imagen",
                                          style: new TextStyle(fontSize: 13)),
                                    ))),
                            Container(
                                //AÑADIR UBICACIÓN
                                alignment: Alignment.centerRight,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                    color: Colors.lightGreen[300]),
                                //borderRadius: BorderRadius.circular(20)),
                                child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute<void>(
                                        builder: (context) => AddLocation(),
                                      ))
                                          .whenComplete(() {
                                        if (globals.ubication.isNotEmpty) {
                                          setState(() {
                                            ubi = true;
                                          });
                                        }
                                      });
                                    }, //TODO AÑADIR UBICACIÓN
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Añadir Ubicación",
                                          style: new TextStyle(fontSize: 13)),
                                    ))),
                          ],
                        ),

                        //PREVISUALIZACION IMAGEN
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              height: MediaQuery.of(context).size.height * 0.31,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[50],
                                  borderRadius: BorderRadius.circular(10)),
                              child: _setImageView(),
                            )
                          ],
                        ),

                        Row(
                          //TEXTO FUROR
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Text("Establece el nivel de furor"),
                            ),
                          ],
                        ),

                        Padding(
                            //GRADIENTE
                            padding: EdgeInsets.only(right: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Expanded(
                                    child: gradiente(),
                                  ),
                                  Image.asset(
                                    emojiGradiente(num_gradiente.toInt()),
                                    width: 30.0,
                                    height: 30.0,
                                  ),
                                ])),

                        Row(
                          //TEXTO DESCRIPCIÓN
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 00.0),
                                child: Row(children: <Widget>[
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Text("Descripción"),
                                ]))
                          ],
                        ),

                        Padding(
                          //DESCRIPCIÓN
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 00.0),
                          child: TextFormField(
                            maxLength: 200,
                            controller: description,
                            decoration: InputDecoration(
                              hintText: 'Añade una descripción',
                            ),
                          ),
                        ),
                        Padding(
                          //BOTON PUBLICAR
                          padding: EdgeInsets.symmetric(
                              horizontal: 00.0, vertical: 24.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.80,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: RaisedButton(
                              disabledColor: Colors.grey,
                              color: Colors.green,
                              onPressed: cantPublicate()
                                  ? null
                                  : () async {
                                      createPublication(
                                          globals.ubication,
                                          pathimagen1,
                                          pathimagen2,
                                          description.text,
                                          num_gradiente);
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (context) => PagePrincipal(),
                                        ),
                                      );
                                    },
                              child: Text(
                                "Publicar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

                //TODO CUENTA ESPECIAL A PARTIR DE AQUI
              } else {
                print("PANTALLA CARGA: hola");
                print(ubi);
                return Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        //Añadir nueva publicación
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Row(
                            children: <Widget>[
                              new Text(
                                "Añadir nueva publicación",
                                style: new TextStyle(fontSize: 22),
                              )
                            ],
                          ),
                        ),

                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  //SELECCIONAR IMAGEN 1 (CUENTA VERIFICADA)
                                  alignment: Alignment.centerLeft,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen[300]),
                                  child: FlatButton(
                                      onPressed: () {
                                        //TODO SELECCIONAR IMAGEN
                                        _showSelectionDialog(context, 1);
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Seleccionar Imagen 1",
                                            style: new TextStyle(fontSize: 13)),
                                      ))),
                              Container(
                                  //SELECCIONAR IMAGEN 2 (CUENTA VERIFICADA)
                                  alignment: Alignment.centerLeft,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen[300]),
                                  child: FlatButton(
                                      onPressed: () {
                                        //TODO SELECCIONAR IMAGEN
                                        _showSelectionDialog(context, 2);
                                      },
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Seleccionar Imagen 2",
                                            style: new TextStyle(fontSize: 13)),
                                      ))),
                              Container(
                                  //AÑADIR UBICACIÓN
                                  alignment: Alignment.centerRight,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  decoration: BoxDecoration(
                                      color: Colors.lightGreen[300]),
                                  //borderRadius: BorderRadius.circular(20)),
                                  child: FlatButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute<void>(
                                          builder: (context) => AddLocation(),
                                        ))
                                            .whenComplete(() {
                                          if (globals.ubication.isNotEmpty) {
                                            setState(() {
                                              ubi = true;
                                            });
                                          }
                                        });
                                      }, //TODO AÑADIR UBICACIÓN
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Añadir Ubicación",
                                            style: new TextStyle(fontSize: 13)),
                                      ))),
                            ]),

                        Row(
                          //PREVISUALIZACION IMAGEN
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              height: MediaQuery.of(context).size.height * 0.31,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                  color: Colors.lightGreen[50],
                                  borderRadius: BorderRadius.circular(10)),
                              child: _swiper(),
                            )
                          ],
                        ),

                        Row(
                          //TEXTO DESCRIPCIÓN
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 00.0),
                                child: Row(children: <Widget>[
                                  SizedBox(
                                    height: 60.0,
                                  ),
                                  Text("Descripción"),
                                ]))
                          ],
                        ),

                        Padding(
                          //DESCRIPCIÓN
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 00.0),
                          child: TextFormField(
                            maxLength: 200,
                            controller: description,
                            decoration: InputDecoration(
                              hintText: 'Añade una descripción',
                            ),
                          ),
                        ),

                        Padding(
                          //BOTON PUBLICAR
                          padding: EdgeInsets.symmetric(
                              horizontal: 00.0, vertical: 24.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.80,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(20)),
                            child: RaisedButton(
                              disabledColor: Colors.grey,
                              color: Colors.green,
                              onPressed: cantPublicate()
                                  ? null
                                  : () async {
                                      createPublication(
                                          globals.ubication,
                                          pathimagen1,
                                          pathimagen2,
                                          description.text,
                                          num_gradiente);
                                      Navigator.of(context).push(
                                        MaterialPageRoute<void>(
                                          builder: (context) => PagePrincipal(),
                                        ),
                                      );
                                    },
                              child: Text(
                                "Publicar",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(

                      ///child: CircularProgressIndicator(),

                      ),
                ],
              );
            }
          }),
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

  Future<void> _showSelectionDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("¿Desde dónde quieres hacer la foto?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Galeria"),
                      onTap: () {
                        _openGallery(context, index);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camara"),
                      onTap: () {
                        _openCamera(context, index);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context, int index) async {
    if (index == 1) {
      var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

      this.setState(() {
        imageFile1 = File(picture.path);
      });
      pathimagen1 = picture.path;
      Navigator.of(context).pop();
    }

    if (index == 2) {
      var picture2 = await ImagePicker.pickImage(source: ImageSource.gallery);

      this.setState(() {
        imageFile2 = File(picture2.path);
      });
      pathimagen2 = picture2.path;
      Navigator.of(context).pop();
    }
  }

  void _openCamera(BuildContext context, int index) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);

    if (index == 1) {
      this.setState(() {
        imageFile1 = File(picture.path);
      });

      pathimagen1 = picture.path;
      Navigator.of(context).pop();
    } else if (index == 2) {
      this.setState(() {
        imageFile2 = File(picture.path);
      });

      pathimagen2 = picture.path;
      Navigator.of(context).pop();
    }
  }

  Widget _setImageView() {
    if (imageFile1 != null) {
      return Image.file(imageFile1,
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.35);
    } else {
      return Align(
        alignment: Alignment.center,
        child: Text("Por favor, seleccione una imagen"),
      );
    }
  }

  Widget _swiper() {
    return Container(
      width: 400,
      height: 200,
      child: Swiper(
        scale: 0.8,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0 && imageFile1 != null) {
            return new Image.file(imageFile1, fit: BoxFit.fill);
          } else if (index == 1 && imageFile2 != null) {
            return new Image.file(imageFile2, fit: BoxFit.fill);
          } else {
            return Align(
              alignment: Alignment.center,
              child: Text("Por favor, seleccione una imagen"),
            );
          }
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
