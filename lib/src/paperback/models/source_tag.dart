part of '../paperback.dart';

@JS()
class SourceTag {
  external String get text;

  /// An enumerator which [SourceTag] uses to define the color of the tag rendered on the website.
  /// Five types are available: blue, green, grey, yellow and red, the default one is blue.
  /// Common colors are red for (Broken), yellow for (+18), grey for (Country-Proof)
  ///
  /// Use [TagType] to define the type of the tag
  external String get type;
}

/// An enumerator which [SourceTag] uses to define the color of the tag rendered on the website.
/// Five types are available: blue, green, grey, yellow and red, the default one is blue.
/// Common colors are red for (Broken), yellow for (+18), grey for (Country-Proof)
enum TagType {
  blue('default'),
  green('success'),
  grey('info'),
  yellow('warning'),
  red('danger');

  final String usage;

  const TagType(this.usage);

  @override
  String toString() => usage;
}
