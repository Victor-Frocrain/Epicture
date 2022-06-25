import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'searchPage.dart';
import 'GalleryModel.dart';

class searchPictures {
  static String lastSearchValue;

  static Future<List<GalleryModel>> findPictures(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {
      'Authorization': 'Client-ID c332b70ff804bf0'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://api.imgur.com/3/gallery/search/top/day/1?q=' + value));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final jsonGallery = await jsonDecode(await response.stream.bytesToString());

      List<GalleryModel> models = new List<GalleryModel>();
      jsonGallery["data"].forEach((model) {
        models.add(GalleryModel.fromJson(model));
      });
      return models;

    }
    else {
      throw Exception();
    }
  }
}