import 'dart:js' show JsObject;

import 'package:dart_pb_extensions_common/js.dart';
import 'package:dart_pb_extensions_common/paperback.dart';
import 'package:dart_pb_extensions_common/src/html/parser.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/registerable.dart';

abstract class Source extends Registerable {
  final Parser parser = Parser();
  RequestManager get requestManager;

  @override
  JsObject register() {
    final source = SourceFutureToPromiseAdatper(this);
    return JsObject.jsify({
      'getChapterDetails': allowInterop(source.getChapterDetails),
      'getChapters': allowInterop(source.getChapters),
      'getMangaDetails': allowInterop(source.getMangaDetails),
      'getSearchResults': allowInterop(source.getSearchResults),
      'filterUpdatedManga': allowInterop(source.filterUpdatedManga),
      'getCloudflareBypassRequest': allowInterop(source.getCloudflareBypassRequest),
      'getHomePageSections': allowInterop(source.getHomePageSections),
      'getMangaShareUrl': allowInterop(source.getMangaShareUrl),
      'getSearchFields': allowInterop(source.getSearchFields),
      'getSearchTags': allowInterop(source.getSearchTags),
      'getSourceMenu': allowInterop(source.getSourceMenu),
      'getViewMoreItems': allowInterop(source.getViewMoreItems),
      'getWebsiteMangaDirectory': allowInterop(source.getWebsiteMangaDirectory),
      'supportsSearchOperators': allowInterop(source.supportsSearchOperators),
      'supportsTagExclusion': allowInterop(source.supportsTagExclusion),
    });
  }

  /// Given a mangaID, this function should use a [Request] object's [Request.perform] method
  /// to grab and populate a [Chapter] object
  ///
  /// Arguments:
  /// - [mangaId]: The ID which this function is expected to grab data for
  Future<MangaInfo> getMangaDetails(String mangaId);

  /// Given a mangaID, this function should use a [Request] object's [Request.perform] method
  /// to grab and populate a [Chapter] array.
  ///
  /// Arguments:
  /// - [mangaId]: The ID which this function is expected to grab data for
  Future<List<Chapter>> getChapters(String mangaId);

  /// Given a mangaID, this function should use a [Request] object's [Request.perform] method
  /// to grab and populate a [ChapterDetails] object.
  ///
  /// Arguments:
  /// - [mangaId]: The ID which this function is expected to grab data for
  Future<ChapterDetails> getChapterDetails(String mangaId, String chapterId);

  /// Given a search request, this function should scan through the website's search page and
  /// return relevent [MangaTile] objects to the given search parameters.
  /// This function is ONLY expected to return the first page of search results.
  /// If there is more than one page of search results, the [PagedResults.metadata]
  /// variable should be filled out with some kind of information pointing to the next page of the search.
  ///
  /// Arguments:
  /// - [query]: A app-filled query which the search request should request from the website.
  /// - [metadata]: A persistant metadata parameter which can be filled out with any data required between search page sections
  Future<PagedResults> getSearchResults(SearchRequest query, Object? metadata);

  // <-----------        OPTIONAL METHODS        -----------> //

  /// (OPTIONAL METHOD) A function which should scan through the latest updates section of a website, and report back with a list of IDs which have been
  /// updated BEFORE the supplied timeframe.
  ///
  /// This function may have to scan through multiple pages in order to discover the full list of updated manga.
  /// Because of this, each batch of IDs should be returned with the mangaUpdatesFoundCallback. The IDs which have been reported for
  /// one page, should not be reported again on another page, unless the relevent ID has been detected again. You do not want to persist
  /// this internal list between [Request] calls
  ///
  /// Arguments:
  /// - [mangaUpdatesFoundCallback]: A callback which is used to report a list of manga IDs back to the API
  /// - [time]: This function should find all manga which has been updated between the current time, and this parameter's reported time.
  ///           After this time has been passed, the system should stop parsing and return
  Future<void> filterUpdatedMangas(
          void Function(MangaUpdates updates) mangaUpdatesFoundCallback, Date time, List<String> ids) =>
      Future.value();

