import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Utils.dart';
import 'login.dart';
import 'home.dart';

class Authenticator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  }
  static Map<String, String> _storageAccess = null;

  void authentication() async {
    try {
      print("authentication");
      final result = await FlutterWebAuth.authenticate(
        url: "https://api.imgur.com/oauth2/authorize?client_id=c332b70ff804bf0&response_type=token",
        callbackUrlScheme: "epicture",
      );
      String response = Uri.parse(result).toString();
      saveCredentials(response);
    } on Exception catch (e) {
      print(e);
    }
  }

  static Map<String, String> getStorageAccess() {
    return _storageAccess;
  }

  static void setStorageAccess(Map<String, String> storage) {
    _storageAccess = storage;
  }

  void saveCredentials(String creds) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs != null && creds != null) {
      await prefs.setString("access_token", parseAuthenticate(creds, "access_token"));
      await prefs.setString("expires_in", parseAuthenticate(creds, "expires_in"));
      await prefs.setString("token_type", parseAuthenticate(creds, "token_type"));
      await prefs.setString("refresh_token", parseAuthenticate(creds, "refresh_token"));
      await prefs.setString("account_username", parseAuthenticate(creds, "account_username"));
      await prefs.setString("account_id", parseAuthenticate(creds, "account_id"));
    }
  }

  static void redirect(BuildContext context) async {
    try {
      SharedPreferences creds = await SharedPreferences.getInstance();

      if (creds != null && creds.containsKey("access_token")) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Home()),
              (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Login()),
              (route) => false,
        );
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}