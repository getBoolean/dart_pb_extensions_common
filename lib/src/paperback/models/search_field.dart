part of '../paperback.dart';

@JS()
class SearchField {
  external String get id;
  external String get placeholder;
  external String get name;

  factory SearchField({
    required String id,
    required String placeholder,
    required String name,
  }) =>
      _createSearchField(
        _CreateSearchFieldOptions(
          id: id,
          placeholder: placeholder,
          name: name,
        ),
      );
}

@JS()
@anonymous
class _CreateSearchFieldOptions {
  external String get id;
  external String get placeholder;
  external String get name;

  external factory _CreateSearchFieldOptions({
    required String id,
    required String placeholder,
    required String name,
  });
}

@JS('createSearchField')
external SearchField _createSearchField(_CreateSearchFieldOptions options);
