import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';

class OnePublication extends StatefulWidget {
  String _publicationid;
  OnePublication(this._publicationid);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<OnePublication> {
  String _publicationid;
  dynamic _publication;

  @override
  void initState() {
    _publicationid = widget._publicationid;
    getUser();
  }

  void getUser() async {
    await getOnePublication(this._publicationid).then((result) {
      setState(() {
        print(result);
        _publication = result;
      });
    });
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
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          Row(children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(_publication['userName'],
                    style: TextStyle(
                        color: Color.fromRGBO(71, 82, 94,
                            0.58))), //cambiar por descripción del usuario
              ),
            )
          ]),
        ])));
  }
}
