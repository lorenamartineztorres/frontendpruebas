import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Home.dart';
import 'package:flutter_application_1/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:search_map_place/search_map_place.dart';
import 'detailedCommentPage.dart';
import 'globals.dart' as globals;

class SearchText extends StatefulWidget {
  @override
  _SearchTextState createState() => _SearchTextState();
}

class _SearchTextState extends State<SearchText> {
  final ubication = TextEditingController();
  List<dynamic> _searchedPublications;
  StreamController _postsController;
  dynamic gradient;
  int num_mg = 0;
  List<dynamic> gradList;
  List<TextEditingController> newcomment;
  Future<double> newaverage;
  List<dynamic> _publications;
  var grads = [];
  GoogleMapController _mapController;
  static LatLng _initialPosition;

  @override
  void initState() {
    _postsController = new StreamController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    ubication.dispose();
    newcomment.forEach((element) => element.dispose());
    super.dispose();
  }

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void searchUbication(String ubi) async {
    await search(ubi).then((result) {
      setState(() => _searchedPublications = result);
      _publications = new List.from(_searchedPublications.reversed);
      newcomment = List.generate(
          _publications.length.toInt(), (index) => TextEditingController());
      constGrads(_publications);
      _postsController.add(result);
    });
  }

  void constGrads(List<dynamic> _rPublications) {
    if (grads != null && gradList != null) {
      grads.clear();
      gradList.clear();
    }

    for (int i = 0; i < _rPublications.length; i++) {
      grads.add(_rPublications[i]['gradientAverage']);
    }
    gradList = new List.from(grads);
    print(gradList);
  }

  void reload(String ubi) async {
    await Future.delayed(Duration(seconds: 1));
    search(ubi).then((result) {
      setState(() => _searchedPublications = result);
      _publications = new List.from(_searchedPublications.reversed);
      constGrads(_publications);
    });
  }

  Widget _swiper(String imagePath, String solutionPath) {
    return Container(
      width: double.infinity,
      height: 250.0,
      child: Swiper(
        scale: 0.8,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            //return new Image.network("http://via.placeholder.com/350x150",fit: BoxFit.fill,);
            return new Image.network("http://158.109.74.52:55002/" + imagePath,
                width: 400, height: 250, scale: 0.8, fit: BoxFit.fill);
          } else {
            return new Image.network(
                "http://158.109.74.52:55002/" + solutionPath,
                width: 400,
                height: 250,
                scale: 0.8,
                fit: BoxFit.fill);
          }
        },
        itemCount: 2,
        pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }

  String emojiGradienteCuentaEspecial(int gradientAverage) {
    String emoji = 'images/cara10.png';
    if (gradientAverage < 10) {
      emoji = 'images/cara10.png';
    }
    if ((gradientAverage >= 10) && (gradientAverage < 20)) {
      emoji = 'images/cara9.png';
    }
    if ((gradientAverage >= 20) && (gradientAverage < 30)) {
      emoji = 'images/cara8.png';
    }
    if ((gradientAverage >= 30) && (gradientAverage < 40)) {
      emoji = 'images/cara7.png';
    }
    if ((gradientAverage >= 40) && (gradientAverage < 50)) {
      emoji = 'images/cara6.png';
    }
    if ((gradientAverage >= 50) && (gradientAverage < 60)) {
      emoji = 'images/cara5.png';
    }
    if ((gradientAverage >= 60) && (gradientAverage < 70)) {
      emoji = 'images/cara14.png';
    }
    if ((gradientAverage >= 70) && (gradientAverage < 80)) {
      emoji = 'images/cara13.png';
    }
    if ((gradientAverage >= 80) && (gradientAverage < 90)) {
      emoji = 'images/cara12.png';
    }
    if ((gradientAverage >= 90) && (gradientAverage <= 100)) {
      emoji = 'images/cara11.png';
    }
    return emoji;
  }

  String emojiGradiente(int gradientAverage) {
    String emoji = 'images/cara1.png';
    if (gradientAverage < 10) {
      emoji = 'images/cara11.png';
    }
    if ((gradientAverage >= 10) && (gradientAverage < 20)) {
      emoji = 'images/cara12.png';
    }
    if ((gradientAverage >= 20) && (gradientAverage < 30)) {
      emoji = 'images/cara13.png';
    }
    if ((gradientAverage >= 30) && (gradientAverage < 40)) {
      emoji = 'images/cara14.png';
    }
    if ((gradientAverage >= 40) && (gradientAverage < 50)) {
      emoji = 'images/cara5.png';
    }
    if ((gradientAverage >= 50) && (gradientAverage < 60)) {
      emoji = 'images/cara6.png';
    }
    if ((gradientAverage >= 60) && (gradientAverage < 70)) {
      emoji = 'images/cara7.png';
    }
    if ((gradientAverage >= 70) && (gradientAverage < 80)) {
      emoji = 'images/cara8.png';
    }
    if ((gradientAverage >= 80) && (gradientAverage < 90)) {
      emoji = 'images/cara9.png';
    }
    if ((gradientAverage >= 90) && (gradientAverage <= 100)) {
      emoji = 'images/cara10.png';
    }
    return emoji;
  }

