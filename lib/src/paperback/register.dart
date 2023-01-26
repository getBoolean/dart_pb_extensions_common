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

typedef RegisterableCreator = Registerable Function();

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the global [context] so that it can be used by the
/// Paperback app.
void register<T extends Registerable>(
  Map<String, Tuple<SourceInfo, RegisterableCreator>> registerables,
) {
  for (final entry in registerables.entries) {
    final String id = entry.key;
    final SourceInfo info = entry.value.first;
    final RegisterableCreator extensionCreator = entry.value.second;
    final sourceExtensionJsClass = allowInterop(() => extensionCreator().register());

    context['Sources.$kCliPrefix'] = id;
    context['Sources.${id}Info'] = JsObject.jsify(info.toMap());
    context['Sources.$id'] = sourceExtensionJsClass;
  }
}
