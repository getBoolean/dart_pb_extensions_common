library dart_pb_extensions_common.js;

import 'package:js/js.dart';

@JS('JSON.parse')
external dynamic parseJson(String json);

@JS()
abstract class Date {
  external factory Date(dynamic value);
  external int getTime();
  external String toISOString();
}

@JS()
@anonymous
class Record<K, V> {
  external K get first;
  external V get second;
}

/// JavaScript Error object.
@JS('Error')
abstract class JsError {
  external factory JsError([message]);

  external String get message;
  external String get stack;
}
