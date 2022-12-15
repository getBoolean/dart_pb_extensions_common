import 'dart:js';

import 'package:dart_pb_extensions_common/src/paperback/base/source.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/tracker.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/source_info.dart';

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the global [context] so that it can be used by the
/// Paperback app.
JsObject Function() registerSource<T extends Source>({
  required String id,
  required Source Function() sourceCreator,
  required SourceInfo sourceInfo,
}) {
  final sourceJsObject = allowInterop(
    () {
      final source = SourceFutureToPromiseAdatper(sourceCreator());
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
    },
  );

  context[id] = sourceJsObject;
  context['${id}Info'] = JsObject.jsify(sourceInfo.toMap());
  return sourceJsObject;
}

/// Registers a [Tracker] with the global [context] so that it can be used by the
/// Paperback app.
JsObject Function() registerTracker<T extends Tracker>({
  required String id,
  required Tracker Function() trackerCreator,
  required SourceInfo sourceInfo,
}) {
  final trackerJsObject = allowInterop(
    () {
      final tracker = TrackerFutureToPromiseAdapter(trackerCreator());
      return JsObject.jsify({
        'getSearchResults': allowInterop(tracker.getSearchResults),
        'getMangaForm': allowInterop(tracker.getMangaForm),
        'getTrackedManga': allowInterop(tracker.getTrackedManga),
        'getSourceMenu': allowInterop(tracker.getSourceMenu),
        'processActionQueue': allowInterop(tracker.processActionQueue),
        'getSearchFields': allowInterop(tracker.getSearchFields),
        'getSearchTags': allowInterop(tracker.getSearchTags),
        'supportsSearchOperators': allowInterop(tracker.supportsSearchOperators),
        'supportsTagExclusion': allowInterop(tracker.supportsTagExclusion),
      });
    },
  );

  context[id] = trackerJsObject;
  context['${id}Info'] = JsObject.jsify(sourceInfo.toMap());
  return trackerJsObject;
}
