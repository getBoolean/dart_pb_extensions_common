// ignore_for_file: unnecessary_lambdas

import 'dart:async';

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

extension PromiseToFutureExtension<T> on Promise<T> {
  Future<T> toFuture() => promiseToFuture<T>(this);
}

@JS()
class Promise<T> {
  external factory Promise(
    void Function(
      dynamic Function(dynamic value) resolve,
      dynamic Function(dynamic error) reject,
    )
        executor,
  );

  external Promise then(
    void Function(T value)? onFulfilled, [
    void Function(dynamic error) onRejected,
  ]);

  factory Promise.of(FutureOr<T> future) =>
      futureToPromise(Future.value(future));
}
