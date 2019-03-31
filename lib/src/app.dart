import 'package:flutter/material.dart';
import 'package:getting_familiar/model/Photo.dart';
import 'package:getting_familiar/src/ImageList.dart';
import 'package:getting_familiar/src/PhotoApi.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState(PhotoApi());
  }
}

class AppState extends State<App> {
  int counter = 1;
  List<Photo> _photos = [];
  PhotoApi _photoStream;
  AppState(this._photoStream);

  void builPhotoStream(num id) {
    _photoStream.fetchPhotoStream(id).listen((data) => _photos.add(data));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello Flutter"),
        ),
        body: ImageList(_photos),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ++counter;
            builPhotoStream(counter);
            setState(() => counter);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
