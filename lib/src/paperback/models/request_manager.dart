import 'package:js/js.dart';

import '../../js/js.dart';
import 'request.dart';
import 'request_interceptor.dart';
import 'response.dart';

@JS()
abstract class RequestManagerInfo {
  external num requestsPerSecond;
  external num? requestTimeout;
  external JsRequestInterceptor? interceptor;
}

class RequestManager {
  late final JsRequestManager jsRequestManager;

  Future<Response> schedule(Request request, num retryCount) {
    return jsRequestManager.schedule(request, retryCount).toFuture();
  }

  RequestManager({
    required num requestsPerSecond,
    num? requestTimeout,
    RequestInterceptor? interceptor,
  }) : jsRequestManager = JsRequestManager(
          requestsPerSecond: requestsPerSecond,
          requestTimeout: requestTimeout,
          interceptor: interceptor?.jsRequestInterceptor,
        );
}

@JS('RequestManager')
class JsRequestManager extends RequestManagerInfo {
  external Promise<Response> Function(Request request, num retryCount) schedule;

  factory JsRequestManager({
    required num requestsPerSecond,
    num? requestTimeout,
    JsRequestInterceptor? interceptor,
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
  external JsRequestInterceptor? get interceptor;

  external factory _CreateRequestManagerInfoOptions({
    num requestsPerSecond,
    num? requestTimeout,
    JsRequestInterceptor? interceptor,
  });
}

@JS('createRequestManager')
external JsRequestManager _createRequestManager(
  _CreateRequestManagerInfoOptions options,
);
