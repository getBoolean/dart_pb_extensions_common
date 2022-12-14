@JS()
library dart_pb_extensions_common;

export 'package:html/parser.dart' show parse;
export 'package:html/dom.dart';
export 'src/utils.dart';
export 'src/js.dart';
export 'src/paperback.dart';

import 'package:js/js.dart';

/// Allows assigning a function to be callable from `window.functionName()`
@JS('functionName')
external set _functionName(void Function() f);

/// Allows calling the assigned function from Dart as well.
@JS()
external void functionName();

void _someDartFunction() {
  print('Hello from Dart!');
}

void main() {
  _functionName = allowInterop(_someDartFunction);
  // JavaScript code may now call `functionName()` or `window.functionName()`.
}
