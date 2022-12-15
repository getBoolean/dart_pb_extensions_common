import 'package:dart_pb_extensions_common/js.dart';

import 'package:dart_pb_extensions_common/src/paperback/models/request.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/response.dart';

class RequestInterceptor {
  RequestInterceptor({
    this.interceptRequest,
    this.interceptResponse,
  });

  /// This method is invoked asynchronously
  ///
  /// Arguments:
  /// - [request]: The intercepted request
  Future<Request> Function(Request request)? interceptRequest;

  /// While this method can be marked async, you should not
  /// do any long running/blocking tasks here. The underlying swift
  /// implementation does not run asynchronously and blocks the
  /// thread it was invoked on
  ///
  /// You *cannot* modify anything other than the data in a Response
  ///
  /// Arguments:
  /// - [response]: The intercepted response
  Future<Response> Function(Response response)? interceptResponse;
}

class RequestInterceptorFutureToPromise implements JsRequestInterceptor {
  final RequestInterceptor requestInterceptor;

  RequestInterceptorFutureToPromise(this.requestInterceptor);

  @override
  Promise<Request>? interceptRequest(Request request) =>
      requestInterceptor.interceptRequest?.call(request).toPromise();

  @override
  Promise<Response>? interceptResponse(Response response) =>
      requestInterceptor.interceptResponse?.call(response).toPromise();
}

@JS()
@anonymous
class JsRequestInterceptor {
  external Promise<Request>? interceptRequest(Request request);

  external Promise<Response>? interceptResponse(Response response);

  external factory JsRequestInterceptor({
    Promise<Request> Function(Request request)? interceptRequest,
    Promise<Response> Function(Response response)? interceptResponse,
  });
}
