import 'package:js/js.dart';

import '../../js.dart';
import 'request.dart';
import 'request_interceptor.dart';
import 'response.dart';

@JS()
abstract class RequestManagerInfo {
  external num requestsPerSecond;
  external num? requestTimeout;
  external RequestInterceptor? interceptor;
}

@JS()
class RequestManager extends RequestManagerInfo {
  external Promise<Response> Function(Request request, num retryCount) schedule;

  factory RequestManager({
    required num requestsPerSecond,
    num? requestTimeout,
    RequestInterceptor? interceptor,
  }) =>
      _createRequestManager(_CreateRequestManagerInfoOptions(
        requestsPerSecond: requestsPerSecond,
        requestTimeout: requestTimeout,
        interceptor: interceptor,
      ));
}

@JS()
@anonymous
class _CreateRequestManagerInfoOptions {
  external num get requestsPerSecond;
  external num? get requestTimeout;
  external RequestInterceptor? get interceptor;

  external factory _CreateRequestManagerInfoOptions({
    num requestsPerSecond,
    num? requestTimeout,
    RequestInterceptor? interceptor,
  });
}

@JS('createRequestManager')
external RequestManager _createRequestManager(
  _CreateRequestManagerInfoOptions options,
);
