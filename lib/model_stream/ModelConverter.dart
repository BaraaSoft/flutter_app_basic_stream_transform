import 'dart:convert';

import 'package:getting_familiar/model_stream/IModel.dart';
import 'package:getting_familiar/model_stream/ModelEventSink.dart';

class ModelConverter<S extends String, M extends IModel>
    extends Converter<S, M> {
  M Function(String str) funConvert;

  ModelConverter(this.funConvert);

  @override
  M convert(S input) {
    print(">> ${M.runtimeType}");
    return funConvert(input);
  }

  @override
  Sink<S> startChunkedConversion(Sink<M> sink) {
    return new ModelEventSinkAdvance<S, M>(sink, this);
  }
}
