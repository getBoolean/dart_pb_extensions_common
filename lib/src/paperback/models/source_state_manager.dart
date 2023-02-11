import 'package:dart_pb_extensions_common/src/js/js_promise.dart';
import 'package:js/js.dart';

class SourceStateManager {
  final JsSourceStateManager jsSourceStateManager = JsSourceStateManager();

  Future<void> store(String key, Object value) =>
      jsSourceStateManager.store.call(key, value).toFuture();

  Future<Object?> retrieve(String key) =>
      jsSourceStateManager.retrieve.call(key).toFuture();

  SourceKeychain get keychain => SourceKeychain(jsSourceStateManager.keychain);
}

class SourceKeychain {
  final JsSourceKeychain jsSourceKeychain;

  SourceKeychain(this.jsSourceKeychain);

  Future<void> store(String key, Object value) =>
      jsSourceKeychain.store.call(key, value).toFuture();

  Future<Object?> retrieve(String key) =>
      jsSourceKeychain.retrieve.call(key).toFuture();
}

@JS()
abstract class SourceStateManagerInfo {}

@JS('SourceStateManager')
class JsSourceStateManager extends SourceStateManagerInfo {
  external Promise<void> Function(String key, Object value) get store;
  external Promise<Object?> Function(String key) get retrieve;
  external JsSourceKeychain get keychain;

  factory JsSourceStateManager() =>
      _createSourceStateManager(_CreateSourceStateManagerInfo());
}

@JS('SourceKeychain')
class JsSourceKeychain {
  external Promise<void> store(String key, Object value);
  external Promise<Object?> retrieve(String key);
}

@JS()
@anonymous
class _CreateSourceStateManagerInfo {
  external factory _CreateSourceStateManagerInfo();
}

@JS('createSourceStateManager')
external JsSourceStateManager _createSourceStateManager(
  _CreateSourceStateManagerInfo info,
);
