library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwODZmZGEzMzdlZWQ0ZGZhMTFkMDg1MCIsImlhdCI6MTYxOTQ1OTQ5OH0.mkTf47YaqGwtYmHd5f68b0-eY3rKk6SI7QYhPR2SoXo";
String token;
var ubication = '';
var latitude;
var longitude;
final likedComments = Map<int, String>();
bool logOut = true;
bool type;
bool ubi = false;
String username;
Set<Marker> markers = {};