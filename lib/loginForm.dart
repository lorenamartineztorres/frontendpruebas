import 'package:flutter/material.dart';
import 'package:flutter_application_1/registerForm.dart';

import 'principal.dart';


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
// Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final email = TextEditingController();
  final password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Image.asset('images/eco_logo.jpeg'),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 20),
              child: TextFormField(
                controller: email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Correo Electrónico',
                    hintText: 'Introduce correo electrónico'
                    ),
                validator: validateEmail,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 20),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Introduce contraseña '
                    ),
                validator: validatePassword,
              ),
            ),
            FlatButton(
              onPressed: (){
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
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Scaffold.of(_formKey.currentContext).showSnackBar(
                                SnackBar(content: Text('Processando Datos')));
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (context) => PagePrincipal(),
                              )
                           );
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
              onPressed: (){
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