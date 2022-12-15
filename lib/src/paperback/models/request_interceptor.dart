import 'package:dart_pb_extensions_common/js.dart';

import 'request.dart';
import 'response.dart';

class RequestInterceptor {
  late RequestInterceptorFutureToPromise jsRequestInterceptor;

  RequestInterceptor({
    this.interceptRequest,
    this.interceptResponse,
  }) : jsRequestInterceptor = RequestInterceptorFutureToPromise(
          interceptsRequest: interceptRequest,
          interceptsResponse: interceptResponse,
        );

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
  RequestInterceptorFutureToPromise({
    this.interceptsRequest,
    this.interceptsResponse,
  });

  /// This method is invoked asynchronously
  ///
  /// Arguments:
  /// - [request]: The intercepted request
  Future<Request> Function(Request request)? interceptsRequest;

  /// While this method can be marked async, you should not
  /// do any long running/blocking tasks here. The underlying swift
  /// implementation does not run asynchronously and blocks the
  /// thread it was invoked on
  ///
  /// You *cannot* modify anything other than the data in a Response
  ///
  /// Arguments:
  /// - [response]: The intercepted response
  Future<Response> Function(Response response)? interceptsResponse;

  @override
  Promise<Request>? interceptRequest(Request request) =>
      interceptsRequest?.call(request).toPromise();

  @override
  Promise<Response>? interceptResponse(Response response) =>
      interceptsResponse?.call(response).toPromise();
}

@JS()
@anonymous
class JsRequestInterceptor {
  /// This method is invoked asynchronously
  ///
  /// Arguments:
  /// - [request]: The intercepted request
  external Promise<Request>? interceptRequest(Request request);

  /// While this method can be marked async, you should not
  /// do any long running/blocking tasks here. The underlying swift
  /// implementation does not run asynchronously and blocks the
  /// thread it was invoked on
  ///
  /// You *cannot* modify anything other than the data in a Response
  ///
  /// Arguments:
  /// - [response]: The intercepted response
  external Promise<Response>? interceptResponse(Response response);

  external factory JsRequestInterceptor({
    Promise<Request> Function(Request request)? interceptRequest,
    Promise<Response> Function(Response response)? interceptResponse,
  });
}
