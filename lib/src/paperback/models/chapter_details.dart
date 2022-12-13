part of '../paperback.dart';

@JS()
class ChapterDetails {
  /// The chapter identifier which this source uses. This may be unique to the source.
  /// For example, one source may use 'Chapter-1' in it's URLs to identify this chapter,
  /// whereas other sources may use some numeric identifier
  external String get id;

  /// The given identifier of the Manga that owns this chapter. This may be unique to the source
  /// which uses it. For example, one source may use the value '1234' to
  /// identify a manga, whereas another one may use the value 'One-Piece' to identify
  external String get mangaId;

  /// A list of page URLs which directly reference the image on the page.
  /// These are what the application renders when the chapter is pulled up
  ///
  /// Example: http://yoursource.com/manga/mangaPage.jpg
  external List<String> get pages;

  /// A mode flag. Should this manga be rendered in longStrip mode?
  external bool get longStrip;

  /// Creates a new chapter details object
  ///
  /// Arguments:
  /// - [id]: The chapter identifier which this source uses. This may be unique to the source.
  /// For example, one source may use 'Chapter-1' in it's URLs to identify this chapter,
  /// whereas other sources may use some numeric identifier
  /// - [mangaId]: The given identifier of the Manga that owns this chapter. This may be unique to the source
  /// which uses it. For example, one source may use the value '1234' to
  /// identify a manga, whereas another one may use the value 'One-Piece' to identify
  /// - [pages]: A list of page URLs which directly reference the image on the page.
  /// These are what the application renders when the chapter is pulled up.
  ///    - Example: http://yoursource.com/manga/mangaPage.jpg
  /// - [longStrip]: A mode flag. Should this manga be rendered in longStrip mode?
  factory ChapterDetails({
    required String id,
    required String mangaId,
    required List<String> pages,
    required bool longStrip,
  }) =>
      _createChapterDetails(
        _CreateChapterDetailsOptions(
          id: id,
          mangaId: mangaId,
          pages: pages,
          longStrip: longStrip,
        ),
      );
}

@JS()
@anonymous
class _CreateChapterDetailsOptions {
  external String get id;
  external String get mangaId;
  external List<String> get pages;
  external bool get longStrip;

  external factory _CreateChapterDetailsOptions({
    String id,
    String mangaId,
    List<String> pages,
    bool longStrip,
  });
}

@JS('createChapterDetails')
external ChapterDetails _createChapterDetails(
  _CreateChapterDetailsOptions options,
);