  /// (OPTIONAL METHOD) A function which should readonly all of the available homepage sections for a given source, and return a [HomeSection] object.
  /// The sectionCallback is to be used for each given section on the website. This may include a 'Latest Updates' section, or a 'Hot Manga' section.
  /// It is recommended that before anything else in your source, you first use this sectionCallback and send it [HomeSection] objects
  /// which are blank, and have not had any requests done on them just yet. This way, you provide the App with the sections to render on screen,
  /// which then will be populated with each additional sectionCallback method called. This is optional, but recommended.
  ///
  /// Arguments:
  /// - [sectionCallback]: A callback which is run for each independant [HomeSection].
  Future<void> getHomePageSections(void Function(HomeSection section) sectionCallback) =>
      Future.value();

  /// If a source is secured by Cloudflare, this method should be filled out.
  /// By returning a request to the website, this source will attempt to create a session
  /// so that the source can load correctly.
  ///
  /// Usually the [Request] url can simply be the base URL to the source.
  Request? getCloudflareBypassRequest() => null;

  /// (OPTIONAL METHOD) Given a manga ID, return a URL which Safari can open in a browser to display.
  String? getMangaShareUrl(String mangaId) => null;

  Future<List<SearchField>>? getSearchFields() => null;

  /// (OPTIONAL METHOD) A function which communicates with a given source, and returns a list of all possible tags which the source supports.
  /// These tags are generic and depend on the source. They could be genres such as 'Isekai, Action, Drama', or they can be
  /// listings such as 'Completed, Ongoing'
  ///
  /// These tags must be tags which can be used in the [JsSource.getSearchResults] function to augment the searching capability of the application
  Future<List<TagSection>>? getSearchTags() => null;

  /// A stateful source may require user input.
  /// By supplying this value to the Source, the app will render your form to the user
  /// in the application settings.
  Future<Section>? getSourceMenu() => null;

  /// (OPTIONAL METHOD) This function will take a given homepageSectionId and metadata value, and with this information, should return
  /// all of the manga tiles supplied for the given state of parameters. Most commonly, the metadata value will contain some sort of page information,
  /// and this request will target the given page. (Incrementing the page in the response so that the next call will return relevent data)
  ///
  /// Arguments:
  /// - [homepageSectionId]: The given ID to the homepage defined in [getHomePageSections] which this method is to readonly more data about
  /// - [metadata]: This is a metadata parameter which is filled our in the [JsSource.getHomePageSections]'s return
  /// function. It initially starts out as null. Afterwards, if the metadata value returned in the [PagedResults] has been modified,
  /// the modified version will be supplied to this function instead of the origional [JsSource.getHomePageSections]'s version.
  /// This is useful for keeping track of which page a user is on, pagnating to other pages as ViewMore is called multiple times.
  Future<PagedResults>? getViewMoreItems(String homepageSectionId, Object? metadata) => null;

  /// (OPTIONAL METHOD) This function is to return the entire library of a manga website, page by page.
  /// If there is an additional page which needs to be called, the [PagedResults] value should have it's metadata filled out
  /// with information needed to continue pulling information from this website.
  /// Note that if the metadata value of [PagedResults] is undefined, this method will not continue to run when the user
  /// attempts to readonly more information
  ///
  /// Arguments:
  /// - [metadata]: Identifying information as to what the source needs to call in order to readonly theext batch of data
  /// of the directory. Usually this is a page counter.
  Future<PagedResults>? getWebsiteMangaDirectory(Object? metadata) => null;

  Future<bool>? supportsSearchOperators() => null;

  Future<bool>? supportsTagExclusion() => null;
}

class SourceFutureToPromiseAdatper implements JsSource {
  final Source source;

  SourceFutureToPromiseAdatper(this.source);

  @override
  Promise<void>? filterUpdatedManga(
          void Function(MangaUpdates updates) mangaUpdatesFoundCallback, Date time, List<String> ids) =>
      source.filterUpdatedMangas(mangaUpdatesFoundCallback, time, ids).toPromise();

  @override
  Promise<ChapterDetails> getChapterDetails(String mangaId, String chapterId) =>
      source.getChapterDetails(mangaId, chapterId).toPromise();

  @override
  Promise<List<Chapter>> getChapters(String mangaId) => source.getChapters(mangaId).toPromise();

  @override
  Request? getCloudflareBypassRequest() => source.getCloudflareBypassRequest();

  @override
  Promise<void>? getHomePageSections(void Function(HomeSection section) sectionCallback) =>
      source.getHomePageSections(sectionCallback).toPromise();

  @override
  Promise<MangaInfo> getMangaDetails(String mangaId) => source.getMangaDetails(mangaId).toPromise();

  @override
  String? getMangaShareUrl(String mangaId) => source.getMangaShareUrl(mangaId);

