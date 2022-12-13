part of '../paperback.dart';

@JS()
class SourceManga {
  external String get id;
  external MangaInfo get mangaInfo;

  factory SourceManga({
    required String id,
    required MangaInfo mangaInfo,
  }) =>
      _createSourceManga(_CreateSourceMangaOptions(id: id, mangaInfo: mangaInfo));
}

@JS()
@anonymous
class _CreateSourceMangaOptions {
  external String get id;
  external MangaInfo get mangaInfo;

  external factory _CreateSourceMangaOptions({
    String id,
    MangaInfo mangaInfo,
  });
}

@JS('createSourceManga')
external SourceManga _createSourceManga(_CreateSourceMangaOptions options);
