import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'home.dart';

class Upload extends StatefulWidget {
  @override
  createState() => _UploadPage();
}

class _UploadPage extends State<Upload> {
  File _image;
  final picker = ImagePicker();
  var _inProgress = false;

  Text _message = Text('No image selected.',
    style: TextStyle(
      fontSize: 20,
      foreground: Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.black,
    ),);

  Image _pickedImage = null;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _pickedImage = updatePickedImage(1);
      }
    });
  }

  Future cancel() {
    setState(() {
      _message = updateMessage("No image selected.", 0);
      _image = null;
    });
  }

  Future uploadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString("access_token");
    if (token != null && _image != null && await _image.exists()) {
      uploadInProgress();
      final client = imgur.Imgur(imgur.Authentication.fromToken(token));
      final path = _image.path;

      await client.image
          .uploadImage(
          imagePath: path,
          title: null,
          description: null)
          .then((image) => refreshPage(image));
    }
    else {
      refreshPage(null);
    }
  }

  Future uploadInProgress() {
    setState(() {
      _inProgress = true;
      _pickedImage = updatePickedImage(0.5);
    });
  }

  Future refreshPage(imgur.Image image) {
    setState(() {
      if (image != null) {
        _message = updateMessage("Success!", 1);
      } else {
        _message = updateMessage("Error!", 2);
      }
      _inProgress = false;
      _image = null;
    });
  }

  Image updatePickedImage(double opacity) {
    Image image = null;
    if (_image != null) {
      image = Image.file(_image,
          color: Color.fromRGBO(255, 255, 255, opacity),
          colorBlendMode: BlendMode.modulate
      );
    }
    return image;
  }

  Text updateMessage(String message, int type) {
    double fontSize = 20;
    PaintingStyle paintStyle = PaintingStyle.fill;
    Color color = Colors.black;
    switch (type) {
      case 0:
        fontSize = 20;
        paintStyle = PaintingStyle.fill;
        color = Colors.black;
        break;
      case 1:
        fontSize = 40;
        paintStyle = PaintingStyle.fill;
        color = Colors.greenAccent;
        break;
      case 2:
        fontSize = 40;
        paintStyle = PaintingStyle.fill;
        color = Colors.redAccent;
        break;
      default:
        break;
    }
    return Text(message,
      style: TextStyle(
        fontSize: fontSize,
        foreground: Paint()
          ..style = paintStyle
          ..color = color,
      ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
          actions: <Widget>[Padding(padding: EdgeInsets.only(right:20),
            child: GestureDetector(
              onTap: () { Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Home()),
                    (route) => false,
              ); },
              child: Icon(
                Icons.home_sharp,  // add custom icons also
              ),
            ),
          )
          ],
        ),
        body:
        Center(
            child: _image == null
                ? _message
                : Stack(
              children: <Widget>[
                _pickedImage,
                Center(
                    child: _inProgress == true
                        ? Text("In Progress...",
                        style: TextStyle(
                          fontSize: 30,
                          foreground: Paint()
                            ..style = PaintingStyle.fill
                            ..color = Colors.white,))
                        : null
                ),
              ],
            )
        ),
        floatingActionButton:
        _inProgress == false
            ? _image == null
            ? Padding(padding: EdgeInsets.only(left:31),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: getImage,
                tooltip: 'Browse Image',
                child: Icon(Icons.add),
              ),))
            : Stack(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left:31),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: uploadImage,
                    tooltip: 'Upload',
                    child: Icon(Icons.backup),
                  ),
                ),),
              Padding(padding: EdgeInsets.only(left:31),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton(
                    onPressed: cancel,
                    tooltip: 'Cancel',
                    child: Icon(Icons.clear),
                  ),
                ),)
            ]
        )
            : null
    );
  }
}