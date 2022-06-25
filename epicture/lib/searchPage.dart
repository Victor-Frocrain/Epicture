import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'loader.dart';
import 'searchPictures.dart';
import 'GalleryModel.dart';
import 'GalleryImage/galleryimage.dart';

class Search extends StatefulWidget {
  @override
  createState() => _SearchPage();
}

class _SearchPage extends State<Search> {
  SearchBar searchBar;
  static String searchValue;
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
      }
    }

    return new AppBar(
        title: new Text(searchValue),
        actions: <Widget>[
          searchBar.getSearchAction(context),
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
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

  _SearchPage() {
    searchValue = searchPictures.lastSearchValue;
    searchPictures.findPictures(searchValue);
    _imagesList= new Map<String, String>();
    searchBar = new SearchBar(
        inBar: true,
        setState: setState,
        onSubmitted: setSearchValue,
        buildDefaultAppBar: buildAppBar
    );
  }

  static String getSearchValue() {
    return searchValue;
  }

  static void setSearchValue(String value) {
    searchValue = value;
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
              Center(
                child: FutureBuilder<List<GalleryModel>>(
                  future: searchPictures.findPictures(searchValue),
                  builder: (context, snapshot){
                    var nbPics = 0;
                    if(snapshot.hasData){
                      final gallery = snapshot.data;
                      for (var model in gallery)
                        if(model!=null)
                          _imagesList.addAll(model.imageLinks);

                      // _imagesList.add("https://i.imgur.com/9OiFMDZ.gif");

                      return Container(
                          child:
                          GalleryImage(
                            imageUrls: _imagesList,
                          ));



                    }else if(snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }

                    return CircularProgressIndicator();
                  },
                ),
              ),
            ]
        ),
      ),
    );
  }
}