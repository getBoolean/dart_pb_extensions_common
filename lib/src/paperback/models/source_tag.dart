import 'package:js/js.dart';

@JS()
@anonymous
class SourceTag {
  external String get text;

  /// An enumerator which [SourceTag] uses to define the color of the tag rendered on the website.
  /// Five types are available: blue, green, grey, yellow and red, the default one is blue.
  /// Common colors are red for (Broken), yellow for (+18), grey for (Country-Proof)
  ///
  /// Use [TagType] to define the type of the tag
  external String get type;

  external factory SourceTag({required String text, required TagType type});
}

/// An enumerator which [SourceTag] uses to define the color of the tag rendered on the website.
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
