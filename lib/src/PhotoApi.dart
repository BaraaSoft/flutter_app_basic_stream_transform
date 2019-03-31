import 'dart:convert';

import 'package:getting_familiar/model/Photo.dart';
import 'package:getting_familiar/model_stream/ModelConverter.dart';
import 'package:http/http.dart' as http;

class PhotoApi {
  List<Photo> Photos = [];

  Future<http.StreamedResponse> _download(num id) {
    //https://jsonplaceholder.typicode.com/photos/
    String baseUrl = 'jsonplaceholder.typicode.com';
    Uri url = Uri.https(baseUrl, '/photos/$id');
    http.Client client = new http.Client();
    http.BaseRequest request = new http.Request('GET', url);
    return request.send();
  }

  Future<Stream<Photo>> fetchPhoto(num id) async {
    var response = await _download(id);
    var photoStream = response.stream.transform(utf8.decoder).transform(
        ModelConverter<String, Photo>(
            (str) => Photo.fromJson(json.decode(str))));
    return photoStream;
  }

  Stream<Photo> fetchPhotoStream(num id) async* {
    var response = await _download(id);
    yield* response.stream
        .transform(utf8.decoder)
        .map((str) => json.decode(str))
        .map((x) => Photo.fromJson(x));
  }

  Stream<Photo> getPhotosStream(num id) async* {
    var response = await _download(id);
    var photoStream = response.stream.transform(utf8.decoder).transform(
        ModelConverter<String, Photo>(
            (str) => Photo.fromJson(json.decode(str))));
    yield* photoStream;
  }

  _teststream() async {
    var photostream = await fetchPhoto(1);
    photostream.listen((x) => print(x.url));
  }
}
