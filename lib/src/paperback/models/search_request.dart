part of '../paperback.dart';

/// The [SearchRequest] interface is a list of optional queries, which
/// can be packed together into a search request.
/// Everything is optional, allowing users flexibility to make a search however they
/// desire. As a Source developer, you should ensure that as many of these fields are handled
/// as fine searching is an important user feature.
@JS()
class SearchRequest {
  /// The title of the search request. This usually is the plaintext query you are
  /// making as a user
  external String? get title;
  external List<Tag>? get includedTags;
  external List<Tag>? get excludedTags;

  /// Use [SearchOperator] to define the operator for the included tags
  external String? includeOperator;

  /// Use [SearchOperator] to define the operator for the excluded tags
  external String? excludeOperator;

  /// This is basically anything other than tags that the user enters such as:
  /// `author: ShindoL author: Miyazuki`
  /// where `author` would be the key and `ShindoL`, `Myazuki` would be the values.
  external Record<String, List<String>> get parameters;
}

enum SearchOperator {
  and('AND'),
  or('OR');

  final String _value;

  const SearchOperator(this._value);

  @override
  String toString() => _value;
}
