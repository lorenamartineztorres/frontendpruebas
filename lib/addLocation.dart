import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:search_map_place/search_map_place.dart';
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'ECOPROTECT',
            style:
                TextStyle(fontSize: 16.0, fontFamily: 'Glacial Indifference'),
          ),
        ),
        body: Container(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("Añade la ubicación:"),
            ),
            Center(
              child: SizedBox(
                height: 383.0,
                child: SearchMapPlaceWidget(
                  language: 'es',
                  iconColor: Colors.green,
                  placeholder: "Introduce una ubicación",
                  apiKey: "AIzaSyCkG1TBTljazmME6wVvjTTw_yBuYp5b6Qg",
                  onSelected: (Place place) async {
                    final geocoding = GoogleMapsGeocoding(
                        apiKey: 'AIzaSyCkG1TBTljazmME6wVvjTTw_yBuYp5b6Qg');
                    final address =
                        await geocoding.searchByPlaceId(place.placeId);
                    final ubiName = address.results[0].formattedAddress;
                    globals.ubication = ubiName;
                    Navigator.of(context).pop(ubication.text);
                  },
                ),
              ),
            ),
          ],
        )));
  }
}
