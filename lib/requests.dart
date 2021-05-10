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
    //print(mapPublications);
    return mapPublications;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get publications');
  }
}

Future<String> register(String mail, String userName, String country,
    String city, String postalCode, String password) async {
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

  final jsonData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print(jsonData['message']);
    return (jsonData['message']);
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<List> login(String mail, String password) async {
  final String uri = "$baseUrl/login";

  Map data = {'mail': mail, 'password': password};

  String body = json.encode(data);

  http.Response response = await http.post(
    uri,
    headers: {"Content-Type": "application/json"},
    body: body,
  );

  final jsonData = jsonDecode(response.body);
  List resposta;
  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    String token = jsonData['token'];
    return [jsonData['token'], 1];
  } else if (response.statusCode == 401) {
    print("statusCode=$response.statusCode");
    return [jsonData['message'], 0];
  } else
    throw Exception("Invalid Password");
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

Future<void> LogOut() async {
  // poner token en la declaracion
  var uri = Uri.parse("$baseUrl/logout");

  var request = new http.MultipartRequest("POST", uri);
  request.headers['session'] = globals.token;
  request.headers['Content-Type'] = 'multipart/form-data';

  request.send().then((response) {
    if (response.statusCode == 200) {
      print("statusCode=$response.statusCode");
      print(response);
      print("correctamente cerrar sessiÃ³n");
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
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to do like');
  }
}

Future<Map<String, dynamic>> getProfile() async {
  final String uri = "$baseUrl/profile";

  http.Response response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("Success to get user");
    final jsonProfile = jsonDecode(response.body);
    return jsonProfile;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get profile');
  }
}

Future<void> getUser(String id) async {
  final String uri = "$baseUrl/user/$id";

  http.Response response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("Success to get user");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get user');
  }
}

Future<String> getUsername() async {
  final String uri = "$baseUrl/profile/";

  http.Response response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("Success to get user");
    final jsonData = jsonDecode(response.body);
    String username = jsonData['username'];
    print(username);
    return username;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get user');
  }
}

Future<void> editUsername(String username) async {
  print("HOLA");
  print(username);
  final String uri = "$baseUrl/user";

  Map data = {'userName': username};

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
    print(response.body);
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<double> putGradient(int gradient, String id) async {
  final String uri = "$baseUrl/publications/gradient/$id";

  Map data = {'gradient': gradient};

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
    print("Success gradient");

    final jsonData = jsonDecode(response.body);
    double gradAverage = jsonData['average'];
    print(gradAverage);
    return gradAverage;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get new gradient average');
  }
}

Future<List<dynamic>> search(String ubi) async {
  String uri = "$baseUrl/publications/search/$ubi";

  http.Response response = await http.get(uri, headers: {
    "session": globals.token,
  });

  final jsonData = jsonDecode(response.body);

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("Success");

    List<dynamic> publications = jsonData;
    print(publications);
    return publications;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get publications');
  }
}

Future<dynamic> getOnePublication(String id) async {
  final String uri = "$baseUrl/publications/$id";

  http.Response response = await http.get(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("Success to get publication");

    final jsonData = jsonDecode(response.body);
    print(jsonData);
    dynamic publication = jsonData;
    return publication;
  } else {
    print("statusCode=$response.statusCode");
    print(globals.token);
    throw Exception('Failed to get publications');
  }
}

Future<int> editPassword(String passwordActual, String passwordNueva) async {
  final String uri = "$baseUrl/user";

  Map data = {'actualPassword': passwordActual, 'password': passwordNueva};

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
    print(response.body);
    final jsonData = jsonDecode(response.body);
    int respuesta = jsonData['response'];
    return respuesta;
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to get children');
  }
}

Future<void> deletePublication(String id) async {
  final String uri = "$baseUrl/publications/$id";

  http.Response response = await http.delete(
    uri,
    headers: {
      "Content-Type": "application/json",
      "session": globals.token,
    },
  );

  if (response.statusCode == 200) {
    print("statusCode=$response.statusCode");
    print("delete publication ok");
  } else {
    print("statusCode=$response.statusCode");
    throw Exception('Failed to delete publication');
  }
}
