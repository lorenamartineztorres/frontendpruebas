import 'package:flutter_application_1/requests.dart';
import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final ubication = TextEditingController();
  var searchedPublications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: ubication,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                      labelText: 'Búsqueda de publicaciones',
                      hintText: 'Introduce una ubicación'),

                      onFieldSubmitted: (value) {
                    print("search");
                    searchedPublications = search(value);
                  },
                ),
              ),
          ]
      ),
    ));
  }
}