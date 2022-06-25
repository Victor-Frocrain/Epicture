import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

class GalleryModel{
  final String id;
  final String title;
  final String link;
  final Map<String, String> imageLinks;
  List<String> tags;

  GalleryModel({this.id, this.title, this.link, this.imageLinks});

  static Map<String, String> getLinks(final json){
    Map<String, String> imageLinks = new Map<String, String>();
    var newValue = "";
    if (json.containsKey("type") && json.containsKey("id")) {
      if( json["type"].toString().startsWith("video")){
        var type = json["type"].toString().split("/");
        if (type != null && type.length > 1) {
          var format = type[1];
          if (json.containsKey(format)) {
            var value= json[format].toString();
            newValue = value.replaceRange(value.lastIndexOf("."), value.length, ".gif");
          }
          else if (json.containsKey("link")) {
            var value= json["link"].toString();
            newValue = value.replaceRange(value.lastIndexOf("."), value.length, ".gif");
          }
        }
      } else if (json["type"].toString().startsWith("image")){
        if( json.containsKey("link")) {
          newValue = json["link"];
        }
      }
      newValue = newValue.replaceRange(0, newValue.indexOf(":"), "https");
      imageLinks[json["id"]] = newValue;
    }
    return imageLinks;
  }

  factory GalleryModel.fromJsonMe(final json){
    return GalleryModel(
      id: json["id"],
      title: json ["title"],
      link: json["link"],
      imageLinks: getLinks(json),
    );


  }
  factory GalleryModel.fromJson(final json){
    Map<String, String> imageLinks = new Map<String, String>();
    if (json.containsKey("images") && json["images"] != null) {
      json["images"].forEach((image) {
        imageLinks.addAll(getLinks(image));
      });
    } else {
      imageLinks.addAll(getLinks(json));
    }
    return GalleryModel(
        id: json["id"],
        title: json ["title"],
        link: json["link"],
        imageLinks: imageLinks
    );
  }
}