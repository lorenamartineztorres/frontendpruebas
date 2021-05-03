import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/PublicacionModel.dart';
import 'dart:convert';
import 'globals.dart' as globals;

final http.Client client = http.Client();

const String baseUrl = "http://158.109.74.52:55002/api";

Future<List<dynamic>> getPublicaciones() async {
  String uri = "$baseUrl/publications";

  http.Response response = await http.get(uri, headers: {
    "session": globals.token,
  });

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("Success");

    final jsonData = jsonDecode(response.body);
    List<dynamic> mapPublications = jsonData;
    print(mapPublications);
    return mapPublications;
  } else {
    print("statusCode=$response.statusCode");
    print(globals.token);
    throw Exception('Failed to get publications');
  }
}

Future<void> register(String mail, String userName, String country, String city,
    String postalCode, String password) async {
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

Future<String> login(String mail, String password) async {
  final String uri = "$baseUrl/login";

  Map data = {'mail': mail, 'password': password};

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
    

    return token;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}


Future<void> createPublication(
    ubication, filename, description, gradient) async {
  //FUNCIONA CORRECTAMENTE
  var uri = Uri.parse("$baseUrl/publications");
  String gradString = gradient.toString();

  //String body = json.encode(data);
  var request = new http.MultipartRequest("POST", uri);
  request.fields['ubication'] = ubication;
  request.fields['description'] = description;
  request.fields['gradient'] = gradString;
  request.headers['session'] = globals.token;
  request.headers['Content-Type'] = 'multipart/form-data';
  request.files.add(await http.MultipartFile.fromPath('image', filename));
  request.send().then((response) {
    if (response.statusCode == 200) {
      print("statusCode=$response.statusCode");
      print(response);
    } else {
      print("statusCode=$response.statusCode");
      throw Exception('Failed to create publication');
    }
  });
}

Future<void> addComment(String comment, String id) async {
  final String uri = "$baseUrl/publications/$id";

  Map data = {'comment': comment};

  String body = json.encode(data);

  http.Response response = await http.put(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
    body: body,
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}


Future<void> LogOut() async { // poner token en la declaracion
  var uri = Uri.parse("$baseUrl/logout");

  var request = new http.MultipartRequest("POST", uri);
  request.headers['session'] = globals.token;
  request.headers['Content-Type'] = 'multipart/form-data';

  request.send().then((response) {
    if (response.statusCode == 200) {
      print("statusCode=$response.statusCode");
      print(response);
      print("correctamente cerrar sessión");
    } else {
      print("statusCode=$response.statusCode");
      throw Exception('Failed to LogOut');
    }
  });
}

Future<void> doLike(String id, int pos) async {
  final String uri = "$baseUrl/publications/like/$id/$pos";

  http.Response response = await http.put(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
          //"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwODZmZGEzMzdlZWQ0ZGZhMTFkMDg1MCIsImlhdCI6MTYxOTQ1OTQ5OH0.mkTf47YaqGwtYmHd5f68b0-eY3rKk6SI7QYhPR2SoXo"
    },
    
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("likeeeeee");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to do like');
  }
}

Future<void> removeLike(String id, int pos) async {
  final String uri = "$baseUrl/publications/like/$id/$pos";

  http.Response response = await http.delete(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
    
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("likeeeeee");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to do like');
  }
}