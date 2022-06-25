import 'package:flutter/material.dart';
import 'uploadImage.dart';

class AddPhotoButton {
  AddPhotoButton();

  static FloatingActionButton addButton(context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Upload())
        );
      },
      child: Icon(Icons.add_a_photo),
    );
  }
}