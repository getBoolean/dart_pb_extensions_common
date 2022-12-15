import 'package:dart_pb_extensions_common/src/paperback/models/request_manager.dart';
import 'package:js/js.dart';

@JS()
abstract class Requestable {
  /// Manages the ratelimits and the number of requests that can be done per second
  /// This is also used to fetch pages when a chapter is downloading
  external JsRequestManager get requestManager;
}
