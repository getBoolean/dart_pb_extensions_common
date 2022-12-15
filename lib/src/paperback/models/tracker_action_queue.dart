import 'package:js/js.dart';

import '../../js/js.dart';
import 'tracked_manga_chapter_read_action.dart';

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
  external Promise<List<TrackedMangaChapterReadAction>> queuedChapterReadActions();
  external Promise<void> retryChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> discardChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> retryAllChapterReadAction();
  external Promise<void> discardAllChapterReadAction();
}
