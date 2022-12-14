import 'package:js/js.dart';

import '../../js/js.dart';
import 'tracked_manga_chapter_read_action.dart';

@JS()
class TrackerActionQueue {
  external Promise<List<TrackedMangaChapterReadAction>> queuedChapterReadActions();
  external Promise<void> retryChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> discardChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> retryAllChapterReadAction();
  external Promise<void> discardAllChapterReadAction();
}
