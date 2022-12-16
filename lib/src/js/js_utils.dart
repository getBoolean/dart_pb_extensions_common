// Copyright 2017 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

library dart_pb_extensions_common.utils;

import 'dart:typed_data';

import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('Object.keys')
external List<String> _keys(Object? object);

/// Invokes [callback] for each key/value pair in [object].
void jsForEach(Object object, void Function(String key, Object? value) callback) {
  for (var key in _keys(object)) {
    callback(key, getProperty(object, key));
  }
}

@JS('Object.defineProperty')
external void _defineProperty(Object object, String name, _PropertyDescriptor prototype);

@JS()
@anonymous
class _PropertyDescriptor {
  external Object get value;
  external Function get get;
  external bool get enumerable;

  external factory _PropertyDescriptor({Object? value, Function? get, bool? enumerable});
}

/// Defines a JS getter on [object] named [name].
///
/// If [get] is passed, the getter invokes it with a `self` argument. Otherwise,
/// the getter just returns [value].
void defineGetter(Object object, String name, {Object? value, Function? get}) {
  _defineProperty(
      object,
      name,
      get == null
          ? _PropertyDescriptor(value: value, enumerable: false)
          : _PropertyDescriptor(get: allowInteropCaptureThis(get), enumerable: false));
}

/// Like [allowInterop], but gives the function a [name] so it's more ergonomic
/// when debugging.
T allowInteropNamed<T extends Function>(String name, T function) {
  function = allowInterop(function);
  defineGetter(function, 'name', value: name);
  _hideDartProperties(function);
  return function;
}

/// Like [allowInteropCaptureThis], but gives the function a [name] so it's more
/// ergonomic when debugging.
Function allowInteropCaptureThisNamed(String name, Function function) {
  function = allowInteropCaptureThis(function);
  defineGetter(function, 'name', value: name);
  _hideDartProperties(function);
  return function;
}

@JS('Object.getOwnPropertyNames')
external List<Object?> _getOwnPropertyNames(Object object);

/// Hide Dart-internal properties on [object].
///
/// Dart sometimes adds weird properties to objects that show up in
/// `utils.inspect()` or `console.log()`. This hides them by marking them as
/// non-enumerable.
void _hideDartProperties(Object object) {
  for (var name in _getOwnPropertyNames(object).cast<String>()) {
    if (name.startsWith('_')) {
      defineGetter(object, name, value: getProperty(object, name));
    }
  }
}

/// Returns whether [value] is truthy according to JavaScript.
bool isTruthy(Object? value) => value != false && value != null;

@JS('Buffer.from')
external Uint8List _buffer(String text, String encoding);

/// Encodes [text] as a UTF-8 byte buffer.
///
/// We could do this using Dart's native UTF-8 support, but it's much less
/// efficient in Node.
Uint8List utf8Encode(String text) => _buffer(text, 'utf8');

/// Converts a JavaScript record into a map from property names to their values.
Map<String, Object?> objectToMap(Object object) {
  final map = <String, Object?>{};
  jsForEach(object, (key, value) => map[key] = value);
  return map;
}
