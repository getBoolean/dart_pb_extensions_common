import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:js/js.dart';

@JS()
class Chapter {
  /// A given identifier of this chapter. This may be unique to the source.
  /// For example, one source may use 'Chapter-1' in it's URLs to identify this chapter,
  /// whereas other sources may use some numeric identifier
  external String get id;

  /// The given identifier of the Manga that owns this chapter. This may be unique to the source
  /// which uses it. For example, one source may use the value '1234' to
  /// identify a manga, whereas another one may use the value 'One-Piece' to identify
  external String get mangaId;

  /// An identifier of which chapter number this is, in a given [MangaInfo]
  external num get chapNum;

  /// The language code which this chapter is associated with.
  /// This allows the application to filter by language
  ///
  /// The enum [LanguageCode] contains a list of some common language codes
  external String get langCode;

  /// The title of this chapter, if one exists
  external String get name;

  /// The volume number that this chapter belongs in, if one exists
  external num get volume;

  /// A grouping of chapters that this belongs to
  external String get group;

  /// The [Date] in which this chapter was released
  external Date get time;

  /// Creates a new chapter
  ///
  /// Arguments:
  /// - [id]: A given identifier of this chapter. This may be unique to the source.
  /// For example, one source may use 'Chapter-1' in it's URLs to identify this chapter,
  /// whereas other sources may use some numeric identifier
  /// - [mangaId]: The given identifier of the Manga that owns this chapter. This may be unique to the source
  /// which uses it. For example, one source may use the value '1234' to
  /// identify a manga, whereas another one may use the value 'One-Piece' to identify
  /// - [chapNum]: An identifier of which chapter number this is, in a given [MangaInfo]
  /// - [langCode]: The language code which this chapter is associated with.
  /// This allows the application to filter by language
  /// - [name]: The title of this chapter, if one exists
  /// - [volume]: The volume number that this chapter belongs in, if one exists
  /// - [group]: A grouping of chapters that this belongs to
  /// - [time]: The [JSDate] in which this chapter was released
  factory Chapter({
    required String id,
    required String mangaId,
    required num chapNum,
    required String langCode,
    required String name,
    required num volume,
    required String group,
    required Date time,
  }) =>
      _createChapter(_CreateChapterOptions(
        id: id,
        mangaId: mangaId,
        chapNum: chapNum,
        langCode: langCode,
        name: name,
        volume: volume,
        group: group,
        time: time,
      ));
}

@JS()
@anonymous
class _CreateChapterOptions {
  external String get id;
  external String get mangaId;
  external num get chapNum;
  external String get langCode;
  external String get name;
  external num get volume;
  external String get group;
  external Date get time;

  external factory _CreateChapterOptions({
    String id,
    String mangaId,
    num chapNum,
    String langCode,
    String name,
    num volume,
    String group,
    Date time,
  });
}

@JS('createChapter')
external Chapter _createChapter(_CreateChapterOptions options);
