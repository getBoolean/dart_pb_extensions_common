import 'package:dart_pb_extensions_common/src/js/js_promise.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/tracked_manga_chapter_read_action.dart';
import 'package:js/js.dart';

class TrackerActionQueue {
  final JsTrackerActionQueue jsTrackerActionQueue;

  TrackerActionQueue(this.jsTrackerActionQueue);

  Future<void> discardAllChapterReadAction() =>
      jsTrackerActionQueue.discardAllChapterReadAction().toFuture();

  Future<void> discardChapterReadAction(TrackedMangaChapterReadAction action) =>
      jsTrackerActionQueue.discardChapterReadAction(action).toFuture();

  Future<List<TrackedMangaChapterReadAction>> queuedChapterReadActions() =>
      jsTrackerActionQueue.queuedChapterReadActions().toFuture();

  Future<void> retryAllChapterReadAction() =>
      jsTrackerActionQueue.retryAllChapterReadAction().toFuture();

  Future<void> retryChapterReadAction(TrackedMangaChapterReadAction action) =>
      jsTrackerActionQueue.retryChapterReadAction(action).toFuture();
}

@JS('TrackerActionQueue')
class JsTrackerActionQueue {
  external Promise<List<TrackedMangaChapterReadAction>>
      queuedChapterReadActions();
  external Promise<void> retryChapterReadAction(
      TrackedMangaChapterReadAction action);
  external Promise<void> discardChapterReadAction(
      TrackedMangaChapterReadAction action);
  external Promise<void> retryAllChapterReadAction();
  external Promise<void> discardAllChapterReadAction();
}
