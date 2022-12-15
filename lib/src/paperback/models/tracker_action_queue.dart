import 'package:js/js.dart';

import '../../js/js.dart';
import 'tracked_manga_chapter_read_action.dart';

class TrackerActionQueue {
  final JsTrackerActionQueue jsQueue;

  TrackerActionQueue(this.jsQueue);

  Future<void> discardAllChapterReadAction() {
    return jsQueue.discardAllChapterReadAction().toFuture();
  }

  Future<void> discardChapterReadAction(TrackedMangaChapterReadAction action) {
    return jsQueue.discardChapterReadAction(action).toFuture();
  }

  Future<List<TrackedMangaChapterReadAction>> queuedChapterReadActions() {
    return jsQueue.queuedChapterReadActions().toFuture();
  }

  Future<void> retryAllChapterReadAction() {
    return jsQueue.retryAllChapterReadAction().toFuture();
  }

  Future<void> retryChapterReadAction(TrackedMangaChapterReadAction action) {
    return jsQueue.retryChapterReadAction(action).toFuture();
  }
}

@JS('TrackerActionQueue')
class JsTrackerActionQueue {
  external Promise<List<TrackedMangaChapterReadAction>> queuedChapterReadActions();
  external Promise<void> retryChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> discardChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> retryAllChapterReadAction();
  external Promise<void> discardAllChapterReadAction();
}
