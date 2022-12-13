part of '../paperback.dart';

@JS('Manga')
class MangaInfo {
  /// A list of titles which this Manga is called.
  /// There may be secondary titles, which can be pushed to this variable
  external List<String> get titles;

  /// A URL pointing to a thumbnail which can be displayed to present the manga
  external String get image;

  /// The rating which users have given this manga
  external num? get rating;

  /// A status code for this manga. This is likely different each source.
  /// For example, a zero might mean that it is unreleased. A one may mean it is ongoing. etc.
  ///
  /// It is recommended to use the [MangaStatus] enum to check/set the status of this manga.
  external num get status;

  /// A language code for the Manga, if one is available.
  /// Examples: en is English, jp is Japanese, etc
  ///
  /// For common language codes, [LanguageCode] can be used for convenience.
  external String? get langFlag;

  /// The name of the artist who has worked on this manga
  external String? get artist;

  /// The author which has written this manga
  external String? get author;

  /// If the manga has additional pictures past the title thumbnail, covers may be used
  /// to display other pieces of art.
  ///
  /// The contents of this array should be URLs to the images
  external List<String>? get covers;

  /// A description of this manga, if available
  external String? get desc;

  /// The number of followers on the source, which follow this manga
  external num? get follows;

  /// A list of [TagSection], tags, which this Manga has
  external List<TagSection>? get tags;

  /// How many views has this manga had up to date
  external num? views;

  /// Is this manga Hentai?
  external bool? get hentai;

  /// Any manga IDs which are related to this entry.
  /// See [MangaInfo.id] for additional information as to what
  /// this should hold
  external List<String>? get relatedIds;

  /// The time which this manga has been updated last
  external Date get lastUpdate;

  /// Create a new MangaInfo object
  ///
  /// Arguments:
  /// - [titles]: A list of titles which this Manga is called.
  /// There may be secondary titles, which can be pushed to this variable
  /// - [image]: A URL pointing to a thumbnail which can be displayed to present the manga
  /// - [rating]: The rating which users have given this manga
  /// - [status]: A status code for this manga. This is likely different each source.
  /// For example, a zero might mean that it is unreleased. A one may mean it is ongoing. etc.
  /// It is recommended to use the [MangaStatus] enum to check/set the status of this manga.
  /// - [langFlag]: A language code for the Manga, if one is available.
  /// Examples: en is English, jp is Japanese, etc.
  /// For common language codes, [LanguageCode] can be used for convenience.
  /// - [artist]: The name of the artist who has worked on this manga
  /// - [author]: The author which has written this manga
  /// - [covers]: If the manga has additional pictures past the title thumbnail, covers may be used
  /// to display other pieces of art. The contents of this array should be URLs to the images
  /// - [desc]: A description of this manga, if available
  /// - [follows]: The number of followers on the source, which follow this manga
  /// - [tags]: A list of [TagSection], tags, which this Manga has
  /// - [views]: How many views has this manga had up to date
  /// - [hentai]: Is this manga Hentai?
  /// - [relatedIds]: Any manga IDs which are related to this entry.
  /// See [MangaInfo.id] for additional information as to what
  /// this should hold
  /// - [lastUpdate]: The time which this manga has been updated last
  factory MangaInfo({
    required List<String> titles,
    required String image,
    num? rating,
    required MangaStatus status,
    String? langFlag,
    String? artist,
    String? author,
    List<String>? covers,
    String? desc,
    num? follows,
    List<TagSection>? tags,
    num? views,
    bool? hentai,
    List<String>? relatedIds,
    required Date lastUpdate,
  }) =>
      _createMangaInfo(_CreateMangaInfoOptions(
        titles: titles,
        image: image,
        rating: rating,
        status: status.value,
        langFlag: langFlag,
        artist: artist,
        author: author,
        covers: covers,
        desc: desc,
        follows: follows,
        tags: tags,
        views: views,
        hentai: hentai,
        relatedIds: relatedIds,
        lastUpdate: lastUpdate,
      ));
}

enum MangaStatus {
  ongoing(1),
  completed(0),
  unknown(2),
  abandoned(3),
  hiatus(4);

  final num value;

  const MangaStatus(this.value);

  @override
  String toString() => value.toString();
}

@JS()
@anonymous
class _CreateMangaInfoOptions {
  external List<String> get titles;
  external String get image;
  external num? get rating;
  external num get status;
  external String? get langFlag;
  external String? get artist;
  external String? get author;
  external List<String>? get covers;
  external String? get desc;
  external num? get follows;
  external List<TagSection>? get tags;
  external num? views;
  external bool? get hentai;
  external List<String>? get relatedIds;
  external Date get lastUpdate;

  external factory _CreateMangaInfoOptions({
    required List<String> titles,
    required String image,
    num? rating,
    required num status,
    String? langFlag,
    String? artist,
    String? author,
    List<String>? covers,
    String? desc,
    num? follows,
    List<TagSection>? tags,
    num? views,
    bool? hentai,
    List<String>? relatedIds,
    required Date lastUpdate,
  });
}

@JS()
external MangaInfo _createMangaInfo(_CreateMangaInfoOptions options);
