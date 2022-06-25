import 'dart:convert';
import 'package:http/http.dart' as http;
import 'GalleryModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
class callApi {

  static Future<List<GalleryModel>> getGallery() async{
    final url = "https://api.imgur.com/3/gallery/hot/viral/0.json";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final jsonGallery = await jsonDecode(response.body);

      //final a = jsonGallery["data"][0]["images"][0]["link"];
      List<GalleryModel> models = new List<GalleryModel>();
      jsonGallery["data"].forEach((model) {
        models.add(GalleryModel.fromJson(model));
      });
      return models;
    }else{
      return null;
    }

  }

  static Future<List<GalleryModel>> getPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken= prefs.getString("access_token");
    var headers = {
      'Authorization': 'Bearer $accessToken'
    };
    var request = http.MultipartRequest('GET', Uri.parse('https://api.imgur.com/3/account/me/images'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var resp= await response.stream.bytesToString();

      final jsonGallery =  jsonDecode(resp);

      List<GalleryModel> models = new List<GalleryModel>();
      jsonGallery["data"].forEach((model) {
        models.add(GalleryModel.fromJsonMe(model));
      });
      return models;

    }
    else {
      return null;
    }
  }

  static Future<List<GalleryModel>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken= prefs.getString("access_token");
    final username = prefs.getString("account_username");

    if (accessToken != null && username != null) {
      var headers = {
        'Authorization': 'Bearer $accessToken'
      };
      var request = http.MultipartRequest(
          'GET', Uri.parse('https://api.imgur.com/3/account/${username}/favorites'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var resp = await response.stream.bytesToString();

        final jsonGallery = jsonDecode(resp);
        var a = jsonGallery["data"];

        List<GalleryModel> models = new List<GalleryModel>();
        jsonGallery["data"].forEach((model) {
          GalleryModel gallery = GalleryModel.fromJson(model);
          if (gallery != null) {
            models.add(gallery);
          }
        });
        print(models);
        return models;
      }
      else {
        return null;
      }
    }
    else {
      return null;
    }
  }

  static void setFavorite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken= prefs.getString("access_token");

    if (accessToken != null) {
      var headers = {
        'Authorization': 'Bearer $accessToken'
      };
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://api.imgur.com/3/image/${id}/favorite'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      }
    }
  }
}