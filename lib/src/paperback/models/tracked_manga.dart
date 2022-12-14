import 'package:dart_pb_extensions_common/src/paperback/models/manga_info.dart';
import 'package:js/js.dart';

@JS()
class TrackedManga {
  external String get id;
  external MangaInfo get mangaInfo;

  factory TrackedManga({
    required String id,
    required MangaInfo mangaInfo,
  }) =>
      _createTrackedManga(_CreateTrackedMangaOptions(
        id: id,
        mangaInfo: mangaInfo,
      ));
}

@JS()
@anonymous
class _CreateTrackedMangaOptions {
  external String get id;
  external MangaInfo get mangaInfo;

  external factory _CreateTrackedMangaOptions({
    required String id,
    required MangaInfo mangaInfo,
  });
}

@JS('createTrackedManga')
external TrackedManga _createTrackedManga(_CreateTrackedMangaOptions options);
