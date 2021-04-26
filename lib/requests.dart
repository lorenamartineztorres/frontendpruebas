import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/PublicacionModel.dart';
import 'dart:convert';

final http.Client client = http.Client();

const String baseUrl = "http://158.109.74.52:55002/api";

Future<Map<String, dynamic>> getPublicaciones() async { //FUNCIONA, falta tratar los datos que recibimos
  String uri = "$baseUrl/publications";
  final response = await client.get(uri);
    
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");

    final jsonData = jsonDecode(response.body);
    Map<String, dynamic> mapDatos = jsonData[0];

    return mapDatos;

  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get publications');
  }
}

Future<void> register(String mail, String userName,String country,String city,String postalCode,String password) async { //FUNCIONA CORRECTAMENTE
  final String uri = "$baseUrl/register";

  Map data = {
  'mail': mail,
  'userName': userName,
  'country': country,
  'city': city,
  'postalCode': postalCode,
  'password': password
  };

  String body = json.encode(data);

  http.Response response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: body,
  );


  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(response.body);
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}


Future<String>  login(String mail, String password) async { 
  final String uri = "$baseUrl/login";

  Map data = {
  'mail': mail,
  'password': password
  };

  String body = json.encode(data);

  http.Response response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");

    final jsonData = jsonDecode(response.body);
    String token = jsonData['token'];
    print(token);

    return token;

  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> register2(String mail, String userName,String country,String city,String postalCode,String password) async {
  String uri = "$baseUrl/register";

  final response = await http.post(uri, body: {
        "mail": mail,
        "userName": userName,
        "country": country,
        "city": city,
        "postalCode": postalCode,
        "password": password, 
    });
  
  // response is NOT a Future because of await but since getTree() is async,
  // execution continues (leaves this function) until response is available,
  // and then we come back here
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(response.body);
    // If the server did return a 200 OK response, then parse the JSON.
    Map<String, dynamic> decoded = convert.jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}



Future<void> stop(int id) async {
  String uri = "$baseUrl/stop?$id";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> add(String name, int fatherId, String type) async {
  String uri = "$baseUrl/add?$name?$fatherId?$type";
  final response = await client.get(uri);
  if (response.statusCode == 200) {
    print("Creat correctament");
    print("statusCode=$response.statusCode");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to create activity');
  }
}