import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';

import 'principal.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
// Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final username = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final country = TextEditingController();
  final postalCode = TextEditingController();
  final population = TextEditingController();
  final password2 = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final _zipcodeRegExp = RegExp(
    r"^[0-9]{5}(?:-[0-9]{4})?$");
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    username.dispose();
    email.dispose();
    password.dispose();
    country.dispose();
    population.dispose();
    postalCode.dispose();
    password2.dispose();
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

  String validatePassword2(String value) {
    if (value != password.text) {
      return "Las contraseñas deben coincidir";
    } else
      return null;
  }

  String validateZipCode(String value) {
    if (value.isEmpty) {
      return "* Campo Requerido";
    } else if (!_zipcodeRegExp.hasMatch(value)) {
        return 'Introduce un código postal válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(    
          centerTitle: true,    
          title: Text('ECOPROTECT', style: TextStyle(fontSize: 16.0,fontFamily: 'Glacial Indifference' ),),   
        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:20,bottom: 13),
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de usuario',
                    hintText: 'Introduce id de usuario'
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 13),
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
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 13),
              child: TextFormField(
                controller: country,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'País',
                    hintText: 'Introduce tu país de residencia'
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 13),
              child: TextFormField(
                controller: population,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Población',
                    hintText: 'Introduce la población donde resides'
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top:0, bottom: 13),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: postalCode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Código Postal',
                    hintText: 'Introduce código postal. Este és un número de 5 dígitos'
                    ),
                validator: validateZipCode,
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top:0, bottom: 13),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Contraseña',
                    hintText: 'Introduce contraseña - 6 caracteres mínimo'
                    ),
                validator: validatePassword,
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 0, bottom: 13),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: password2,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repita Contraseña',
                    hintText: 'Introduce de nuevo la contraseña'
                    ),
                validator: validatePassword2,
              ),
            ),
             FlatButton(
              onPressed: (){
                 
              },
              child: Text(
                'Pulsando Registrarse, aceptas nuestra Política de Privacidad.',
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            Scaffold.of(_formKey.currentContext).showSnackBar(
                                SnackBar(content: Text('Processando Datos')));
                            
                            final String usernameX = username.text;
                            final String emailX = email.text;
                            final String passwordX = password.text;
                            final String countryX = country.text;
                            final String postalcodeX = postalCode.text;
                            final String populationX = population.text;

                            register(email.text, username.text, country.text, population.text, postalCode.text, password.text);
                    }
                },
                child: Text(
                  'Registrarse',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              height: 110,
            ),
          ],
        ),
      ),
      ),
    );
  }
}