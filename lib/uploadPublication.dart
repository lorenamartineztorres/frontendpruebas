import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';
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
  var description = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

   @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //Añadir nueva publicación
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(color: Colors.lightGreen[300]),
                    child: FlatButton(
                        onPressed: () {
                          //TODO SELECCIONAR IMAGEN
                          _showSelectionDialog(context);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Seleccionar Imagen",
                              style: new TextStyle(fontSize: 13)),
                        ))),
                Container(
                    //AÑADIR UBICACIÓN
                    alignment: Alignment.centerRight,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.40,
                    decoration: BoxDecoration(color: Colors.lightGreen[300]),
                    //borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => AddLocation(),
                              ));
                        }, //TODO AÑADIR UBICACIÓN
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Añadir Ubicación",
                              style: new TextStyle(fontSize: 13)),
                        ))),
              ],
            ),
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
                  child: _setImageView(),
                )
              ],
            ),
            Row(
              //TEXTO FUROR
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  child: Text("Establece el nivel de furor"),
                ),
              ],
            ),
            Padding(
                //GRADIENTE
                padding: EdgeInsets.only(right: 30),
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
            Row(
              //TEXTO DESCRIPCIÓN
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 00.0),
                  child: Text("Descripción"),
                )
              ],
            ),
            Padding(
              //DESCRIPCIÓN
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 00.0),
              child: TextFormField(
                controller: description,
                decoration: InputDecoration(
                  hintText: 'Añade una descripción',
                ),
              ),
            ),
            Padding(
              //BOTON PUBLICAR
              padding: EdgeInsets.symmetric(horizontal: 00.0, vertical: 24.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                      createPublication(globals.ubication, imageFile, description.text, num_gradiente);
                  },
                  child: Text(
                    'Publicar',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget gradiente() {
    return Slider(
      value: num_gradiente,
      min: 0,
      max: 100,
      divisions: 10,
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

  Future<void> _showSelectionDialog(BuildContext context) {
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
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camara"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  void _openGallery(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

  Widget _setImageView() {
    if (imageFile != null) {
      return Image.file(imageFile,
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.35);
    } else {
      return Align(
        alignment: Alignment.center,
        child: Text("Por favor, seleccione una imagen"),
      );
    }
  }
}
