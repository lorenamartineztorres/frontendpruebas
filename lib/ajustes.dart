import 'package:flutter/material.dart';
import 'package:flutter_application_1/cambiarContrasena.dart';
import 'package:flutter_application_1/cambiarNombre.dart';
import 'package:flutter_application_1/loginRegister.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:flutter_application_1/solicitarVerificado.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'globals.dart' as globals;
import 'package:flutter_application_1/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ajustes extends StatefulWidget {
  ajustes();
  @override
  _ajustesState createState() => _ajustesState();
}

class _ajustesState extends State<ajustes> {

 final _formKey = GlobalKey<FormState>();
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 20, bottom: 13),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: Colors.black),
                    Text(
                      " Configuracion",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 20, bottom: 13),
              ),
              Container(
                height: 50,
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => cambiarNombre(),
                    ));
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cambiar nombre de usuario',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5, bottom: 5),
              ),
              Container(
                height: 50,
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => cambiarContrasena(),
                    ));
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cambiar contraseña',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5, bottom: 5),
              ),
              if (globals.type == false)
              Container(
                height: 50,
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {                    
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => solicitarVerificado(),
                    )).then((result){
                      if (result == true){
                        setState(() {
                              globals.type = true;
                            });
                           showDialog(context: context, builder: (context) => AlertDialog(
                                title: Text('¡Enhorabuena!'),
                              content: Text('Su cuenta ha sido verificada satisfactoriamente.'),
                              actions: <Widget>[
                                FlatButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('OK'))
                              ],
                           ));
                          }
                          });
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Solicitar cuenta verificada',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 5, bottom: 5),
              ),
              Container(
                height: 50,
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed:() async {
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();                    
                    sharedPreferences.remove('tok');
                    LogOut();
                    globals.logOut = true;
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => LoginRegister(),
                    ));
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Cerrar sesión',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black87, fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }
}
