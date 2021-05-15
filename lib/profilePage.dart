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
  List<dynamic> images;
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


        _postsController.add(result);
      });
    });
  }


  Widget _buildRow(List<dynamic> publications, int index) {
    return Row(
      children: <Widget>[
        Image.asset(
          'images/vp_basura.jpeg',
        ),
      ],
    );
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
                        child: Row(children: <Widget>[
                          for (int i = 0; i < awards.length; i++) getAwards(i),
                        ])),
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
                          if (images.length == 0)
                            Text("No tienes publicaciones aún"),
                          if (images.length != 0 && type == false)
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: images.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OnePublication(
                                              publicationsIds[index]),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Image.network(
                                        "http://158.109.74.52:55002/" +
                                            images[index],
                                        width: 185.0,
                                        height: 130.0,
                                        fit: BoxFit.fill));
                              },
                            ),
                            if (images.length != 0 && type == true)
                            GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: publicationsIds.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int index) {
                                return FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OnePublication(
                                              publicationsIds[index]),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Image.network(
                                        "http://158.109.74.52:55002/" +
                                            images[index*2+1],
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
}
