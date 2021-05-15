import 'package:flutter/material.dart';
import 'globals.dart' as globals;

class AddLocation extends StatelessWidget {
  String location = "Madrid";
  // This widget is the root of your application.
  
  var ubication = TextEditingController();
 @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    ubication.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ECOPROTECT',
            style:
                TextStyle(fontSize: 16.0, fontFamily: 'Glacial Indifference'),
          ),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text("Añade la ubicación:"),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              maxLength: 30,
              controller: ubication,
              decoration: InputDecoration(
                hintText: 'Ubicación',
              ),
            ),
          ),
        ]),
        floatingActionButton: Transform.scale(
          scale: 1.2,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              globals.ubication = ubication.text;        
              Navigator.of(context).pop(ubication.text);
            },

            child: Icon(Icons.check_outlined),
            backgroundColor: Color.fromRGBO(100, 211, 83, 1),
          ),
        ));
  }
}
