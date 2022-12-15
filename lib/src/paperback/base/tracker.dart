import 'package:js/js.dart';

import '../../js/js.dart';
import '../models/dynamic_ui/form.dart';
import '../models/dynamic_ui/section.dart';
import '../models/paged_results.dart';
import '../models/request_manager.dart';
import '../models/search_request.dart';
import '../models/tracked_manga.dart';
import '../models/tracker_action_queue.dart';
import 'requestable.dart';
import 'searchable.dart';

@JS()
abstract class Tracker implements Requestable, Searchable {
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
  external Promise<void> processActionQueue(TrackerActionQueue actionQueue);
}
