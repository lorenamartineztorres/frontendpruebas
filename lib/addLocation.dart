import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:search_map_place/search_map_place.dart';
import 'globals.dart' as globals;

class AddLocation extends StatelessWidget {
  String location = "Madrid";
  // This widget is the root of your application.
  Marker _publicationUbi;
  
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
        resizeToAvoidBottomInset: false,
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
            child: 
            SearchMapPlaceWidget(
                    language: 'es',
                    iconColor: Colors.green,
                    placeholder: "Introduce una ubicación",
                    apiKey: "AIzaSyCkG1TBTljazmME6wVvjTTw_yBuYp5b6Qg",
                    onSelected: (Place place) async {
                      Geolocation geolocation = await place.geolocation;
                      final geocoding = GoogleMapsGeocoding(apiKey: 'AIzaSyCkG1TBTljazmME6wVvjTTw_yBuYp5b6Qg');
                      final address = await geocoding.searchByPlaceId(place.placeId);
                      final ubiName =  address.results[0].formattedAddress;
                      globals.ubication = ubiName;
                      globals.latitude = address.results[0].geometry.location.lat;
                      globals.longitude = address.results[0].geometry.location.lng;
                      Navigator.of(context).pop(ubication.text);
                    },
                    
                  ),
            
            /*TextFormField(
              maxLength: 30,
              controller: ubication,
              decoration: InputDecoration(
                hintText: 'Ubicación',
              ),*/
            )
        ]),
        /*
        floatingActionButton: Transform.scale(
          scale: 1.2,
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            onPressed: () {
              globals.ubication = geolocation;        
              Navigator.of(context).pop(ubication.text);
            },

            child: Icon(Icons.check_outlined),
            backgroundColor: Color.fromRGBO(100, 211, 83, 1),
          ),
        )*/);
  }
}
