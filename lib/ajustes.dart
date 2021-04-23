import 'package:flutter/material.dart';
import 'package:flutter_application_1/cambiarContrasena.dart';
import 'package:flutter_application_1/cambiarNombre.dart';
import 'package:flutter_application_1/loginForm.dart';
import 'package:flutter_application_1/registerForm.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/principal.dart';
import 'package:flutter_application_1/solicitarVerificado.dart';

class ajustes extends StatefulWidget {
  ajustes();
  @override
  _ajustesState createState() => _ajustesState();
}

class _ajustesState extends State<ajustes> {
  int selectedIndex = 4;

  void _onItemTapped(int index) {
    /*setState(() {
      selectedIndex = index;
    });*/
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute<void>(
              builder: (context) => PagePrincipal(),
            ))
            .then((var value) {});
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute<void>(
              builder: (context) => LoginForm(),
            ))
            .then((var value) {});
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute<void>(
              builder: (context) => RegisterForm(),
            ))
            .then((var value) {});
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute<void>(
              builder: (context) => PagePrincipal(),
            ))
            .then((var value) {});
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute<void>(
              builder: (context) => ajustes(),
            ))
            .then((var value) {});
        break;
    }
  }

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
              Container(
                height: 50,
                width: 1000,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => solicitarVerificado(),
                    ));
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<void>(
                      builder: (context) => PagePrincipal(),
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
