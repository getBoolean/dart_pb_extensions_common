part of '../js.dart';

@JS()
class CheerioAPI {
  @JS()
  external CheerioAPI load(String content, [Map<String, Object?>? options, bool isDocument = true]);

  @JS()
  external bool contains(Object container, Object contained);

}
