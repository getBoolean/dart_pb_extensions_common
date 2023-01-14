import 'dart:js' show JsObject, context;

import 'package:dart_pb_extensions_common/src/paperback/base/registerable.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/source.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/source_info.dart';
import 'package:js/js.dart';

const kCliPrefix = '\$SourceId\$';

class Tuple<K, V> {
  final K first;
  final V second;

  const Tuple(this.first, this.second);
}

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the global [context] so that it can be used by the
/// Paperback app.
JsObject register<T extends Registerable>(
  Map<String, Tuple<SourceInfo, Registerable Function()>> registerables,
) {
  final sourceJsClass = JsObject.jsify(
      registerables.entries.fold<Map<String, Object>>({}, (previousSourceMap, entry) {
    final id = entry.key;
    final info = entry.value.first;
    final extensionCreator = entry.value.second;
    final sourceExtensionJsClass = allowInterop(
      () => extensionCreator().register(),
    );

    return previousSourceMap
      ..addAll({
        // TODO: Find another way to get the source id. This might break if multiple sources are bundled
        kCliPrefix: id,
        '${id}Info': JsObject.jsify(info.toMap()),
        id: sourceExtensionJsClass,
      });
  }));

  context['Sources'] = sourceJsClass;

  return sourceJsClass;
}
