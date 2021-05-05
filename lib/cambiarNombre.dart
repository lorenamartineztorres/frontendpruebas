import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';

class cambiarNombre extends StatefulWidget {
  cambiarNombre();
  @override
  _cambiarNombreState createState() => _cambiarNombreState();
}

class _cambiarNombreState extends State<cambiarNombre> {
  String username;
  final newUsername = TextEditingController();
  final _formKeyUsername = GlobalKey<FormState>();

  @override
  void initState() {
    //globals.token = widget.token;
    getInfo();
    //num_gradiente = _publicacion['gradient'][0];
  }

  void getInfo() async {
    //await Future.delayed(Duration(seconds: 1));
    Text("Welcome");
    getUsername().then((result) {
      setState(() => username = result);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    newUsername.dispose();
    super.dispose();
  }

  String validateUsername(String value) {
    if (value.isEmpty) {
      return "* Campo Requerido";
    } else if ((value.length <= 2) || (value.length > 18)) {
      return "El nombre ha de tener entre 3 y 17 caracteres";
    } else
      return null;
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKeyUsername,
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
                    Text(
                      "Cambio de nombre de usuario",
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
                padding: const EdgeInsets.all(10),
                child: Text('Nombre de usuario actual: ' + username),
              ),
              new Padding(padding: EdgeInsets.only(top: 10.0)),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nuevo nombre',
                  hintText: 'Introduce tu nuevo nombre de usuario',
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                    borderSide: new BorderSide(),
                  ),
                ),
                controller: newUsername,
                validator: validateUsername,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 20, bottom: 13),
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
                    if (_formKeyUsername.currentState.validate()) {
                      _formKeyUsername.currentState.save();
                      Scaffold.of(_formKeyUsername.currentContext).showSnackBar(
                          SnackBar(content: Text('Procesando cambios')));
                      print(newUsername.text);
                      editUsername(newUsername.text);

                      Navigator.of(context).pop(true);
                    }
                  },
                  child: Text(
                    'Confirmar',
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
