// ignore_for_file: unnecessary_lambdas

import 'dart:async';

import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:js/js.dart';

/// Creates Dart `Future` which completes when [promise] is resolved or
/// rejected.
///
/// See also:
///   - [futureToPromise]
Future<T> promiseToFuture<T>(Promise<T> promise) {
  final completer = Completer<T>.sync();
  promise.then(
    allowInterop((value) => completer.complete(value)),
    allowInterop((error) => completer.completeError(error)),
  );
  return completer.future;
}

/// Creates JS [Promise] which is resolved when [future] completes.
///
/// See also:
/// - [promiseToFuture]
Promise<T> futureToPromise<T>(Future<T> future) {
  return Promise<T>(allowInterop((Function resolve, Function reject) {
    future.then((result) => resolve(result), onError: reject);
  }));
}

extension FutureToPromiseExtension<T> on Future<T> {
  Promise<T> toPromise() => futureToPromise<T>(this);
}