  @override
  Promise<List<SearchField>>? getSearchFields() => source.getSearchFields()?.toPromise();

  @override
  Promise<PagedResults> getSearchResults(SearchRequest query, Object? metadata) =>
      source.getSearchResults(query, metadata).toPromise();

  @override
  Promise<List<TagSection>>? getSearchTags() => source.getSearchTags()?.toPromise();

  @override
  Promise<Section>? getSourceMenu() => source.getSourceMenu()?.toPromise();

  @override
  Promise<PagedResults>? getViewMoreItems(String homepageSectionId, Object? metadata) =>
      source.getViewMoreItems(homepageSectionId, metadata)?.toPromise();

  @override
  Promise<PagedResults>? getWebsiteMangaDirectory(Object? metadata) =>
      source.getWebsiteMangaDirectory(metadata)?.toPromise();

  @override
  JsRequestManager get requestManager => source.requestManager.jsRequestManager;

  @override
  Promise<bool>? supportsSearchOperators() => source.supportsSearchOperators()?.toPromise();

  @override
  Promise<bool>? supportsTagExclusion() => source.supportsTagExclusion()?.toPromise();
}

@JS('Source')
abstract class JsSource implements Requestable, Searchable {
  @override
  external JsRequestManager get requestManager;

  /// Given a mangaID, this function should use a [Request] object's [Request.perform] method
  /// to grab and populate a [Chapter] object
  ///
  /// Arguments:
  /// - [mangaId]: The ID which this function is expected to grab data for
  @JS()
  external Promise<MangaInfo> getMangaDetails(String mangaId);

  /// Given a mangaID, this function should use a [Request] object's [Request.perform] method
  /// to grab and populate a [Chapter] array.
  ///
  /// Arguments:
  /// - [mangaId]: The ID which this function is expected to grab data for
  @JS()
  external Promise<List<Chapter>> getChapters(String mangaId);

  /// Given a mangaID, this function should use a [Request] object's [Request.perform] method
  /// to grab and populate a [ChapterDetails] object.
  ///
  /// Arguments:
  /// - [mangaId]: The ID which this function is expected to grab data for
  @JS()
  external Promise<ChapterDetails> getChapterDetails(String mangaId, String chapterId);

  /// Given a search request, this function should scan through the website's search page and
  /// return relevent [MangaTile] objects to the given search parameters.
  /// This function is ONLY expected to return the first page of search results.
  /// If there is more than one page of search results, the [PagedResults.metadata]
  /// variable should be filled out with some kind of information pointing to the next page of the search.
  ///
  /// Arguments:
  /// - [query]: A app-filled query which the search request should request from the website.
  /// - [metadata]: A persistant metadata parameter which can be filled out with any data required between search page sections
  @override
  @JS()
  external Promise<PagedResults> getSearchResults(SearchRequest query, Object? metadata);

  // <-----------        OPTIONAL METHODS        -----------> //

  @override
  @JS()
  external Promise<List<SearchField>>? getSearchFields();

  /// (OPTIONAL METHOD) A function which communicates with a given source, and returns a list of all possible tags which the source supports.
  /// These tags are generic and depend on the source. They could be genres such as 'Isekai, Action, Drama', or they can be
  /// listings such as 'Completed, Ongoing'
  ///
  /// These tags must be tags which can be used in the [JsSource.getSearchResults] function to augment the searching capability of the application
  @override
  @JS()
  external Promise<List<TagSection>>? getSearchTags();

  @override
  @JS()
  external Promise<bool>? supportsTagExclusion();

  @override
  @JS()
  external Promise<bool>? supportsSearchOperators();

  /// A stateful source may require user input.
  /// By supplying this value to the Source, the app will render your form to the user
  /// in the application settings.
  @JS()
  external Promise<Section>? getSourceMenu();

  /// (OPTIONAL METHOD) Given a manga ID, return a URL which Safari can open in a browser to display.
  @JS()
  external String? getMangaShareUrl(String mangaId);

  /// If a source is secured by Cloudflare, this method should be filled out.
  /// By returning a request to the website, this source will attempt to create a session
  /// so that the source can load correctly.
  ///
  /// Usually the [Request] url can simply be the base URL to the source.
  @JS()
  external Request? getCloudflareBypassRequest();

