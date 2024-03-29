import 'dart:js' show JsObject, context;

import 'package:dart_pb_extensions_common/js.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/registerable.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/source.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/source_info.dart';

const kCliPrefix = '\$SourceId\$';

class Tuple<K, V> {
  final K first;
  final V second;

  const Tuple(this.first, this.second);
}

typedef RegisterableCreator<T extends Registerable> = T Function();

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the global [context] so that it can be used by the
/// Paperback app.
void register<T extends Registerable>({
  required String id,
  required SourceInfo info,
  required RegisterableCreator<T> creator,
}) {
  context['self'] ??= context['window'] ??= context['global'] ??= context;
  final sourceExtensionJsClass =
      allowInteropCaptureThis(() => creator().register());

  final sourcesObj = JsObject.jsify({
    kCliPrefix: id,
    '${id}Info': JsObject.jsify(info.toMap()),
    id: sourceExtensionJsClass,
  });

  context['Sources'] = sourcesObj;
}
