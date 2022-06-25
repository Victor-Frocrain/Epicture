import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'loader.dart';
import 'searchPictures.dart';
import 'searchPage.dart';
import 'callApi.dart';
import 'GalleryModel.dart';
import 'addPhoto.dart';
import 'GalleryImage/galleryimage.dart';
import 'Profile.dart';
import 'home.dart';
import 'Utils.dart';

class Favorites extends StatefulWidget {
  @override
  createState() => _FavoritesPage();
}

class _FavoritesPage extends State<Favorites> {
  SearchBar searchBar;
  Map<String, String> _imagesList;

  AppBar buildAppBar(BuildContext context) {
    void handleClick(String value) async {
      switch (value) {
        case 'Logout':
          SharedPreferences creds = await SharedPreferences.getInstance();

          await creds.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Loading()),
                (route) => false,
          );
          break;
        case 'My images' :
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile()),
          );
          break;
        case 'Home' :
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home()),
          );
          break;
      }
    }

    return new AppBar(
        title: new Text('My favorites'),
        actions: <Widget>[
          searchBar.getSearchAction(context),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Home', 'My images', 'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ]
    );
  }

  _FavoritesPage() {
    _imagesList= new Map<String, String>();
    searchBar = new SearchBar(
        inBar: true,
        setState: setState,
        onSubmitted: (value) {
          searchPictures.lastSearchValue = value;
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Search())
          );
          //searchPictures.findPictures
        },
        buildDefaultAppBar: buildAppBar
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: searchBar.build(context),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<List<GalleryModel>>(
                  future : callApi.getFavorites(),
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      final gallery = snapshot.data;
                      for (var model in gallery)
                        if(model!=null)
                          _imagesList.addAll(model.imageLinks);

                      return Container(
                          child: Column(
                              children: <Widget>[ GalleryImage(
                                imageUrls: getRangedMap(_imagesList, 0, 2),
                              ),
                                GalleryImage(
                                  imageUrls: getRangedMap(_imagesList, 3, 5),
                                ),
                                GalleryImage(
                                  imageUrls: getRangedMap(_imagesList, 6, -1),
                                ),
                              ])
                          );


                    }else if(snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }
                    return CircularProgressIndicator();
                  },
                )
              ]
          ),
        ),
        floatingActionButton: AddPhotoButton.addButton(context)
    );
  }
}