import 'package:dart_pb_extensions_common/js.dart';
import 'package:dart_pb_extensions_common/src/html/parser.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/registerable.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/requestable.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/searchable.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/form.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/dynamic_ui/section.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/paged_results.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/request_manager.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/search_field.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/search_request.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/tag_section.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/tracked_manga.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/tracker_action_queue.dart';

abstract class Tracker extends Registerable {
  final Parser parser = Parser();

  /// Manages the ratelimits and the number of requests that can be done per second
  /// This is also used to fetch pages when a chapter is downloading
  RequestManager get requestManager;

  Future<PagedResults> getSearchResults(SearchRequest query, Object? metadata);

  /// This cannot be async since the app expects a form as soon as this function is called
  /// for async tasks handle them in `sections`.
  Future<Form> getMangaForm(String mangaId);

  Future<TrackedManga> getTrackedManga(String mangaId);

  Future<Section> getSourceMenu();

  /// This method MUST dequeue all actions and process them, any unsuccessful actions
  /// must be marked for retry instead of being left in the queue.
  /// NOTE: Retried actions older than 24 hours will be discarded
  Future<void> processActionQueue(TrackerActionQueue actionQueue);

  // <-----------        OPTIONAL METHODS        -----------> //

  Future<List<TagSection>>? getSearchTags();

  Future<List<SearchField>>? getSearchFields();

  Future<bool>? supportsTagExclusion();

  Future<bool>? supportsSearchOperators();
}

class TrackerFutureToPromiseAdapter implements JsTracker {
  final Tracker tracker;

  TrackerFutureToPromiseAdapter(this.tracker);

  @override
  JsRequestManager get requestManager => tracker.requestManager.jsRequestManager;

  @override
  Promise<PagedResults> getSearchResults(SearchRequest query, Object? metadata) =>
      Promise.of(tracker.getSearchResults(query, metadata));

  @override
  Promise<Form> getMangaForm(String mangaId) => Promise.of(tracker.getMangaForm(mangaId));

  @override
  Promise<TrackedManga> getTrackedManga(String mangaId) =>
      Promise.of(tracker.getTrackedManga(mangaId));

  @override
  Promise<Section> getSourceMenu() => Promise.of(tracker.getSourceMenu());

  @override
  Promise<void> processActionQueue(JsTrackerActionQueue actionQueue) =>
      Promise.of(tracker.processActionQueue(TrackerActionQueue(actionQueue)));

  @override
  Promise<List<SearchField>>? getSearchFields() => tracker.getSearchFields()?.toPromise();

  @override
  Promise<List<TagSection>>? getSearchTags() => tracker.getSearchTags()?.toPromise();

  @override
  Promise<bool>? supportsSearchOperators() => tracker.supportsSearchOperators()?.toPromise();

  @override
  Promise<bool>? supportsTagExclusion() => tracker.supportsTagExclusion()?.toPromise();
}

@JS('Tracker')
abstract class JsTracker implements Requestable, Searchable {
  /// Manages the ratelimits and the number of requests that can be done per second
  /// This is also used to fetch pages when a chapter is downloading
  @override
  external JsRequestManager get requestManager;

  @override
  @JS()
  external Promise<PagedResults> getSearchResults(SearchRequest query, Object? metadata);

  /// This cannot be async since the app expects a form as soon as this function is called
  /// for async tasks handle them in `sections`.
  @JS()
  external Promise<Form> getMangaForm(String mangaId);

  @JS()
  external Promise<TrackedManga> getTrackedManga(String mangaId);
  @JS()
  external Promise<Section> getSourceMenu();

  /// This method MUST dequeue all actions and process them, any unsuccessful actions
  /// must be marked for retry instead of being left in the queue.
  /// NOTE: Retried actions older than 24 hours will be discarded
  @JS()
  external Promise<void> processActionQueue(JsTrackerActionQueue actionQueue);
}
