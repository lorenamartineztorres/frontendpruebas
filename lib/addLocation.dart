import 'package:flutter/material.dart';

class AddLocation extends StatelessWidget {
  String location = "Madrid";
  // This widget is the root of your application.
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
              onChanged: (text) {
                this.location = text;
              },
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
              Navigator.of(context).pop(true);
            },
            child: Icon(Icons.check_outlined),
            backgroundColor: Color.fromRGBO(100, 211, 83, 1),
          ),
        ));
  }
}
