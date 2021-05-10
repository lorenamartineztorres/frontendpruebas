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
                          if (images.length  == 0)
                            Text("No tienes publicaciones aún"),

                        if (images.length  != 0)
                          GridView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: images.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
                              itemBuilder: (BuildContext context, int index) {
                                return FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OnePublication(
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
                        )
                          
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
