import 'dart:async';
import 'dart:convert';

import 'package:getting_familiar/model_stream/IModel.dart';
import 'package:getting_familiar/model_stream/ModelConverter.dart';

class ModelEventSink<S extends String, M extends IModel>
    extends StringConversionSinkBase {
  EventSink<M> _innerSink;
  ModelConverter<S, M> _converter;
  ModelEventSink(this._innerSink, this._converter);

  @override
  void addSlice(String str, int start, int end, bool isLast) {
    _innerSink.add(_converter.convert(str));
  }

  @override
  void close() {
    _innerSink.close();
  }
}

class ModelEventSinkAdvance<S extends String, M extends IModel>
    extends ChunkedConversionSink<S> {
  EventSink<M> _innerSink;
  ModelConverter<S, M> _converter;

  ModelEventSinkAdvance(this._innerSink, this._converter);

  @override
  void add(chunk) {
    _innerSink.add(_converter.convert(chunk));
  }

  @override
  void close() {
    _innerSink.close();
  }
}
