import 'package:js/js.dart';

import '../../js.dart';
import 'request.dart';
import 'response.dart';

@JS()
class RequestInterceptor {
  /// This method is invoked asynchronously
  /// 
  /// Arguments:
  /// - [request]: The intercepted request
  external Promise<Request> interceptRequest(Request request);

  /// While this method can be marked async, you should not
  /// do any long running/blocking tasks here. The underlying swift
  /// implementation does not run asynchronously and blocks the 
  /// thread it was invoked on
  /// 
  /// You *cannot* modify anything other than the data in a Response
  /// 
  /// Arguments:
  /// - [response]: The intercepted response
  external Promise<Response> interceptResponse(Response response);
}