import 'package:flutter/material.dart';
import 'package:flutter_application_1/requests.dart';
import 'dart:async';
import 'package:flutter_application_1/deletePublication.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '';
  List<dynamic> awards;
  List<dynamic> publicationsIds;
  List<dynamic> images;
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
                                  color: Color.fromRGBO(71, 82, 94, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                        ])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(children: <Widget>[
                          Text("Logros",
                              style: TextStyle(
                                  color: Color.fromRGBO(71, 82, 94, 1))),
                        ])),

/*
          ListView.builder(
                itemCount: awards.length,
                itemBuilder: (BuildContext context, int index) => Text(awards.length.toString())
                Image.network("http://158.109.74.52:55002/" + awards[index],
                  width: 30.0,
                  height: 30.0, 
                ),
      ),*/

                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Row(children: <Widget>[
                          Text("Publicaciones",
                              style: TextStyle(
                                  color: Color.fromRGBO(71, 82, 94, 1))),
                        ])),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10.0),
                        child: Column(children: <Widget>[
                          if (images.length % 2 == 0)
                            for (int i = 0; i < images.length; i += 2)
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OnePublication(
                                                      publicationsIds[i]),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Image.network(
                                            "http://158.109.74.52:55002/" +
                                                images[i],
                                            width: 185.0,
                                            height: 130.0,
                                            fit: BoxFit.fill)),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OnePublication(
                                                      publicationsIds[i]),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Image.network(
                                            "http://158.109.74.52:55002/" +
                                                images[i + 1],
                                            width: 185.0,
                                            height: 130.0,
                                            fit: BoxFit.fill)),
                                  ])
                          else
                            for (int i = 0; i < images.length - 1; i += 2)
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OnePublication(
                                                      publicationsIds[i]),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Image.network(
                                            "http://158.109.74.52:55002/" +
                                                images[i],
                                            width: 185.0,
                                            height: 130.0,
                                            fit: BoxFit.fill)),
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OnePublication(
                                                      publicationsIds[i]),
                                            ),
                                          );
                                        },
                                        padding: EdgeInsets.all(0.0),
                                        child: Image.network(
                                            "http://158.109.74.52:55002/" +
                                                images[i + 1],
                                            width: 185.0,
                                            height: 130.0,
                                            fit: BoxFit.fill)),
                                  ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => OnePublication(
                                              publicationsIds[
                                                  images.length - 1]),
                                        ),
                                      );
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    child: Image.network(
                                        "http://158.109.74.52:55002/" +
                                            images[images.length - 1],
                                        width: 185.0,
                                        height: 130.0,
                                        fit: BoxFit.fill)),
                              ])

                          /*
                 Image.asset(
                  'images/vp_basura.jpeg',
                  width: 170.0,
                  height: 120.0,
                  fit: BoxFit.fill 
                ),

                 Image.asset(
                  'images/basura_playa.jpg',
                  width: 170.0,
                  height: 120.0,
                  fit: BoxFit.fill 
                ),*/
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
}
