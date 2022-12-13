import 'package:js/js.dart';

import '../../js.dart';

@JS()
abstract class SourceStateManagerInfo {}

@JS()
class SourceStateManager extends SourceStateManagerInfo {
  external Promise<void> Function(String key, Object value) get store;
  external Promise<Object?> Function(String key) get retrieve;
  external SourceKeychain get keychain;

  factory SourceStateManager({
    required Promise<void> Function(String key, Object value) store,
    required Promise<Object?> Function(String key) retrieve,
    required SourceKeychain keychain,
  }) =>
      _createSourceStateManager(
        _CreateSourceStateManagerInfo(
          store: store,
          retrieve: retrieve,
          keychain: keychain,
        ),
      );
}

@JS()
class SourceKeychain {
  external Promise<void> store(String key, Object value);
  external Promise<Object?> retrieve(String key);
}

@JS()
@anonymous
class _CreateSourceStateManagerInfo {
  external Promise<void> Function(String key, Object value) get store;
  external Promise<Object?> Function(String key) get retrieve;
  external SourceKeychain get keychain;

  external factory _CreateSourceStateManagerInfo({
    required Promise<void> Function(String key, Object value) store,
    required Promise<Object?> Function(String key) retrieve,
    required SourceKeychain keychain,
  });
}

@JS('createSourceStateManager')
external SourceStateManager _createSourceStateManager(
  _CreateSourceStateManagerInfo info,
);
