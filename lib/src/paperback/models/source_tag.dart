import 'package:dart_pb_extensions_common/js.dart';
import 'package:js/js.dart';

class SourceTag {
  late final JsSourceTag jsService;
  final String text;

  /// An enumerator which [SourceTag] uses to define the color of the tag rendered on the website.
  /// Five types are available: blue, green, grey, yellow and red, the default one is blue.
  /// Common colors are red for (Broken), yellow for (+18), grey for (Country-Proof)
  final TagType type;

  SourceTag({required this.text, required this.type})
      : jsService = JsSourceTag(text: text, type: type.value);

  Map<String, dynamic> toMap() => {
        'text': text,
        'type': type.value,
      };
}

@JS()
@anonymous
class JsSourceTag {
  external String get text;

  /// An enumerator which [JsSourceTag] uses to define the color of the tag rendered on the website.
  /// Five types are available: blue, green, grey, yellow and red, the default one is blue.
  /// Common colors are red for (Broken), yellow for (+18), grey for (Country-Proof)
  ///
  /// Use [TagType] to define the type of the tag
  external String get type;

  external factory JsSourceTag({required String text, required String type});
}

/// An enumerator which [JsSourceTag] uses to define the color of the tag rendered on the website.
/// Five types are available: blue, green, grey, yellow and red, the default one is blue.
/// Common colors are red for (Broken), yellow for (+18), grey for (Country-Proof)
enum TagType {
  /// default
  blue('default'),

  /// success
  green('success'),

  /// info
  grey('info'),

  /// warning
  yellow('warning'),

  /// danger
  red('danger');

  final String value;

  const TagType(this.value);

  @override
  String toString() => value;
}
