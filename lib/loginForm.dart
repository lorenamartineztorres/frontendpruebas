import 'package:flutter/material.dart';
import 'package:flutter_application_1/prueba.dart';
import 'package:flutter_application_1/registerForm.dart';
import 'package:flutter_application_1/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;
import 'principal.dart';
import 'principal.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
// Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  //
  //Future<String> token; // token del usuario al iniciar sesion

  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _isObscure = true;
  Future<String> token;
  String respuesta;
  int caso;
  List mapa;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    email.dispose();
    password.dispose();
    super.dispose();
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return '* Campo Requerido';
    } else if (!_emailRegExp.hasMatch(value)) {
      return 'Introduce un correo electrónico válido como abc@gmail.com';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Campo Requerido";
    } else if (value.length < 6) {
      return "Por seguridad la contraseña debe ser superior a 6 carácteres";
    } else
      return null;
  }

  /*Future<String> getlogin() async{

        login(email.text, password.text).then((result) {
        setState(() => globals.token = result); 
        });

      return globals.token;
  }*/

  Future<String> getLogin(String respuesta) async {
    final String aux = respuesta;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      globals.token = aux;
      sharedPreferences.setString('tok', globals.token);
    });
    return aux;
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 60),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('images/eco_logo.jpg'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 20),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Correo Electrónico',
                      hintText: 'Introduce correo electrónico'),
                  validator: validateEmail,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 20),
                  //padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    obscureText: _isObscure,
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                      hintText: 'Introduce contraseña ',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                    ),
                    validator: validatePassword,
                  )),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Olvidaste la contraseña?',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      mapa = await login(email.text, password.text);
                      respuesta = mapa[0] as String;
                      caso = mapa[1];
                      print(respuesta);
                      print(caso);
                      if (respuesta == null) caso = 0;
                      if (caso == 0) {
                        if (respuesta == 'Invalid Password') {
                          Scaffold.of(_formKey.currentContext).showSnackBar(
                              SnackBar(content: Text('Contraseña incorrecta')));
                        } else {
                          Scaffold.of(_formKey.currentContext).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Correo electrónico no registrado')));
                        }
                      } else {
                        getLogin(respuesta).then((result) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PagePrincipal(),
                            ),
                          );
                        });
                      }
                    }
                  },
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
              SizedBox(
                height: 110,
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (context) => RegisterForm(),
                    ),
                  );
                },
                child: Text(
                  'Nuevo Usuario? Regístrate gratis.',
                  style: TextStyle(color: Colors.green, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
