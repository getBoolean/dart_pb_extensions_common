part of '../paperback.dart';

@JS()
class TrackerActionQueue {
  external Promise<List<TrackedMangaChapterReadAction>> queuedChapterReadActions();
  external Promise<void> retryChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> discardChapterReadAction(TrackedMangaChapterReadAction action);
  external Promise<void> retryAllChapterReadAction();
  external Promise<void> discardAllChapterReadAction();
}