  /// (OPTIONAL METHOD) A function which should scan through the latest updates section of a website, and report back with a list of IDs which have been
  /// updated BEFORE the supplied timeframe.
  ///
  /// This function may have to scan through multiple pages in order to discover the full list of updated manga.
  /// Because of this, each batch of IDs should be returned with the mangaUpdatesFoundCallback. The IDs which have been reported for
  /// one page, should not be reported again on another page, unless the relevent ID has been detected again. You do not want to persist
  /// this internal list between [Request] calls
  ///
  /// Arguments:
  /// - [mangaUpdatesFoundCallback]: A callback which is used to report a list of manga IDs back to the API
  /// - [time]: This function should find all manga which has been updated between the current time, and this parameter's reported time.
  ///           After this time has been passed, the system should stop parsing and return
  @JS()
  external Promise<void>? filterUpdatedManga(
    void Function(MangaUpdates updates) mangaUpdatesFoundCallback,
    Date time,
    List<String> ids,
  );

  /// (OPTIONAL METHOD) A function which should readonly all of the available homepage sections for a given source, and return a [HomeSection] object.
  /// The sectionCallback is to be used for each given section on the website. This may include a 'Latest Updates' section, or a 'Hot Manga' section.
  /// It is recommended that before anything else in your source, you first use this sectionCallback and send it [HomeSection] objects
  /// which are blank, and have not had any requests done on them just yet. This way, you provide the App with the sections to render on screen,
  /// which then will be populated with each additional sectionCallback method called. This is optional, but recommended.
  ///
  /// Arguments:
  /// - [sectionCallback]: A callback which is run for each independant [HomeSection].
  @JS()
  external Promise<void>? getHomePageSections(void Function(HomeSection section) sectionCallback);

  /// (OPTIONAL METHOD) This function will take a given homepageSectionId and metadata value, and with this information, should return
  /// all of the manga tiles supplied for the given state of parameters. Most commonly, the metadata value will contain some sort of page information,
  /// and this request will target the given page. (Incrementing the page in the response so that the next call will return relevent data)
  ///
  /// Arguments:
  /// - [homepageSectionId]: The given ID to the homepage defined in [getHomePageSections] which this method is to readonly more data about
  /// - [metadata]: This is a metadata parameter which is filled our in the [JsSource.getHomePageSections]'s return
  /// function. It initially starts out as null. Afterwards, if the metadata value returned in the [PagedResults] has been modified,
  /// the modified version will be supplied to this function instead of the origional [JsSource.getHomePageSections]'s version.
  /// This is useful for keeping track of which page a user is on, pagnating to other pages as ViewMore is called multiple times.
  @JS()
  external Promise<PagedResults>? getViewMoreItems(String homepageSectionId, Object? metadata);

  /// (OPTIONAL METHOD) This function is to return the entire library of a manga website, page by page.
  /// If there is an additional page which needs to be called, the [PagedResults] value should have it's metadata filled out
  /// with information needed to continue pulling information from this website.
  /// Note that if the metadata value of [PagedResults] is undefined, this method will not continue to run when the user
  /// attempts to readonly more information
  ///
  /// Arguments:
  /// - [metadata]: Identifying information as to what the source needs to call in order to readonly theext batch of data
  /// of the directory. Usually this is a page counter.
  @JS()
  external Promise<PagedResults>? getWebsiteMangaDirectory(Object? metadata);
}

/// Many sites use `[x] time ago` - Figured it would be good to handle these cases in general
///
/// JavaScript implementation:
/// ```js
/// export function convertTime(timeAgo: string): Date {
///   let time: Date
///   let trimmed: number = Number((/\d*/.exec(timeAgo) ?? [])[0])
///   trimmed = (trimmed == 0 && timeAgo.includes('a')) ? 1 : trimmed
///   if (timeAgo.includes('minutes')) {
///     time = new Date(Date.now() - trimmed * 60000)
///   }
///   else if (timeAgo.includes('hours')) {
///     time = new Date(Date.now() - trimmed * 3600000)
///   }
///   else if (timeAgo.includes('days')) {
///     time = new Date(Date.now() - trimmed * 86400000)
///   }
///   else if (timeAgo.includes('year') || timeAgo.includes('years')) {
///     time = new Date(Date.now() - trimmed * 31556952000)
///   }
///   else {
///     time = new Date(Date.now())
///   }
///
///   return time
/// }
/// ```
@JS()
external Date convertTime(String timeAgo);

/// When a function requires a POST body, it always should be defined as a Json Map
/// and then passed through this function to ensure that it's encoded properly.
@JS()
external Object urlEncodeObject(Map<String, Object?> obj);
