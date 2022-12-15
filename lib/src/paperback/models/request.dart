import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:js/js.dart';

@JS('paperback-extensions-common.Request')
class Request {
  /// The URL which this HTTP request should be delivered to
  external String get url;
  external set url(String url);

  /// The type of HTTP method. Usually GET or POST
  external String get method;
  external set method(String method);

  /// Metadata is something which can be applied to a Request, which will
  /// be passed on to the function which consumes this request. By inserting
  /// data here, you are able to forward any data you need as a Source developer
  /// to the methods meant to parse the returning data
  external Object? get metadata;
  external set metadata(Object? metadata);

  /// Any HTTP headers which should be applied to this request
  external Map<String, String>? get headers;
  external set headers(Map<String, String>? headers);

  /// Data which
  external Object? get data;
  external set data(Object? data);

  /// Formatted parameters which are to be associated to the end of the URL.
  ///
  /// Eg: `?paramOne=ImportantData&paramTwo=MoreData`
  external String? get param;
  external set param(String? param);

  /// Any formatted cookies which should be inserted into the header
  ///
  /// Cookies need to be formatted to be put into headers
  external List<Cookie>? get cookies;
  external set cookies(List<Cookie>? cookies);

  /// A toggle for if this request should be made in incognito mode or not
  external bool? get incognito;
  external set incognito(bool? incognito);

  factory Request({
    required String url,
    required String method,
    Object? metadata,
    Map<String, String>? headers,
    Object? data,
    String? param,
    List<Cookie>? cookies,
    bool? incognito,
  }) =>
      _createRequestObject(_CreateRequestObjectOptions(
        url: url,
        method: method,
        metadata: metadata,
        headers: headers,
        data: data,
        param: param,
        cookies: cookies,
        incognito: incognito,
      ));
}

@JS()
class Cookie {
  external String get name;
  external String get value;
  external String get domain;
  external String? get path;
  external Date? get created;
  external Date? get expires;

  factory Cookie({
    required String name,
    required String value,
    required String domain,
    String? path,
    Date? created,
    Date? expires,
  }) =>
      _createCookie(_CreateCookieOptions(
        name: name,
        value: value,
        domain: domain,
        path: path,
        created: created,
        expires: expires,
      ));
}

@JS()
@anonymous
class _CreateCookieOptions {
  external String get name;
  external String get value;
  external String get domain;
  external String? get path;
  external Date? get created;
  external Date? get expires;

  external factory _CreateCookieOptions({
    required String name,
    required String value,
    required String domain,
    String? path,
    Date? created,
    Date? expires,
  });
}

@JS('createCookie')
external Cookie _createCookie(_CreateCookieOptions options);

@JS()
@anonymous
class _CreateRequestObjectOptions {
  external String get url;
  external String get method;
  external Object? get metadata;
  external Map<String, String>? get headers;
  external Object? get data;
  external String? get param;
  external List<Cookie>? get cookies;
  external bool? get incognito;

  external factory _CreateRequestObjectOptions({
    required String url,
    required String method,
    Object? metadata,
    Map<String, String>? headers,
    Object? data,
    String? param,
    List<Cookie>? cookies,
    bool? incognito,
  });
}

@JS('createRequestObject')
external Request _createRequestObject(_CreateRequestObjectOptions options);
