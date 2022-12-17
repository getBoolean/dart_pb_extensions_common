import 'dart:js' show context;

import 'package:dart_pb_extensions_common/src/paperback/base/registerable.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/source.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/source_info.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

const kCliPrefix = '\$SourceId\$';

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the global [context] so that it can be used by the
/// Paperback app.
Object Function() register<T extends Registerable>({
  required String id,
  required Registerable Function() creator,
  required SourceInfo info,
}) {
  final jsObject = allowInterop(
    () => creator().register(),
  );

  context[kCliPrefix] = id;
  context[id] = jsObject;
  context['${id}Info'] = jsify(info.toMap());
  return jsObject;
}
