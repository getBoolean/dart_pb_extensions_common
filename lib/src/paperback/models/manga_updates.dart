part of '../paperback.dart';

@JS()
class MangaUpdates {
  external List<String> get ids;

  factory MangaUpdates({
    required List<String> ids,
  }) =>
      _createMangaUpdates(_CreateMangaUpdatesOptions(
        ids: ids,
      ));
}

@JS()
@anonymous
class _CreateMangaUpdatesOptions {
  external List<String> get ids;

  external factory _CreateMangaUpdatesOptions({
    required List<String> ids,
  });
}

@JS('createMangaUpdates')
external MangaUpdates _createMangaUpdates(_CreateMangaUpdatesOptions options);
