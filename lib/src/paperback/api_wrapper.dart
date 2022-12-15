import 'package:dart_pb_extensions_common/src/js/js.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/source.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/chapter.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/chapter_details.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/home_section.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/manga_info.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/manga_tile.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/manga_updates.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/paged_results.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/search_request.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/tag_section.dart';
import 'package:js/js.dart';

@JS()
class APIWrapper {
  external Promise<MangaInfo> getMangaDetails(JsSource source, String mangaId);

  external Promise<List<Chapter>> getChapters(JsSource source, String mangaId);

  external Promise<ChapterDetails> getChapterDetails(
    JsSource source,
    String mangaId,
    String chapterId,
  );

  external Promise<PagedResults> searchRequest(
    JsSource source,
    SearchRequest query,
    Object? metadata,
  );

  external Promise<List<TagSection>?> getTags(JsSource source);

  external Promise<List<MangaUpdates>> filterUpdatedManga(
    JsSource source,
    Date time,
    List<String> ids,
  );

  external Promise<List<HomeSection>> getHomePageSections(JsSource source);

  /// Performs a 'get more' request. Usually this is done when a homesection has it's 'View More' button tapped, and the user
  /// is starting to scroll through all of the available titles in each section.
  /// It is recommended that when you write your tests for a source, that you run one test using this function,
  /// for each homepageSectionId that the source offers, if those sections are expected to traverse multiple pages
  ///
  /// Arguments:
  /// - [source]
  /// - [homepageSectionId]
  /// - [metadata]
  /// - [resultPageLimiter] How many pages this should attempt to iterate through at most. This prevents
  /// you from being in an infinite loop. Defaults to 3.
  external Promise<List<MangaTile>?> getViewMoreItems(
    JsSource source,
    String homepageSectionId,
    Object? metadata, [
    int resultPageLimiter = 3,
  ]);

  external Promise<PagedResults?> getWebsiteMangaDirectory(JsSource source, Object? metadata);
}
