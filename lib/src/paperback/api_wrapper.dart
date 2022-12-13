import 'package:js/js.dart';

import '../js.dart';
import 'base/source.dart';
import 'models/chapter.dart';
import 'models/chapter_details.dart';
import 'models/home_section.dart';
import 'models/manga_info.dart';
import 'models/manga_tile.dart';
import 'models/manga_updates.dart';
import 'models/paged_results.dart';
import 'models/search_request.dart';
import 'models/tag_section.dart';

@JS()
class APIWrapper {
  external Promise<MangaInfo> getMangaDetails(Source source, String mangaId);

  external Promise<List<Chapter>> getChapters(Source source, String mangaId);

  external Promise<ChapterDetails> getChapterDetails(
    Source source,
    String mangaId,
    String chapterId,
  );

  external Promise<PagedResults> searchRequest(
    Source source,
    SearchRequest query,
    Object? metadata,
  );

  external Promise<List<TagSection>?> getTags(Source source);

  external Promise<List<MangaUpdates>> filterUpdatedManga(
    Source source,
    Date time,
    List<String> ids,
  );

  external Promise<List<HomeSection>> getHomePageSections(Source source);

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
    Source source,
    String homepageSectionId,
    Object? metadata, [
    int resultPageLimiter = 3,
  ]);

  external Promise<PagedResults?> getWebsiteMangaDirectory(Source source, Object? metadata);
}
