import 'package:epicture/Utils.dart';
import 'package:epicture/GalleryModel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Map<String, String> mapTest = new Map<String, String>();
  mapTest["hello"] = "hi";
  mapTest["Why"] = "how";
  mapTest["bonjour"] = "salut";
  test('parseAuthenticate find the good attribute', () {
    String source = "attr=hello";
    expect(parseAuthenticate(source, "attr"), equals("hello"));
  });
  test('parseAuthenticate bad attribute', () {
    String source = "attr=";
    expect(parseAuthenticate(source, "attr"), equals(""));
  });
  test('parseAuthenticate no attribute', () {
    String source = "";
    expect(parseAuthenticate(source, "attr"), equals(""));
  });
  test('getRangedMap 0 to 1', () {
    expect(getRangedMap(mapTest, 0, 1), equals({"hello": "hi", "Why": "how"}));
  });
  test('getRangedMap 1 to 2', () {
    expect(getRangedMap(mapTest, 1, 2), equals({"Why": "how", "bonjour": "salut"}));
  });
  test('getRangedMap for all', () {
    expect(getRangedMap(mapTest, 0, -1), equals({"hello": "hi", "Why": "how", "bonjour": "salut"}));
  });
  test('getLinks for image', () {
    var json = {"id": "1234", "type": "image/jpg", "link": "http://helloWorld.jpg"};
    expect(GalleryModel.getLinks(json), equals({"1234": "https://helloWorld.jpg"}));
  });
  test('getLinks for video with mp4 section', () {
    var json = {"id": "1234", "type": "video/mp4", "mp4": "http://helloWorld.mp4"};
    expect(GalleryModel.getLinks(json), equals({"1234": "https://helloWorld.gif"}));
  });
  test('getLinks for video with gifv section', () {
    var json = {"id": "1234", "type": "video/gifv", "gifv": "http://helloWorld.gifv"};
    expect(GalleryModel.getLinks(json), equals({"1234": "https://helloWorld.gif"}));
  });
  test('getLinks without type', () {
    var json = {"id": "1234", "gifv": "http://helloWorld.gifv"};
    expect(GalleryModel.getLinks(json), equals({}));
  });
}