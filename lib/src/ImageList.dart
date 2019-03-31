import 'package:flutter/material.dart';
import 'package:getting_familiar/model/Photo.dart';

class ImageList extends StatelessWidget {
  List<Photo> _images;

  ImageList(this._images);

  Widget renderImageWithContent(pos, {Widget Function(num) contents}) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.grey, width: 1.0)),
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(24.0),
      child: contents(pos),
    );
  }

  Widget renderInnerContent(pos) {
    return Column(
      children: <Widget>[
        Image.network(_images[pos].url),
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Text(_images[pos].title),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _images.length,
        itemBuilder: (context, pos) {
          if (_images.length > pos) {
            return renderImageWithContent(pos, contents: renderInnerContent);
          }
        });
  }
}
