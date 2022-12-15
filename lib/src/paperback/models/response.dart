import 'package:dart_pb_extensions_common/src/paperback/models/raw_data.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/request.dart';
import 'package:js/js.dart';

@JS('paperback-extensions-common.Response')
class Response {
  external RawData get rawData;

  /// The response which was provided from the server
  external Object? get data;

  /// The HTTP status code from the server response
  external num get status;

  /// The HTTP headers that the server responded with
  /// All header names are lower cased and can be accessed
  /// using the bracket notation.
  ///
  /// Example: `response.headers['content-type']`
  external Map<String, String> get headers;

  /// The request which generated this response.
  external Request get request;
}
