// To parse this JSON data, do
//
//     final publicacion = publicacionFromJson(jsonString);

import 'dart:convert';

Publicacion publicacionFromJson(String str) => Publicacion.fromJson(json.decode(str));

String publicacionToJson(Publicacion data) => json.encode(data.toJson());

class Publicacion {
  List<String> comments;
  List<int> mgCount;
  List<String> gradient;
  String sId;
  String publicacionID;
  String userName;
  String ubication;
  String imagePath;
  String description;
  bool type;
  int iV;
  int commentsNum;

  Publicacion(
      {this.comments,
      this.mgCount,
      this.gradient,
      this.sId,
      this.publicacionID,
      this.userName,
      this.ubication,
      this.imagePath,
      this.description,
      this.type,
      this.iV,
      this.commentsNum});

  Publicacion.fromJson(Map<String, dynamic> json) {
    comments = json['comments'].cast<String>();
    mgCount = json['mgCount'].cast<int>();
    gradient = json['gradient'].cast<String>();
    sId = json['_id'];
    publicacionID = json['publicacionID'];
    userName = json['userName'];
    ubication = json['ubication'];
    imagePath = json['imagePath'];
    description = json['description'];
    type = json['type'];
    iV = json['__v'];
    commentsNum = json['commentsNum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comments'] = this.comments;
    data['mgCount'] = this.mgCount;
    data['gradient'] = this.gradient;
    data['_id'] = this.sId;
    data['publicacionID'] = this.publicacionID;
    data['userName'] = this.userName;
    data['ubication'] = this.ubication;
    data['imagePath'] = this.imagePath;
    data['description'] = this.description;
    data['type'] = this.type;
    data['__v'] = this.iV;
    data['commentsNum'] = this.commentsNum;
    return data;
  }
}
