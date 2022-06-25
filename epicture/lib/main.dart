import 'package:flutter/material.dart';
import 'GalleryModel.dart';
import 'callApi.dart';
import 'loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Loading(),
    );
  }
}

class HttpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<GalleryModel>>(
          future: callApi.getGallery(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              final gallery = snapshot.data;

              //return Image.network("${gallery.imageLink}");

            }else if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}