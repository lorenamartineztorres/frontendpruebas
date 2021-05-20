import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';
import 'dart:async';
import 'package:flutter_application_1/deletePublication.dart';
import 'globals.dart' as globals;

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '';
  List<dynamic> awards;
  List<dynamic> publicationsIds;
  List<dynamic> _rPublicationsIds;
  List<dynamic> images;
  List<dynamic> _rImages;
  bool type;
  StreamController _postsController;

  @override
  void initState() {
    _postsController = new StreamController();
    getUser();
    super.initState();
  }

  void getUser() async {
    await getProfile().then((result) {
      setState(() {
        userName = result["username"];
        awards = result["awards"];
        publicationsIds = result["publications"];
        images = result["images"];
        type = result["type"];
        globals.type = type;
        print(publicationsIds.length);
        print(images.length);

        _rImages = new List.from(images.reversed);
        _rPublicationsIds = new List.from(publicationsIds.reversed);


        _postsController.add(result);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: StreamBuilder(
          stream: _postsController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print('Has error: ${snapshot.hasError}');
            print('Has data: ${snapshot.hasData}');
            print('Snapshot Data ${snapshot.data}');

            if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(children: <Widget>[
                          Text(userName,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal)),
                          SizedBox(
                              width: 5.0,
                            ),
                          if(type == true)
                            Image.asset(
                              'images/verificado.png',
                              width: 15.0,
                              height: 15.0,
                            ),
                        ])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(children: <Widget>[
                          Text("Logros",
                              style: TextStyle(
                                  color: Color.fromRGBO(71, 82, 94, 1),
                                  fontSize: 18)),
                        ])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                          for (int i = 0; i < awards.length; i++)
                          FlatButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) => _buildPopupDialog(context,i),
                                      );
                                    },
                                    height: 5.0,
                                    child: getAwards(i),
                    )])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(children: <Widget>[
                          Text("Publicaciones",
                              style: TextStyle(
                                  color: Color.fromRGBO(71, 82, 94, 1),
                                  fontSize: 18)),
                        ])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Column(children: <Widget>[
                          if (_rImages.length == 0)
                            Text("No tienes publicaciones aún"),
                          if (_rImages.length != 0 && type == false)
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _rImages.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OnePublication(
                                              _rPublicationsIds[index]),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Image.network(
                                        "http://158.109.74.52:55002/" +
                                            _rImages[index],
                                        width: 185.0,
                                        height: 130.0,
                                        fit: BoxFit.fill));
                              },
                            ),
                            if (_rImages.length != 0 && type == true)
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: _rPublicationsIds.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OnePublication(
                                              _rPublicationsIds[index]),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Image.network(
                                        "http://158.109.74.52:55002/" +
                                            _rImages[index*2+1],
                                        width: 185.0,
                                        height: 130.0,
                                        fit: BoxFit.fill));
                              },
                            ),
                        ])),
                  ],
                ),
              );
            }
            if (!snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
          }),
    );
  }

  Widget getAwards(int i) {
    if (awards[i] == 'bronzePublication')
      return Image.asset(
        'images/bronzePublication.png',
        width: 45,
        height: 45.0,
      );
    if (awards[i] == 'silverPublication')
      return Image.asset(
        'images/silverPublication.png',
        width: 45.0,
        height: 45.0,
      );
    if (awards[i] == 'goldPublication')
      return Image.asset(
        'images/goldPublication.png',
        width: 45.0,
        height: 45.0,
      );
    if (awards[i] == 'bronzeComment')
      return Image.asset(
        'images/bronzeComment.png',
        width: 45.0,
        height: 45.0,
      );
    if (awards[i] == 'silverComment')
      return Image.asset(
        'images/silverComment.png',
        width: 45.0,
        height: 45.0,
      );
    if (awards[i] == 'goldComment')
      return Image.asset(
        'images/goldComment.png',
        width: 45.0,
        height: 45.0,
      );
  }

Widget _buildPopupDialog(BuildContext context, int i) {
  return new AlertDialog(
    title: const Text('Enhorabuena!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        getTextPopUp(i),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Cerrar'),
      ),
    ],
  );
}

Widget getTextPopUp(int i) {
    if (awards[i] == 'bronzePublication')
      return Text("Has realizado tu primera publicación!");
    if (awards[i] == 'silverPublication')
      return Text("Has realizado 10 publicaciones!");
    if (awards[i] == 'goldPublication')
      return Text("Has realizado 20 publicaciones!");
    if (awards[i] == 'bronzeComment')
      return Text("Has realizado tu primer comentario!");
    if (awards[i] == 'silverComment')
      return Text("Has realizado 30 comentarios!");
    if (awards[i] == 'goldComment')
      return Text("Has realizado 50 comentarios!");
  }

}




