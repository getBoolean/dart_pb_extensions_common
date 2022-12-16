import 'dart:js' show context;

import 'package:dart_pb_extensions_common/src/paperback/base/registerable.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/source.dart';
import 'package:dart_pb_extensions_common/src/paperback/base/tracker.dart';
import 'package:dart_pb_extensions_common/src/paperback/models/source_info.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

// Solution to allowing interop with class methods
// https://github.com/dart-lang/sdk/issues/47855#issuecomment-1069311247

/// Registers a [Source] with the global [context] so that it can be used by the
/// Paperback app.
dynamic Function() register<T extends Registerable>({
  required String id,
  required Registerable Function() creator,
  required SourceInfo info,
}) {
  final jsObject = allowInterop(
    () {
      final regiserable = creator();
      if (regiserable is Source) {
        final source = SourceFutureToPromiseAdatper(regiserable);
        return jsify({
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
      } else if (regiserable is Tracker) {
        final tracker = TrackerFutureToPromiseAdapter(regiserable);
        return jsify({
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
      } else {
        throw Exception('Unknown Registerable type');
      }
    },
  );

  context[id] = jsObject;
  context['${id}Info'] = jsify(info.toMap());
  return jsObject;
}