  bool likedComment(String comment, int pos) {
    bool liked = false;
    if (globals.likedComments[pos] == comment) {
      liked = true;
    }
    return liked;
  }

  String validateComment(String value) {
    if (value.isEmpty) {
      return "Escribe algo";
    } else if (value.length > 300) {
      return "Max 300 caracteres";
    } else if (value == " ") {
      return null;
    } else
      return "true";
  }

  Widget gradiente(int index) {
    if (gradList[index].runtimeType == int)
      return new Expanded(
        child: Slider(
          value: gradList[index].toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          label: gradList[index].round().toString(),
          activeColor: Color.fromRGBO(71, 82, 94, 1),
          inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
          onChanged: (double value) {
            setState(() {
              gradList[index] = value.toInt();
            });
          },
        ),
      );
    if (gradList[index].runtimeType == double)
      return new Expanded(
        child: Slider(
          value: gradList[index],
          min: 0,
          max: 100,
          divisions: 100,
          label: gradList[index].round().toString(),
          activeColor: Color.fromRGBO(71, 82, 94, 1),
          inactiveColor: Color.fromRGBO(71, 82, 94, 0.58),
          onChanged: (double value) {
            setState(() {
              gradList[index] = value;
            });
          },
        ),
      );
  }

  Widget comentarios(int index, dynamic publication) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: newcomment[index],
        onChanged: (text) {
          final controller = newcomment[index];
        },
        decoration: InputDecoration(
          hintText: 'Añade un nuevo comentario',
          suffixIcon: IconButton(
            onPressed: () => {
              if (validateComment(newcomment[index].text) == "true")
                {
                  addComment(newcomment[index].text, publication['_id']),
                  newcomment[index].clear(),
                  reload(ubication.text),
                }
              else
                {print("NO")},
              reload(ubication.text),
            },
            icon: Icon(Icons.check_outlined),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(Map<String, dynamic> publication, int index) {
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      // nombre de usuario
      Row(children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                Flexible(
                  child: Text(publication['userName'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
                SizedBox(
                  width: 5.0,
                ),
                if (publication['solutionPath'] != " ")
                  Image.asset(
                    'images/verificado.png',
                    width: 15.0,
                    height: 15.0,
                  ),
              ])),
        )
      ]),

      // ubicación
      Row(children: [
        Flexible(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: Row(children: <Widget>[
                Image.asset(
                  'images/location.png',
                  width: 15.0,
                  height: 15.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Flexible(
                  child: Text(publication['ubication'],
                      style: TextStyle(color: Colors.black.withOpacity(0.5))),
                ),
              ])),
        )
      ]),
      // imagen
      if (publication['solutionPath'] != ' ')
        _swiper(publication['imagePath'], publication['solutionPath']),
      if (publication['solutionPath'] == ' ')
        Image.network("http://158.109.74.52:55002/" + publication['imagePath'],
            width: 400, height: 250, scale: 0.8, fit: BoxFit.fill),
      // Gradiente
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                gradiente(index),
                IconButton(
                  onPressed: () => {
                    //setState(() {
                    newaverage = putGradient(
                        gradList[index].toInt(), publication['_id']),
                    gradList[index] = newaverage,
                    //}

                    //Future.delayed(const Duration(seconds: 1)),
                    gradList.clear(),
                    reload(ubication.text),
                    //Future.delayed(const Duration(seconds: 1)),
                  },
                  icon: Icon(Icons.check_outlined),
                ),
                if (publication['solutionPath'] == " ")
                  Image.asset(
                    emojiGradiente(gradList[index].toInt()),
                    width: 30.0,
                    height: 30.0,
                  )
                else
                  Image.asset(
                    emojiGradienteCuentaEspecial(gradList[index].toInt()),
                    width: 30.0,
                    height: 30.0,
                  ),
              ])),

      // Descripción
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(children: <Widget>[
            Text("Descripción",
                style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
          ])),
      Row(children: [
        Flexible(
          child: Container(
            //DESCRIPCIÓN
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Text(publication['description'],
                style: TextStyle(
                    color: Color.fromRGBO(71, 82, 94,
                        0.58))), //cambiar por descripción del usuario
          ),
        )
      ]),

      // Comentarios
      Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Row(children: <Widget>[
            Text("Comentarios",
                style: TextStyle(color: Color.fromRGBO(71, 82, 94, 1))),
          ])),
      if (publication['comments'].length > 0)
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(publication['comments'][0],
                        style: TextStyle(
                            color: Color.fromRGBO(71, 82, 94,
                                0.58))), //cambiar por comentario del usuario
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: likedComment(publication['comments'][0], 0)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            String comment1 = publication['comments'][0];
                            if (likedComment(comment1, 0)) {
                              num_mg = publication['mgCount'][0];
                              num_mg--;
                              publication['mgCount'][0] = num_mg;
                              globals.likedComments.remove(0);
                              removeLike(publication['_id'], 0);
                            } else {
                              num_mg = publication['mgCount'][0];
                              num_mg++;
                              publication['mgCount'][0] = num_mg;
                              globals.likedComments[0] = comment1;
                              doLike(publication['_id'], 0);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(publication['mgCount'][0].toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(71, 82, 94,
                                  0.58))), //cambiar numeros de mg reales del comentario
                    ],
                  ),
                ])),
      if (publication['comments'].length > 1)
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(publication['comments'][1],
                        style: TextStyle(
                            color: Color.fromRGBO(71, 82, 94,
                                0.58))), //cambiar por comentario del usuario
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: likedComment(publication['comments'][1], 1)
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            String comment2 = publication['comments'][1];
                            if (likedComment(comment2, 1)) {
                              num_mg = publication['mgCount'][1];
                              num_mg--;
                              publication['mgCount'][1] = num_mg;
                              globals.likedComments.remove(1);
                              removeLike(publication['_id'], 1);
                            } else {
                              num_mg = publication['mgCount'][1];
                              num_mg++;
                              publication['mgCount'][1] = num_mg;
                              globals.likedComments[1] = comment2;
                              doLike(publication['_id'], 1);
                            }
                          });
                        },
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(publication['mgCount'][1].toString(),
                          style: TextStyle(
                              color: Color.fromRGBO(71, 82, 94,
                                  0.58))), //cambiar numeros de mg reales del comentario
                    ],
                  ),
                ])),
      if (publication['comments'].length > 2)
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CommentsPage(_publications[index]),
              ),
            );
          },
          child: Text(
            'Ver todos los comentarios',
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
        ),
      comentarios(index, publication),
    ]));
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
      resizeToAvoidBottomInset: false,
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
              if (_publications.length > 0)
                return ListView.separated(
                  // it's like ListView.builder() but better because it includes a separator between items
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _publications.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _buildRow(_publications[index], index),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                );
              else
                return Center(
                    child: Text(
                        "No se encontraron publicaciones con esa ubicación",
                        style: TextStyle(color: Colors.green, fontSize: 15)));
            }
            if (!snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text("Buscar publicaciones por texto"),
                    ),
                    SizedBox(
                      height: 383.0,
                      child: SearchMapPlaceWidget(
                        language: 'es',
                        iconColor: Colors.green,
                        placeholder: "Introduce una ubicación",
                        apiKey: "AIzaSyCkG1TBTljazmME6wVvjTTw_yBuYp5b6Qg",
                        onSelected: (Place place) async {
                          Geolocation geolocation = await place.geolocation;
                          _mapController.animateCamera(
                              CameraUpdate.newLatLng(geolocation.coordinates));
                          _mapController.animateCamera(
                              CameraUpdate.newLatLngBounds(
                                  geolocation.bounds, 0));
                          final geocoding = GoogleMapsGeocoding(
                              apiKey:
                                  'AIzaSyCkG1TBTljazmME6wVvjTTw_yBuYp5b6Qg');
                          final address =
                              await geocoding.searchByPlaceId(place.placeId);
                          final ubiName = address.results[0].formattedAddress;
                          Timer(Duration(seconds: 2), () {
                            searchUbication(ubiName);
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 600.0,
                      child: GoogleMap(
                        onMapCreated:
                            (GoogleMapController googleMapController) {
                          setState(() {
                            _mapController = googleMapController;
                          });
                        },
                        initialCameraPosition: CameraPosition(
                            zoom: 15.0, target: LatLng(41.497292, 2.108340)),
                        mapType: MapType.normal,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
