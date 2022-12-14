import 'package:js/js.dart';

import 'source_tag.dart';

class SourceInfo {
  late final JsSourceInfo jsSourceInfo;

  SourceInfo({
    required this.version,
    required this.name,
    required this.icon,
    required this.author,
    required this.description,
    required this.contentRating,
    required this.websiteBaseURL,
    this.authorWebsite,
    this.language,
    this.sourceTags,
  }) : jsSourceInfo = JsSourceInfo(
          version: version,
          name: name,
          icon: icon,
          author: author,
          description: description,
          contentRating: contentRating.value,
          websiteBaseURL: websiteBaseURL,
          authorWebsite: authorWebsite,
          language: language,
          sourceTags: sourceTags?.map((tag) => tag.toMap()).toList(),
        );

  /// Required class variable which denotes the current version of the application.
  /// This is what the application uses to determine whether it needs to update it's local
  /// version of the source, to a new version on the repository
  final String version;

  /// The title of this source, this is what will show up in the application
  /// to identify what Manga location is being targeted
  final String name;

  /// An INTERNAL reference to an icon which is associated with this source.
  /// This Icon should ideally be a matching aspect ratio (a cube)
  /// The location of this should be in an includes directory next to your source.
  /// For example, the MangaPark link sits at: sources/MangaPark/includes/icon.png
  /// This [SourceInfo.icon] field would then be simply referenced as 'icon.png' and
  /// the path will then resolve correctly internally
  final String icon;

  /// The author of this source. The string here will be shown off to the public on the application
  /// interface, so only write what you're comfortable with showing
  final String author;

  /// A brief description of what this source targets. This is additional content displayed to the user when browsing sources.
  ///
  /// What website does it target? What features are working? Etc.
  final String description;

  /// A content rating attributed to each source. This can be one of three values, and should be set appropriately.
  /// - Everyone: This source does not have any sort of adult content available. Each title within is assumed safe for all audiences
  /// - Mature: This source MAY have mature content inside of it. Even if most content is safe, mature should be selected even if a small subset applies
  /// - Adult: This source probably has straight
  ///
  /// This rating helps us filter your source to users who have the necessary visibility rules toggled for their profile.
  /// Naturally, only 'Everyone' sources will show up for users without an account, or without any mode toggles changed.
  final ContentRating contentRating;

  /// A required field which points to the source's front-page. This must be a fully qualified URL,
  /// eg. https://mangadex.org
  final String websiteBaseURL;

  /// An optional field where the author may put a link to their website
  final String? authorWebsite;

  /// An optional field that defines the language of the extension's source
  final String? language;

  /// An optional field of source tags: Little bits of metadata which is rendered on the website
  /// under your repositories section
  final List<SourceTag>? sourceTags;

  Map<String, dynamic> toMap() => {
        'version': jsSourceInfo.version,
        'name': jsSourceInfo.name,
        'icon': jsSourceInfo.icon,
        'author': jsSourceInfo.author,
        'description': jsSourceInfo.description,
        'contentRating': jsSourceInfo.contentRating,
        'websiteBaseURL': jsSourceInfo.websiteBaseURL,
        'authorWebsite': jsSourceInfo.authorWebsite,
        'language': jsSourceInfo.language,
        'sourceTags': jsSourceInfo.sourceTags,
      };
}

@JS('SourceInfo')
@anonymous
class JsSourceInfo {
  /// Required class variable which denotes the current version of the application.
  /// This is what the application uses to determine whether it needs to update it's local
  /// version of the source, to a new version on the repository
  external String get version;

  /// The title of this source, this is what will show up in the application
  /// to identify what Manga location is being targeted
  external String get name;

  /// An INTERNAL reference to an icon which is associated with this source.
  /// This Icon should ideally be a matching aspect ratio (a cube)
  /// The location of this should be in an includes directory next to your source.
  /// For example, the MangaPark link sits at: sources/MangaPark/includes/icon.png
  /// This [JsSourceInfo.icon] field would then be simply referenced as 'icon.png' and
  /// the path will then resolve correctly internally
  external String get icon;

  /// The author of this source. The string here will be shown off to the public on the application
  /// interface, so only write what you're comfortable with showing
  external String get author;

  /// A brief description of what this source targets. This is additional content displayed to the user when browsing sources.
  ///
  /// What website does it target? What features are working? Etc.
  external String get description;

  /// A content rating attributed to each source. This can be one of three values, and should be set appropriately.
  /// - Everyone: This source does not have any sort of adult content available. Each title within is assumed safe for all audiences
  /// - Mature: This source MAY have mature content inside of it. Even if most content is safe, mature should be selected even if a small subset applies
  /// - Adult: This source probably has straight
  ///
  /// This rating helps us filter your source to users who have the necessary visibility rules toggled for their profile.
  /// Naturally, only 'Everyone' sources will show up for users without an account, or without any mode toggles changed.
  external String get contentRating;

  /// A required field which points to the source's front-page. This must be a fully qualified URL,
  /// eg. https://mangadex.org
  external String get websiteBaseURL;

  /// An optional field where the author may put a link to their website
  external String? get authorWebsite;

  /// An optional field that defines the language of the extension's source
  external String? get language;

  /// An optional field of source tags: Little bits of metadata which is rendered on the website
  /// under your repositories section
  external List<Map<String, dynamic>>? get sourceTags;

  external factory JsSourceInfo({
    required String version,
    required String name,
    required String icon,
    required String author,
    required String description,
    required String contentRating,
    required String websiteBaseURL,
    String? authorWebsite,
    String? language,
    List<Map<String, dynamic>>? sourceTags,
  });
}

/// A content rating to be attributed to each source.
enum ContentRating {
  everyone("EVERYONE"),
  mature("MATURE"),
  adult("ADULT");

  final String value;

  const ContentRating(this.value);

  @override
  String toString() => value;
}
